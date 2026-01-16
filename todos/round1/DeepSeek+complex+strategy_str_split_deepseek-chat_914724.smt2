; Log Analysis Scenario: Parsing structured server log entries with str_split operations
(set-logic ALL)

; Declare string variables for log entry and its components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)

; Declare uninterpreted functions for str_split interface

; Assert that log_entry has at least 3 segments when split by spaces
(assert (>= (str.num_splits log_entry " ") 3))

; Extract timestamp as the first segment (index 0) when splitting by spaces
(assert (= timestamp (str.split_at log_entry " " 0)))

; Extract log_level as the second segment (index 1) when splitting by spaces
(assert (= log_level (str.split_at log_entry " " 1)))

; Extract message as the concatenation of all segments from index 2 onwards when splitting by spaces
(assert (= message (str.split_rest log_entry " " 2)))

; Additional constraint: timestamp must contain a colon ':' (e.g., HH:MM:SS format)
(assert (str.contains timestamp ":"))

; Additional constraint: log_level must be one of "INFO", "WARN", or "ERROR"
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR")))

; Additional constraint: message must not be empty
(assert (> (str.len message) 0))

; Additional constraint: timestamp must have exactly two colons (for HH:MM:SS format)
(assert (= (str.num_splits timestamp ":") 3))

; Additional constraint: the first part of timestamp (hours) must be a two-digit number
(declare-const hours String)
(assert (= hours (str.split_at timestamp ":" 0)))
(assert (= (str.len hours) 2))
(assert (and (>= (str.to_int hours) 0) (<= (str.to_int hours) 23)))

; Additional constraint: the second part of timestamp (minutes) must be a two-digit number
(declare-const minutes String)
(assert (= minutes (str.split_at timestamp ":" 1)))
(assert (= (str.len minutes) 2))
(assert (and (>= (str.to_int minutes) 0) (<= (str.to_int minutes) 59)))

; Additional constraint: the third part of timestamp (seconds) must be a two-digit number
(declare-const seconds String)
(assert (= seconds (str.split_at timestamp ":" 2)))
(assert (= (str.len seconds) 2))
(assert (and (>= (str.to_int seconds) 0) (<= (str.to_int seconds) 59)))

; Additional constraint: log_entry must start with timestamp and a space
(assert (str.prefixof (str.++ timestamp " ") log_entry))

; Additional constraint: log_entry must contain log_level and message in order
(assert (str.contains log_entry (str.++ " " log_level " " message)))

; Check satisfiability


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
