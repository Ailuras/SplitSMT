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
(declare-const user_agent String)

; Declare interface functions for str_split

; Assert log entry structure: timestamp log_level message ip_address user_agent
; Example format: "2023-10-05T14:30:00 INFO Request processed 192.168.1.1 Mozilla/5.0"
; Split by spaces to get components
(assert (>= (num_splits log_entry " ") 5))
(assert (= timestamp (split_at log_entry " " 0)))
(assert (= log_level (split_at log_entry " " 1)))
(assert (= message (split_at log_entry " " 2)))
(assert (= ip_address (split_at log_entry " " 3)))
(assert (= user_agent (split_rest log_entry " " 4)))

; Validate timestamp format: YYYY-MM-DDTHH:MM:SS
(assert (str.prefixof "2023-" timestamp))
(assert (str.contains timestamp "T"))
(assert (str.contains timestamp ":"))
(assert (= (str.len timestamp) 19))

; Validate log level: must be one of INFO, WARN, ERROR, DEBUG
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR") (= log_level "DEBUG")))

; Additional constraints for diversity
; Ensure message is non-empty
(assert (> (str.len message) 0))
; Ensure IP address contains a dot
(assert (str.contains ip_address "."))
; Ensure user agent contains a slash
(assert (str.contains user_agent "/"))

; Create a SAT instance by adding a specific example constraint
(assert (str.contains log_entry "Request processed"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
