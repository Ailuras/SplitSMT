; Log Analysis Scenario: Parsing structured server log entries with str_split operations
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

; Constraint 1: Log entry must have at least 3 segments when split by spaces (timestamp, log_level, message)
(assert (>= (str.num_splits log_entry delimiter_space) 3))

; Constraint 2: Extract timestamp as the first segment after splitting by spaces
(assert (= timestamp (str.split_at log_entry delimiter_space 0)))

; Constraint 3: Extract log_level as the second segment after splitting by spaces
(assert (= log_level (str.split_at log_entry delimiter_space 1)))

; Constraint 4: Extract message as the concatenation of all segments from index 2 onwards after splitting by spaces
(assert (= message (str.split_rest log_entry delimiter_space 2)))

; Constraint 5: Timestamp must be in format HH:MM:SS, validated by splitting with colon delimiter
(assert (= (str.num_splits timestamp delimiter_colon) 3))
(assert (>= (str.len (str.split_at timestamp delimiter_colon 0)) 2)) ; Hours part has at least 2 digits
(assert (>= (str.len (str.split_at timestamp delimiter_colon 1)) 2)) ; Minutes part has at least 2 digits
(assert (>= (str.len (str.split_at timestamp delimiter_colon 2)) 2)) ; Seconds part has at least 2 digits

; Constraint 6: Log level must be one of "INFO", "WARN", or "ERROR"
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR")))

; Constraint 7: Message must not be empty
(assert (>= (str.len message) 1))

; Additional constraint to create a SAT instance: specify a concrete log entry
(assert (= log_entry "2023-10-05 14:30:45 INFO: Server started successfully"))

; Check satisfiability


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
