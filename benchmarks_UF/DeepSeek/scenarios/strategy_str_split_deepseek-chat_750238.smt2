(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
; Log Analysis: Parsing structured server log entries with spaces and colons, focusing on timestamp format and log level extraction.
; Declare variables for log entry and its components.
(declare-fun log_entry () String)
(declare-fun timestamp () String)
(declare-fun log_level () String)
(declare-fun message () String)
; Declare interface functions for string splitting.
; Assert that the log entry contains at least three segments when split by spaces.
(assert (>= (num_splits log_entry " ") 3))
; Extract timestamp as the first segment after splitting by space.
(assert (= timestamp (split_at log_entry " " 0)))
; Extract log level as the second segment after splitting by space.
(assert (= log_level (split_at log_entry " " 1)))
; Extract message as the concatenation of all segments from index 2 onwards.
(assert (= message (split_rest log_entry " " 2)))
; Validate timestamp format: should be of the form "HH:MM:SS" with exactly two colons.
(assert (= (num_splits timestamp ":") 3))
(assert (= (str.len (split_at timestamp ":" 0)) 2))
(assert (= (str.len (split_at timestamp ":" 1)) 2))
(assert (= (str.len (split_at timestamp ":" 2)) 2))
; Validate log level: must be one of "INFO", "WARN", "ERROR", or "DEBUG".
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR") (= log_level "DEBUG")))
; Additional constraint: message must not be empty.
(assert (not (= (str.len message) 0)))
; Ensure the log entry does not contain invalid characters like commas or semicolons in the timestamp.
(assert (not (str.contains timestamp ",")))
(assert (not (str.contains timestamp ";")))
; Check for a specific pattern in the message: it should contain at least one word separated by spaces.
(assert (>= (num_splits message " ") 1))
; Final check: the entire log entry must be non-empty.
(assert (not (= (str.len log_entry) 0)))

; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
