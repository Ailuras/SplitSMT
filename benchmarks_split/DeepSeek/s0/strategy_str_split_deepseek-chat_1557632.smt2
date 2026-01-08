; Log Analysis: Parsing structured server log entries with str_split operations
(set-logic ALL)

; Declare variables for log entry and its components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)
(declare-const colon_segments Int)
(declare-const space_segments Int)

; Declare uninterpreted functions for str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Assert that log entry has at least 3 space-separated parts (timestamp, log_level, message)
(assert (>= (num_splits log_entry " ") 3))
(set-option :timeout 5000)
; Extract timestamp as the first space-separated segment
(assert (= timestamp (split_at log_entry " " 0)))

; Extract log_level as the second space-separated segment
(assert (= log_level (split_at log_entry " " 1)))

; Extract message as the concatenation of all segments from index 2 onwards
(assert (= message (split_rest log_entry " " 2)))

; Validate timestamp format: should contain a colon and have exactly 2 colon-separated parts (e.g., HH:MM)
(assert (>= (num_splits timestamp ":") 2))
(assert (= colon_segments (num_splits timestamp ":")))
(assert (<= colon_segments 2)) ; Ensure no extra colons beyond one

; Validate log_level: must be one of "INFO", "WARN", "ERROR"
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR")))

; Additional constraint: message must not be empty
(assert (not (= message "")))

; Ensure distinctness of components to avoid trivial solutions
(assert (not (= timestamp log_level)))
(assert (not (= timestamp message)))
(assert (not (= log_level message)))

; Add a length constraint for timestamp to be realistic (e.g., 5 characters for HH:MM)
(assert (= (str.len timestamp) 5))

; Check satisfiability
(check-sat)
(get-value (log_entry timestamp log_level message colon_segments space_segments))

; [GENERATION STATUS: SUCCESS]