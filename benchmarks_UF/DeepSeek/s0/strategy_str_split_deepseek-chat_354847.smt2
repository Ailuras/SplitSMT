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
(declare-const colon_segments Int)
(declare-const space_segments Int)

; Declare uninterpreted functions for str_split interface

; Assert that log entry is non-empty
(assert (not (= log_entry "")))

; Split log entry by spaces to extract components
(assert (= timestamp (split_at log_entry " " 0)))
(assert (= log_level (split_at log_entry " " 1)))
(assert (= message (split_rest log_entry " " 2)))
(assert (>= (num_splits log_entry " ") 3))

; Validate timestamp format: should contain a colon and be at least 5 characters
(assert (str.contains timestamp ":"))
(assert (>= (str.len timestamp) 5))

; Further split timestamp by colon to check hour and minute parts
(assert (= colon_segments (num_splits timestamp ":")))
(assert (>= colon_segments 2))
(assert (<= colon_segments 3))

; Extract hour from timestamp (first segment after splitting by colon)
(declare-const hour String)
(assert (= hour (split_at timestamp ":" 0)))
(assert (>= (str.len hour) 1))
(assert (<= (str.len hour) 2))

; Validate log level: must be one of INFO, WARN, ERROR
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR")))

; Ensure message is non-empty
(assert (not (= message "")))

; Additional constraint: log entry must contain at least one space after timestamp
(assert (str.contains (str.substr log_entry (str.len timestamp) (str.len log_entry)) " "))

; Check satisfiability
(check-sat)
(get-value (log_entry timestamp log_level message hour colon_segments))

; [GENERATION STATUS: SUCCESS]
(exit)
