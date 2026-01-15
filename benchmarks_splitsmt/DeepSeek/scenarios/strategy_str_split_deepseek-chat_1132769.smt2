; Log Analysis: Parsing structured server log entries with spaces and colons
; Core structure: timestamp format validation and log level extraction using str_split operations
(set-logic ALL)

; Declare variables for log entry and its components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)
(declare-const delimiter_space String)
(declare-const delimiter_colon String)

; Define delimiters
(assert (= delimiter_space " "))
(assert (= delimiter_colon ":"))

; Declare str_split interface functions

; Constraint 1: Log entry must have at least 3 space-separated segments (timestamp, log_level, message)
(assert (>= (str.num_splits log_entry delimiter_space) 3))

; Constraint 2: Extract timestamp as first segment
(assert (= timestamp (str.split_at log_entry delimiter_space 0)))

; Constraint 3: Timestamp must match format HH:MM:SS (two digits, colon-separated)
(assert (str.in_re timestamp (re.++ ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re ":") ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re ":") ((_ re.loop 2 2) (re.range "0" "9")))))

; Constraint 4: Extract log_level as second segment
(assert (= log_level (str.split_at log_entry delimiter_space 1)))

; Constraint 5: Log level must be one of INFO, WARN, ERROR (case-sensitive)
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR")))

; Constraint 6: Extract message as the rest after the second segment
(assert (= message (str.split_rest log_entry delimiter_space 2)))

; Constraint 7: Message must contain at least one colon (for structured data)
(assert (>= (str.num_splits message delimiter_colon) 2))

; Constraint 8: Message length must be at least 10 characters
(assert (>= (str.len message) 10))

; Constraint 9: Log entry must not be empty
(assert (not (= log_entry "")))

; Constraint 10: Additional constraint to ensure variability (timestamp not equal to a specific value)
(assert (not (= timestamp "12:00:00")))

; Check satisfiability
(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
