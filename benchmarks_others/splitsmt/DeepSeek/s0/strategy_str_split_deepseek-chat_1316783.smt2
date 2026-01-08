; Log Analysis: Parsing structured server log entries with spaces and colons
(set-logic ALL)

; Declare variables for log entry and its components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)
(declare-const colon_segments Int)
(declare-const space_segments Int)

; Declare functions for str_split interface

; Assert that log_entry has at least 3 colon-separated parts (e.g., timestamp:level:message)
(assert (>= (str.num_splits log_entry ":") 3))
(set-option :timeout 5000)
; Extract timestamp as the first segment before the first colon
(assert (= timestamp (str.split_at log_entry ":" 0)))

; Extract log_level as the second segment between first and second colons
(assert (= log_level (str.split_at log_entry ":" 1)))

; Extract message as the concatenation of all segments from the third colon onwards
(assert (= message (str.split_rest log_entry ":" 2)))

; Validate timestamp format: should be exactly 19 characters (e.g., "2023-10-05 14:30:00")
(assert (= (str.len timestamp) 19))
(assert (str.contains timestamp "-"))
(assert (str.contains timestamp ":"))
(assert (str.contains timestamp " "))

; Validate log_level: must be one of "INFO", "WARN", "ERROR"
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR")))

; Additional constraint: message must contain at least one space, indicating multiple words
(assert (>= (str.num_splits message " ") 2))

; Ensure log_entry is non-empty and has reasonable length
(assert (> (str.len log_entry) 20))
(assert (< (str.len log_entry) 200))

; Check for consistency: timestamp should not contain log_level or message parts
(assert (not (str.contains timestamp log_level)))
(assert (not (str.contains timestamp message)))

; Final satisfiability check
(check-sat)
(get-value (log_entry timestamp log_level message))


; [GENERATION STATUS: SUCCESS]
