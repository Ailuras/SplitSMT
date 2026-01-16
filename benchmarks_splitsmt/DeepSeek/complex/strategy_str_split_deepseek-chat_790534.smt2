; Log Analysis: Parsing structured server log entries with str_split operations
(set-logic ALL)

; Declare variables for log entry and its components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)
(declare-const colon_segments Int)
(declare-const space_segments Int)

; Define str_split interface functions

; Assert that the log entry has at least 3 space-separated parts (timestamp, log_level, message)
(assert (>= (str.num_splits log_entry " ") 3))
(set-info :space_segments (str.num_splits log_entry " "))

; Extract timestamp as the first space-separated segment
(assert (= timestamp (str.split_at log_entry " " 0)))

; Extract log_level as the second space-separated segment
(assert (= log_level (str.split_at log_entry " " 1)))

; Extract message as the concatenation of all segments from index 2 onwards
(assert (= message (str.split_rest log_entry " " 2)))

; Validate timestamp format: should contain a colon and have at least 2 colon-separated parts (e.g., HH:MM:SS)
(assert (>= (str.num_splits timestamp ":") 2))
(set-info :colon_segments (str.num_splits timestamp ":"))

; Additional constraints for diversity: timestamp length between 5 and 10 characters
(assert (and (>= (str.len timestamp) 5) (<= (str.len timestamp) 10)))

; Constraint on log_level: must be one of "INFO", "WARN", "ERROR"
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR")))

; Ensure message is non-empty
(assert (> (str.len message) 0))

; Create a SAT instance by providing a concrete example log entry
(assert (= log_entry "12:34:56 INFO Server started successfully"))


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
