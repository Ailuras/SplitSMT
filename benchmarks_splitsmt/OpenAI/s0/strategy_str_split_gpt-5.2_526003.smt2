(set-logic ALL)

; Uninterpreted split interface

; =========================
; Scenario: Log Analysis
; Parsing structured server log entries separated by spaces and colons.
; Example intended shape:
;   "YYYY-MM-DD HH:MM:SS LEVEL: component: message"
; =========================

; ---------- SAT instance: a well-formed log line ----------
(declare-const log_line_sat String)
(declare-const date_sat String)
(declare-const time_sat String)
(declare-const level_with_colon_sat String)
(declare-const level_sat String)
(declare-const component_sat String)
(declare-const message_sat String)

; Basic splitting by spaces: [date, time, level:, rest...]
(assert (>= (str.num_splits log_line_sat " ") 4))
(assert (= date_sat (str.split_at log_line_sat " " 0)))
(assert (= time_sat (str.split_at log_line_sat " " 1)))
(assert (= level_with_colon_sat (str.split_at log_line_sat " " 2)))
(assert (= (str.split_rest log_line_sat " " 3) (str.++ component_sat " " message_sat)))

; Timestamp format checks (date)
(assert (= (str.len date_sat) 10))
(assert (= (str.at date_sat 4) "-"))
(assert (= (str.at date_sat 7) "-"))
(assert (str.in_re (str.substr date_sat 0 4) (re.+ (re.range "0" "9"))))
(assert (str.in_re (str.substr date_sat 5 2) (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re (str.substr date_sat 8 2) (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Timestamp format checks (time)
(assert (= (str.len time_sat) 8))
(assert (= (str.at time_sat 2) ":"))
(assert (= (str.at time_sat 5) ":"))
(assert (str.in_re (str.substr time_sat 0 2) (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re (str.substr time_sat 3 2) (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re (str.substr time_sat 6 2) (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Extract log level from "LEVEL:" via split on ":"
(assert (>= (str.num_splits level_with_colon_sat ":") 2))
(assert (= level_sat (str.split_at level_with_colon_sat ":" 0)))
(assert (= "" (str.split_at level_with_colon_sat ":" 1)))

; Allow common levels
(assert (or (= level_sat "INFO") (= level_sat "WARN") (= level_sat "ERROR") (= level_sat "DEBUG")))

; Component should end with ':' in the original rest-of-line format "component: message"
(assert (>= (str.num_splits component_sat ":") 2))
(assert (= (str.split_at component_sat ":" 1) ""))
(assert (>= (str.len message_sat) 1))

; Concretize one satisfying log line
(assert (= log_line_sat "2026-01-09 12:34:56 INFO: auth: login ok"))

; ---------- UNSAT instance: conflicting timestamp/level requirements ----------
(declare-const log_line_unsat String)
(declare-const date_unsat String)
(declare-const time_unsat String)
(declare-const level_with_colon_unsat String)
(declare-const level_unsat String)

(assert (>= (str.num_splits log_line_unsat " ") 3))
(assert (= date_unsat (str.split_at log_line_unsat " " 0)))
(assert (= time_unsat (str.split_at log_line_unsat " " 1)))
(assert (= level_with_colon_unsat (str.split_at log_line_unsat " " 2)))

; Demand strict time punctuation
(assert (= (str.len time_unsat) 8))
(assert (= (str.at time_unsat 2) ":"))
(assert (= (str.at time_unsat 5) ":"))

; But also force a contradictory time where position 2 is not ':'
(assert (= time_unsat "12-34-56"))

; Extract level and contradict it
(assert (>= (str.num_splits level_with_colon_unsat ":") 2))
(assert (= level_unsat (str.split_at level_with_colon_unsat ":" 0)))
(assert (= level_unsat "INFO"))
(assert (= level_unsat "ERROR"))

; Provide a plausible log line anyway (still unsat due to contradictions)
(assert (= log_line_unsat "2026-01-09 12-34-56 INFO: core: msg"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
