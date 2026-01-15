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

; Assert that the log entry has at least 4 segments when split by spaces
(assert (>= (num_splits log_entry " ") 4))

; Extract timestamp as the first segment (index 0) when splitting by space
(assert (= timestamp (split_at log_entry " " 0)))

; Extract log level as the second segment (index 1) when splitting by space
(assert (= log_level (split_at log_entry " " 1)))

; Extract IP address as the third segment (index 2) when splitting by space
(assert (= ip_address (split_at log_entry " " 2)))

; Extract message as the concatenation of all segments from index 3 onwards when splitting by space
(assert (= message (split_rest log_entry " " 3)))

; Validate timestamp format: should contain a colon and be at least 8 characters long
(assert (str.contains timestamp ":"))
(assert (>= (str.len timestamp) 8))

; Validate log level: must be one of "INFO", "WARN", or "ERROR"
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR")))

; Additional constraint: IP address should contain a dot and be at least 7 characters long
(assert (str.contains ip_address "."))
(assert (>= (str.len ip_address) 7))

; Ensure the message is non-empty
(assert (> (str.len message) 0))

; Add a specific example to make it SAT: define a concrete log entry
(assert (= log_entry "2023-10-05T14:30:00 INFO 192.168.1.1 User login successful"))

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
