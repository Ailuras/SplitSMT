(set-logic ALL)

; Uninterpreted interface for string splitting
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; -------------------------
; SAT instance: well-formed log line
; Format: "YYYY-MM-DD HH:MM:SS LEVEL: message"
; -------------------------
(declare-const log_line String)
(declare-const date_part String)
(declare-const time_part String)
(declare-const level_colon_part String)
(declare-const level String)
(declare-const message String)

(declare-const year String)
(declare-const month String)
(declare-const day String)
(declare-const hour String)
(declare-const minute String)
(declare-const second String)

(declare-const y Int)
(declare-const mon Int)
(declare-const d Int)
(declare-const h Int)
(declare-const mi Int)
(declare-const s Int)

; Split by spaces into: [date, time, rest...]
(assert (= date_part (split_at log_line " " 0)))
(assert (= time_part (split_at log_line " " 1)))
(assert (= level_colon_part (split_at log_line " " 2)))
(assert (= message (split_rest log_line " " 3)))
(assert (>= (num_splits log_line " ") 4))

; Extract level from "LEVEL:" by splitting on ":"
(assert (= level (split_at level_colon_part ":" 0)))
(assert (>= (num_splits level_colon_part ":") 2))

; Timestamp structure checks using splitting
(assert (= year (split_at date_part "-" 0)))
(assert (= month (split_at date_part "-" 1)))
(assert (= day (split_at date_part "-" 2)))
(assert (= hour (split_at time_part ":" 0)))
(assert (= minute (split_at time_part ":" 1)))
(assert (= second (split_at time_part ":" 2)))
(assert (= (num_splits date_part "-") 3))
(assert (= (num_splits time_part ":") 3))

; Length constraints for timestamp components
(assert (= (str.len year) 4))
(assert (= (str.len month) 2))
(assert (= (str.len day) 2))
(assert (= (str.len hour) 2))
(assert (= (str.len minute) 2))
(assert (= (str.len second) 2))

; Digits-only regex for each component
(assert (str.in_re year (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.range "0" "9"))))))
(assert (str.in_re month (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re day (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re hour (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re minute (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re second (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Numeric range constraints via str.to_int
(assert (= y (str.to_int year)))
(assert (= mon (str.to_int month)))
(assert (= d (str.to_int day)))
(assert (= h (str.to_int hour)))
(assert (= mi (str.to_int minute)))
(assert (= s (str.to_int second)))
(assert (and (<= 1970 y) (<= y 2099)))
(assert (and (<= 1 mon) (<= mon 12)))
(assert (and (<= 1 d) (<= d 31)))
(assert (and (<= 0 h) (<= h 23)))
(assert (and (<= 0 mi) (<= mi 59)))
(assert (and (<= 0 s) (<= s 59)))

; Log level allowed set
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))

; Sanity: ensure message exists and does not contain newline
(assert (>= (str.len message) 1))
(assert (not (str.contains message "\n")))

; Build a concrete satisfying example to anchor SAT instance
(assert (= log_line "2024-11-05 19:07:03 ERROR: disk full"))

; -------------------------
; UNSAT instance: contradicting constraints on a second log line
; -------------------------
(declare-const bad_log String)
(declare-const bad_date String)
(declare-const bad_time String)
(declare-const bad_level_colon String)
(declare-const bad_level String)
(declare-const bad_year String)
(declare-const bad_month String)
(declare-const bad_day String)
(declare-const bad_mon_int Int)

(assert (= bad_date (split_at bad_log " " 0)))
(assert (= bad_time (split_at bad_log " " 1)))
(assert (= bad_level_colon (split_at bad_log " " 2)))
(assert (>= (num_splits bad_log " ") 3))

(assert (= bad_level (split_at bad_level_colon ":" 0)))
(assert (>= (num_splits bad_level_colon ":") 2))

(assert (= bad_year (split_at bad_date "-" 0)))
(assert (= bad_month (split_at bad_date "-" 1)))
(assert (= bad_day (split_at bad_date "-" 2)))
(assert (= (num_splits bad_date "-") 3))

; Force a concrete bad log
(assert (= bad_log "2023-13-01 00:00:00 INFO: ok"))

; Also require the month to be within range (1..12) but simultaneously equal to 13 -> UNSAT
(assert (= (str.len bad_month) 2))
(assert (str.in_re bad_month (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (= bad_mon_int (str.to_int bad_month)))
(assert (and (<= 1 bad_mon_int) (<= bad_mon_int 12)))
(assert (= bad_mon_int 13))

(check-sat)


; [GENERATION STATUS: SUCCESS]