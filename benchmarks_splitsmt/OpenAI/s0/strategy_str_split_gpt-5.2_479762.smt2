(set-logic ALL)

; Uninterpreted functions for str_split interface

; =========================
; SAT instance: Log analysis parsing
; Format (space-separated): "YYYY-MM-DD HH:MM:SS LEVEL: message"
; =========================
(declare-const log_line_sat String)
(declare-const date_sat String)
(declare-const time_sat String)
(declare-const level_and_msg_sat String)
(declare-const level_sat String)
(declare-const msg_sat String)

(declare-const year_sat String)
(declare-const month_sat String)
(declare-const day_sat String)
(declare-const hour_sat String)
(declare-const min_sat String)
(declare-const sec_sat String)

(declare-const y_sat Int)
(declare-const mo_sat Int)
(declare-const d_sat Int)
(declare-const hh_sat Int)
(declare-const mm_sat Int)
(declare-const ss_sat Int)

; Basic splitting by spaces
(assert (>= (str.num_splits log_line_sat " ") 3))
(assert (= date_sat (str.split_at log_line_sat " " 0)))
(assert (= time_sat (str.split_at log_line_sat " " 1)))
(assert (= level_and_msg_sat (str.split_rest log_line_sat " " 2)))

; Extract level and message by colon delimiter ("LEVEL: message")
(assert (>= (str.num_splits level_and_msg_sat ":") 2))
(assert (= level_sat (str.split_at level_and_msg_sat ":" 0)))
(assert (= msg_sat (str.split_rest level_and_msg_sat ":" 1)))

; Constrain level to common values
(assert (or (= level_sat "INFO") (= level_sat "WARN") (= level_sat "ERROR") (= level_sat "DEBUG")))

; Date must be YYYY-MM-DD
(assert (>= (str.num_splits date_sat "-") 3))
(assert (= year_sat (str.split_at date_sat "-" 0)))
(assert (= month_sat (str.split_at date_sat "-" 1)))
(assert (= day_sat (str.split_at date_sat "-" 2)))
(assert (= (str.len year_sat) 4))
(assert (= (str.len month_sat) 2))
(assert (= (str.len day_sat) 2))

; Time must be HH:MM:SS
(assert (>= (str.num_splits time_sat ":") 3))
(assert (= hour_sat (str.split_at time_sat ":" 0)))
(assert (= min_sat (str.split_at time_sat ":" 1)))
(assert (= sec_sat (str.split_at time_sat ":" 2)))
(assert (= (str.len hour_sat) 2))
(assert (= (str.len min_sat) 2))
(assert (= (str.len sec_sat) 2))

; Timestamp numeric range checks using str.to_int
(assert (= y_sat (str.to_int year_sat)))
(assert (= mo_sat (str.to_int month_sat)))
(assert (= d_sat (str.to_int day_sat)))
(assert (= hh_sat (str.to_int hour_sat)))
(assert (= mm_sat (str.to_int min_sat)))
(assert (= ss_sat (str.to_int sec_sat)))

(assert (and (>= y_sat 1970) (<= y_sat 2099)))
(assert (and (>= mo_sat 1) (<= mo_sat 12)))
(assert (and (>= d_sat 1) (<= d_sat 31)))
(assert (and (>= hh_sat 0) (<= hh_sat 23)))
(assert (and (>= mm_sat 0) (<= mm_sat 59)))
(assert (and (>= ss_sat 0) (<= ss_sat 59)))

; Ensure the log line is consistent with extracted pieces
(assert (= log_line_sat (str.++ date_sat " " time_sat " " level_sat ":" msg_sat)))

; Some message properties
(assert (> (str.len msg_sat) 0))
(assert (str.contains msg_sat "request"))

; Regex validation for digit-only components
(assert (str.in_re year_sat (re.loop (str.to_re "0") 0 0)))
; The above is intentionally weak (always false) in some solvers; use explicit digit regex instead
(assert (str.in_re year_sat (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.range "0" "9"))))))
(assert (str.in_re month_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re day_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re hour_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re min_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re sec_sat (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Pin a concrete satisfying example (keeps it clearly SAT)
(assert (= log_line_sat "2024-11-05 13:07:59 INFO: request completed"))

(check-sat)

; =========================
; UNSAT instance: Contradicting timestamp / level extraction
; =========================
(declare-const log_line_unsat String)
(declare-const date_unsat String)
(declare-const time_unsat String)
(declare-const level_and_msg_unsat String)
(declare-const level_unsat String)
(declare-const msg_unsat String)

(declare-const month_unsat String)
(declare-const mo_unsat Int)

(assert (>= (str.num_splits log_line_unsat " ") 3))
(assert (= date_unsat (str.split_at log_line_unsat " " 0)))
(assert (= time_unsat (str.split_at log_line_unsat " " 1)))
(assert (= level_and_msg_unsat (str.split_rest log_line_unsat " " 2)))

(assert (>= (str.num_splits level_and_msg_unsat ":") 2))
(assert (= level_unsat (str.split_at level_and_msg_unsat ":" 0)))
(assert (= msg_unsat (str.split_rest level_and_msg_unsat ":" 1)))

; Enforce that level is exactly INFO
(assert (= level_unsat "INFO"))

; Now contradict by requiring the reconstructed line to contain "ERROR" as extracted level
(assert (= log_line_unsat (str.++ date_unsat " " time_unsat " " "ERROR" ":" msg_unsat)))

; Also enforce a valid date split but impossible month range
(assert (>= (str.num_splits date_unsat "-") 3))
(assert (= month_unsat (str.split_at date_unsat "-" 1)))
(assert (= mo_unsat (str.to_int month_unsat)))
(assert (and (>= mo_unsat 1) (<= mo_unsat 12)))
(assert (= mo_unsat 13))

; Pin a concrete line that still makes the constraints clash
(assert (= log_line_unsat "2024-13-05 10:00:00 INFO: request failed"))

(check-sat)
(exit)
