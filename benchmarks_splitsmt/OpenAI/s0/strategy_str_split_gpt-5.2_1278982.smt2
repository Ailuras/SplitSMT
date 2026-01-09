(set-logic ALL)

; Uninterpreted str_split interface

; --- SAT instance: parse and validate a structured log entry ---
(declare-const log_line String)
(declare-const ts_date String)
(declare-const ts_time String)
(declare-const log_level String)
(declare-const component String)
(declare-const message String)
(declare-const ts_hour String)
(declare-const ts_min String)
(declare-const ts_sec String)
(declare-const ts_year String)
(declare-const ts_month String)
(declare-const ts_day String)

; Basic shape: "YYYY-MM-DD HH:MM:SS LEVEL component: message"
(assert (= ts_date (str.split_at log_line " " 0)))
(assert (= ts_time (str.split_at log_line " " 1)))
(assert (= log_level (str.split_at log_line " " 2)))
(assert (= component (str.split_at log_line " " 3)))
(assert (= message (str.split_rest log_line " " 4)))
(assert (>= (str.num_splits log_line " ") 5))

; Timestamp date validation: YYYY-MM-DD
(assert (= ts_year (str.split_at ts_date "-" 0)))
(assert (= ts_month (str.split_at ts_date "-" 1)))
(assert (= ts_day (str.split_at ts_date "-" 2)))
(assert (= (str.num_splits ts_date "-") 3))
(assert (= (str.len ts_year) 4))
(assert (= (str.len ts_month) 2))
(assert (= (str.len ts_day) 2))
(assert (str.in_re ts_year (re.+ (re.range "0" "9"))))
(assert (str.in_re ts_month (re.++ (re.range "0" "1") (re.range "0" "9"))))
(assert (str.in_re ts_day (re.++ (re.range "0" "3") (re.range "0" "9"))))

; Timestamp time validation: HH:MM:SS
(assert (= ts_hour (str.split_at ts_time ":" 0)))
(assert (= ts_min (str.split_at ts_time ":" 1)))
(assert (= ts_sec (str.split_at ts_time ":" 2)))
(assert (= (str.num_splits ts_time ":") 3))
(assert (= (str.len ts_hour) 2))
(assert (= (str.len ts_min) 2))
(assert (= (str.len ts_sec) 2))
(assert (str.in_re ts_hour (re.++ (re.range "0" "2") (re.range "0" "9"))))
(assert (str.in_re ts_min (re.++ (re.range "0" "5") (re.range "0" "9"))))
(assert (str.in_re ts_sec (re.++ (re.range "0" "5") (re.range "0" "9"))))

; Log level extraction check
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR") (= log_level "DEBUG")))

; Component token ends with ':' and message is non-empty
(assert (str.suffixof ":" component))
(assert (> (str.len message) 0))

; Concrete example to ensure SAT with consistent parsing
(assert (= log_line "2026-01-09 13:45:22 INFO auth: user=alice action=login"))

; --- UNSAT instance: contradictory checks for another log line ---
(declare-const bad_line String)
(declare-const bad_level String)
(declare-const bad_ts_time String)
(declare-const bad_hour String)
(declare-const bad_min String)
(declare-const bad_sec String)

(assert (= bad_ts_time (str.split_at bad_line " " 1)))
(assert (= bad_level (str.split_at bad_line " " 2)))
(assert (>= (str.num_splits bad_line " ") 4))

; Force the level to be INFO but also not INFO (contradiction)
(assert (= bad_level "INFO"))
(assert (not (= bad_level "INFO")))

; Additionally constrain time to have 3 parts, then contradict it by requiring 2
(assert (= bad_hour (str.split_at bad_ts_time ":" 0)))
(assert (= bad_min (str.split_at bad_ts_time ":" 1)))
(assert (= bad_sec (str.split_at bad_ts_time ":" 2)))
(assert (= (str.num_splits bad_ts_time ":") 3))
(assert (= (str.num_splits bad_ts_time ":") 2))

; Concrete bad line (still irrelevant due to above contradictions)
(assert (= bad_line "2026-01-09 25:61:61 INFO core: impossible"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
