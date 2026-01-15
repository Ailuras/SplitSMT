; Log Analysis Scenario: Parsing structured server log entries with str_split operations
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Declare string variables for log entry and its components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)

; Declare uninterpreted functions for str_split interface

; Assert that log_entry has at least 3 segments when split by spaces
(assert (>= (num_splits log_entry " ") 3))

; Extract timestamp as the first segment (index 0) when splitting by spaces
(assert (= timestamp (split_at log_entry " " 0)))

; Extract log_level as the second segment (index 1) when splitting by spaces
(assert (= log_level (split_at log_entry " " 1)))

; Extract message as the concatenation of all segments from index 2 onwards when splitting by spaces
(assert (= message (split_rest log_entry " " 2)))

; Additional constraint: timestamp must contain a colon ':' (e.g., HH:MM:SS format)
(assert (str.contains timestamp ":"))

; Additional constraint: log_level must be one of "INFO", "WARN", or "ERROR"
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR")))

; Additional constraint: message must not be empty
(assert (> (str.len message) 0))

; Complex pattern: Ensure timestamp has exactly two colons (for HH:MM:SS)
(assert (= (num_splits timestamp ":") 3))

; Complex pattern: Check that the first part of timestamp (hours) is a two-digit number
(declare-const hours_str String)
(assert (= hours_str (split_at timestamp ":" 0)))
(assert (= (str.len hours_str) 2))

; Convert hours string to integer for range check (0-23)
(declare-const hours_int Int)
(assert (= hours_int (str.to_int hours_str)))
(assert (and (>= hours_int 0) (<= hours_int 23)))

; SAT instance: Add a constraint that makes the problem satisfiable
(assert (str.contains log_entry "INFO"))

; Final checks
(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
