; Log Analysis: Parsing structured server log entries with str_split operations
(set-logic ALL)

; Declare variables for log entry and its components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)
(declare-const colon_delimiter String)
(declare-const space_delimiter String)

; Define delimiters as constants
(assert (= colon_delimiter ":"))
(assert (= space_delimiter " "))

; Declare uninterpreted functions for str_split interface

; Constraint 1: Log entry must contain at least one colon and one space for parsing
(assert (>= (str.num_splits log_entry colon_delimiter) 2))
(assert (>= (str.num_splits log_entry space_delimiter) 2))

; Constraint 2: Extract timestamp as the first segment after splitting by space
(assert (= timestamp (str.split_at log_entry space_delimiter 0)))

; Constraint 3: Extract log level as the second segment after splitting by space, then split by colon to isolate level
(declare-const second_segment String)
(assert (= second_segment (str.split_at log_entry space_delimiter 1)))
(assert (>= (str.num_splits second_segment colon_delimiter) 2))
(assert (= log_level (str.split_at second_segment colon_delimiter 0)))

; Constraint 4: Extract message as the concatenation of all segments from index 2 onwards after splitting by space
(assert (= message (str.split_rest log_entry space_delimiter 2)))

; Constraint 5: Timestamp format validation: must be of length 19 and contain hyphens and colons in specific positions
(assert (= (str.len timestamp) 19))
(assert (= (str.at timestamp 4) "-"))
(assert (= (str.at timestamp 7) "-"))
(assert (= (str.at timestamp 10) " "))
(assert (= (str.at timestamp 13) ":"))
(assert (= (str.at timestamp 16) ":"))

; Constraint 6: Log level must be one of "INFO", "WARN", "ERROR"
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR")))

; Constraint 7: Message must not be empty and should not contain the colon delimiter
(assert (> (str.len message) 0))
(assert (not (str.contains message colon_delimiter)))

; Additional constraint to create a SAT instance: ensure log entry matches a specific pattern
(assert (str.contains log_entry "2024-01-01 12:00:00 INFO:Server started successfully"))

(check-sat)
(get-model)


; [GENERATION STATUS: SUCCESS]
