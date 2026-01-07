; ; Complete SMT-LIB2 file for log analysis with timestamp and level extraction
(set-logic QF_SLIA)

; Declare string sort and operations

; Variables for log parsing
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)
(declare-const full_message String)

; ; Example log format: [2023-11-15 14:30:45] INFO | main: System started
; Constraints for valid log entry structure
(assert (str.contains log_entry "["))
(assert (str.contains log_entry "]"))
(assert (str.contains log_entry "|"))
(assert (str.contains log_entry ":"))

; ; Extract timestamp part between [ and ]
(assert (= timestamp (str.split_at (str.split_at log_entry "[" 1) "]" 0)))

; ; Validate timestamp format YYYY-MM-DD HH:MM:SS
(assert (= (str.len timestamp) 19))
(assert (= (str.at timestamp 4) "-"))
(assert (= (str.at timestamp 7) "-"))
(assert (= (str.at timestamp 10) " "))
(assert (= (str.at timestamp 13) ":"))
(assert (= (str.at timestamp 16) ":"))

; ; Extract log level between ] and |
(assert (= log_level (str.split_at (str.split_at log_entry "]" 1) "|" 0)))
(assert (or (= log_level " INFO ") 
 (= log_level " WARN ") 
 (= log_level " ERROR ") 
 (= log_level " DEBUG ")))

; ; Extract message part after |
(assert (= full_message (str.split_at log_entry "|" 1)))

; ; Extract component before : in message
(declare-const component String)
(assert (= component (str.split_at full_message ":" 0)))

; ; Extract actual message after :
(assert (= message (str.split_at full_message ":" 1)))

; Additional constraints for message content
(assert (>= (str.len message) 5))
(assert (not (str.contains message "[")))
(assert (not (str.contains message "]")))

; Satisfiable case: valid log entry
(assert (= log_entry "[2023-11-15 14:30:45] INFO | main: System started successfully"))
(check-sat)




(exit)