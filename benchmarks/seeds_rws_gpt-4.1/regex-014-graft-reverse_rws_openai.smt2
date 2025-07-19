; ; SMT-LIB2 file for Log Analysis: Log entry parsing with timestamp and level extraction
; Delimiters used: space (' '), colon (':'), dash ('-'), pipe ('|'), left bracket ('['), right bracket (']')
; ; Focus: timestamp format, log level validation, message extraction

(set-logic QF_S)

; Declare the log entry string variable
(declare-fun log_entry () String)

; ; Example log entry format:
; [2024-06-01 12:34:56] INFO | User login succeeded: user=alice

; ; Step 1: Extract timestamp (between '[' and ']')
; Segment 1 after splitting at '[' is timestamp + "] INFO | ..."
(define-fun seg1_after_lbracket () String (str.split_at log_entry "[" 1))
; Segment 0 after splitting seg1 at ']' is the timestamp
(define-fun timestamp () String (str.split_at seg1_after_lbracket "]" 0))

; ; Step 2: Extract log level (appears after "] " and before " |")
; Segment 1 after splitting at ']' is " INFO | User login succeeded: user=alice"
(define-fun after_rbracket () String (str.split_at log_entry "]" 1))
; Remove leading space
(define-fun after_rbracket_trim () String
 (ite (str.prefixof " " after_rbracket)
 (str.substr after_rbracket 1 (- (str.len after_rbracket) 1))
 after_rbracket))
; Segment 0 after splitting at '|' is "INFO "
(define-fun level_and_space () String (str.split_at after_rbracket_trim "|" 0))
; Remove trailing space
(define-fun log_level () String
 (let ((lvl (str.replace level_and_space " " "")))
 lvl))

; ; Step 3: Extract message (after the first '|', trimmed of leading spaces)
(define-fun message_with_spaces () String (str.split_at log_entry "|" 1))
(define-fun message () String
 (ite (str.prefixof " " message_with_spaces)
 (str.substr message_with_spaces 1 (- (str.len message_with_spaces) 1))
 message_with_spaces))

; Constraint 1: Timestamp format should be "YYYY-MM-DD HH:MM:SS"
; ; Check lengths and positions of '-', ' ', ':'
(assert (= (str.len timestamp) 19))
(assert (= (str.at timestamp 4) "-"))
(assert (= (str.at timestamp 7) "-"))
(assert (= (str.at timestamp 10) " "))
(assert (= (str.at timestamp 13) ":"))
(assert (= (str.at timestamp 16) ":"))

; Constraint 2: Log level should be one of INFO, WARN, ERROR, DEBUG
(assert (or (= log_level "INFO")
 (= log_level "WARN")
 (= log_level "ERROR")
 (= log_level "DEBUG")))

; Constraint 3: Message must not be empty
(assert (> (str.len message) 0))

; ; Satisfiable Example: Provide a concrete example for satisfiability
(assert (= log_entry "[2024-06-01 12:34:56] INFO | User login succeeded: user=alice"))

(check-sat)
(get-value (log_entry timestamp log_level message))

; ; Unsatisfiable Example: Timestamp format is wrong (missing dash)
(declare-fun bad_log_entry () String)

; [20240601 12:34:56] WARN | Something happened
; Timestamp is "20240601 12:34:56" (missing dashes)
(define-fun bad_seg1_after_lbracket () String (str.split_at bad_log_entry "[" 1))
(define-fun bad_timestamp () String (str.split_at bad_seg1_after_lbracket "]" 0))
(define-fun bad_after_rbracket () String (str.split_at bad_log_entry "]" 1))
(define-fun bad_after_rbracket_trim () String
 (ite (str.prefixof " " bad_after_rbracket)
 (str.substr bad_after_rbracket 1 (- (str.len bad_after_rbracket) 1))
 bad_after_rbracket))
(define-fun bad_level_and_space () String (str.split_at bad_after_rbracket_trim "|" 0))
(define-fun bad_log_level () String
 (let ((lvl (str.replace bad_level_and_space " " "")))
 lvl))
(define-fun bad_message_with_spaces () String (str.split_at bad_log_entry "|" 1))
(define-fun bad_message () String
 (ite (str.prefixof " " bad_message_with_spaces)
 (str.substr bad_message_with_spaces 1 (- (str.len bad_message_with_spaces) 1))
 bad_message_with_spaces))

(assert (= bad_log_entry "[20240601 12:34:56] WARN | Something happened"))
(assert (= (str.len bad_timestamp) 19))
(assert (= (str.at bad_timestamp 4) "-"))
(assert (= (str.at bad_timestamp 7) "-"))
(assert (= (str.at bad_timestamp 10) " "))
(assert (= (str.at bad_timestamp 13) ":"))
(assert (= (str.at bad_timestamp 16) ":"))
(assert (or (= bad_log_level "INFO")
 (= bad_log_level "WARN")
 (= bad_log_level "ERROR")
 (= bad_log_level "DEBUG")))
(assert (> (str.len bad_message) 0))

(check-sat)
(get-value (bad_log_entry bad_timestamp bad_log_level bad_message))

(exit)