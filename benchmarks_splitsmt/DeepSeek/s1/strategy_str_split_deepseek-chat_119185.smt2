; Log Analysis: Parsing structured server log entries with spaces and colons, validating timestamp format and extracting log level.
; Extended from seed with str_split interface and additional constraints.
(set-logic ALL)

; Declare variables for log entry and its components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)

; Declare functions from str_split interface

; Assert that log_entry has at least 3 segments when split by space
(assert (>= (str.num_splits log_entry " ") 3))

; Extract timestamp as the first segment after splitting by space
(assert (= timestamp (str.split_at log_entry " " 0)))

; Extract log_level as the second segment after splitting by space
(assert (= log_level (str.split_at log_entry " " 1)))

; Extract message as the concatenation of all segments from index 2 onwards
(assert (= message (str.split_rest log_entry " " 2)))

; Validate timestamp format: should be of the form YYYY-MM-DDTHH:MM:SS
; Check that timestamp contains 'T' and has at least 19 characters (e.g., "2023-10-05T14:30:00")
(assert (>= (str.len timestamp) 19))
(assert (str.contains timestamp "T"))
; Further constraints: timestamp should have hyphens and colons in correct positions
(assert (= (str.at timestamp 4) "-"))
(assert (= (str.at timestamp 7) "-"))
(assert (= (str.at timestamp 13) ":"))
(assert (= (str.at timestamp 16) ":"))

; Validate log_level: must be one of "INFO", "WARN", "ERROR", or "DEBUG"
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR") (= log_level "DEBUG")))

; Additional constraint: message should not be empty and should not contain the delimiter "::" (to avoid confusion with colons)
(assert (not (= (str.len message) 0)))
(assert (not (str.contains message "::")))

; Ensure that the log_entry itself does not start or end with a space to avoid empty segments
(assert (not (= (str.at log_entry 0) " ")))
(assert (not (= (str.at log_entry (- (str.len log_entry) 1)) " ")))

; Add a constraint to make the problem SAT: require that timestamp starts with "2023"
(assert (= (str.substr timestamp 0 4) "2023"))

; Check satisfiability
(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
