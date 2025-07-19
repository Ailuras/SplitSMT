; ; SMT-LIB2 file for Log Analysis: Log entry parsing with timestamp and level extraction
; Delimiters used: ' ', ':', '-', '|', '[', ']'
; ; Focus: timestamp format, log level validation, message extraction

(set-logic QF_S)

; Declare the log entry string variable
(declare-fun log_entry () String)

; ; Example log entry format:
; [2024-06-14 19:21:30] INFO | User login succeeded

; Split log_entry at first space to separate [timestamp] and rest
(define-fun timestamp_with_brackets () String
 (str.split_at log_entry " " 0)
)
(define-fun rest1 () String
 (str.split_rest log_entry " " 1)
)

; timestamp_with_brackets should be like "[2024-06-14"
; ; To extract the timestamp, split at '[' and ']'

; Remove leading '['
(define-fun timestamp_with_bracket_left () String
 (str.split_at timestamp_with_brackets "[" 1)
)
; timestamp_with_bracket_left is "2024-06-14"

; ; To extract the full timestamp with time, join with rest of timestamp
; Split rest1 at "]" to get the remaining part of timestamp and after
(define-fun timestamp_and_rest () String
 (str.split_at rest1 "]" 0)
)
(define-fun after_bracket () String
 (str.split_rest rest1 "]" 1)
)

; Join to get the full timestamp: timestamp_with_bracket_left + " " + timestamp_and_rest
(define-fun full_timestamp () String
 (str.++ timestamp_with_bracket_left " " timestamp_and_rest)
)

; Now, full_timestamp should be of the form "2024-06-14 19:21:30"
; ; Check timestamp format: YYYY-MM-DD HH:MM:SS (length 19, positions of '-' and ':')
(define-fun is_timestamp_length () Bool
 (= (str.len full_timestamp) 19)
)
(define-fun is_first_dash () Bool
 (= (str.at full_timestamp 4) "-")
)
(define-fun is_second_dash () Bool
 (= (str.at full_timestamp 7) "-")
)
(define-fun is_space () Bool
 (= (str.at full_timestamp 10) " ")
)
(define-fun is_first_colon () Bool
 (= (str.at full_timestamp 13) ":")
)
(define-fun is_second_colon () Bool
 (= (str.at full_timestamp 16) ":")
)

; ; Extract log level: After "] ", before " |"
; after_bracket starts with log level and rest of entry
; Split at " |" to separate log level and message
(define-fun log_level () String
 (str.split_at (str.trim after_bracket) " |" 0)
)
(define-fun message () String
 (str.split_rest (str.trim after_bracket) " |" 1)
)

; Log level validation: must be one of "INFO", "WARN", "ERROR", "DEBUG"
(define-fun is_valid_log_level () Bool
 (or (= log_level "INFO")
 (= log_level "WARN")
 (= log_level "ERROR")
 (= log_level "DEBUG"))
)

; ; Message extraction: message should not be empty
(define-fun is_nonempty_message () Bool
 (> (str.len (str.trim message)) 0)
)

; -------------------------
; Satisfiable log entry constraints
; -------------------------
(push)
(assert (= log_entry "[2024-06-14 19:21:30] INFO | User login succeeded"))
(assert is_timestamp_length)
(assert is_first_dash)
(assert is_second_dash)
(assert is_space)
(assert is_first_colon)
(assert is_second_colon)
(assert is_valid_log_level)
(assert is_nonempty_message)
(check-sat)
(pop)

; -------------------------
; Unsatisfiable log entry constraints: Bad timestamp and invalid log level
; -------------------------
(push)
(assert (= log_entry "[2024-06-14 19:21] NOTICE | Something happened"))
; Missing seconds in timestamp and invalid log level "NOTICE"
(assert is_timestamp_length)
(assert is_first_dash)
(assert is_second_dash)
(assert is_space)
(assert is_first_colon)
(assert is_second_colon)
(assert is_valid_log_level)
(assert is_nonempty_message)
(check-sat)
(pop)

; -------------------------
; Unsatisfiable log entry: Empty message
; -------------------------
(push)
(assert (= log_entry "[2024-06-14 19:21:30] ERROR | "))
(assert is_timestamp_length)
(assert is_first_dash)
(assert is_second_dash)
(assert is_space)
(assert is_first_colon)
(assert is_second_colon)
(assert is_valid_log_level)
(assert is_nonempty_message)
(check-sat)
(pop)

(exit)