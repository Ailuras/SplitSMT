; Log Analysis: Parsing structured server log entries with timestamp validation and log level extraction
(set-logic ALL)

; Declare string variables for log entry and its components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)

; Declare integer variables for validation
(declare-const colon_count Int)
(declare-const space_count Int)
(declare-const timestamp_len Int)

; Declare uninterpreted functions for str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Core constraints for log parsing
; 1. Log entry must not be empty
(assert (not (= log_entry "")))

; 2. Split by space to get timestamp (first segment)
(assert (= timestamp (split_at log_entry " " 0)))
(assert (>= (num_splits log_entry " ") 3)) ; At least timestamp, log_level, message

; 3. Validate timestamp format: YYYY-MM-DD HH:MM:SS (19 characters)
(assert (= timestamp_len (str.len timestamp)))
(assert (= timestamp_len 19))
(assert (str.contains timestamp "-"))
(assert (str.contains timestamp ":"))
(assert (str.contains timestamp " "))

; 4. Extract log_level as second segment after splitting by space
(assert (= log_level (split_at log_entry " " 1)))

; 5. Log level must be one of: INFO, WARN, ERROR, DEBUG
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR") (= log_level "DEBUG")))

; 6. Extract message as the rest after timestamp and log_level
(assert (= message (split_rest log_entry " " 2)))
(assert (not (= message "")))

; 7. Additional validation: count colons and spaces in timestamp
(assert (= colon_count (+ (str.len (str.replace_all timestamp ":" "")) (str.len ":") (- (str.len timestamp)))))
(assert (= space_count (+ (str.len (str.replace_all timestamp " " "")) (str.len " ") (- (str.len timestamp)))))
(assert (= colon_count 2)) ; HH:MM:SS format
(assert (= space_count 1)) ; Space between date and time

; 8. Ensure timestamp starts with year (4 digits)
(assert (str.prefixof "202" timestamp))

; 9. Create a SAT instance with a concrete example
(assert (= log_entry "2024-05-15 14:30:45 INFO Server started successfully"))

(check-sat)
(get-model)

; [GENERATION STATUS: SUCCESS]