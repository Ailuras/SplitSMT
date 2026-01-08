; Log Analysis: Parsing structured server log entries with str_split operations
(set-logic ALL)

; Declare variables for log entry and its components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)

; Declare uninterpreted functions for str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Assert that the log entry has at least 3 segments when split by spaces
(assert (>= (num_splits log_entry " ") 3))

; Extract timestamp as the first segment (index 0) after splitting by spaces
(assert (= timestamp (split_at log_entry " " 0)))

; Extract log_level as the second segment (index 1) after splitting by spaces
(assert (= log_level (split_at log_entry " " 1)))

; Extract message as the concatenation of all segments from index 2 onwards after splitting by spaces
(assert (= message (split_rest log_entry " " 2)))

; Validate timestamp format: should contain a colon and be at least 8 characters long
(assert (str.contains timestamp ":"))
(assert (>= (str.len timestamp) 8))

; Validate log_level: must be one of "INFO", "WARN", or "ERROR"
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR")))

; Additional constraint: message must not be empty
(assert (not (= message "")))

; Check satisfiability
(check-sat)
(get-value (log_entry timestamp log_level message))


; [GENERATION STATUS: SUCCESS]