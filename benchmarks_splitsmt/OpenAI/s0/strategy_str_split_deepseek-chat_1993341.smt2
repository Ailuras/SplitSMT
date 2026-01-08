(set-logic ALL)

; Uninterpreted split interface

; ----------------------------
; Scenario: Log Analysis
; Parsing structured server log entries separated by spaces and colons.
; Expected rough form:
;   "YYYY-MM-DD HH:MM:SS LEVEL: message..."
; We extract timestamp pieces and level and validate formats.
; ----------------------------

; ===== SAT instance =====
(declare-const log_line_sat String)
(declare-const date_sat String)
(declare-const time_sat String)
(declare-const level_with_colon_sat String)
(declare-const level_sat String)
(declare-const msg_sat String)

(declare-const year_sat String)
(declare-const month_sat String)
(declare-const day_sat String)
(declare-const hour_sat String)
(declare-const minute_sat String)
(declare-const second_sat String)

; Split by spaces: date, time, "LEVEL:", rest-of-message
(assert (= date_sat (str.split_at log_line_sat " " 0)))
(assert (= time_sat (str.split_at log_line_sat " " 1)))
(assert (= level_with_colon_sat (str.split_at log_line_sat " " 2)))
(assert (= msg_sat (str.split_rest log_line_sat " " 3)))
(assert (>= (str.num_splits log_line_sat " ") 4))

; Split level token by ':' => "LEVEL" then "" (since token ends with ':')
(assert (= level_sat (str.split_at level_with_colon_sat ":" 0)))
(assert (>= (str.num_splits level_with_colon_sat ":") 2))

; Date format YYYY-MM-DD
(assert (= year_sat (str.split_at date_sat "-" 0)))
(assert (= month_sat (str.split_at date_sat "-" 1)))
(assert (= day_sat (str.split_at date_sat "-" 2)))
(assert (= (str.num_splits date_sat "-") 3))
(assert (= (str.len year_sat) 4))
(assert (= (str.len month_sat) 2))
(assert (= (str.len day_sat) 2))

; Time format HH:MM:SS
(assert (= hour_sat (str.split_at time_sat ":" 0)))
(assert (= minute_sat (str.split_at time_sat ":" 1)))
(assert (= second_sat (str.split_at time_sat ":" 2)))
(assert (= (str.num_splits time_sat ":") 3))
(assert (= (str.len hour_sat) 2))
(assert (= (str.len minute_sat) 2))
(assert (= (str.len second_sat) 2))

; Regex digit checks
(assert (str.in_re year_sat (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.range "0" "9"))))))
(assert (str.in_re month_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re day_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re hour_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re minute_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re second_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Log level extraction checks
(assert (or (= level_sat "INFO") (= level_sat "WARN") (= level_sat "ERROR") (= level_sat "DEBUG")))
(assert (> (str.len msg_sat) 0))

; Provide one concrete satisfying example to anchor SAT
(assert (= log_line_sat "2025-01-07 13:05:09 INFO: service started"))

; ===== UNSAT instance =====
(declare-const log_line_unsat String)
(declare-const date_unsat String)
(declare-const time_unsat String)
(declare-const level_with_colon_unsat String)
(declare-const level_unsat String)

(declare-const year_unsat String)
(declare-const month_unsat String)
(declare-const day_unsat String)

; Basic splitting like above
(assert (= date_unsat (str.split_at log_line_unsat " " 0)))
(assert (= time_unsat (str.split_at log_line_unsat " " 1)))
(assert (= level_with_colon_unsat (str.split_at log_line_unsat " " 2)))
(assert (>= (str.num_splits log_line_unsat " ") 3))
(assert (= level_unsat (str.split_at level_with_colon_unsat ":" 0)))

; Force a concrete line with a non-numeric month "AB" while requiring digits => contradiction
(assert (= log_line_unsat "2025-AB-07 13:05:09 ERROR: bad timestamp"))

(assert (= year_unsat (str.split_at date_unsat "-" 0)))
(assert (= month_unsat (str.split_at date_unsat "-" 1)))
(assert (= day_unsat (str.split_at date_unsat "-" 2)))
(assert (= (str.num_splits date_unsat "-") 3))
(assert (= (str.len month_unsat) 2))
(assert (str.in_re month_unsat (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Additionally require level to be one of the standard ones (holds for ERROR, but month causes UNSAT)
(assert (or (= level_unsat "INFO") (= level_unsat "WARN") (= level_unsat "ERROR") (= level_unsat "DEBUG")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
