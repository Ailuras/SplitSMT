; Log Analysis Scenario: Parsing structured server log entries with str_split operations
(set-logic ALL)

; Declare string variables for log entry and its components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)

; Declare uninterpreted functions for str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Assert that log_entry has at least 3 segments when split by spaces
(assert (>= (num_splits log_entry " ") 3))

; Extract timestamp as first segment (index 0) when splitting by spaces
(assert (= timestamp (split_at log_entry " " 0)))

; Extract log_level as second segment (index 1) when splitting by spaces
(assert (= log_level (split_at log_entry " " 1)))

; Extract message as the concatenation of all segments from index 2 onwards
(assert (= message (split_rest log_entry " " 2)))

; Additional constraints for timestamp format validation (e.g., contains colon)
(assert (str.contains timestamp ":"))
(assert (>= (str.len timestamp) 8))

; Additional constraints for log_level extraction (must be one of common levels)
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR") (= log_level "DEBUG")))

; Ensure message is non-empty
(assert (> (str.len message) 0))

; Create a UNSAT instance by adding contradictory constraints
; Uncomment the following line to make it UNSAT:
; (assert (not (str.contains log_entry " "))) ; Contradicts the split requirement

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
