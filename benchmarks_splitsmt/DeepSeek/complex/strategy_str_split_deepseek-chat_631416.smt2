; Log Analysis Scenario: Parsing structured server log entries with str_split operations
(set-logic ALL)

; Declare string variables for log entry and its components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)

; Declare uninterpreted functions for str_split interface

; Assert that log_entry has at least 3 segments when split by spaces
(assert (>= (str.num_splits log_entry " ") 3))

; Extract timestamp as the first segment (index 0) when splitting by spaces
(assert (= timestamp (str.split_at log_entry " " 0)))

; Extract log_level as the second segment (index 1) when splitting by spaces
(assert (= log_level (str.split_at log_entry " " 1)))

; Extract message as the concatenation of all segments from index 2 onwards
(assert (= message (str.split_rest log_entry " " 2)))

; Additional constraint: timestamp must contain a colon ':' (e.g., HH:MM:SS format)
(assert (str.contains timestamp ":"))

; Additional constraint: log_level must be one of "INFO", "WARN", or "ERROR"
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR")))

; Additional constraint: message must not be empty
(assert (> (str.len message) 0))

; Complex pattern: Ensure timestamp has exactly two colons (for HH:MM:SS)
(assert (= (str.num_splits timestamp ":") 3))

; Complex pattern: Check that the first part of timestamp (hours) is a two-digit number
(declare-const hours_str String)
(assert (= hours_str (str.split_at timestamp ":" 0)))
(assert (= (str.len hours_str) 2))

; Final check for satisfiability


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
