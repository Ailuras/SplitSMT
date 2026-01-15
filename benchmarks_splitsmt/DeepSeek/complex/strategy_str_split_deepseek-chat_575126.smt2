; Log Analysis Scenario: Parsing structured server log entries with str_split operations
(set-logic ALL)

; Declare string variables for log entry and its components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)

; Declare uninterpreted functions for str_split interface

; Assert that log_entry has at least 3 segments when split by spaces
(assert (>= (str.num_splits log_entry " ") 3))

; Extract timestamp as first segment (index 0) when splitting by spaces
(assert (= timestamp (str.split_at log_entry " " 0)))

; Extract log_level as second segment (index 1) when splitting by spaces
(assert (= log_level (str.split_at log_entry " " 1)))

; Extract message as the concatenation of all segments from index 2 onwards
(assert (= message (str.split_rest log_entry " " 2)))

; Additional constraints for timestamp format validation (e.g., contains colon)
(assert (str.contains timestamp ":"))
(assert (>= (str.len timestamp) 8))

; Additional constraints for log_level extraction (common levels)
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR") (= log_level "DEBUG")))

; Ensure message is non-empty
(assert (> (str.len message) 0))

; Add a complex pattern: timestamp should have exactly two colons (HH:MM:SS format)
(assert (= (str.num_splits timestamp ":") 3))

; Create a UNSAT condition: timestamp cannot be empty and have two colons simultaneously if length is less than 8
; This is contradictory because two colons require at least 8 characters in "HH:MM:SS"
; But we already asserted length >=8, so this instance is SAT; to make UNSAT, add:
; (assert (< (str.len timestamp) 8))
; Uncomment the line above to make it UNSAT

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
