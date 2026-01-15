; Log Analysis: Parsing structured server log entries with timestamp validation and log level extraction
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Declare string variables for log entries and components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)
(declare-const source String)
(declare-const raw_log String)

; Declare split functions for parsing

; Core constraint: Parse log entry with format "TIMESTAMP LEVEL: MESSAGE [SOURCE]"
; First split by space to separate timestamp and rest
(assert (= timestamp (split_at log_entry " " 0)))
(assert (= (split_rest log_entry " " 0) (str.++ log_level ":" message " [" source "]")))

; Validate timestamp format: YYYY-MM-DD HH:MM:SS
(assert (= (str.len timestamp) 19))
(assert (= (str.at timestamp 4) "-"))
(assert (= (str.at timestamp 7) "-"))
(assert (= (str.at timestamp 10) " "))
(assert (= (str.at timestamp 13) ":"))
(assert (= (str.at timestamp 16) ":"))

; Extract log level by splitting the rest after timestamp by colon
(assert (= log_level (split_at (split_rest log_entry " " 1) ":" 0)))

; Validate log level is one of standard values
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR") (= log_level "DEBUG")))

; Extract message by taking segment after log level colon
(assert (= message (split_at (split_rest (split_rest log_entry " " 1) ":" 1) " [" 0)))

; Extract source from brackets
(assert (= source (split_at (split_rest (split_rest log_entry " " 1) ":" 1) " [" 1)))
(assert (str.contains source "]"))
(assert (= (str.at source (- (str.len source) 1)) "]"))

; Additional constraint: Ensure log entry has proper structure with at least 3 space-separated parts
(assert (>= (num_splits log_entry " ") 3))

; Example log entry for SAT instance
(assert (= log_entry "2023-10-05 14:30:22 ERROR: Database connection failed [server-db-01]"))

; Additional constraints for complexity
; Constraint 1: Message must not be empty
(assert (> (str.len message) 0))

; Constraint 2: Source must contain hyphen
(assert (str.contains source "-"))

; Constraint 3: Timestamp year must be reasonable (2000-2099)
(assert (str.prefixof "20" (str.substr timestamp 0 2)))

; Constraint 4: Log level extraction consistency check
(assert (= (num_splits (str.++ log_level ":" message " [" source "]") ":") 2))

; Check satisfiability
(check-sat)
(get-value (log_entry timestamp log_level message source))

; [GENERATION STATUS: SUCCESS]
(exit)
