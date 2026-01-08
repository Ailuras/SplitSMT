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

; Interface operations for string splitting
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; Constraint 1: Log entry must contain at least 3 space-separated segments (timestamp, log_level, message)
(assert (>= (num_splits log_entry delimiter_space) 3))

; Constraint 2: Extract timestamp as first segment
(assert (= timestamp (split_at log_entry delimiter_space 0)))

; Constraint 3: Timestamp must match format HH:MM:SS (two digits, colon-separated)
(assert (str.in_re timestamp (re.++ ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re ":") ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re ":") ((_ re.loop 2 2) (re.range "0" "9")))))

; Constraint 4: Extract log_level as second segment
(assert (= log_level (split_at log_entry delimiter_space 1)))

; Constraint 5: Log level must be one of INFO, WARN, ERROR (case-sensitive)
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR")))

; Constraint 6: Extract message as the rest starting from third segment
(assert (= message (split_rest log_entry delimiter_space 2)))

; Constraint 7: Message must contain at least one colon-separated key-value pair
(assert (>= (num_splits message delimiter_colon) 2))

; Constraint 8: First key-value pair in message must have key "user"
(assert (str.contains (split_at message delimiter_colon 0) "user"))

; Constraint 9: Log entry length must be between 20 and 100 characters
(assert (and (>= (str.len log_entry) 20) (<= (str.len log_entry) 100)))

; Constraint 10: Timestamp and log_level combined length is less than 15 characters
(assert (< (str.len (str.++ timestamp log_level)) 15))

; Check satisfiability
(check-sat)


; [GENERATION STATUS: SUCCESS]
(get-model)
