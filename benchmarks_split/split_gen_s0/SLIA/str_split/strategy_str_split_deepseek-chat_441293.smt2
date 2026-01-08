; Log Analysis Scenario: Parsing structured server log entries with spaces and colons
(set-logic ALL)

; Declare variables for log entry and its components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)
(declare-const source String)

; Declare uninterpreted functions for str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Assert that log entry has at least 4 space-separated segments (timestamp, level, source, message)
(assert (>= (num_splits log_entry " ") 4))

; Extract timestamp as first segment after splitting by space
(assert (= timestamp (split_at log_entry " " 0)))

; Extract log level as second segment after splitting by space
(assert (= log_level (split_at log_entry " " 1)))

; Extract source as third segment after splitting by space
(assert (= source (split_at log_entry " " 2)))

; Extract message as the rest starting from index 3 (concatenated with spaces)
(assert (= message (split_rest log_entry " " 3)))

; Validate timestamp format: should contain colons and be non-empty
(assert (str.contains timestamp ":"))
(assert (>= (str.len timestamp) 8)) ; e.g., HH:MM:SS

; Validate log level: must be one of INFO, WARN, ERROR, DEBUG
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR") (= log_level "DEBUG")))

; Additional constraint: source must contain a colon (e.g., server:port)
(assert (str.contains source ":"))

; Constraint to ensure message is non-empty
(assert (> (str.len message) 0))

; Make the problem SAT by allowing flexibility in log entry
(assert (str.contains log_entry "INFO"))
(assert (str.contains log_entry "server:8080"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(get-model)