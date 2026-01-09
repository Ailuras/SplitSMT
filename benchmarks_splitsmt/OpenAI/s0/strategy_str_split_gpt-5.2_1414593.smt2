(set-logic ALL)

; Uninterpreted interface: str_split

; Scenario: Log Analysis
; Format (space-separated): "YYYY-MM-DD HH:MM:SS LEVEL: module: message"

(declare-const log_line String)
(declare-const ts_date String)
(declare-const ts_time String)
(declare-const ts_full String)
(declare-const level_and_rest String)
(declare-const level_token String)
(declare-const module_token String)
(declare-const message_tail String)

(declare-const year String)
(declare-const month String)
(declare-const day String)
(declare-const hour String)
(declare-const minute String)
(declare-const second String)

(declare-const i_year Int)
(declare-const i_month Int)
(declare-const i_day Int)
(declare-const i_hour Int)
(declare-const i_minute Int)
(declare-const i_second Int)

(declare-const sat_witness String)
(declare-const sat_level String)
(declare-const sat_msg String)

(declare-const unsat_line String)
(declare-const unsat_level String)

; ------------------------
; General parsing constraints on log_line
; ------------------------

; Split by spaces: [0]=date, [1]=time, [2]=LEVEL:, rest
(assert (>= (str.num_splits log_line " ") 4))
(assert (= ts_date (str.split_at log_line " " 0)))
(assert (= ts_time (str.split_at log_line " " 1)))
(assert (= level_and_rest (str.split_rest log_line " " 2)))
(assert (= ts_full (str.++ ts_date " " ts_time)))

; Validate date structure YYYY-MM-DD via split by "-"
(assert (= year (str.split_at ts_date "-" 0)))
(assert (= month (str.split_at ts_date "-" 1)))
(assert (= day (str.split_at ts_date "-" 2)))
(assert (= (str.num_splits ts_date "-") 3))
(assert (= (str.len year) 4))
(assert (= (str.len month) 2))
(assert (= (str.len day) 2))

; Validate time structure HH:MM:SS via split by ":"
(assert (= hour (str.split_at ts_time ":" 0)))
(assert (= minute (str.split_at ts_time ":" 1)))
(assert (= second (str.split_at ts_time ":" 2)))
(assert (= (str.num_splits ts_time ":") 3))
(assert (= (str.len hour) 2))
(assert (= (str.len minute) 2))
(assert (= (str.len second) 2))

; Digits-only and ranges for date/time fields
(assert (str.in_re year (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.range "0" "9"))))))
(assert (str.in_re month (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re day (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re hour (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re minute (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re second (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Convert to integers
(assert (= i_year (str.to_int year)))
(assert (= i_month (str.to_int month)))
(assert (= i_day (str.to_int day)))
(assert (= i_hour (str.to_int hour)))
(assert (= i_minute (str.to_int minute)))
(assert (= i_second (str.to_int second)))

; Range constraints (simplified calendar)
(assert (and (>= i_year 1970) (<= i_year 2099)))
(assert (and (>= i_month 1) (<= i_month 12)))
(assert (and (>= i_day 1) (<= i_day 31)))
(assert (and (>= i_hour 0) (<= i_hour 23)))
(assert (and (>= i_minute 0) (<= i_minute 59)))
(assert (and (>= i_second 0) (<= i_second 59)))

; Parse level/module/message by splitting level_and_rest on ": "
; Expected: "LEVEL: module: message..."
(assert (>= (str.num_splits level_and_rest ": ") 3))
(assert (= level_token (str.split_at level_and_rest ": " 0)))
(assert (= module_token (str.split_at level_and_rest ": " 1)))
(assert (= message_tail (str.split_rest level_and_rest ": " 2)))

; Log level validation
(assert (or (= level_token "INFO") (= level_token "WARN") (= level_token "ERROR") (= level_token "DEBUG")))

; Module token should be non-empty and alnum/underscore/dash
(assert (>= (str.len module_token) 1))
(assert (str.in_re module_token (re.+ (re.union (re.range "a" "z") (re.union (re.range "A" "Z") (re.union (re.range "0" "9") (re.union (str.to_re "_") (str.to_re "-"))))))))

; Message should be non-empty
(assert (>= (str.len message_tail) 1))

; ------------------------
; SAT instance (existence witness): ensure some line can be valid
; ------------------------

; sat_witness is an example-valid line, linked to parsing constraints by equality
(assert (= log_line sat_witness))

; Constrain witness to contain a known substring and be consistent with parsed level/message
(assert (str.contains sat_witness "INFO"))
(assert (str.contains sat_witness "module"))
(assert (str.contains sat_witness "started"))

; Tie additional extracted variables to confirm extraction behavior
(assert (= sat_level level_token))
(assert (= sat_msg message_tail))

; Provide a concrete satisfiable witness (still respects all assertions)
(assert (= sat_witness "2024-01-09 13:45:07 INFO: module: started"))

; ------------------------
; UNSAT instance: a second independent log line that cannot satisfy level constraints
; ------------------------

; Force unsat_line to have a well-formed timestamp and delimiter structure, but an impossible level
(assert (>= (str.num_splits unsat_line " ") 4))
(assert (= (str.split_at unsat_line " " 0) "2024-01-09"))
(assert (= (str.split_at unsat_line " " 1) "13:45:07"))
(assert (= unsat_level (str.split_at (str.split_rest unsat_line " " 2) ": " 0)))
(assert (>= (str.num_splits (str.split_rest unsat_line " " 2) ": ") 3))

; Contradictory level constraints (must be both INFO and not INFO)
(assert (= unsat_level "INFO"))
(assert (not (= unsat_level "INFO")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
