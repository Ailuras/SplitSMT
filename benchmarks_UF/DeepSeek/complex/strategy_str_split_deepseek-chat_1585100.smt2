; HTTP Header Parsing Scenario: Extracting values from HTTP request headers using colons and newlines
; Logic includes string splitting, integer constraints, and validation for content-length
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Declare variables for the HTTP request header string and its components
(declare-const header String)
(declare-const content_length_str String)
(declare-const content_length_val Int)
(declare-const host_str String)
(declare-const user_agent_str String)

; Declare uninterpreted functions for the str_split interface

; Assert that the header contains at least two key-value pairs separated by newlines
(assert (>= (num_splits header "\n") 2))

; Extract the first line (e.g., "Content-Length: 123") by splitting on newline
(assert (= content_length_str (split_at header "\n" 0)))

; Ensure the first line has a colon to separate key and value
(assert (>= (num_splits content_length_str ":") 2))

; Extract the value part after the colon (assuming format "Content-Length: 123")
(assert (= content_length_val (str.to_int (split_at content_length_str ":" 1))))

; Validate content-length value: must be a non-negative integer less than 10000
(assert (>= content_length_val 0))
(assert (< content_length_val 10000))

; Extract the second line (e.g., "Host: example.com") by splitting on newline
(assert (= host_str (split_at header "\n" 1)))

; Ensure the second line has a colon
(assert (>= (num_splits host_str ":") 2))

; Extract the host value (e.g., "example.com")
(assert (= (split_at host_str ":" 1) "example.com"))

; Extract the third line if present (e.g., "User-Agent: Mozilla") by splitting on newline
(assert (= user_agent_str (split_rest header "\n" 2)))

; Ensure the third line has a colon if it exists (using a conditional-like constraint via implication)
(assert (=> (>= (num_splits header "\n") 3) (>= (num_splits user_agent_str ":") 2)))

; Add a constraint to make the problem SAT: require the header to contain specific strings
(assert (str.contains header "Content-Length:"))
(assert (str.contains header "Host:"))

; Check satisfiability
(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
