; Log Analysis Scenario: Parsing structured server log entries
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Declare variables for log entry components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)
(declare-const source String)

; Declare interface functions for str_split operations

; Example log format: "2023-10-05T14:30:00 INFO:Server started:localhost"
; Split by space first, then by colon for components

; Assert that log entry has at least 3 space-separated parts
(assert (>= (num_splits log_entry " ") 3))

; Extract timestamp (first space-separated segment)
(assert (= timestamp (split_at log_entry " " 0)))

; Extract log level from second space-separated segment after colon split
(assert (= log_level (split_at (split_at log_entry " " 1) ":" 0)))

; Extract message as the rest after timestamp and log level
(assert (= message (split_rest log_entry " " 2)))

; Additional constraint: timestamp must have 'T' separator (ISO 8601 format)
(assert (str.contains timestamp "T"))

; Constraint: log level must be one of standard levels
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR") (= log_level "DEBUG")))

; Constraint: message must contain at least one colon for further parsing
(assert (>= (num_splits message ":") 2))

; Extract source from message (part after first colon in message)
(assert (= source (split_at message ":" 1)))

; Constraint: source must not be empty
(assert (> (str.len source) 0))

; Make problem SAT by adding specific value constraints
(assert (str.contains log_entry "INFO"))
(assert (str.contains log_entry "localhost"))

; Final check


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
