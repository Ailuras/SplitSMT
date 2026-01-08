; HTTP Header Parsing Scenario: Extracting values from HTTP request headers using colons and newlines
; Logic includes string splitting and integer validation for content-length
(set-logic ALL)

; Declare string variables for the HTTP header and its components
(declare-const header String)
(declare-const key1 String)
(declare-const value1 String)
(declare-const key2 String)
(declare-const value2 String)
(declare-const content_length_str String)

; Declare integer variable for parsed content-length
(declare-const content_length Int)

; Declare uninterpreted functions for str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Assert that the header contains at least two key-value pairs separated by newlines
(assert (>= (num_splits header "\n") 2))

; Extract the first key-value pair: split by newline, then by colon
(assert (= key1 (split_at (split_at header "\n" 0) ":" 0)))
(assert (= value1 (split_rest (split_at header "\n" 0) ":" 1)))

; Extract the second key-value pair: similar process
(assert (= key2 (split_at (split_at header "\n" 1) ":" 0)))
(assert (= value2 (split_rest (split_at header "\n" 1) ":" 1)))

; Ensure the first key is "Content-Length" (case-sensitive) and extract its value
(assert (= key1 "Content-Length"))
(assert (= content_length_str value1))

; Convert the content-length string to an integer and validate it
(assert (str.is_digit content_length_str))
(assert (= content_length (str.to_int content_length_str)))
(assert (>= content_length 0))
(assert (<= content_length 10000))

; Additional constraint: the second key must be "Host" and its value must contain a dot
(assert (= key2 "Host"))
(assert (str.contains value2 "."))

; Ensure the header does not contain empty lines or malformed pairs
(assert (not (str.contains header "\n\n")))
(assert (>= (str.len key1) 1))
(assert (>= (str.len value1) 1))
(assert (>= (str.len key2) 1))
(assert (>= (str.len value2) 1))

; Check satisfiability
(check-sat)


; [GENERATION STATUS: SUCCESS]
(get-model)
