; Log Analysis: Parsing structured server log entries with timestamp validation and log level extraction
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Declare variables for log entry and its components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)
(declare-const source String)

; Declare functions for string split operations

; Constraint 1: Log entry must have at least 4 segments when split by spaces
(assert (>= (num_splits log_entry " ") 4))

; Constraint 2: Extract timestamp as first segment (index 0) when split by spaces
(assert (= timestamp (split_at log_entry " " 0)))

; Constraint 3: Timestamp must match format YYYY-MM-DD HH:MM:SS
(assert (str.in_re timestamp (re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re "-") ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re "-") ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re " ") ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re ":") ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re ":") ((_ re.loop 2 2) (re.range "0" "9")))))

; Constraint 4: Extract log level as second segment (index 1) when split by spaces
(assert (= log_level (split_at log_entry " " 1)))

; Constraint 5: Log level must be one of INFO, WARN, ERROR, DEBUG
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR") (= log_level "DEBUG")))

; Constraint 6: Extract source as third segment (index 2) when split by spaces
(assert (= source (split_at log_entry " " 2)))

; Constraint 7: Source must contain a colon separating component and subcomponent
(assert (>= (num_splits source ":") 2))

; Constraint 8: Extract message as the rest of the log entry starting from index 3
(assert (= message (split_rest log_entry " " 3)))

; Constraint 9: Message must not be empty
(assert (> (str.len message) 0))

; Constraint 10: Additional check: log entry must not start or end with a space
(assert (not (str.prefixof " " log_entry)))
(assert (not (str.suffixof " " log_entry)))

; Constraint 11: Create an UNSAT scenario by adding contradictory constraint
; Uncomment the line below to make the instance UNSAT
; (assert (str.contains log_entry "INVALID"))


; [GENERATION STATUS: SUCCESS]
(check-sat)
(get-model)
(exit)
