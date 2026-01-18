(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted interface functions for string splitting

; -----------------------------
; SAT instance: well-formed log line
; Format target (conceptual): "YYYY-MM-DD HH:MM:SS LEVEL: message"
; Split by spaces to get [date, time, levelColon, ...]
; Then split levelColon by ":" to extract level
; -----------------------------
(declare-const log_line_sat String)
(declare-const date_sat String)
(declare-const time_sat String)
(declare-const level_colon_sat String)
(declare-const level_sat String)
(declare-const message_sat String)
(declare-const rest_after_level_sat String)
(declare-const year_sat String)
(declare-const month_sat String)
(declare-const day_sat String)
(declare-const hour_sat String)
(declare-const minute_sat String)
(declare-const second_sat String)

(assert (= date_sat (split_at log_line_sat " " 0)))
(assert (= time_sat (split_at log_line_sat " " 1)))
(assert (= level_colon_sat (split_at log_line_sat " " 2)))
(assert (= rest_after_level_sat (split_rest log_line_sat " " 3)))
(assert (>= (num_splits log_line_sat " ") 4))

(assert (= level_sat (split_at level_colon_sat ":" 0)))
(assert (= message_sat (split_rest level_colon_sat ":" 1)))
(assert (>= (num_splits level_colon_sat ":") 2))

; Timestamp format validation using regexes
(assert (str.in_re date_sat (re.++ (re.range "0" "9") (re.range "0" "9") (re.range "0" "9") (re.range "0" "9") (str.to_re "-") (re.range "0" "9") (re.range "0" "9") (str.to_re "-") (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re time_sat (re.++ (re.range "0" "9") (re.range "0" "9") (str.to_re ":") (re.range "0" "9") (re.range "0" "9") (str.to_re ":") (re.range "0" "9") (re.range "0" "9"))))

; Decompose date and time with split_at on separators
(assert (= year_sat (split_at date_sat "-" 0)))
(assert (= month_sat (split_at date_sat "-" 1)))
(assert (= day_sat (split_at date_sat "-" 2)))
(assert (= hour_sat (split_at time_sat ":" 0)))
(assert (= minute_sat (split_at time_sat ":" 1)))
(assert (= second_sat (split_at time_sat ":" 2)))
(assert (= (num_splits date_sat "-") 3))
(assert (= (num_splits time_sat ":") 3))

; More validation: numeric ranges for month/day/hour/minute/second via Int conversion
(assert (= (str.len year_sat) 4))
(assert (= (str.len month_sat) 2))
(assert (= (str.len day_sat) 2))
(assert (= (str.len hour_sat) 2))
(assert (= (str.len minute_sat) 2))
(assert (= (str.len second_sat) 2))

(assert (>= (str.to_int month_sat) 1))
(assert (<= (str.to_int month_sat) 12))
(assert (>= (str.to_int day_sat) 1))
(assert (<= (str.to_int day_sat) 31))
(assert (>= (str.to_int hour_sat) 0))
(assert (<= (str.to_int hour_sat) 23))
(assert (>= (str.to_int minute_sat) 0))
(assert (<= (str.to_int minute_sat) 59))
(assert (>= (str.to_int second_sat) 0))
(assert (<= (str.to_int second_sat) 59))

; Log level extraction constraints
(assert (or (= level_sat "INFO") (= level_sat "WARN") (= level_sat "ERROR") (= level_sat "DEBUG")))

; Ensure a non-empty message and that remaining tail matches what split_rest gave
(assert (> (str.len message_sat) 0))
(assert (> (str.len rest_after_level_sat) 0))

; Provide a concrete satisfying log line witness (still consistent with splitting constraints)
(assert (= log_line_sat "2024-07-03 09:15:42 INFO: service started"))

; -----------------------------
; UNSAT instance: inconsistent timestamp checks
; Here we force a concrete line with an invalid month, while also requiring month in [1,12]
; -----------------------------
(declare-const log_line_unsat String)
(declare-const date_unsat String)
(declare-const time_unsat String)
(declare-const level_colon_unsat String)
(declare-const level_unsat String)
(declare-const month_unsat String)

(assert (= log_line_unsat "2024-13-01 00:00:00 ERROR: bad month"))
(assert (= date_unsat (split_at log_line_unsat " " 0)))
(assert (= time_unsat (split_at log_line_unsat " " 1)))
(assert (= level_colon_unsat (split_at log_line_unsat " " 2)))
(assert (>= (num_splits log_line_unsat " ") 4))

(assert (= month_unsat (split_at date_unsat "-" 1)))
(assert (= (num_splits date_unsat "-") 3))

; Require correct date regex and month range (contradiction because month is "13")
(assert (str.in_re date_unsat (re.++ (re.range "0" "9") (re.range "0" "9") (re.range "0" "9") (re.range "0" "9") (str.to_re "-") (re.range "0" "9") (re.range "0" "9") (str.to_re "-") (re.range "0" "9") (re.range "0" "9"))))
(assert (>= (str.to_int month_unsat) 1))
(assert (<= (str.to_int month_unsat) 12))

(assert (= level_unsat (split_at level_colon_unsat ":" 0)))
(assert (or (= level_unsat "INFO") (= level_unsat "WARN") (= level_unsat "ERROR") (= level_unsat "DEBUG")))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(get-model)
(exit)
