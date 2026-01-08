; Log Analysis: Parsing structured server log entries with spaces and colons
; Core structure: Validate timestamp format and extract log level using str_split operations
(set-logic ALL)

; Declare variables for log entry and its components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)
(declare-const num_segments_space Int)
(declare-const num_segments_colon Int)

; Declare uninterpreted functions for str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Assertions for log parsing
; Assume log format: "YYYY-MM-DD HH:MM:SS LEVEL: message"
; Split by space to separate timestamp and rest
(assert (= timestamp (split_at log_entry " " 0)))
(assert (= num_segments_space (num_splits log_entry " ")))
(assert (>= num_segments_space 3)) ; At least timestamp, level, and message

; Extract log level by splitting the rest after timestamp by colon
(assert (= log_level (split_at (split_rest log_entry " " 1) ":" 0)))
(assert (= num_segments_colon (num_splits (split_rest log_entry " " 1) ":")))
(assert (>= num_segments_colon 2)) ; Ensure colon separates level and message

; Validate timestamp format: should contain hyphens and colons
(assert (str.contains timestamp "-"))
(assert (str.contains timestamp ":"))
(assert (>= (str.len timestamp) 19)) ; Minimum length for "YYYY-MM-DD HH:MM:SS"

; Check log level is one of standard levels
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR") (= log_level "DEBUG")))

; Additional constraint: message should not be empty
(assert (not (= (split_rest (split_rest log_entry " " 1) ":" 1) "")))

; Ensure the log entry is not a specific invalid string (mutated from seed)
(assert (not (= log_entry "file:")))

; Add a SAT/UNSAT variation: make timestamp invalid for UNSAT, or keep valid for SAT
; For SAT instance: comment out the next line; for UNSAT: uncomment
; (assert (not (str.contains timestamp "-"))) ; This would conflict with earlier assertion, making UNSAT

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
