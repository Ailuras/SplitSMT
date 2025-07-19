; ; SMT-LIB2 script for log analysis with timestamp and level extraction
; Delimiters: ' ', ':', '-', '|', '[', ']'
(set-logic QF_S)

; Declare string constants for delimiters
(declare-const space String)
(assert (= space " "))
(declare-const colon String)
(assert (= colon ":"))
(declare-const dash String)
(assert (= dash "-"))
(declare-const pipe String)
(assert (= pipe "|"))
(declare-const lbracket String)
(assert (= lbracket "["))
(declare-const rbracket String)
(assert (= rbracket "]"))

; Declare log entry variable
(declare-const log_entry String)

; ; Example log format: [2023-01-15 14:30:45] INFO | System started
(assert (str.contains log_entry lbracket))
(assert (str.contains log_entry rbracket))
(assert (str.contains log_entry pipe))
(assert (str.contains log_entry space))

; ; Extract timestamp portion between brackets
(declare-const timestamp String)
(assert (= timestamp (str.split_at log_entry lbracket 1)))
(assert (= timestamp (str.split_at timestamp rbracket 0)))

; ; Validate timestamp format: YYYY-MM-DD HH:MM:SS
(declare-const date_part String)
(declare-const time_part String)
(assert (= date_part (str.split_at timestamp space 0)))
(assert (= time_part (str.split_at timestamp space 1)))

; Split date into components
(assert (= (str.num_splits date_part dash) 3))
(declare-const year String)
(declare-const month String)
(declare-const day String)
(assert (= year (str.split_at date_part dash 0)))
(assert (= month (str.split_at date_part dash 1)))
(assert (= day (str.split_at date_part dash 2)))

; Split time into components
(assert (= (str.num_splits time_part colon) 3))
(declare-const hour String)
(declare-const minute String)
(declare-const second String)
(assert (= hour (str.split_at time_part colon 0)))
(assert (= minute (str.split_at time_part colon 1)))
(assert (= second (str.split_at time_part colon 2)))

; ; Validate timestamp components are numeric
(assert (str.is_digit year))
(assert (str.is_digit month))
(assert (str.is_digit day))
(assert (str.is_digit hour))
(assert (str.is_digit minute))
(assert (str.is_digit second))

; ; Extract log level (between ] and |)
(declare-const after_timestamp String)
(assert (= after_timestamp (str.split_rest log_entry rbracket 1)))
(declare-const log_level String)
(assert (= log_level (str.split_at after_timestamp pipe 0)))
(assert (= log_level (str.trim log_level space)))

; ; Validate log level is one of standard values
(assert (or (= log_level "INFO") 
 (= log_level "WARN") 
 (= log_level "ERROR") 
 (= log_level "DEBUG")))

; ; Extract message (after |)
(declare-const message String)
(assert (= message (str.split_rest after_timestamp pipe 1)))
(assert (= message (str.trim message space)))

; Additional constraints for realistic log entries
(assert (>= (str.len year) 4)) ; Year should have 4 digits
(assert (<= (str.to_int month) 12))
(assert (<= (str.to_int day) 31))
(assert (<= (str.to_int hour) 23))
(assert (<= (str.to_int minute) 59))
(assert (<= (str.to_int second) 59))

; Test case: make message non-empty when level is ERROR
(assert (=> (= log_level "ERROR") (>= (str.len message) 1)))

; Uncomment to make unsatisfiable
; (assert (= log_level "CRITICAL")) ; Invalid log level

(check-sat)
(get-model)
(exit)