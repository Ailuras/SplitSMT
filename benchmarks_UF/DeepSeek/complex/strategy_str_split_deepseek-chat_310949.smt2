; Log Analysis Scenario: Parsing structured server log entries with str_split operations
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Declare variables for log entry and its components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)
(declare-const source String)

; Declare uninterpreted functions for str_split interface

; Assert that log entry has at least 4 space-separated segments (timestamp, level, source, message)
(assert (>= (num_splits log_entry " ") 4))

; Extract timestamp as first segment (index 0) when splitting by space
(assert (= timestamp (split_at log_entry " " 0)))

; Extract log level as second segment (index 1) when splitting by space
(assert (= log_level (split_at log_entry " " 1)))

; Extract source as third segment (index 2) when splitting by space
(assert (= source (split_at log_entry " " 2)))

; Extract message as the concatenation of all segments from index 3 onwards
(assert (= message (split_rest log_entry " " 3)))

; Additional constraints for timestamp format validation (e.g., contains colon and digits)
(assert (str.contains timestamp ":"))
(assert (>= (str.len timestamp) 8)) ; Minimum length for HH:MM:SS

; Constraints for log level: must be one of INFO, WARN, ERROR, DEBUG
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR") (= log_level "DEBUG")))

; Ensure message is non-empty
(assert (> (str.len message) 0))

; Complex pattern: Check if source contains a colon (e.g., "server:port") and split further
(declare-const source_host String)
(declare-const source_port String)
(assert (str.contains source ":"))
(assert (= source_host (split_at source ":" 0)))
(assert (= source_port (split_at source ":" 1)))
(assert (>= (str.len source_host) 1))
(assert (>= (str.len source_port) 1))

; SAT instance: Add a specific constraint that makes it satisfiable
(assert (str.contains log_entry "INFO"))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
