(set-logic ALL)

; Uninterpreted interface functions for string splitting

; -------- SAT instance: well-formed log analysis --------
(declare-const log_line_sat String)
(declare-const ts_token_sat String)
(declare-const time_part_sat String)
(declare-const level_token_sat String)
(declare-const msg_rest_sat String)
(declare-const ts_date_sat String)
(declare-const ts_clock_sat String)

; Structure: "YYYY-MM-DD HH:MM:SS LEVEL: message..."
(assert (= ts_token_sat (str.split_at log_line_sat " " 0)))
(assert (= time_part_sat (str.split_at log_line_sat " " 1)))
(assert (= level_token_sat (str.split_at log_line_sat " " 2)))
(assert (= msg_rest_sat (str.split_rest log_line_sat " " 3)))
(assert (>= (str.num_splits log_line_sat " ") 4))

; Timestamp format validation (basic): date token has two '-' and time token has two ':'
(assert (= (str.num_splits ts_token_sat "-") 3))
(assert (= (str.num_splits time_part_sat ":") 3))

; Enforce fixed lengths: "YYYY-MM-DD" length 10, "HH:MM:SS" length 8
(assert (= (str.len ts_token_sat) 10))
(assert (= (str.len time_part_sat) 8))

; Split timestamp pieces to constrain digit-only fields
(assert (= ts_date_sat ts_token_sat))
(assert (= ts_clock_sat time_part_sat))

(declare-const year_sat String)
(declare-const month_sat String)
(declare-const day_sat String)
(declare-const hour_sat String)
(declare-const min_sat String)
(declare-const sec_sat String)

(assert (= year_sat (str.split_at ts_date_sat "-" 0)))
(assert (= month_sat (str.split_at ts_date_sat "-" 1)))
(assert (= day_sat (str.split_at ts_date_sat "-" 2)))
(assert (= hour_sat (str.split_at ts_clock_sat ":" 0)))
(assert (= min_sat (str.split_at ts_clock_sat ":" 1)))
(assert (= sec_sat (str.split_at ts_clock_sat ":" 2)))

(assert (= (str.len year_sat) 4))
(assert (= (str.len month_sat) 2))
(assert (= (str.len day_sat) 2))
(assert (= (str.len hour_sat) 2))
(assert (= (str.len min_sat) 2))
(assert (= (str.len sec_sat) 2))

; Digit-only checks using regex
(assert (str.in_re year_sat (re.+ (re.range "0" "9"))))
(assert (str.in_re month_sat (re.+ (re.range "0" "9"))))
(assert (str.in_re day_sat (re.+ (re.range "0" "9"))))
(assert (str.in_re hour_sat (re.+ (re.range "0" "9"))))
(assert (str.in_re min_sat (re.+ (re.range "0" "9"))))
(assert (str.in_re sec_sat (re.+ (re.range "0" "9"))))

; Extract log level from token of form "LEVEL:" (colon terminated)
(declare-const level_name_sat String)
(assert (= level_name_sat (str.split_at level_token_sat ":" 0)))
(assert (= (str.split_at level_token_sat ":" 1) ""))
(assert (>= (str.num_splits level_token_sat ":") 2))

; Restrict log level to a known set
(assert (or (= level_name_sat "INFO") (= level_name_sat "WARN") (= level_name_sat "ERROR") (= level_name_sat "DEBUG")))

; Message must be non-empty and contain at least one alphabetic character
(assert (> (str.len msg_rest_sat) 0))
(assert (str.in_re msg_rest_sat (re.++ (re.* re.allchar) (re.range "A" "Z") (re.* re.allchar))))

; Provide a concrete satisfiable example
(assert (= log_line_sat "2025-01-09 13:45:59 INFO: Service started"))

; -------- UNSAT instance: contradictory constraints on another log line --------
(declare-const log_line_unsat String)
(declare-const ts_token_unsat String)
(declare-const time_part_unsat String)
(declare-const level_token_unsat String)
(declare-const msg_rest_unsat String)

(assert (= ts_token_unsat (str.split_at log_line_unsat " " 0)))
(assert (= time_part_unsat (str.split_at log_line_unsat " " 1)))
(assert (= level_token_unsat (str.split_at log_line_unsat " " 2)))
(assert (= msg_rest_unsat (str.split_rest log_line_unsat " " 3)))
(assert (>= (str.num_splits log_line_unsat " ") 4))

; Contradiction: require exactly 3 ':' splits in time token, but force length 7 (cannot match HH:MM:SS which needs 8)
(assert (= (str.num_splits time_part_unsat ":") 3))
(assert (= (str.len time_part_unsat) 7))

; Also force a concrete time token length 8 via equality => direct conflict with length 7
(assert (= time_part_unsat "12:34:56"))

; Another mild structure constraint to mimic parsing
(assert (= (str.num_splits ts_token_unsat "-") 3))
(assert (= (str.len ts_token_unsat) 10))

; Concrete line (doesn't matter due to contradictions above)
(assert (= log_line_unsat "2025-01-09 12:34:56 ERROR: Something failed"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
