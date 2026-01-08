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
(declare-const -1 Int)
(assert (= -1 (- 1)))

; Assert that the header contains at least two key-value pairs separated by newlines
(assert (>= (num_splits header "\n") 2))

; Extract the first line (e.g., "Content-Length: 123") by splitting on newline
(assert (= content_length_str (split_at header "\n" 0)))

; Ensure the first line has a colon to separate key and value
(assert (>= (num_splits content_length_str ":") 2))

; Extract the value part after the colon in the first line (e.g., " 123")
(assert (= content_length_str (split_rest content_length_str ":" 1)))

; Convert the extracted string to an integer for content-length validation
(assert (= content_length_val (str.to_int content_length_str)))

; Validate that content-length is a positive integer (e.g., > 0)
(assert (> content_length_val 0))

; Extract the second line (e.g., "Host: example.com") by splitting on newline
(assert (= host_str (split_at header "\n" 1)))

; Ensure the second line has a colon to separate key and value
(assert (>= (num_splits host_str ":") 2))

; Extract the value part after the colon in the second line (e.g., " example.com")
(assert (= host_str (split_rest host_str ":" 1)))

; Assert that the host value is non-empty (e.g., length > 0)
(assert (> (str.len host_str) 0))

; Extract the third line (e.g., "User-Agent: Mozilla") by splitting on newline, if present
(assert (= user_agent_str (split_at header "\n" 2)))

; Ensure the third line has a colon to separate key and value (if it exists)
(assert (>= (num_splits user_agent_str ":") 2))

; Extract the value part after the colon in the third line (e.g., " Mozilla")
(assert (= user_agent_str (split_rest user_agent_str ":" 1)))

; Assert that the user-agent value is non-empty (e.g., length > 0)
(assert (> (str.len user_agent_str) 0))

; Additional constraint: Ensure the header does not contain invalid characters like semicolons in key parts
(assert (not (str.contains (split_at header "\n" 0) ";")))

; Check satisfiability of the constraints
(check-sat)


; [GENERATION STATUS: SUCCESS]
(get-model)
