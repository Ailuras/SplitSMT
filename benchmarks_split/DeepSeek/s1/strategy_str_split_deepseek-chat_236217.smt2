; Log Analysis: Parsing structured server log entries with timestamp validation and log level extraction
(set-logic ALL)

; Declare string variables for log entry and its components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)

; Declare functions for string split operations
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Constraint 1: Log entry must contain at least 3 segments when split by space
(assert (>= (num_splits log_entry " ") 3))

; Constraint 2: Extract timestamp as first segment (index 0) when splitting by space
(assert (= timestamp (split_at log_entry " " 0)))

; Constraint 3: Timestamp must match format YYYY-MM-DD HH:MM:SS
(assert (str.in_re timestamp (re.++ (re.range "0" "9") (re.range "0" "9") (re.range "0" "9") (re.range "0" "9") (str.to_re "-") (re.range "0" "1") (re.range "0" "9") (str.to_re "-") (re.range "0" "3") (re.range "0" "9") (str.to_re " ") (re.range "0" "2") (re.range "0" "9") (str.to_re ":") (re.range "0" "5") (re.range "0" "9") (str.to_re ":") (re.range "0" "5") (re.range "0" "9"))))

; Constraint 4: Extract log level as second segment (index 1) when splitting by space
(assert (= log_level (split_at log_entry " " 1)))

; Constraint 5: Log level must be one of INFO, WARN, ERROR, DEBUG
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR") (= log_level "DEBUG")))

; Constraint 6: Extract message as the concatenation of all segments from index 2 onwards
(assert (= message (split_rest log_entry " " 2)))

; Constraint 7: Message must contain at least one colon separator
(assert (>= (num_splits message ":") 2))

; Constraint 8: First part of message (before first colon) must be non-empty
(assert (> (str.len (split_at message ":" 0)) 0))

; Constraint 9: Log entry must end with a newline character
(assert (str.suffixof "\n" log_entry))

; Constraint 10: Create an UNSAT scenario by adding contradictory constraint
; This ensures diversity in SAT/UNSAT instances
(assert (and (= log_level "INFO") (= log_level "ERROR")))

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)