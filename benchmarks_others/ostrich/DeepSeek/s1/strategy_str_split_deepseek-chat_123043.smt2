; Log Analysis: Parsing structured server log entries with spaces and colons
; Core structure: Validate timestamp format and extract log level using str_split operations
(set-logic ALL)

; Declare variables for log entry and its components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)
(declare-const colon_count Int)
(declare-const space_count Int)

; Define str_split interface operations for splitting by delimiter
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; Constraint 1: Log entry must contain at least one colon and one space
(assert (str.contains log_entry ":"))
(assert (str.contains log_entry " "))

; Constraint 2: Extract timestamp as first segment when splitting by space
; Timestamp is assumed to be at the beginning of the log entry
(assert (= timestamp (split_at log_entry " " 0)))

; Constraint 3: Timestamp must have format HH:MM:SS (8 characters with colons)
(assert (= (str.len timestamp) 8))
(assert (str.contains timestamp ":"))
; Ensure exactly two colons in timestamp
(assert (= (num_splits timestamp ":") 3))
; Validate colon positions at indices 2 and 5 (0-based)
(assert (= (str.at timestamp 2) ":"))
(assert (= (str.at timestamp 5) ":"))
; Ensure other characters are digits (simplified check: not colons)
(assert (not (= (str.at timestamp 0) ":")))
(assert (not (= (str.at timestamp 1) ":")))
(assert (not (= (str.at timestamp 3) ":")))
(assert (not (= (str.at timestamp 4) ":")))
(assert (not (= (str.at timestamp 6) ":")))
(assert (not (= (str.at timestamp 7) ":")))

; Constraint 4: Extract log level as second segment when splitting by space
; Log level is after timestamp, separated by a space
(assert (= log_level (split_at log_entry " " 1)))

; Constraint 5: Log level must be one of INFO, WARN, ERROR (case-sensitive)
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR")))

; Constraint 6: Message is the rest of the log after the first two segments (timestamp and log level)
(assert (= message (split_rest log_entry " " 2)))

; Constraint 7: Message must not be empty and should contain at least one colon for key-value pairs
(assert (not (= message "")))
(assert (str.contains message ":"))

; Constraint 8: Count colons and spaces in the entire log entry for additional validation
(assert (= colon_count (num_splits log_entry ":")))
(assert (= space_count (num_splits log_entry " ")))
; Ensure at least 3 colons (two in timestamp, one in message) and at least 2 spaces
(assert (>= colon_count 3))
(assert (>= space_count 2))

; Constraint 9: Specific example to create a SAT instance
; This forces a particular valid log entry structure
(assert (str.contains log_entry "12:34:56 INFO user:login"))

; Check satisfiability
(check-sat)
(get-model)


; [GENERATION STATUS: SUCCESS]
