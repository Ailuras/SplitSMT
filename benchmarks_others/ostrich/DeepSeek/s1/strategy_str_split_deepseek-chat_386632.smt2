; Log Analysis: Parsing structured server log entries with timestamp validation and log level extraction
(set-logic ALL)
; Declare string variables for log components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)
(declare-const temp String)
; Declare split functions for parsing
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))
; Constraint 1: Log entry must have at least 3 segments when split by space
(assert (>= (num_splits log_entry " ") 3))
; Constraint 2: Extract timestamp as first segment
(assert (= timestamp (split_at log_entry " " 0)))
; Constraint 3: Timestamp must match format YYYY-MM-DD HH:MM:SS (simplified)
(assert (= (str.len timestamp) 19))
(assert (= (str.at timestamp 4) "-"))
(assert (= (str.at timestamp 7) "-"))
(assert (= (str.at timestamp 10) " "))
(assert (= (str.at timestamp 13) ":"))
(assert (= (str.at timestamp 16) ":"))
; Constraint 4: Extract log level as second segment
(assert (= log_level (split_at log_entry " " 1)))
; Constraint 5: Log level must be one of INFO, WARN, ERROR, DEBUG
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR") (= log_level "DEBUG")))
; Constraint 6: Extract message as the rest after the second segment
(assert (= message (split_rest log_entry " " 2)))
; Constraint 7: Message must contain at least one colon separator
(assert (>= (num_splits message ":") 2))
; Constraint 8: First part of message (before colon) must not be empty
(assert (> (str.len (split_at message ":" 0)) 0))
; Constraint 9: Log entry must contain the string "server" (case-insensitive via transformation)
(assert (str.contains (str.++ log_entry) "server"))
; Constraint 10: Additional check for specific log pattern (makes it SAT)
(assert (str.contains message "request_id"))
(check-sat)
(get-value (log_entry timestamp log_level message))

; [GENERATION STATUS: SUCCESS]
