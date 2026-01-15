; Log Analysis: Parsing structured server log entries with spaces and colons
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

; Declare functions for string split operations

; Assert that the log entry contains at least one colon and one space
(assert (str.contains log_entry ":"))
(assert (str.contains log_entry " "))

; Split by colon to extract timestamp and log level
(assert (= colon_segments (num_splits log_entry ":")))
(assert (>= colon_segments 2))
(assert (= timestamp (split_at log_entry ":" 0)))
(assert (= log_level (split_at log_entry ":" 1)))

; Validate timestamp format: must be exactly 19 characters (e.g., "2023-10-05 14:30:00")
(assert (= (str.len timestamp) 19))
(assert (str.contains timestamp "-"))
(assert (str.contains timestamp " "))
(assert (str.contains timestamp ":"))

; Validate log level: must be one of "INFO", "WARN", "ERROR"
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR")))

; Split by space to extract message after the log level
(assert (= space_segments (num_splits log_entry " ")))
(assert (>= space_segments 3))
(assert (= message (split_rest log_entry " " 2)))

; Additional constraint: message must not be empty
(assert (> (str.len message) 0))

; Ensure the log entry is consistent: the part after the first colon and space matches the extracted components
(assert (str.contains (split_rest log_entry ":" 1) log_level))
(assert (str.contains (split_rest log_entry " " 2) message))

; Check for satisfiability
(check-sat)
(get-value (log_entry timestamp log_level message colon_segments space_segments))

; [GENERATION STATUS: SUCCESS]
(exit)
