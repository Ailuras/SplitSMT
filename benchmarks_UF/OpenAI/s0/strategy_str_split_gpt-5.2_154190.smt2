(set-logic ALL)

; Uninterpreted interface for string split operations
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; -------------------------
; SAT instance: well-formed log line parsing
; Format: "YYYY-MM-DD HH:MM:SS LEVEL: message"
; -------------------------
(declare-const log_line_sat String)
(declare-const date_sat String)
(declare-const time_sat String)
(declare-const level_field_sat String)
(declare-const level_sat String)
(declare-const message_sat String)
(declare-const year_sat String)
(declare-const month_sat String)
(declare-const day_sat String)
(declare-const hour_sat String)
(declare-const minute_sat String)
(declare-const second_sat String)

(assert (= date_sat (split_at log_line_sat " " 0)))
(assert (= time_sat (split_at log_line_sat " " 1)))
(assert (= level_field_sat (split_at log_line_sat " " 2)))
(assert (= message_sat (split_rest log_line_sat " " 3)))
(assert (>= (num_splits log_line_sat " ") 4))

; Timestamp structure checks (date and time split by '-' and ':')
(assert (>= (num_splits date_sat "-") 3))
(assert (= year_sat (split_at date_sat "-" 0)))
(assert (= month_sat (split_at date_sat "-" 1)))
(assert (= day_sat (split_at date_sat "-" 2)))

(assert (>= (num_splits time_sat ":") 3))
(assert (= hour_sat (split_at time_sat ":" 0)))
(assert (= minute_sat (split_at time_sat ":" 1)))
(assert (= second_sat (split_at time_sat ":" 2)))

; Length checks
(assert (= (str.len year_sat) 4))
(assert (= (str.len month_sat) 2))
(assert (= (str.len day_sat) 2))
(assert (= (str.len hour_sat) 2))
(assert (= (str.len minute_sat) 2))
(assert (= (str.len second_sat) 2))

; Digit-only checks via regex
(assert (str.in_re year_sat (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.range "0" "9"))))))
(assert (str.in_re month_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re day_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re hour_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re minute_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re second_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Basic range checks using lexicographic-safe constraints by mapping to Int via str.to_int
; Note: str.to_int returns -1 if not a valid numeral, but we already constrain digits.
(declare-const month_i Int)
(declare-const day_i Int)
(declare-const hour_i Int)
(declare-const minute_i Int)
(declare-const second_i Int)
(assert (= month_i (str.to_int month_sat)))
(assert (= day_i (str.to_int day_sat)))
(assert (= hour_i (str.to_int hour_sat)))
(assert (= minute_i (str.to_int minute_sat)))
(assert (= second_i (str.to_int second_sat)))
(assert (and (<= 1 month_i) (<= month_i 12)))
(assert (and (<= 1 day_i) (<= day_i 31)))
(assert (and (<= 0 hour_i) (<= hour_i 23)))
(assert (and (<= 0 minute_i) (<= minute_i 59)))
(assert (and (<= 0 second_i) (<= second_i 59)))

; Log level extraction: LEVEL:
(assert (>= (str.len level_field_sat) 2))
(assert (= (str.at level_field_sat (- (str.len level_field_sat) 1)) ":"))
(assert (= level_sat (str.substr level_field_sat 0 (- (str.len level_field_sat) 1))))

; Level must be one of {INFO,WARN,ERROR,DEBUG}
(assert (or (= level_sat "INFO") (= level_sat "WARN") (= level_sat "ERROR") (= level_sat "DEBUG")))

; Message sanity constraints
(assert (> (str.len message_sat) 0))
(assert (not (str.contains message_sat "\n")))

; Concretize one satisfying example (still consistent with all constraints)
(assert (= log_line_sat "2025-01-09 07:15:59 INFO: service started"))

(check-sat)

; -------------------------
; UNSAT instance: contradictory requirements for the same parsing rules
; -------------------------
(declare-const log_line_unsat String)
(declare-const date_unsat String)
(declare-const time_unsat String)
(declare-const level_field_unsat String)
(declare-const level_unsat String)
(declare-const message_unsat String)
(declare-const month_unsat String)
(declare-const minute_unsat String)
(declare-const month_unsat_i Int)
(declare-const minute_unsat_i Int)

(assert (= date_unsat (split_at log_line_unsat " " 0)))
(assert (= time_unsat (split_at log_line_unsat " " 1)))
(assert (= level_field_unsat (split_at log_line_unsat " " 2)))
(assert (= message_unsat (split_rest log_line_unsat " " 3)))
(assert (>= (num_splits log_line_unsat " ") 4))

; Pull out month and minute from the split components
(assert (>= (num_splits date_unsat "-") 3))
(assert (= month_unsat (split_at date_unsat "-" 1)))
(assert (>= (num_splits time_unsat ":") 3))
(assert (= minute_unsat (split_at time_unsat ":" 1)))

; Enforce digits and exact width
(assert (= (str.len month_unsat) 2))
(assert (= (str.len minute_unsat) 2))
(assert (str.in_re month_unsat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re minute_unsat (re.++ (re.range "0" "9") (re.range "0" "9"))))

(assert (= month_unsat_i (str.to_int month_unsat)))
(assert (= minute_unsat_i (str.to_int minute_unsat)))

; Contradictory range constraints (force UNSAT)
(assert (and (<= 1 month_unsat_i) (<= month_unsat_i 12)))
(assert (and (<= 13 month_unsat_i) (<= month_unsat_i 99)))

; Also enforce level field structure but contradict the allowed level
(assert (>= (str.len level_field_unsat) 2))
(assert (= (str.at level_field_unsat (- (str.len level_field_unsat) 1)) ":"))
(assert (= level_unsat (str.substr level_field_unsat 0 (- (str.len level_field_unsat) 1))))
(assert (or (= level_unsat "INFO") (= level_unsat "WARN") (= level_unsat "ERROR") (= level_unsat "DEBUG")))
(assert (= level_unsat "TRACE"))

; Make the line otherwise look plausible
(assert (= log_line_unsat "2025-01-09 07:15:59 TRACE: impossible"))

(check-sat)


; [GENERATION STATUS: SUCCESS]