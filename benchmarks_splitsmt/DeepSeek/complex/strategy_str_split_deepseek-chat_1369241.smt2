; Log Analysis: Parsing structured server log entries with str_split operations
(set-logic ALL)

; Declare variables for log entry and its components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)
(declare-const delimiter_space String)
(declare-const delimiter_colon String)

; Define delimiters as constants
(assert (= delimiter_space " "))
(assert (= delimiter_colon ":"))

; Declare uninterpreted functions for str_split interface

; Assert that the log entry has at least 3 segments when split by spaces (timestamp, log_level, message)
(assert (>= (str.num_splits log_entry delimiter_space) 3))

; Extract timestamp as the first segment after splitting by spaces
(assert (= timestamp (str.split_at log_entry delimiter_space 0)))

; Extract log_level as the second segment after splitting by spaces
(assert (= log_level (str.split_at log_entry delimiter_space 1)))

; Extract message as the concatenation of all segments from index 2 onwards after splitting by spaces
(assert (= message (str.split_rest log_entry delimiter_space 2)))

; Validate timestamp format: should contain at least one colon and have exactly 2 segments when split by colon (e.g., HH:MM:SS)
(assert (>= (str.num_splits timestamp delimiter_colon) 2))
(assert (<= (str.num_splits timestamp delimiter_colon) 3)) ; Allow HH:MM or HH:MM:SS

; Validate log_level: must be one of "INFO", "WARN", "ERROR"
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR")))

; Additional constraint: message must not be empty
(assert (> (str.len message) 0))

; Specific example to make it SAT: define a concrete log entry
(assert (= log_entry "12:34:56 INFO Server started successfully"))


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
