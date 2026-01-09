(set-logic ALL)

; Uninterpreted interface operations for string splitting

; =====================
; SAT instance: well-formed log line
; Format: "YYYY-MM-DD HH:MM:SS LEVEL: component: message"
; =====================
(declare-const log_line_sat String)
(declare-const date_sat String)
(declare-const time_sat String)
(declare-const levelcol_sat String)
(declare-const level_sat String)
(declare-const componentcol_sat String)
(declare-const component_sat String)
(declare-const message_sat String)

; Split by spaces into at least 4 segments: date, time, LEVEL:, rest...
(assert (>= (str.num_splits log_line_sat " ") 4))
(assert (= date_sat (str.split_at log_line_sat " " 0)))
(assert (= time_sat (str.split_at log_line_sat " " 1)))
(assert (= levelcol_sat (str.split_at log_line_sat " " 2)))
(assert (= message_sat (str.split_rest log_line_sat " " 3)))

; Validate date format YYYY-MM-DD with digits
(assert (str.in_re date_sat (re.++ (re.loop (re.range "0" "9") 4 4)
                                  (str.to_re "-")
                                  (re.loop (re.range "0" "9") 2 2)
                                  (str.to_re "-")
                                  (re.loop (re.range "0" "9") 2 2))))

; Validate time format HH:MM:SS with digits
(assert (str.in_re time_sat (re.++ (re.loop (re.range "0" "9") 2 2)
                                  (str.to_re ":")
                                  (re.loop (re.range "0" "9") 2 2)
                                  (str.to_re ":")
                                  (re.loop (re.range "0" "9") 2 2))))

; Extract level from "LEVEL:" and validate against known levels
(assert (str.suffixof ":" levelcol_sat))
(assert (= level_sat (str.substr levelcol_sat 0 (- (str.len levelcol_sat) 1))))
(assert (or (= level_sat "INFO") (= level_sat "WARN") (= level_sat "ERROR") (= level_sat "DEBUG")))

; Message part contains "component:" as first token, and component has no spaces
(assert (= componentcol_sat (str.split_at message_sat " " 0)))
(assert (str.suffixof ":" componentcol_sat))
(assert (= component_sat (str.substr componentcol_sat 0 (- (str.len componentcol_sat) 1))))
(assert (not (str.contains component_sat " ")))

; Constrain an explicit concrete satisfying example
(assert (= log_line_sat "2025-01-09 13:45:07 INFO: auth: login ok"))

; =====================
; UNSAT instance: contradictory timestamp validation
; =====================
(declare-const log_line_unsat String)
(declare-const date_unsat String)
(declare-const time_unsat String)

(assert (>= (str.num_splits log_line_unsat " ") 2))
(assert (= date_unsat (str.split_at log_line_unsat " " 0)))
(assert (= time_unsat (str.split_at log_line_unsat " " 1)))

; Require time to be both correct HH:MM:SS and also contain no ':' -> contradiction
(assert (str.in_re time_unsat (re.++ (re.loop (re.range "0" "9") 2 2)
                                    (str.to_re ":")
                                    (re.loop (re.range "0" "9") 2 2)
                                    (str.to_re ":")
                                    (re.loop (re.range "0" "9") 2 2))))
(assert (not (str.contains time_unsat ":")))

; Fix a concrete log line to ensure the contradiction is about constraints, not freedom
(assert (= log_line_unsat "2025-01-09 12:00:00 ERROR: core: bad"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
