; Log Analysis Scenario: Parsing structured server log entries
(set-logic ALL)

; Declare variables for log entry and its components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)
(declare-const ip_address String)
(declare-const user_agent String)

; Declare functions for string split operations
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Assert that log entry has at least 5 space-separated segments (timestamp, level, message, IP, user agent)
(assert (>= (num_splits log_entry " ") 5))

; Extract timestamp as the first segment (index 0) when splitting by space
(assert (= timestamp (split_at log_entry " " 0)))

; Extract log level as the second segment (index 1) when splitting by space
(assert (= log_level (split_at log_entry " " 1)))

; Extract message as the third segment (index 2) when splitting by space
(assert (= message (split_at log_entry " " 2)))

; Extract IP address as the fourth segment (index 3) when splitting by space
(assert (= ip_address (split_at log_entry " " 3)))

; Extract user agent as the concatenation of all segments from index 4 onwards
(assert (= user_agent (split_rest log_entry " " 4)))

; Validate timestamp format: should contain colons and be at least 8 characters
(assert (str.contains timestamp ":"))
(assert (>= (str.len timestamp) 8))

; Validate log level: must be one of "INFO", "WARN", "ERROR", or "DEBUG"
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR") (= log_level "DEBUG")))

; Additional constraint: IP address should contain a dot
(assert (str.contains ip_address "."))

; Constraint to make it SAT: ensure log entry is non-empty and has valid structure
(assert (not (= log_entry "")))
(assert (str.contains log_entry " "))

; Check satisfiability
(check-sat)


; [GENERATION STATUS: SUCCESS]
(get-model)