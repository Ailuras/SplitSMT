; Log Analysis Scenario: Parsing structured server log entries
(set-logic ALL)

; Declare variables for log entry and its components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)
(declare-const source String)

; Declare uninterpreted functions for str_split interface

; Assert that log entry has at least 4 space-separated segments (timestamp, level, source, message)
(assert (>= (str.num_splits log_entry " ") 4))

; Extract timestamp as first segment (index 0) when splitting by space
(assert (= timestamp (str.split_at log_entry " " 0)))

; Extract log level as second segment (index 1) when splitting by space
(assert (= log_level (str.split_at log_entry " " 1)))

; Extract source as third segment (index 2) when splitting by space
(assert (= source (str.split_at log_entry " " 2)))

; Extract message as the rest starting from index 3 when splitting by space
(assert (= message (str.split_rest log_entry " " 3)))

; Validate timestamp format: should contain colon ':' and have at least 2 colon-separated parts (e.g., HH:MM:SS)
(assert (>= (str.num_splits timestamp ":") 2))

; Additional constraint: timestamp must have exactly 3 colon-separated segments for HH:MM:SS format
(assert (= (str.num_splits timestamp ":") 3))

; Validate log level: must be one of "INFO", "WARN", "ERROR", or "DEBUG"
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR") (= log_level "DEBUG")))

; Complex pattern: Ensure message does not contain the word "FAILURE" if log level is "INFO"
(assert (=> (= log_level "INFO") (not (str.contains message "FAILURE"))))

; Another constraint: Source must contain at least one dot '.' (e.g., "server.api")
(assert (str.contains source "."))

; Check satisfiability
(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
