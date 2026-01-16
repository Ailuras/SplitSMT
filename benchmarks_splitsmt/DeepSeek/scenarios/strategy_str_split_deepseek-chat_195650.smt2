; Log Analysis: Parsing structured server log entries with timestamp validation and log level extraction
(set-logic ALL)

; Declare string variables for log entries and components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)

; Declare functions for string split operations

; Constraint 1: Log entry must contain at least 3 segments when split by spaces
(assert (>= (str.num_splits log_entry " ") 3))

; Constraint 2: Extract timestamp as first segment (index 0) when split by space
(assert (= timestamp (str.split_at log_entry " " 0)))

; Constraint 3: Timestamp must match format YYYY-MM-DD HH:MM:SS
; First part (date) must be YYYY-MM-DD
(assert (str.in_re (str.split_at timestamp " " 0) (re.++ (re.range "0" "9") (re.range "0" "9") (re.range "0" "9") (re.range "0" "9") (str.to_re "-") (re.range "0" "9") (re.range "0" "9") (str.to_re "-") (re.range "0" "9") (re.range "0" "9"))))
; Second part (time) must be HH:MM:SS
(assert (str.in_re (str.split_at timestamp " " 1) (re.++ (re.range "0" "9") (re.range "0" "9") (str.to_re ":") (re.range "0" "9") (re.range "0" "9") (str.to_re ":") (re.range "0" "9") (re.range "0" "9"))))

; Constraint 4: Extract log level as second segment (index 1) when split by space
(assert (= log_level (str.split_at log_entry " " 1)))

; Constraint 5: Log level must be one of INFO, WARN, ERROR, DEBUG
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR") (= log_level "DEBUG")))

; Constraint 6: Extract message as the concatenation of all segments from index 2 onwards
(assert (= message (str.split_rest log_entry " " 2)))

; Constraint 7: Message must contain at least one colon separator for further parsing
(assert (>= (str.num_splits message ":") 2))

; Constraint 8: First part of message (before colon) must be alphanumeric with underscores
(assert (str.in_re (str.split_at message ":" 0) (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "_")))))

; Constraint 9: Log entry must end with a newline character
(assert (str.suffixof "\n" log_entry))

; Additional constraint to ensure timestamp and log level are non-empty
(assert (> (str.len timestamp) 0))
(assert (> (str.len log_level) 0))


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
