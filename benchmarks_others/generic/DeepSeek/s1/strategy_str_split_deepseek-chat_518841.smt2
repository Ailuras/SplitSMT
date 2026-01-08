; Log Analysis: Parsing structured server log entries with spaces and colons
; Scenario: Validate timestamp format and extract log level using str_split operations
(set-logic ALL)

; Declare string constants for log entry and its components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)

; Declare uninterpreted functions for str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Constraint 1: Log entry must contain at least 3 segments when split by space
; This ensures the log has timestamp, log level, and message components
(assert (>= (num_splits log_entry " ") 3))

; Constraint 2: Extract timestamp as the first segment (index 0) when splitting by space
(assert (= timestamp (split_at log_entry " " 0)))

; Constraint 3: Timestamp must follow format YYYY-MM-DD HH:MM:SS
; Validate using regex: four digits, hyphen, two digits, hyphen, two digits, space, two digits, colon, two digits, colon, two digits
(assert (str.in_re timestamp (re.++ (re.range "0" "9") (re.range "0" "9") (re.range "0" "9") (re.range "0" "9") (str.to_re "-") (re.range "0" "9") (re.range "0" "9") (str.to_re "-") (re.range "0" "9") (re.range "0" "9") (str.to_re " ") (re.range "0" "9") (re.range "0" "9") (str.to_re ":") (re.range "0" "9") (re.range "0" "9") (str.to_re ":") (re.range "0" "9") (re.range "0" "9"))))

; Constraint 4: Extract log level as the second segment (index 1) when splitting by space
(assert (= log_level (split_at log_entry " " 1)))

; Constraint 5: Log level must be one of INFO, WARN, ERROR, DEBUG (case-sensitive)
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR") (= log_level "DEBUG")))

; Constraint 6: Extract message as the concatenation of all segments from index 2 onwards when splitting by space
(assert (= message (split_rest log_entry " " 2)))

; Constraint 7: Message must contain at least one colon ':' as a separator for key-value pairs
(assert (str.contains message ":"))

; Constraint 8: Message must not be empty (length > 0)
(assert (> (str.len message) 0))

; Constraint 9: Additional validation: Log entry must start with timestamp and log level followed by a space
; This ensures proper formatting before the message
(assert (str.prefixof (str.++ timestamp " " log_level " ") log_entry))

; Constraint 10: Create an UNSAT condition by adding a contradictory constraint
; For example, require log_level to be both "INFO" and "ERROR" simultaneously
; This makes the instance unsatisfiable (UNSAT)
(assert (and (= log_level "INFO") (= log_level "ERROR")))

; Check satisfiability
(check-sat)


; [GENERATION STATUS: SUCCESS]
(get-model)
