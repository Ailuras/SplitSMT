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

; Example log format: "2023-10-05 14:30:00 INFO 192.168.1.1: User login successful"
; Split by space to extract components
(assert (= timestamp (split_at log_entry " " 0)))
(assert (= log_level (split_at log_entry " " 2)))
(assert (= ip_address (split_at (split_at log_entry " " 3) ":" 0)))
(assert (= message (split_rest log_entry " " 4)))

; Constraints for valid log structure
(assert (>= (num_splits log_entry " ") 5)) ; At least 5 segments (timestamp, time, level, ip:port, message)
(assert (>= (num_splits (split_at log_entry " " 3) ":") 2)) ; IP:port segment must have colon

; Timestamp format validation: YYYY-MM-DD HH:MM:SS
(assert (str.prefixof "2023-" timestamp))
(assert (= (str.len (split_at timestamp "-" 0)) 4)) ; Year part length 4
(assert (= (str.len (split_at timestamp "-" 1)) 2)) ; Month part length 2
(assert (= (str.len (split_at timestamp " " 0)) 10)) ; Full date length 10
(assert (str.contains timestamp ":")) ; Time part includes colon

; Log level extraction and validation
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR") (= log_level "DEBUG")))

; Additional constraints for diversity
(assert (not (str.contains message "error"))) ; Message should not contain 'error' (case-sensitive)
(assert (>= (str.len ip_address) 7)) ; IP address at least 7 chars (e.g., 1.2.3.4)
(assert (<= (str.len message) 100)) ; Message length limit

; SAT instance: Ensure satisfiability with a sample log
(assert (str.contains log_entry "INFO"))
(assert (str.contains log_entry "192.168"))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
