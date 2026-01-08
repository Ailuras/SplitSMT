; Log Analysis: Parsing structured server log entries with spaces and colons
(set-logic ALL)

; Declare variables for log entry and its components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)
(declare-const colon_split_count Int)
(declare-const space_split_count Int)

; Declare uninterpreted functions for str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; Assert that log entry is non-empty and has a specific format
(assert (not (= log_entry "")))
(assert (str.contains log_entry ":"))
(assert (str.contains log_entry " "))

; Split log entry by colon to extract timestamp and rest
(assert (= timestamp (split_at log_entry ":" 0)))
(assert (= colon_split_count (num_splits log_entry ":")))
(assert (>= colon_split_count 2))
(assert (= message (split_rest log_entry ":" 1)))

; Validate timestamp format: should be of length 8 and contain only digits and colons
(assert (= (str.len timestamp) 8))
(assert (str.in_re timestamp (re.++ (re.range "0" "9") (re.range "0" "9") (str.to_re ":") (re.range "0" "9") (re.range "0" "9") (str.to_re ":") (re.range "0" "9") (re.range "0" "9"))))

; Split the rest (message) by space to extract log level
(assert (= log_level (split_at message " " 0)))
(assert (= space_split_count (num_splits message " ")))
(assert (>= space_split_count 2))

; Validate log level: should be one of "INFO", "WARN", "ERROR"
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR")))

; Additional constraint: message must contain at least one word after log level
(assert (not (= (split_at message " " 1) "")))

; Create a SAT instance by setting a specific log entry
(assert (= log_entry "12:34:56 INFO Server started successfully"))

(check-sat)
(get-model)

; [GENERATION STATUS: SUCCESS]
