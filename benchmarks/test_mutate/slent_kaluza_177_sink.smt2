; ; SMT-LIB2 file for Log Analysis: Log entry parsing with timestamp and level extraction
; Delimiters: ' ', ':', '-', '|', '[', ']'
; ; Focus on: timestamp format, log level validation, message extraction

(set-logic QF_S)

; Declare the log entry variable
(declare-fun log_entry () String)

; ; --- Split operations for extraction ---

; ; Step 1: Extract the part after the left bracket '['
(define-fun after_lb () String (str.split_at log_entry "[" 1))
; after_lb = "2024-06-30 14:23:55] | INFO | User logged in"

; ; Step 2: Extract the timestamp (up to the right bracket ']')
(define-fun timestamp () String (str.split_at after_lb "]" 0))
; timestamp = "2024-06-30 14:23:55"

; ; Step 3: Extract the part after the right bracket ']'
(define-fun after_rb () String (str.split_at after_lb "]" 1))
; after_rb = " | INFO | User logged in"

; ; Step 4: Extract the part after the first pipe '|'
(define-fun after_first_pipe () String (str.split_at after_rb "|" 1))
; after_first_pipe = " INFO | User logged in"

; ; Step 5: Extract the log level (between the first and second pipe '|')
(define-fun loglevel_with_spaces () String (str.split_at after_first_pipe "|" 0))
; loglevel_with_spaces = " INFO "
(define-fun loglevel_left_strip () String (str.split_at loglevel_with_spaces " " 1))
(define-fun loglevel () String (str.split_at loglevel_left_strip " " 0))
; loglevel = "INFO"

; ; Step 6: Extract the message (after the second pipe '|')
(define-fun message_with_space () String (str.split_at after_first_pipe "|" 1))
; message_with_space = " User logged in"
(define-fun message () String
 (ite (= (str.at message_with_space 0) #\Space)
 (str.substr message_with_space 1 (- (str.len message_with_space) 1))
 message_with_space))

; --- Constraints for a valid log entry ---

; Timestamp format: "YYYY-MM-DD HH:MM:SS" (length 19, specific positions for delimiters)
(assert (= (str.len timestamp) 19))
(assert (= (str.at timestamp 4) #\-))
(assert (= (str.at timestamp 7) #\-))
(assert (= (str.at timestamp 10) #\Space))
(assert (= (str.at timestamp 13) #\:))
(assert (= (str.at timestamp 16) #\:))

; Year must be "2024"
(assert (= (str.substr timestamp 0 4) "2024"))

; Log level must be one of these four
(assert (or
 (= loglevel "INFO")
 (= loglevel "WARN")
 (= loglevel "ERROR")
 (= loglevel "DEBUG")
))

; Message must not be empty
(assert (> (str.len message) 0))

; --- Satisfiable instance ---
(assert (= log_entry "[2024-06-30 14:23:55] | INFO | User logged in"))

(check-sat)
(get-model)

; --- Unsatisfiable instance (invalid timestamp and log level) ---
(push)
(assert (= log_entry "[2024/06/30 14-23-55] | FATAL | System crash"))
(check-sat)
(pop)

(exit)