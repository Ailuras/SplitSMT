(set-logic ALL)

; Uninterpreted interface functions for str_split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; -----------------------------
; SAT instance: well-formed log
; Format: "YYYY-MM-DD HH:MM:SS LEVEL: message"
; -----------------------------
(declare-const log_line_sat String)
(declare-const date_sat String)
(declare-const time_sat String)
(declare-const level_colon_sat String)
(declare-const level_sat String)
(declare-const msg_sat String)

(declare-const year_sat String)
(declare-const month_sat String)
(declare-const day_sat String)
(declare-const hour_sat String)
(declare-const min_sat String)
(declare-const sec_sat String)

; Split by spaces: [date, time, LEVEL:, rest-of-message]
(assert (>= (num_splits log_line_sat " ") 4))
(assert (= date_sat (split_at log_line_sat " " 0)))
(assert (= time_sat (split_at log_line_sat " " 1)))
(assert (= level_colon_sat (split_at log_line_sat " " 2)))
(assert (= msg_sat (split_rest log_line_sat " " 3)))

; Date validation: YYYY-MM-DD
(assert (= (str.len date_sat) 10))
(assert (str.in_re date_sat (re.++ (re.loop (re.range "0" "9") 4 4)
                                  (str.to_re "-")
                                  (re.loop (re.range "0" "9") 2 2)
                                  (str.to_re "-")
                                  (re.loop (re.range "0" "9") 2 2))))
(assert (= year_sat (str.substr date_sat 0 4)))
(assert (= month_sat (str.substr date_sat 5 2)))
(assert (= day_sat (str.substr date_sat 8 2)))

; Time validation: HH:MM:SS
(assert (= (str.len time_sat) 8))
(assert (str.in_re time_sat (re.++ (re.loop (re.range "0" "9") 2 2)
                                  (str.to_re ":")
                                  (re.loop (re.range "0" "9") 2 2)
                                  (str.to_re ":")
                                  (re.loop (re.range "0" "9") 2 2))))
(assert (= hour_sat (str.substr time_sat 0 2)))
(assert (= min_sat (str.substr time_sat 3 2)))
(assert (= sec_sat (str.substr time_sat 6 2)))

; Log level extraction: LEVEL: (split by colon)
(assert (>= (num_splits level_colon_sat ":") 2))
(assert (= level_sat (split_at level_colon_sat ":" 0)))

; Level must be one of common levels
(assert (or (= level_sat "INFO") (= level_sat "WARN") (= level_sat "ERROR") (= level_sat "DEBUG")))

; Message sanity: non-empty and should not contain a newline
(assert (> (str.len msg_sat) 0))
(assert (not (str.contains msg_sat "\n")))

; Construct a concrete satisfiable example (anchors the SAT portion)
(assert (= log_line_sat "2026-01-09 13:05:44 INFO: service started"))

; -----------------------------
; UNSAT instance: contradictory timestamp/level constraints
; -----------------------------
(declare-const log_line_unsat String)
(declare-const date_unsat String)
(declare-const time_unsat String)
(declare-const level_colon_unsat String)
(declare-const level_unsat String)
(declare-const msg_unsat String)

; Split by spaces
(assert (>= (num_splits log_line_unsat " ") 4))
(assert (= date_unsat (split_at log_line_unsat " " 0)))
(assert (= time_unsat (split_at log_line_unsat " " 1)))
(assert (= level_colon_unsat (split_at log_line_unsat " " 2)))
(assert (= msg_unsat (split_rest log_line_unsat " " 3)))

; Require correct time regex, but also force an impossible fixed value
(assert (= (str.len time_unsat) 8))
(assert (str.in_re time_unsat (re.++ (re.loop (re.range "0" "9") 2 2)
                                    (str.to_re ":")
                                    (re.loop (re.range "0" "9") 2 2)
                                    (str.to_re ":")
                                    (re.loop (re.range "0" "9") 2 2))))
(assert (= time_unsat "99:99:99"))

; Level extraction and contradictory level requirements
(assert (>= (num_splits level_colon_unsat ":") 2))
(assert (= level_unsat (split_at level_colon_unsat ":" 0)))
(assert (= level_unsat "INFO"))
(assert (= level_unsat "ERROR"))

; Keep remaining parts plausible
(assert (= date_unsat "2026-01-09"))
(assert (= level_colon_unsat "INFO:"))
(assert (= msg_unsat "x"))
(assert (= log_line_unsat (str.++ date_unsat " " time_unsat " " level_colon_unsat " " msg_unsat)))

(check-sat)


; [GENERATION STATUS: SUCCESS]