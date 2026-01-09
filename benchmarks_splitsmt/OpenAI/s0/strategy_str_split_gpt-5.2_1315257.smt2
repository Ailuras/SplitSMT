(set-logic ALL)

; Uninterpreted interface functions for string split

; ============================
; Scenario: Log Analysis (SAT instance)
; Log format (intended): "YYYY-MM-DD HH:MM:SS LEVEL: message..."
; Parsing structured server log entries separated by spaces and colons.
; ============================

(declare-const log_line String)
(declare-const date_part String)
(declare-const time_part String)
(declare-const level_and_msg String)
(declare-const level_str String)
(declare-const msg_str String)

(declare-const year String)
(declare-const month String)
(declare-const day String)
(declare-const hour String)
(declare-const minute String)
(declare-const second String)

; Split on spaces: expect at least 3 segments: date, time, and rest
(assert (>= (str.num_splits log_line " ") 3))
(assert (= date_part (str.split_at log_line " " 0)))
(assert (= time_part (str.split_at log_line " " 1)))
(assert (= level_and_msg (str.split_rest log_line " " 2)))

; Split date on '-' into Y,M,D
(assert (>= (str.num_splits date_part "-") 3))
(assert (= year  (str.split_at date_part "-" 0)))
(assert (= month (str.split_at date_part "-" 1)))
(assert (= day   (str.split_at date_part "-" 2)))

; Timestamp basic shape checks
(assert (= (str.len year) 4))
(assert (= (str.len month) 2))
(assert (= (str.len day) 2))

(assert (str.in_re year (re.+ (re.range "0" "9"))))
(assert (str.in_re month (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re day (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Split time on ':' into HH,MM,SS
(assert (>= (str.num_splits time_part ":") 3))
(assert (= hour   (str.split_at time_part ":" 0)))
(assert (= minute (str.split_at time_part ":" 1)))
(assert (= second (str.split_at time_part ":" 2)))

(assert (= (str.len hour) 2))
(assert (= (str.len minute) 2))
(assert (= (str.len second) 2))

(assert (str.in_re hour   (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re minute (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re second (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Range checks for time fields
(assert (and (>= (str.to_int hour) 0) (<= (str.to_int hour) 23)))
(assert (and (>= (str.to_int minute) 0) (<= (str.to_int minute) 59)))
(assert (and (>= (str.to_int second) 0) (<= (str.to_int second) 59)))

; Extract log level by splitting on ':' (first colon separates LEVEL from message)
(assert (>= (str.num_splits level_and_msg ":") 2))
(assert (= level_str (str.split_at level_and_msg ":" 0)))
(assert (= msg_str (str.split_rest level_and_msg ":" 1)))

; Allowable levels
(assert (or (= level_str "INFO") (= level_str "WARN") (= level_str "ERROR") (= level_str "DEBUG")))

; Message constraints (must exist, basic sanity)
(assert (>= (str.len msg_str) 1))
(assert (not (str.contains msg_str "\n")))

; A concrete example witness for satisfiable parsing
(assert (= log_line "2026-01-09 07:15:42 INFO: service started"))

(check-sat)

; ============================
; Scenario: Log Analysis (UNSAT instance)
; Conflicting requirements: force second=60 while also constraining seconds <=59
; ============================

(declare-const bad_log_line String)
(declare-const bad_date String)
(declare-const bad_time String)
(declare-const bad_rest String)
(declare-const bad_second String)

(assert (>= (str.num_splits bad_log_line " ") 3))
(assert (= bad_date (str.split_at bad_log_line " " 0)))
(assert (= bad_time (str.split_at bad_log_line " " 1)))
(assert (= bad_rest (str.split_rest bad_log_line " " 2)))

(assert (>= (str.num_splits bad_time ":") 3))
(assert (= bad_second (str.split_at bad_time ":" 2)))
(assert (= (str.len bad_second) 2))
(assert (str.in_re bad_second (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Range constraint says seconds <= 59
(assert (and (>= (str.to_int bad_second) 0) (<= (str.to_int bad_second) 59)))

; Force seconds to be "60" which contradicts the range
(assert (= bad_log_line "2026-01-09 12:00:60 ERROR: impossible second"))
(assert (= bad_second "60"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
