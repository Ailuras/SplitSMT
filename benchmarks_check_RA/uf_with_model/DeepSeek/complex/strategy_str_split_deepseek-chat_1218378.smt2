; Log Analysis Scenario: Parsing structured server log entries
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Declare variables for log components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)
(declare-const ip_address String)

; Declare interface functions for str_split operations

; Assert log entry structure: timestamp log_level ip_address:message
; Example format: "2023-10-05T14:30:00 INFO 192.168.1.1:User login successful"
(assert (= timestamp (split_at log_entry " " 0)))
(assert (= log_level (split_at log_entry " " 1)))
(assert (= ip_address (split_at (split_at log_entry " " 2) ":" 0)))
(assert (= message (split_rest (split_at log_entry " " 2) ":" 1)))

; Validate number of splits for spaces and colons
(assert (>= (num_splits log_entry " ") 3))
(assert (>= (num_splits (split_at log_entry " " 2) ":") 2))

; Timestamp format validation: must contain 'T' and ':'
(assert (str.contains timestamp "T"))
(assert (str.contains timestamp ":"))
(assert (>= (str.len timestamp) 19)) ; Minimum length for ISO format

; Log level must be one of standard values
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR") (= log_level "DEBUG")))

; IP address must contain dots and be reasonable length
(assert (str.contains ip_address "."))
(assert (>= (str.len ip_address) 7))
(assert (<= (str.len ip_address) 15))

; Message must not be empty
(assert (> (str.len message) 0))

; Additional constraint for SAT instance: ensure log entry has valid structure
(assert (str.contains log_entry " "))
(assert (str.contains log_entry ":"))

; Check satisfiability


; [GENERATION STATUS: SUCCESS]
(check-sat)
(get-model)
(exit)
