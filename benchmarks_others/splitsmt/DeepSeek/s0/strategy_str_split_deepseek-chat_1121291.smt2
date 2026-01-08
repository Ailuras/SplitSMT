; Log Analysis Scenario: Parsing structured server log entries
(set-logic ALL)

; Declare variables for log entry and its components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)
(declare-const source String)

; Declare uninterpreted functions for str_split interface

; Assert that log entry has at least 4 space-separated segments (timestamp, level, source, message)
(assert (>= (str.num_splits log_entry " ") 4))

; Extract timestamp as first segment (index 0) after splitting by space
(assert (= timestamp (str.split_at log_entry " " 0)))

; Extract log level as second segment (index 1) after splitting by space
(assert (= log_level (str.split_at log_entry " " 1)))

; Extract source as third segment (index 2) after splitting by space
(assert (= source (str.split_at log_entry " " 2)))

; Extract message as the rest starting from index 3 (concatenated with spaces)
(assert (= message (str.split_rest log_entry " " 3)))

; Validate timestamp format: should be of the form HH:MM:SS (8 characters with colons)
(assert (= (str.len timestamp) 8))
(assert (= (str.at timestamp 2) ":"))
(assert (= (str.at timestamp 5) ":"))
; Ensure characters at positions 0,1,3,4,6,7 are digits (0-9)
(assert (and (>= (str.to_code (str.at timestamp 0)) 48) (<= (str.to_code (str.at timestamp 0)) 57)))
(assert (and (>= (str.to_code (str.at timestamp 1)) 48) (<= (str.to_code (str.at timestamp 1)) 57)))
(assert (and (>= (str.to_code (str.at timestamp 3)) 48) (<= (str.to_code (str.at timestamp 3)) 57)))
(assert (and (>= (str.to_code (str.at timestamp 4)) 48) (<= (str.to_code (str.at timestamp 4)) 57)))
(assert (and (>= (str.to_code (str.at timestamp 6)) 48) (<= (str.to_code (str.at timestamp 6)) 57)))
(assert (and (>= (str.to_code (str.at timestamp 7)) 48) (<= (str.to_code (str.at timestamp 7)) 57)))

; Validate log level: must be one of "INFO", "WARN", "ERROR"
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR")))

; Additional constraint: source must contain a colon (e.g., "server:port")
(assert (>= (str.num_splits source ":") 2))

; Ensure message is non-empty
(assert (> (str.len message) 0))

; Create a SAT instance by providing a concrete example log entry
(assert (= log_entry "12:34:56 INFO server:8080 User logged in successfully"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(get-model)
