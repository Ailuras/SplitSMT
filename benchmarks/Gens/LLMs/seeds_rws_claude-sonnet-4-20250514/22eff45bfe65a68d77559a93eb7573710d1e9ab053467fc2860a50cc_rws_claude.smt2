(set-info :status unknown)
(set-logic QF_SLIA)

; ; Log Analysis: Log entry parsing with timestamp and level extraction
; This SMT-LIB2 file models constraints for parsing log entries with various delimiters
; ; Focus areas: timestamp format validation, log level validation, message extraction

; Declare string variables for log entry components
(declare-fun log_entry () String)
(declare-fun timestamp_part () String)
(declare-fun level_part () String)
(declare-fun message_part () String)
(declare-fun date_component () String)
(declare-fun time_component () String)
(declare-fun hour_part () String)
(declare-fun minute_part () String)
(declare-fun second_part () String)

; Sample log entry format: "2024-01-15 14:30:25 [INFO] | Application started successfully"
(assert (= log_entry "2024-01-15 14:30:25 [INFO] | Application started successfully"))

; ; Extract timestamp part (first segment when split by space)
(assert (= timestamp_part (str.split_at log_entry " " 0)))

; ; Extract time portion (second segment when split by space)
(assert (= time_component (str.split_at log_entry " " 1)))

; ; Extract level and message part (remaining after timestamp)
(assert (= level_part (str.split_at log_entry " " 2)))
(assert (= message_part (str.split_rest log_entry " " 3)))

; ; Validate timestamp format: date component should be "2024-01-15"
(assert (= date_component timestamp_part))
(assert (= (str.split_at date_component "-" 0) "2024"))
(assert (= (str.split_at date_component "-" 1) "01"))
(assert (= (str.split_at date_component "-" 2) "15"))
(assert (= (str.num_splits date_component "-") 3))

; ; Validate time format: should have 3 components (hour:minute:second)
(assert (= (str.num_splits time_component ":") 3))
(assert (= hour_part (str.split_at time_component ":" 0)))
(assert (= minute_part (str.split_at time_component ":" 1)))
(assert (= second_part (str.split_at time_component ":" 2)))

; Time component validation
(assert (= hour_part "14"))
(assert (= minute_part "30"))
(assert (= second_part "25"))

; ; Log level validation - extract level from brackets
(assert (str.prefixof "[" level_part))
(assert (str.suffixof "]" level_part))

; ; Extract the actual level text between brackets
(declare-fun level_content () String)
(assert (= level_content (str.split_at (str.split_at level_part "[" 1) "]" 0)))

; ; Validate log level is one of standard levels
(assert (or (= level_content "INFO")
 (= level_content "DEBUG")
 (= level_content "WARN")
 (= level_content "ERROR")
 (= level_content "FATAL")))

; ; Message extraction - should start with pipe delimiter
(assert (str.prefixof "|" message_part))

; ; Extract actual message content after pipe
(declare-fun actual_message () String)
(assert (= actual_message (str.split_at message_part "|" 1)))

; Message should not be empty after trimming
(assert (not (= actual_message "")))
(assert (not (= actual_message " ")))

; ; Additional constraint: log entry should have exactly 4 main segments when split by space
(assert (>= (str.num_splits log_entry " ") 4))

; Test case 2: Different log format with multiple delimiters
(declare-fun log_entry2 () String)
(declare-fun error_timestamp () String)
(declare-fun error_level () String)
(declare-fun error_msg () String)

(assert (= log_entry2 "2024-01-15:16:45:30-[ERROR]-Database connection failed"))

; ; Extract components using different delimiters
(assert (= error_timestamp (str.split_at log_entry2 "-" 0)))
(assert (= error_level (str.split_at log_entry2 "-" 1)))
(assert (= error_msg (str.split_at log_entry2 "-" 2)))

; ; Validate error timestamp has both date and time
(assert (str.contains error_timestamp ":"))
(assert (= (str.num_splits error_timestamp ":") 3))

; ; Validate error level format
(assert (str.prefixof "[" error_level))
(assert (str.suffixof "]" error_level))

; ; Extract error level content
(declare-fun error_level_content () String)
(assert (= error_level_content (str.split_at (str.split_at error_level "[" 1) "]" 0)))
(assert (= error_level_content "ERROR"))

; Test case 3: Complex log with nested brackets
(declare-fun complex_log () String)
(declare-fun service_name () String)
(declare-fun request_id () String)

(assert (= complex_log "2024-01-15 09:15:22 [DEBUG] [UserService] [req-12345] | User authentication successful"))

; ; Extract service name from second bracket pair
(declare-fun service_bracket () String)
(assert (= service_bracket (str.split_at complex_log " " 3)))
(assert (= service_name (str.split_at (str.split_at service_bracket "[" 1) "]" 0)))
(assert (= service_name "UserService"))

; ; Extract request ID from third bracket pair
(declare-fun req_bracket () String)
(assert (= req_bracket (str.split_at complex_log " " 4)))
(assert (= request_id (str.split_at (str.split_at req_bracket "[" 1) "]" 0)))
(assert (= request_id "req-12345"))

; ; Constraint: request ID should follow pattern req-XXXXX
(assert (str.prefixof "req-" request_id))
(assert (= (str.len request_id) 9))

; ; Test unsatisfiable constraint: timestamp cannot be both morning and evening
(declare-fun impossible_log () String)
(declare-fun impossible_time () String)
(declare-fun impossible_hour () String)

(assert (= impossible_log "2024-01-15 23:30:25 [INFO] | Evening process"))
(assert (= impossible_time (str.split_at impossible_log " " 1)))
(assert (= impossible_hour (str.split_at impossible_time ":" 0)))

; This should make the constraints unsatisfiable
(assert (= impossible_hour "23"))
(assert (= impossible_hour "08"))

(check-sat)
(exit)