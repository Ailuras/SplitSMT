; Log Analysis: Parsing structured server log entries with spaces and colons
(set-logic ALL)

; Declare variables for log entry and its components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)
(declare-const colon_count Int)
(declare-const space_count Int)

; Declare functions for string split operations
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Assert that the log entry contains at least one colon and one space
(assert (str.contains log_entry ":"))
(assert (str.contains log_entry " "))

; Extract timestamp as the first segment before the first space
(assert (= timestamp (split_at log_entry " " 0)))

; Validate timestamp format: must be of length 19 and contain two colons
(assert (= (str.len timestamp) 19))
(assert (str.contains timestamp ":"))
(assert (= (num_splits timestamp ":") 3))

; Extract log level as the second segment after the first space and before the colon
(assert (= log_level (split_at (split_rest log_entry " " 1) ":" 0)))

; Validate log level: must be one of "INFO", "WARN", "ERROR"
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR")))

; Extract message as the rest after the colon following the log level
(assert (= message (split_rest (split_rest log_entry " " 1) ":" 1)))

; Ensure the message is non-empty
(assert (> (str.len message) 0))

; Additional constraints for diversity: check counts of colons and spaces in the full log entry
(assert (= colon_count (num_splits log_entry ":")))
(assert (= space_count (num_splits log_entry " ")))
(assert (>= colon_count 2))
(assert (>= space_count 2))

; Create a SAT instance by adding a specific example constraint
(assert (str.contains log_entry "2023-01-01 12:00:00"))

(check-sat)
(get-value (log_entry timestamp log_level message colon_count space_count))

; [GENERATION STATUS: SUCCESS]
