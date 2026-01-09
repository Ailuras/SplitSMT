(set-logic ALL)

; Uninterpreted interface functions for str_split

; ---------- SAT instance: well-formed log entry ----------
(declare-const log_line_sat String)
(declare-const ts_sat String)
(declare-const level_sat String)
(declare-const component_sat String)
(declare-const message_sat String)
(declare-const date_sat String)
(declare-const time_sat String)
(declare-const year_sat String)
(declare-const month_sat String)
(declare-const day_sat String)
(declare-const hour_sat String)
(declare-const minute_sat String)
(declare-const second_sat String)
(declare-const component_name_sat String)
(declare-const pid_sat String)

; Shape: "YYYY-MM-DD HH:MM:SS LEVEL component: message"
(assert (= ts_sat (str.++ (str.split_at log_line_sat " " 0) " " (str.split_at log_line_sat " " 1))))
(assert (= level_sat (str.split_at log_line_sat " " 2)))
(assert (= component_sat (str.split_at log_line_sat " " 3)))
(assert (= message_sat (str.split_rest log_line_sat " " 4)))

; Require at least 5 space-separated fields
(assert (>= (str.num_splits log_line_sat " ") 5))

; Timestamp tokenization
(assert (= date_sat (str.split_at ts_sat " " 0)))
(assert (= time_sat (str.split_at ts_sat " " 1)))
(assert (= year_sat (str.split_at date_sat "-" 0)))
(assert (= month_sat (str.split_at date_sat "-" 1)))
(assert (= day_sat (str.split_at date_sat "-" 2)))
(assert (= hour_sat (str.split_at time_sat ":" 0)))
(assert (= minute_sat (str.split_at time_sat ":" 1)))
(assert (= second_sat (str.split_at time_sat ":" 2)))

; Ensure correct number of splits in date and time
(assert (= (str.num_splits date_sat "-") 3))
(assert (= (str.num_splits time_sat ":") 3))

; Regex: digit-only and fixed lengths
(assert (str.in_re year_sat (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.range "0" "9"))))))
(assert (str.in_re month_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re day_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re hour_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re minute_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re second_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Basic range checks via int conversion
(declare-const year_i_sat Int)
(declare-const month_i_sat Int)
(declare-const day_i_sat Int)
(declare-const hour_i_sat Int)
(declare-const minute_i_sat Int)
(declare-const second_i_sat Int)
(assert (= year_i_sat (str.to_int year_sat)))
(assert (= month_i_sat (str.to_int month_sat)))
(assert (= day_i_sat (str.to_int day_sat)))
(assert (= hour_i_sat (str.to_int hour_sat)))
(assert (= minute_i_sat (str.to_int minute_sat)))
(assert (= second_i_sat (str.to_int second_sat)))
(assert (>= year_i_sat 2000))
(assert (<= year_i_sat 2099))
(assert (>= month_i_sat 1))
(assert (<= month_i_sat 12))
(assert (>= day_i_sat 1))
(assert (<= day_i_sat 31))
(assert (>= hour_i_sat 0))
(assert (<= hour_i_sat 23))
(assert (>= minute_i_sat 0))
(assert (<= minute_i_sat 59))
(assert (>= second_i_sat 0))
(assert (<= second_i_sat 59))

; Log level extraction and validation
(assert (or (= level_sat "INFO") (= level_sat "WARN") (= level_sat "ERROR") (= level_sat "DEBUG")))

; Component must end with ':' and have non-empty name before it
(assert (= ":" (str.at component_sat (- (str.len component_sat) 1))))
(assert (> (str.len component_sat) 1))
(assert (= component_name_sat (str.substr component_sat 0 (- (str.len component_sat) 1))))
(assert (not (= component_name_sat "")))

; Optional PID pattern in component name like "auth[1234]" is allowed
(assert (or
  (not (str.contains component_name_sat "["))
  (and
    (= (str.split_at component_name_sat "[" 0) component_name_sat) ; conservative: no '[' means no split
    true)))

; Message should be non-empty and contain at least one printable character (approx: not empty)
(assert (> (str.len message_sat) 0))

; Witness a concrete satisfiable log line
(assert (= log_line_sat "2024-01-09 13:45:07 INFO auth: login ok"))

; ---------- UNSAT instance: contradictory timestamp + level constraints ----------
(declare-const log_line_unsat String)
(declare-const ts_unsat String)
(declare-const level_unsat String)
(declare-const date_unsat String)
(declare-const time_unsat String)
(declare-const month_unsat String)
(declare-const month_i_unsat Int)

(assert (>= (str.num_splits log_line_unsat " ") 4))
(assert (= ts_unsat (str.++ (str.split_at log_line_unsat " " 0) " " (str.split_at log_line_unsat " " 1))))
(assert (= level_unsat (str.split_at log_line_unsat " " 2)))

(assert (= date_unsat (str.split_at ts_unsat " " 0)))
(assert (= time_unsat (str.split_at ts_unsat " " 1)))
(assert (= (str.num_splits date_unsat "-") 3))
(assert (= month_unsat (str.split_at date_unsat "-" 1)))

; Month must be exactly two digits
(assert (str.in_re month_unsat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (= month_i_unsat (str.to_int month_unsat)))

; Contradiction: month must be within [1..12] and simultaneously be 13
(assert (>= month_i_unsat 1))
(assert (<= month_i_unsat 12))
(assert (= month_i_unsat 13))

; Contradiction: level is fixed to INFO but must also be ERROR
(assert (= level_unsat "INFO"))
(assert (= level_unsat "ERROR"))

; Give a concrete looking line; contradictions above make it UNSAT anyway
(assert (= log_line_unsat "2024-13-01 00:00:00 INFO core: bad month"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
