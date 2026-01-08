; Log Analysis: Parsing structured server log entries with spaces and colons
; Core structure extended with str_split operations for timestamp and log level extraction
(set-logic ALL)

; Original Boolean variables
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)

; String variables for log parsing
(declare-fun var_0xINPUT_14893 () String)
(declare-fun timestamp () String)
(declare-fun log_level () String)
(declare-fun message () String)

; Declare str_split interface functions

; Original constraints (modified for relevance)
(assert (= T_1 (= "" var_0xINPUT_14893)))  ; Check if log is empty
(assert (= T_2 (not T_1)))
(assert T_2)  ; Log must not be empty
(assert (= T_3 (str.contains var_0xINPUT_14893 "ERROR")))  ; Check if contains ERROR
(assert (= T_4 (not T_3)))
(assert T_4)  ; For UNSAT scenario: require no ERROR (change to (assert (not T_4)) for SAT)

; New constraints for log parsing
; Assume format: "YYYY-MM-DD HH:MM:SS LEVEL: message"
; First split by space to separate timestamp and rest
(assert (>= (str.num_splits var_0xINPUT_14893 " ") 3))  ; At least 3 parts: date, time, rest
(assert (= timestamp (str.++ (str.split_at var_0xINPUT_14893 " " 0) " " (str.split_at var_0xINPUT_14893 " " 1))))

; Validate timestamp format: YYYY-MM-DD HH:MM:SS
(assert (= (str.len (str.split_at var_0xINPUT_14893 " " 0)) 10))  ; Date part length
(assert (str.contains (str.split_at var_0xINPUT_14893 " " 0) "-"))  ; Date has hyphens
(assert (= (str.len (str.split_at var_0xINPUT_14893 " " 1)) 8))   ; Time part length
(assert (str.contains (str.split_at var_0xINPUT_14893 " " 1) ":"))  ; Time has colons

; Extract log level after second space, before colon
(declare-fun rest_part () String)
(assert (= rest_part (str.split_rest var_0xINPUT_14893 " " 2)))  ; Everything after timestamp
(assert (>= (str.num_splits rest_part ":") 2))  ; At least one colon for level:message
(assert (= log_level (str.split_at rest_part ":" 0)))
(assert (= message (str.split_rest rest_part ":" 1)))

; Log level must be one of INFO, WARN, DEBUG (case-sensitive)
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "DEBUG")))

; Additional constraint: message length between 5 and 100 characters
(assert (>= (str.len message) 5))
(assert (<= (str.len message) 100))

; Final check
(check-sat)


; [GENERATION STATUS: SUCCESS]
(get-model)
