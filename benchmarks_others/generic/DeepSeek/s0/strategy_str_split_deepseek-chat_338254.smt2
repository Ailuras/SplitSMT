; Log Analysis: Parsing structured server log entries with str_split operations
(set-logic ALL)

; Declare variables for log entry and its components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)
(declare-const ip_address String)

; Declare uninterpreted functions for str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Example log format: "2023-10-05 14:30:00 INFO 192.168.1.1: User login successful"
; Split by space to get components
(assert (>= (num_splits log_entry " ") 4))
(assert (= timestamp (split_at log_entry " " 0)))
(assert (= log_level (split_at log_entry " " 2)))
(assert (= ip_address (split_at (split_at log_entry " " 3) ":" 0)))
(assert (= message (split_rest log_entry " " 3)))

; Validate timestamp format: YYYY-MM-DD HH:MM:SS
(assert (str.contains timestamp "-"))
(assert (str.contains timestamp ":"))
(assert (>= (str.len timestamp) 19))
(assert (= (str.at timestamp 4) "-"))
(assert (= (str.at timestamp 7) "-"))
(assert (= (str.at timestamp 13) ":"))
(assert (= (str.at timestamp 16) ":"))

; Validate log level: must be one of INFO, WARN, ERROR
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR")))

; Additional constraints for diversity
(assert (str.contains message "login"))
(assert (>= (str.len ip_address) 7))
(assert (str.contains ip_address "."))

; Check for SAT/UNSAT mix: add a contradictory constraint for potential UNSAT
; (assert (not (str.contains log_entry " "))) ; Uncomment to make UNSAT

(check-sat)
(get-value (log_entry timestamp log_level ip_address message))

; [GENERATION STATUS: SUCCESS]
