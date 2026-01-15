; Log Analysis: Parsing structured server log entries with spaces and colons
; Core structure: timestamp format validation and log level extraction using str_split operations
(set-logic ALL)

; Declare string variables for log entry and its components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)

; Declare str_split interface functions

; Constraint 1: Log entry must have at least 3 segments when split by space
; This ensures basic structure: timestamp log_level message
(assert (>= (str.num_splits log_entry " ") 3))

; Constraint 2: Extract timestamp as first segment (index 0) when splitting by space
(assert (= timestamp (str.split_at log_entry " " 0)))

; Constraint 3: Validate timestamp format using regex
; Expected format: YYYY-MM-DDTHH:MM:SS (ISO 8601 basic)
(assert (str.in_re timestamp (re.++ 
    ((_ re.loop 4 4) (re.range "0" "9")) ; year
    (str.to_re "-")
    ((_ re.loop 2 2) (re.range "0" "9")) ; month
    (str.to_re "-")
    ((_ re.loop 2 2) (re.range "0" "9")) ; day
    (str.to_re "T")
    ((_ re.loop 2 2) (re.range "0" "9")) ; hour
    (str.to_re ":")
    ((_ re.loop 2 2) (re.range "0" "9")) ; minute
    (str.to_re ":")
    ((_ re.loop 2 2) (re.range "0" "9")) ; second
)))

; Constraint 4: Extract log level as second segment (index 1) when splitting by space
(assert (= log_level (str.split_at log_entry " " 1)))

; Constraint 5: Log level must be one of: INFO, WARN, ERROR, DEBUG
(assert (or 
    (= log_level "INFO")
    (= log_level "WARN")
    (= log_level "ERROR")
    (= log_level "DEBUG")
))

; Constraint 6: Extract message as the concatenation of all segments from index 2 onwards
; This handles messages that may contain spaces
(assert (= message (str.split_rest log_entry " " 2)))

; Constraint 7: Message must not be empty
(assert (> (str.len message) 0))

; Constraint 8: Additional validation for messages containing colons
; If message contains ":", split it and ensure at least 2 parts
(assert (=> (str.contains message ":") (>= (str.num_splits message ":") 2)))

; Constraint 9: Create a UNSAT condition for diversity
; Force log_level to be both "INFO" and "ERROR" simultaneously (impossible)
; Commented out to keep SAT by default; uncomment for UNSAT instance
; (assert (and (= log_level "INFO") (= log_level "ERROR")))

; Check satisfiability
(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
