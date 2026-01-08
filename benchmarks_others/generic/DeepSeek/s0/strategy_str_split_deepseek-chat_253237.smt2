; Log Analysis Scenario: Parsing structured server log entries with str_split operations
(set-logic ALL)

; Declare variables for log entry and its components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)
(declare-const colon_segments Int)
(declare-const space_segments Int)

; Declare uninterpreted functions for str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Assert that log entry has at least 3 segments when split by spaces (timestamp, log_level, message)
(assert (>= (num_splits log_entry " ") 3))

; Extract timestamp as the first segment after splitting by space
(assert (= timestamp (split_at log_entry " " 0)))

; Extract log_level as the second segment after splitting by space
(assert (= log_level (split_at log_entry " " 1)))

; Extract message as the concatenation of all segments from index 2 onwards after splitting by space
(assert (= message (split_rest log_entry " " 2)))

; Validate timestamp format: should contain a colon and have at least 2 segments when split by colon
(assert (>= (num_splits timestamp ":") 2))

; Additional constraint: log_level must be one of "INFO", "WARN", or "ERROR"
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR")))

; Constraint to make the problem SAT: ensure message is non-empty
(assert (>= (str.len message) 1))

; Check satisfiability
(check-sat)
(get-value (log_entry timestamp log_level message))


; [GENERATION STATUS: SUCCESS]
