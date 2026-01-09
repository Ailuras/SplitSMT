(set-logic ALL)

; Uninterpreted interface functions for str_split

; -----------------------
; Log Analysis scenario
; Parsing structured server log entries separated by spaces and colons.
; Expected shape (typical): "YYYY-MM-DD HH:MM:SS LEVEL: message"
; -----------------------

; Main (intended SAT) instance
(declare-const log_line String)
(declare-const date_part String)
(declare-const time_part String)
(declare-const level_and_rest String)
(declare-const level_token String)
(declare-const message String)

; Auxiliary pieces
(declare-const yyyy String)
(declare-const mm String)
(declare-const dd String)
(declare-const hh String)
(declare-const mi String)
(declare-const ss String)

; Split by spaces: [0]=date [1]=time [2]=LEVEL: [3..]=rest
(assert (>= (str.num_splits log_line " ") 4))
(assert (= date_part (str.split_at log_line " " 0)))
(assert (= time_part (str.split_at log_line " " 1)))
(assert (= level_and_rest (str.split_rest log_line " " 2)))

; level_and_rest begins with token ending in ':' and then a space and message
(assert (>= (str.num_splits level_and_rest " ") 2))
(assert (= level_token (str.split_at level_and_rest " " 0)))
(assert (= message (str.split_rest level_and_rest " " 1)))

; Split log level token by ':' => [0]=LEVEL [1]=empty suffix or extra
(assert (>= (str.num_splits level_token ":") 2))
(assert (= (str.split_at level_token ":" 0) (str.split_at level_token ":" 0)))
(assert (= "" (str.split_at level_token ":" 1)))

; Level must be one of typical levels
(assert (or (= (str.split_at level_token ":" 0) "INFO")
            (= (str.split_at level_token ":" 0) "WARN")
            (= (str.split_at level_token ":" 0) "ERROR")
            (= (str.split_at level_token ":" 0) "DEBUG")))

; Timestamp format validation
; Date: YYYY-MM-DD
(assert (>= (str.num_splits date_part "-") 3))
(assert (= yyyy (str.split_at date_part "-" 0)))
(assert (= mm   (str.split_at date_part "-" 1)))
(assert (= dd   (str.split_at date_part "-" 2)))
(assert (= (str.len yyyy) 4))
(assert (= (str.len mm) 2))
(assert (= (str.len dd) 2))
(assert (str.in_re yyyy (re.+ (re.range "0" "9"))))
(assert (str.in_re mm   (re.++ (re.range "0" "1") (re.range "0" "9"))))
(assert (str.in_re dd   (re.++ (re.range "0" "3") (re.range "0" "9"))))

; Time: HH:MM:SS
(assert (>= (str.num_splits time_part ":") 3))
(assert (= hh (str.split_at time_part ":" 0)))
(assert (= mi (str.split_at time_part ":" 1)))
(assert (= ss (str.split_at time_part ":" 2)))
(assert (= (str.len hh) 2))
(assert (= (str.len mi) 2))
(assert (= (str.len ss) 2))
(assert (str.in_re hh (re.++ (re.range "0" "2") (re.range "0" "9"))))
(assert (str.in_re mi (re.++ (re.range "0" "5") (re.range "0" "9"))))
(assert (str.in_re ss (re.++ (re.range "0" "5") (re.range "0" "9"))))

; Message should be non-empty and contain a colon-separated key:value somewhere (common in structured logs)
(assert (> (str.len message) 0))
(assert (str.contains message ":"))

; Provide a concrete witness (helps SAT and keeps constraints meaningful)
(assert (= log_line "2025-07-19 14:05:33 INFO: user_id:42 action:login"))

; -----------------------
; Additional (intended UNSAT) instance to ensure diversity
; Contradictory requirements on extracted level and timestamp parts.
; -----------------------

(declare-const bad_log_line String)
(declare-const bad_date String)
(declare-const bad_time String)
(declare-const bad_level_and_rest String)
(declare-const bad_level_token String)
(declare-const bad_level String)
(declare-const bad_yyyy String)

(assert (>= (str.num_splits bad_log_line " ") 3))
(assert (= bad_date (str.split_at bad_log_line " " 0)))
(assert (= bad_time (str.split_at bad_log_line " " 1)))
(assert (= bad_level_and_rest (str.split_rest bad_log_line " " 2)))
(assert (= bad_level_token (str.split_at bad_level_and_rest " " 0)))
(assert (>= (str.num_splits bad_level_token ":") 2))
(assert (= bad_level (str.split_at bad_level_token ":" 0)))

; Force the log line to be a specific one with INFO
(assert (= bad_log_line "2025-01-01 00:00:00 INFO: x:y"))

; Contradiction: extracted level must be both INFO and ERROR
(assert (= bad_level "INFO"))
(assert (= bad_level "ERROR"))

; Extra timestamp contradiction: year must be 4 digits, but also explicitly set to length 3
(assert (>= (str.num_splits bad_date "-") 3))
(assert (= bad_yyyy (str.split_at bad_date "-" 0)))
(assert (= (str.len bad_yyyy) 4))
(assert (= (str.len bad_yyyy) 3))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
