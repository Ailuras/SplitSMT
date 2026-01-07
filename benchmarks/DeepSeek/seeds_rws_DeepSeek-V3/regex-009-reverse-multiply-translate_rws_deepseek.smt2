; ; Complete SMT-LIB2 file for log analysis with timestamp and level extraction
(set-logic QF_SLIA)
(set-option :produce-models true)

; Declare string constants for delimiters
(declare-const space String)
(assert (= space " "))
(declare-const colon String)
(assert (= colon ":"))
(declare-const dash String)
(assert (= dash "-"))
(declare-const pipe String)
(assert (= pipe "|"))
(declare-const lbracket String)
(assert (= lbracket "["))
(declare-const rbracket String)
(assert (= rbracket "]"))

; Declare log entry variable
(declare-const log_entry String)

; ; Example log format: [2023-12-25 10:30:45] INFO | main: System started
(assert (str.contains log_entry lbracket))
(assert (str.contains log_entry rbracket))
(assert (str.contains log_entry pipe))
(assert (str.contains log_entry colon))

; ; Extract timestamp portion between brackets
(declare-const timestamp String)
(assert (= timestamp (str.split_at (str.split_at log_entry lbracket 1) rbracket 0)))

; ; Validate timestamp format YYYY-MM-DD HH:MM:SS
(assert (= (str.len timestamp) 19))
(assert (= (str.at timestamp 4) dash))
(assert (= (str.at timestamp 7) dash))
(assert (= (str.at timestamp 10) space))
(assert (= (str.at timestamp 13) colon))
(assert (= (str.at timestamp 16) colon))

; ; Extract log level (between ] and |)
(declare-const level_part String)
(assert (= level_part (str.split_at (str.split_at log_entry rbracket 1) pipe 0)))

; Trim whitespace from level part
(declare-const log_level String)
(assert (= log_level (str.replace_all level_part space "")))

; ; Validate log level is one of standard values
(assert (or (= log_level "INFO") 
 (= log_level "WARN") 
 (= log_level "ERROR") 
 (= log_level "DEBUG")))

; ; Extract message part (after |)
(declare-const message_part String)
(assert (= message_part (str.split_at log_entry pipe 1)))

; Message should contain at least one colon for component separation
(assert (str.contains message_part colon))

; ; Extract component name (before first colon in message)
(declare-const component String)
(assert (= component (str.split_at message_part colon 0)))

; Component name should not be empty
(assert (not (= component "")))

; ; Extract actual message (after first colon)
(declare-const message String)
(assert (= message (str.split_at message_part colon 1)))

; Message should not be empty
(assert (not (= message "")))

; Additional constraints for specific scenarios
; Scenario 1: ERROR logs must contain "failed" or "exception"
(assert (=> (= log_level "ERROR")
 (or (str.contains message "failed")
 (str.contains message "exception"))))

; Scenario 2: DEBUG logs must come from "main" or "network" components
(assert (=> (= log_level "DEBUG")
 (or (= component "main")
 (= component "network"))))

; Scenario 3: Timestamp year must be >= 2020
(declare-const year_str String)
(assert (= year_str (str.substr timestamp 0 4)))
(assert (>= (str.to_int year_str) 2020))

; Unsatisfiable constraint combination for testing
(assert (= log_level "INFO"))
(assert (str.contains message "critical error"))
(assert (not (str.contains message "error"))) ; This makes it unsat
(check-sat)

(exit)