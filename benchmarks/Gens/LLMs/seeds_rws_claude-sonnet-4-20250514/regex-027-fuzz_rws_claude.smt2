(set-logic QF_SLIA)
(set-info :source |Log Analysis: Log entry parsing with timestamp and level extraction|)
(set-info :category "industrial")

; Declare string variables for log entries and components
(declare-fun log_entry_1 () String)
(declare-fun log_entry_2 () String)
(declare-fun timestamp_1 () String)
(declare-fun timestamp_2 () String)
(declare-fun log_level_1 () String)
(declare-fun log_level_2 () String)
(declare-fun message_1 () String)
(declare-fun message_2 () String)

; Declare auxiliary variables for parsing
(declare-fun date_part_1 () String)
(declare-fun time_part_1 () String)
(declare-fun hour_1 () String)
(declare-fun minute_1 () String)
(declare-fun second_1 () String)
(declare-fun year_1 () String)
(declare-fun month_1 () String)
(declare-fun day_1 () String)

; Define log entry format: "2023-12-15 14:30:25 [INFO] | Database connection established"
(assert (= log_entry_1 "2023-12-15 14:30:25 [INFO] | Database connection established"))
(assert (= log_entry_2 "2024-01-08 09:15:42 [ERROR] | Failed to authenticate user"))

; ; Extract timestamp part (first two segments split by space)
(assert (= timestamp_1 (str.++ (str.split_at log_entry_1 " " 0) " " (str.split_at log_entry_1 " " 1))))
(assert (= timestamp_2 (str.++ (str.split_at log_entry_2 " " 0) " " (str.split_at log_entry_2 " " 1))))

; ; Extract date and time components from timestamp
(assert (= date_part_1 (str.split_at timestamp_1 " " 0)))
(assert (= time_part_1 (str.split_at timestamp_1 " " 1)))

; Parse date components using hyphen delimiter
(assert (= year_1 (str.split_at date_part_1 "-" 0)))
(assert (= month_1 (str.split_at date_part_1 "-" 1)))
(assert (= day_1 (str.split_at date_part_1 "-" 2)))

; Parse time components using colon delimiter
(assert (= hour_1 (str.split_at time_part_1 ":" 0)))
(assert (= minute_1 (str.split_at time_part_1 ":" 1)))
(assert (= second_1 (str.split_at time_part_1 ":" 2)))

; ; Validate timestamp format constraints
(assert (= (str.len year_1) 4))
(assert (= (str.len month_1) 2))
(assert (= (str.len day_1) 2))
(assert (= (str.len hour_1) 2))
(assert (= (str.len minute_1) 2))
(assert (= (str.len second_1) 2))

; Ensure proper number of splits for date and time
(assert (= (str.num_splits date_part_1 "-") 3))
(assert (= (str.num_splits time_part_1 ":") 3))

; ; Extract log level using bracket delimiters
(assert (= log_level_1 (str.split_at (str.split_at log_entry_1 "[" 1) "]" 0)))
(assert (= log_level_2 (str.split_at (str.split_at log_entry_2 "[" 1) "]" 0)))

; ; Validate log levels are from allowed set
(assert (or (= log_level_1 "INFO") (= log_level_1 "ERROR") (= log_level_1 "DEBUG") (= log_level_1 "WARN")))
(assert (or (= log_level_2 "INFO") (= log_level_2 "ERROR") (= log_level_2 "DEBUG") (= log_level_2 "WARN")))

; ; Extract message part after pipe delimiter
(assert (= message_1 (str.split_rest log_entry_1 "|" 1)))
(assert (= message_2 (str.split_rest log_entry_2 "|" 1)))

; Ensure messages are non-empty after trimming leading space
(assert (> (str.len (str.split_at message_1 " " 1)) 0))
(assert (> (str.len (str.split_at message_2 " " 1)) 0))

; ; Validate log entry structure has correct number of main components
(assert (= (str.num_splits log_entry_1 " ") 4))
(assert (= (str.num_splits log_entry_2 " ") 4))

; Ensure each log entry has exactly one bracket pair for log level
(assert (= (str.num_splits log_entry_1 "[") 2))
(assert (= (str.num_splits log_entry_1 "]") 2))
(assert (= (str.num_splits log_entry_2 "[") 2))
(assert (= (str.num_splits log_entry_2 "]") 2))

; Ensure each log entry has exactly one pipe delimiter
(assert (= (str.num_splits log_entry_1 "|") 2))
(assert (= (str.num_splits log_entry_2 "|") 2))

; Cross-validation: ensure timestamp consistency
(assert (str.prefixof "202" year_1))
(assert (and (str.<= "01" month_1) (str.<= month_1 "12")))
(assert (and (str.<= "01" day_1) (str.<= day_1 "31")))
(assert (and (str.<= "00" hour_1) (str.<= hour_1 "23")))
(assert (and (str.<= "00" minute_1) (str.<= minute_1 "59")))
(assert (and (str.<= "00" second_1) (str.<= second_1 "59")))

; Ensure log levels match expected patterns
(assert (= log_level_1 "INFO"))
(assert (= log_level_2 "ERROR"))

; ; Validate that year is exactly 2023 for first entry
(assert (= year_1 "2023"))

; Ensure month is December for first entry
(assert (= month_1 "12"))

; Ensure day is 15th for first entry
(assert (= day_1 "15"))

(check-sat)
(exit)