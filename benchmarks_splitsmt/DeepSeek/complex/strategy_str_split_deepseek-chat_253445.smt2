; Log Analysis Scenario: Parsing structured server log entries
(set-logic ALL)

; Declare variables for log components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)
(declare-const source String)

; Declare interface functions for string splitting

; Assert that the log entry has at least 4 space-separated segments
(assert (>= (str.num_splits log_entry " ") 4))

; Extract timestamp (first segment)
(assert (= timestamp (str.split_at log_entry " " 0)))

; Extract log level (second segment)
(assert (= log_level (str.split_at log_entry " " 1)))

; Extract message (third segment)
(assert (= message (str.split_at log_entry " " 2)))

; Extract source (fourth segment onwards)
(assert (= source (str.split_rest log_entry " " 3)))

; Validate timestamp format: should contain a colon
(assert (str.contains timestamp ":"))

; Validate log level: must be one of INFO, WARN, ERROR
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR")))

; Additional constraint: timestamp must have exactly two colons (HH:MM:SS format)
(assert (= (str.num_splits timestamp ":") 3))

; Constraint to make it SAT: ensure log entry is non-empty
(assert (> (str.len log_entry) 0))

; Check satisfiability
(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
