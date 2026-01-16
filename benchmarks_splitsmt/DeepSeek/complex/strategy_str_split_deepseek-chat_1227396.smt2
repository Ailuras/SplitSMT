; HTTP Header Parsing Scenario: Extracting values from HTTP request headers using colons and newlines
; Logic includes string splitting and integer validation for content-length
(set-logic ALL)

; Declare variables for the HTTP header string and its components
(declare-const header String)
(declare-const content_length_str String)
(declare-const content_length_val Int)
(declare-const host_str String)
(declare-const user_agent_str String)

; Declare uninterpreted functions for string split operations as per interface

; Assert that the header contains at least one newline to separate lines
(assert (str.contains header "\n"))

; Split the header by newlines to get individual lines
(assert (>= (str.num_splits header "\n") 2))

; Extract the first line (assumed to be the request line, e.g., "GET / HTTP/1.1")
(declare-const request_line String)
(assert (= request_line (str.split_at header "\n" 0)))

; Extract the second line as the Host header (example: "Host: example.com")
(assert (= host_str (str.split_at header "\n" 1)))

; Assert that the Host line contains a colon to separate key and value
(assert (str.contains host_str ":"))
(assert (>= (str.num_splits host_str ":") 2))

; Extract the value part after the colon in the Host line
(declare-const host_value String)
(assert (= host_value (str.split_at host_str ":" 1)))

; Assert that the host value is non-empty
(assert (> (str.len host_value) 0))

; Extract the third line as the User-Agent header (example: "User-Agent: Mozilla")
(assert (= user_agent_str (str.split_at header "\n" 2)))

; Assert that the User-Agent line contains a colon
(assert (str.contains user_agent_str ":"))
(assert (>= (str.num_splits user_agent_str ":") 2))

; Extract the value part after the colon in the User-Agent line
(declare-const user_agent_value String)
(assert (= user_agent_value (str.split_at user_agent_str ":" 1)))

; Assert that the user agent value is non-empty
(assert (> (str.len user_agent_value) 0))

; Extract the Content-Length line (assumed to be the fourth line)
(assert (= content_length_str (str.split_at header "\n" 3)))

; Assert that the Content-Length line contains a colon and the key "Content-Length"
(assert (str.contains content_length_str ":"))
(assert (>= (str.num_splits content_length_str ":") 2))
(assert (str.contains content_length_str "Content-Length"))

; Extract the value part after the colon in the Content-Length line
(declare-const content_length_value_str String)
(assert (= content_length_value_str (str.split_at content_length_str ":" 1)))

; Convert the content-length value string to an integer
(assert (= content_length_val (str.to_int content_length_value_str)))

; Validate that the content-length is a non-negative integer
(assert (>= content_length_val 0))

; Additional constraint to ensure the header ends properly (optional, for realism)
(assert (str.suffixof "\n\n" (str.split_rest header "\n" 4)))

; Check satisfiability

; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
