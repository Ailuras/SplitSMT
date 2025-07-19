; ; SMT-LIB2 file for Log Analysis: Log entry parsing with timestamp and level extraction
; Delimiters used: ' ', ':', '-', '|', '[', ']'
; ; Focus: timestamp format, log level validation, message extraction

(set-logic ALL)

; Declare the log entry string
(declare-fun log_entry () String)

; ; Example log entry format:
; [2024-06-25 14:23:11] | INFO | User login successful

; ; Extract the timestamp part
; 1. The timestamp is inside the first pair of brackets '[' and ']'
; ; 2. Use str.split_at to extract segments

; Split by ']' to get: ["[2024-06-25 14:23:11", " | INFO | User login successful"]
(define-fun segment0 () String (str.split_at log_entry "]" 0))
(define-fun segment1 () String (str.split_at log_entry "]" 1))

; Now split segment0 by '[' to get: ["", "2024-06-25 14:23:11"]
(define-fun timestamp () String (str.split_at segment0 "[" 1))

; ; Split segment1 by '|' (with whitespace as delimiter) to extract log level
; First, remove leading space after ']'
(define-fun after_bracket () String (str.trim segment1))

; Split by '|' to get: ["INFO", "User login successful"]
(define-fun level () String (str.trim (str.split_at after_bracket "|" 1)))
(define-fun message () String (str.trim (str.split_at after_bracket "|" 2)))

; Satisfiable scenario: well-formed log entry
(assert (= log_entry "[2024-06-25 14:23:11] | INFO | User login successful"))

; ; Constraint: Timestamp must be of format "YYYY-MM-DD HH:MM:SS"
; ; We'll check the number of splits when splitting by space and ':'
; Split timestamp by ' ' (space)
(define-fun ts_date () String (str.split_at timestamp " " 0))
(define-fun ts_time () String (str.split_at timestamp " " 1))

; Split ts_date by '-' should yield 3 segments (year, month, day)
(assert (= (str.num_splits ts_date "-") 3))
; Split ts_time by ':' should yield 3 segments (hour, minute, second)
(assert (= (str.num_splits ts_time ":") 3))

; ; Constraint: Log level should be one of INFO, WARN, ERROR, DEBUG
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))

; ; Constraint: The message must not be empty
(assert (not (= message "")))

; ; Constraint: Message must contain the word "login"
(assert (str.contains message "login"))

; Unsatisfiable scenario: force log level to be invalid
(assert (not (= level "INFO")))
(assert (not (= level "WARN")))
(assert (not (= level "ERROR")))
(assert (not (= level "DEBUG")))

; The above two sets of constraints (level must be a valid value and must not be any valid value)
; are unsatisfiable together.

(check-sat)
(exit)