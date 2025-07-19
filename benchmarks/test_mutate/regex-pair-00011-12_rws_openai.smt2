; ; SMT-LIB2 file for Log Analysis: Log entry parsing with timestamp and level extraction
; Delimiters used: space (" "), colon (":"), dash ("-"), pipe ("|"), square brackets ("[", "]")
; ; Focus: timestamp format, log level validation, message extraction

(set-logic QF_S)

; Declare the log entry string
(declare-fun log_entry () String)

; ; Example log entry format:
; [2023-06-18 12:34:56] INFO | User-1234 | Action completed successfully

; ; 1. Extract timestamp string (between '[' and ']')
; The timestamp is the 1st segment (index 1) after splitting by '['
(define-fun timestamp_with_bracket () String (str.split_at log_entry "[" 1))
; The timestamp_with_bracket includes the timestamp and the rest, up to '] ...'

; ; Now, extract the timestamp only, by splitting timestamp_with_bracket at ']' and taking the 0th segment
(define-fun timestamp_str () String (str.split_at timestamp_with_bracket "]" 0))

; ; 2. Extract log level (e.g., "INFO", "ERROR", "DEBUG")
; After splitting log_entry by ']', the 1st segment (index 1) starts with a space and the log level
(define-fun after_bracket () String (str.split_at log_entry "]" 1))
; Remove leading space by splitting at space and taking the 1st segment
(define-fun log_level () String (str.split_at after_bracket " " 1))

; ; 3. Extract message (text after the last '|')
; Split log_entry by '|' and get the last segment
(define-fun num_pipes () Int (str.num_splits log_entry "|"))
(define-fun message () String (str.split_at log_entry "|" (- num_pipes 1)))

; 4. Timestamp format: "YYYY-MM-DD HH:MM:SS"
; ; We check that timestamp_str splits at ' ' into two segments: date_part and time_part

(define-fun date_part () String (str.split_at timestamp_str " " 0))
(define-fun time_part () String (str.split_at timestamp_str " " 1))

; The date part should split by '-' into three parts: year, month, day
(define-fun year () String (str.split_at date_part "-" 0))
(define-fun month () String (str.split_at date_part "-" 1))
(define-fun day () String (str.split_at date_part "-" 2))

; The time part should split by ':' into three parts: hour, minute, second
(define-fun hour () String (str.split_at time_part ":" 0))
(define-fun minute () String (str.split_at time_part ":" 1))
(define-fun second () String (str.split_at time_part ":" 2))

; Satisfiable constraints: a valid log entry
(assert (= year "2023"))
(assert (= month "06"))
(assert (= day "18"))
(assert (= hour "12"))
(assert (= minute "34"))
(assert (= second "56"))
(assert (or (= log_level "INFO") (= log_level "ERROR") (= log_level "DEBUG")))
(assert (= message " Action completed successfully"))

; Unsatisfiable combination: log level is not valid
(assert (not (or (= log_level "INFO") (= log_level "ERROR") (= log_level "DEBUG") (= log_level "WARN"))))

(check-sat)
(exit)