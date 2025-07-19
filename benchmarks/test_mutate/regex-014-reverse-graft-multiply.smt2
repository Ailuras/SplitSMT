; ; SMT-LIB2 file for Log Analysis: Log entry parsing with timestamp and level extraction
; Delimiters: ' ', ':', '-', '|', '[', ']'
; ; Focus: timestamp format, log level validation, message extraction

(set-logic ALL)

; Declare the log entry variable
(declare-fun log_entry () String)

; ; Example log entry format:
; [2024-06-11 12:34:56] INFO | System started successfully

; ; 1. Extract the timestamp portion
; Split at first space after the ']' to get the remainder
(define-fun right_of_bracket () String
 (str.split_at log_entry "]" 1)
)

; ; The timestamp is inside the brackets; extract between '[' and ']'
(define-fun inside_brackets () String
 (str.split_at (str.split_at log_entry "[" 1) "]" 0)
)

; ; 2. Extract log level
; After ']', the log level comes after a space
(define-fun after_bracket_trimmed () String
 (str.trim (right_of_bracket))
)
(define-fun log_level () String
 (str.split_at (after_bracket_trimmed) " " 0)
)

; ; 3. Extract the message (after '|', trimmed)
(define-fun after_pipe () String
 (str.split_at log_entry "|" 1)
)
(define-fun message () String
 (str.trim after_pipe)
)

; Constraint 1: Timestamp format 'YYYY-MM-DD HH:MM:SS'
; e.g. 2024-06-11 12:34:56
; Split timestamp by ' ' (space)
(define-fun ts_date () String
 (str.split_at inside_brackets " " 0)
)
(define-fun ts_time () String
 (str.split_at inside_brackets " " 1)
)

; Split date by '-'
(define-fun year () String
 (str.split_at ts_date "-" 0)
)
(define-fun month () String
 (str.split_at ts_date "-" 1)
)
(define-fun day () String
 (str.split_at ts_date "-" 2)
)

; Split time by ':'
(define-fun hour () String
 (str.split_at ts_time ":" 0)
)
(define-fun minute () String
 (str.split_at ts_time ":" 1)
)
(define-fun second () String
 (str.split_at ts_time ":" 2)
)

; Constraint 2: Log level validation (must be one of "INFO", "WARN", "ERROR", "DEBUG")
(define-fun valid_level () Bool
 (or
 (= log_level "INFO")
 (= log_level "WARN")
 (= log_level "ERROR")
 (= log_level "DEBUG")
)
)

; Constraint 3: Message must not be empty
(assert (not (= (str.len message) 0)))

; ; Satisfiable example: valid log entry
(assert
 (= log_entry "[2024-06-11 12:34:56] INFO | System started successfully")
)
; ; Timestamp format checks: year/month/day/hour/minute/second have correct lengths
(assert (= (str.len year) 4))
(assert (= (str.len month) 2))
(assert (= (str.len day) 2))
(assert (= (str.len hour) 2))
(assert (= (str.len minute) 2))
(assert (= (str.len second) 2))
(assert valid_level)

(check-sat)
; -------------------------------------------------
; ; Now, unsatisfiable example: invalid log level
(reset)
(set-logic ALL)

(declare-fun log_entry () String)

(define-fun right_of_bracket () String
 (str.split_at log_entry "]" 1)
)
(define-fun inside_brackets () String
 (str.split_at (str.split_at log_entry "[" 1) "]" 0)
)
(define-fun after_bracket_trimmed () String
 (str.trim (right_of_bracket))
)
(define-fun log_level () String
 (str.split_at (after_bracket_trimmed) " " 0)
)
(define-fun after_pipe () String
 (str.split_at log_entry "|" 1)
)
(define-fun message () String
 (str.trim after_pipe)
)

(define-fun ts_date () String
 (str.split_at inside_brackets " " 0)
)
(define-fun ts_time () String
 (str.split_at inside_brackets " " 1)
)
(define-fun year () String
 (str.split_at ts_date "-" 0)
)
(define-fun month () String
 (str.split_at ts_date "-" 1)
)
(define-fun day () String
 (str.split_at ts_date "-" 2)
)
(define-fun hour () String
 (str.split_at ts_time ":" 0)
)
(define-fun minute () String
 (str.split_at ts_time ":" 1)
)
(define-fun second () String
 (str.split_at ts_time ":" 2)
)
(define-fun valid_level () Bool
 (or
 (= log_level "INFO")
 (= log_level "WARN")
 (= log_level "ERROR")
 (= log_level "DEBUG")
)
)

(assert
 (= log_entry "[2024-06-11 12:34:56] TRACE | Undocumented log level")
)
(assert (= (str.len year) 4))
(assert (= (str.len month) 2))
(assert (= (str.len day) 2))
(assert (= (str.len hour) 2))
(assert (= (str.len minute) 2))
(assert (= (str.len second) 2))
(assert valid_level)

(check-sat)

(exit)