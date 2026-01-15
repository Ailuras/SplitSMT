; Log Analysis: Parsing structured server log entries with str_split operations
(set-logic ALL)

; Declare variables for log components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)
(declare-const delimiter String)

; Define str_split interface functions

; Set delimiter as space for splitting log entry
(assert (= delimiter " "))

; Constraint 1: Log entry must have at least 3 segments (timestamp, log_level, message)
(assert (>= (str.num_splits log_entry delimiter) 3))

; Constraint 2: Extract timestamp as first segment
(assert (= timestamp (str.split_at log_entry delimiter 0)))

; Constraint 3: Extract log_level as second segment
(assert (= log_level (str.split_at log_entry delimiter 1)))

; Constraint 4: Extract message as concatenation of remaining segments
(assert (= message (str.split_rest log_entry delimiter 2)))

; Constraint 5: Timestamp format validation (must contain colon and be at least 8 chars)
(assert (str.contains timestamp ":"))
(assert (>= (str.len timestamp) 8))

; Constraint 6: Log_level must be one of valid levels
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR") (= log_level "DEBUG")))

; Constraint 7: Message must not be empty
(assert (not (= message "")))

; Constraint 8: Additional check for colon-separated subparts in timestamp
(assert (>= (str.num_splits timestamp ":") 2))

; Constraint 9: Ensure timestamp first segment (hours) is numeric (simplified check)
(assert (str.contains "0123456789" (str.at timestamp 0)))

; Constraint 10: Create UNSAT condition by adding contradictory constraint
; (assert (= log_level "CRITICAL")) ; Uncomment to make UNSAT

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
