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
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Assert that the header contains at least two key-value pairs separated by newlines
(assert (>= (num_splits header "\n") 2))

; Extract the first line (e.g., "Content-Length: 123") by splitting on newline
(assert (= content_length_str (split_at header "\n" 0)))

; Ensure the first line has a colon to separate key and value
(assert (>= (num_splits content_length_str ":") 2))

; Extract the value part after the colon (assuming format "Content-Length: 123")
(assert (= content_length_val (str.to_int (split_at content_length_str ":" 1))))

; Validate content-length: must be a non-negative integer
(assert (>= content_length_val 0))

; Extract the second line (e.g., "Host: example.com") by splitting on newline
(assert (= host_str (split_at header "\n" 1)))

; Ensure the second line has a colon
(assert (>= (num_splits host_str ":") 2))

; Extract the value part for host
(assert (str.contains (split_at host_str ":" 1) "."))

; Extract the third line (e.g., "User-Agent: Mozilla") if present, using split_rest for flexibility
(declare-const rest_header String)
(assert (= rest_header (split_rest header "\n" 2)))
(assert (str.contains rest_header "User-Agent:"))

; Additional constraint: total header length must be reasonable (e.g., less than 1000 characters)
(assert (< (str.len header) 1000))

; Check satisfiability
(check-sat)


; [GENERATION STATUS: SUCCESS]
(get-model)
