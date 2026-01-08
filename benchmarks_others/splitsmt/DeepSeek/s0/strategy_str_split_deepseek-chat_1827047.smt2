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

; Extract the first line (e.g., "Content-Length: 123") by splitting on newline
(assert (= content_length_str (str.split_at header "\n" 0)))

; Ensure the first line has a colon to separate key and value
(assert (>= (str.num_splits content_length_str ":") 2))

; Extract the value part after the colon (index 1) from the first line
(assert (= (str.split_at content_length_str ":" 1) " 123"))

; Convert the extracted value string to an integer for content-length validation
(assert (= content_length_val (str.to_int (str.substr (str.split_at content_length_str ":" 1) 1 (str.len (str.split_at content_length_str ":" 1))))))

; Validate content-length: must be a positive integer less than 1000
(assert (> content_length_val 0))
(assert (< content_length_val 1000))

; Extract the second line (e.g., "Host: example.com") from the header
(assert (= host_str (str.split_at header "\n" 1)))

; Ensure the second line contains a colon
(assert (str.contains host_str ":"))

; Extract the third line (e.g., "User-Agent: Mozilla") if present, else set to empty
(assert (= user_agent_str (ite (>= (str.num_splits header "\n") 3) (str.split_at header "\n" 2) "")))

; Assert that the header does not contain any malformed lines without colons (except possibly empty lines)
(assert (forall ((i Int))
  (let ((line (str.split_at header "\n" i)))
    (=> (and (>= i 0) (< i (str.num_splits header "\n")) (not (= line "")))
        (str.contains line ":")))))

; Additional constraint: the total length of the header string must be reasonable (less than 500 characters)
(assert (< (str.len header) 500))

; Check satisfiability of the constraints
(check-sat)


; [GENERATION STATUS: SUCCESS]
(get-model)
