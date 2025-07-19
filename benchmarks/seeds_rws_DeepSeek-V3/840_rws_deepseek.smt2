; ; Complete SMT-LIB2 file for log analysis with timestamp and level extraction
(set-logic QF_S)

; Declare string sort and operations
(declare-fun str.split_at (String String Int) String)
(declare-fun str.num_splits (String String) Int)
(declare-fun str.split_rest (String String Int) String)

; Declare variables for log parsing
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)

; ; Example log format: "[2023-01-15 14:30:45] INFO: User login successful | ip=192.168.1.1"
; ; Constraints for timestamp extraction (between square brackets)
(assert (= timestamp (str.split_at (str.split_at log_entry "[" 1) "]" 0)))

; ; Validate timestamp format (YYYY-MM-DD HH:MM:SS)
(assert (= (str.len timestamp) 19))
(assert (= (str.split_at timestamp "-" 0) "2023")) ; Fixed year for example
(assert (= (str.split_at (str.split_at timestamp " " 1) ":" 0) "14")) ; Hour
(assert (= (str.split_at (str.split_at timestamp " " 1) ":" 1) "30")) ; Minute
(assert (= (str.split_at (str.split_at timestamp " " 1) ":" 2) "45")) ; Second

; ; Extract log level (after timestamp, before colon)
(assert (= log_level (str.split_at (str.split_at log_entry "]" 1) ":" 0)))

; ; Validate log level is one of standard values
(assert (or (= log_level " INFO") 
 (= log_level " WARN") 
 (= log_level " ERROR") 
 (= log_level " DEBUG")))

; ; Extract message (everything after level marker)
(assert (= message (str.split_rest log_entry ":" 1)))

; Additional constraints for message content
(assert (str.contains message " "))
(assert (>= (str.len message) 5))

; Satisfiable case: well-formed log entry
(push)
(assert (= log_entry "[2023-01-15 14:30:45] INFO: User login successful | ip=192.168.1.1"))
(check-sat)
(get-model)
(pop)

; Unsatisfiable case: malformed timestamp
(push)
(assert (= log_entry "[2023-01-15 14:30] INFO: User login failed")) ; Missing seconds
(check-sat)
(pop)

; Unsatisfiable case: invalid log level
(push)
(assert (= log_entry "[2023-01-15 14:30:45] ALERT: System down")) ; Invalid level
(check-sat)
(pop)

; Satisfiable case with different delimiters
(push)
(assert (= log_entry "[2023-12-31 23:59:59] ERROR: Database connection failed|retry=3"))
(assert (str.contains message "|"))
(check-sat)
(get-model)
(pop)

; ; Final check with all constraints
(check-sat)
(exit)