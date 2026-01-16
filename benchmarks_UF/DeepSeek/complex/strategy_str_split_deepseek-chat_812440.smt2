; Log Analysis Scenario: Parsing structured server log entries
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Declare variables
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)
(declare-const ip_address String)
(declare-const user_agent String)

; Declare interface functions for str_split

; Assert log entry structure: timestamp log_level message ip_address user_agent
; Example format: "2023-10-05T14:30:00 INFO Request processed 192.168.1.1 Mozilla/5.0"
; Split by spaces to get components
(assert (>= (num_splits log_entry " ") 5))
(assert (= timestamp (split_at log_entry " " 0)))
(assert (= log_level (split_at log_entry " " 1)))
(assert (= message (split_rest log_entry " " 2)))

; Further split message to extract ip_address and user_agent (separated by space)
(assert (>= (num_splits message " ") 2))
(assert (= ip_address (split_at message " " 0)))
(assert (= user_agent (split_rest message " " 1)))

; Timestamp format validation: YYYY-MM-DDTHH:MM:SS
; Check length and specific characters
(assert (= (str.len timestamp) 19))
(assert (= (str.at timestamp 4) "-"))
(assert (= (str.at timestamp 7) "-"))
(assert (= (str.at timestamp 10) "T"))
(assert (= (str.at timestamp 13) ":"))
(assert (= (str.at timestamp 16) ":"))

; Log level extraction and validation: must be one of INFO, WARN, ERROR, DEBUG
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR") (= log_level "DEBUG")))

; Additional constraints for diversity
; IP address must contain a dot
(assert (str.contains ip_address "."))
; User agent must not be empty
(assert (> (str.len user_agent) 0))
; Ensure log entry is not empty
(assert (> (str.len log_entry) 0))

; Create both SAT and UNSAT possibilities by adding a contradictory constraint
; Comment out the next line for SAT, uncomment for UNSAT
; (assert (str.contains log_entry "INVALID"))


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
