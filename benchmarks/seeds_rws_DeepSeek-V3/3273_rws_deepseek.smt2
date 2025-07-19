
(set-logic QF_S) ; String theory

; Declarations for string operations
(declare-fun str.split_at (String String Int) String)
(declare-fun str.num_splits (String String) Int)
(declare-fun str.split_rest (String String Int) String)

; Declare variables for log parsing
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)

; ; Example log format: "[2023-12-25 15:30:45] INFO: System started successfully | PID:1234"
; Constraints for parsing this format

; ; 1. Timestamp extraction (between square brackets)
(assert (= timestamp (str.split_at (str.split_at log_entry "[" 1) "]" 0)))

; 2. Timestamp format validation (YYYY-MM-DD HH:MM:SS)
(assert (= (str.len timestamp) 19))
(assert (= (str.split_at timestamp "-" 0) "2023")) ; Fixed year for example
(assert (= (str.split_at timestamp "-" 1) "12")) ; Month
(assert (= (str.split_at (str.split_at timestamp "-" 2) " " 0) "25")) ; Day
(assert (= (str.split_at (str.split_at timestamp " " 1) ":" 0) "15")) ; Hour
(assert (= (str.split_at (str.split_at timestamp ":" 1) ":" 0) "30")) ; Minute
(assert (= (str.split_at timestamp ":" 2) "45")) ; Second

; ; 3. Log level extraction (after timestamp, before colon)
(assert (= log_level (str.split_at (str.split_at log_entry "]" 1) ":" 0)))

; 4. Log level validation (must be one of standard levels)
(assert (or (= log_level "INFO")
 (= log_level "WARN")
 (= log_level "ERROR")
 (= log_level "DEBUG")
 (= log_level "FATAL")))

; ; 5. Message extraction (everything after log level and colon)
(assert (= message (str.split_rest log_entry ":" 2)))

; 6. Additional constraints for message content
(assert (str.contains message " ")) ; Message must contain at least one space
(assert (>= (str.len message) 5)) ; Minimum message length

; 7. Verify the log entry contains all required components
(assert (str.contains log_entry "["))
(assert (str.contains log_entry "]"))
(assert (str.contains log_entry ":"))
(assert (>= (str.num_splits log_entry " ") 5)) ; At least 5 space-separated components

; ; 8. Unsatisfiable constraint example (conflicting timestamp)
(assert (not (= (str.split_at timestamp "-" 0) "2023"))) ; This makes it unsat

(check-sat)
(get-model)
(exit)
