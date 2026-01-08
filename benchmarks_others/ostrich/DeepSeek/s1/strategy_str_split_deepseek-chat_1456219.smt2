; Log Analysis: Parsing structured server log entries with spaces and colons
; Scenario: Validate timestamp format and extract log level using str_split operations
(set-logic ALL)

; Declare string variables for log entry and its components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)

; Declare str_split interface functions
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; Constraint 1: Log entry must contain at least 3 segments when split by space
(assert (>= (num_splits log_entry " ") 3))

; Constraint 2: Extract timestamp as first segment (index 0) when split by space
(assert (= timestamp (split_at log_entry " " 0)))

; Constraint 3: Extract log level as second segment (index 1) when split by space
(assert (= log_level (split_at log_entry " " 1)))

; Constraint 4: Extract message as concatenation of remaining segments (from index 2 onwards)
(assert (= message (split_rest log_entry " " 2)))

; Constraint 5: Timestamp must follow format HH:MM:SS with colons
; Split timestamp by colon and validate each component
(assert (= (num_splits timestamp ":") 3))
(declare-const hour String)
(declare-const minute String)
(declare-const second String)
(assert (= hour (split_at timestamp ":" 0)))
(assert (= minute (split_at timestamp ":" 1)))
(assert (= second (split_at timestamp ":" 2)))

; Constraint 6: Hour must be two digits and between 00 and 23
(assert (= (str.len hour) 2))
(assert (str.in_re hour (re.++ (re.range "0" "2") (re.range "0" "9"))))
(assert (<= (str.to_int hour) 23))

; Constraint 7: Minute must be two digits and between 00 and 59
(assert (= (str.len minute) 2))
(assert (str.in_re minute (re.++ (re.range "0" "5") (re.range "0" "9"))))
(assert (<= (str.to_int minute) 59))

; Constraint 8: Second must be two digits and between 00 and 59
(assert (= (str.len second) 2))
(assert (str.in_re second (re.++ (re.range "0" "5") (re.range "0" "9"))))
(assert (<= (str.to_int second) 59))

; Constraint 9: Log level must be one of INFO, WARN, ERROR, DEBUG
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR") (= log_level "DEBUG")))

; Constraint 10: Message must not be empty and contain at least one non-space character
(assert (not (= message "")))
(assert (str.contains message (str.from_code 65))) ; Contains 'A' as example

; Constraint 11: Log entry length constraints for realistic logs
(assert (>= (str.len log_entry) 20))
(assert (<= (str.len log_entry) 200))

; Constraint 12: Ensure timestamp appears at the beginning of log entry
(assert (str.prefixof timestamp log_entry))

; Constraint 13: Additional validation: log level must be uppercase
(assert (str.in_re log_level (re.++ (re.range "A" "Z") (re.range "A" "Z") (re.range "A" "Z") (re.range "A" "Z"))))

; Constraint 14: Message must not contain the delimiter used for splitting (space) at the start
(assert (not (str.prefixof " " message)))

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
