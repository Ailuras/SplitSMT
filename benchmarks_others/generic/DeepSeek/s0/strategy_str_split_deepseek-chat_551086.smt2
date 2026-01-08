; Log Analysis: Parsing structured server log entries with str_split operations
(set-logic ALL)

; Declare variables for log entry and its components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)
(declare-const delimiter_space String)
(declare-const delimiter_colon String)

; Define delimiters as constants
(assert (= delimiter_space " "))
(assert (= delimiter_colon ":"))

; Declare uninterpreted functions for str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Assert that the log entry has at least 3 segments when split by spaces (timestamp, log_level, message)
(assert (>= (num_splits log_entry delimiter_space) 3))

; Extract timestamp as the first segment after splitting by space
(assert (= timestamp (split_at log_entry delimiter_space 0)))

; Extract log_level as the second segment after splitting by space
(assert (= log_level (split_at log_entry delimiter_space 1)))

; Extract message as the concatenation of all segments from index 2 onwards after splitting by space
(assert (= message (split_rest log_entry delimiter_space 2)))

; Validate timestamp format: should contain a colon and have at least 2 segments when split by colon (e.g., HH:MM:SS)
(assert (>= (num_splits timestamp delimiter_colon) 2))

; Additional constraint: timestamp must have exactly 3 segments for a full HH:MM:SS format (SAT instance)
; Comment out the line below to create a UNSAT instance by making it impossible
(assert (= (num_splits timestamp delimiter_colon) 3))

; Constraint for log_level: must be one of "INFO", "WARN", or "ERROR" (using string equality)
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR")))

; Constraint for message: must not be empty (length > 0)
(assert (> (str.len message) 0))

; Add a sample log entry to ensure satisfiability (e.g., "12:34:56 INFO: Server started")
; This makes the instance SAT; remove or modify to create UNSAT
(assert (= log_entry "12:34:56 INFO: Server started"))

(check-sat)
(get-model)

; [GENERATION STATUS: SUCCESS]
