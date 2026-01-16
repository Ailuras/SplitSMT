; Log Analysis: Parsing structured server log entries with str_split operations
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Declare variables for log entry and its components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)
(declare-const ip_address String)

; Declare uninterpreted functions for str_split interface

; Example log format: "2023-10-05 14:30:00 INFO 192.168.1.1 User login successful"
; Split by space to extract components
(assert (>= (num_splits log_entry " ") 5))
(assert (= timestamp (split_at log_entry " " 0)))
(assert (= log_level (split_at log_entry " " 2)))
(assert (= ip_address (split_at log_entry " " 3)))
(assert (= message (split_rest log_entry " " 4)))

; Validate timestamp format: YYYY-MM-DD HH:MM:SS
; Check that timestamp has exactly two parts separated by space
(assert (>= (num_splits timestamp " ") 2))
(declare-const date_part String)
(declare-const time_part String)
(assert (= date_part (split_at timestamp " " 0)))
(assert (= time_part (split_at timestamp " " 1)))

; Date part: YYYY-MM-DD
(assert (= (str.len date_part) 10))
(assert (str.contains date_part "-"))
(assert (>= (num_splits date_part "-") 3))

; Time part: HH:MM:SS
(assert (= (str.len time_part) 8))
(assert (str.contains time_part ":"))
(assert (>= (num_splits time_part ":") 3))

; Log level validation: must be one of INFO, WARN, ERROR
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR")))

; Additional constraint: IP address format (simplified check for dots)
(assert (str.contains ip_address "."))
(assert (>= (num_splits ip_address ".") 4))

; Ensure message is non-empty
(assert (> (str.len message) 0))

; Create a SAT instance by setting a specific log entry
(assert (= log_entry "2023-10-05 14:30:00 INFO 192.168.1.1 User login successful"))


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
