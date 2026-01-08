; HTTP Header Parsing Scenario: Extracting values from HTTP request headers using colons and newlines
; Logic includes string splitting, integer constraints, and validation for content-length
(set-logic ALL)

; Declare variables for the HTTP request header string and its components
(declare-const header String)
(declare-const content_length_str String)
(declare-const content_length_val Int)
(declare-const host_str String)
(declare-const user_agent_str String)

; Declare uninterpreted functions for the str_split interface

; Assert that the header contains at least two key-value pairs separated by newlines
(assert (>= (str.num_splits header "\n") 2))

; Extract the first line (e.g., "Content-Length: 123") by splitting on newline and taking the first segment
(assert (= (str.split_at header "\n" 0) (str.++ "Content-Length: " content_length_str)))

; Extract the second line (e.g., "Host: example.com") by splitting on newline and taking the second segment
(assert (= (str.split_at header "\n" 1) (str.++ "Host: " host_str)))

; Extract the third line (e.g., "User-Agent: Mozilla") by splitting on newline and taking the third segment
(assert (= (str.split_at header "\n" 2) (str.++ "User-Agent: " user_agent_str)))

; Validate that content_length_str is a non-empty string representing a positive integer
(assert (str.in_re content_length_str (re.+ (re.range "0" "9"))))
(assert (> (str.len content_length_str) 0))

; Convert content_length_str to an integer value using str.to_int
(assert (= content_length_val (str.to_int content_length_str)))

; Add constraints on the integer value: content-length must be positive and less than 10000
(assert (> content_length_val 0))
(assert (< content_length_val 10000))

; Ensure host_str and user_agent_str are non-empty strings
(assert (> (str.len host_str) 0))
(assert (> (str.len user_agent_str) 0))

; Additional constraint: The header must contain the string "HTTP/1.1" somewhere
(assert (str.contains header "HTTP/1.1"))

; Check satisfiability of the constraints
(check-sat)


; [GENERATION STATUS: SUCCESS]
(get-model)
