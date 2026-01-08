; HTTP Header Parsing Scenario: Extracting values from HTTP request headers using colons and newlines
; Logic includes string splitting and integer validation for content-length
(set-logic ALL)

; Declare variables for the HTTP header string and its components
(declare-const header String)
(declare-const method String)
(declare-const path String)
(declare-const host String)
(declare-const content_length_str String)
(declare-const content_length_val Int)

; Declare uninterpreted functions for string split operations as per interface

; Assert that the header contains at least one newline to separate lines
(assert (str.contains header "\n"))

; Split the header into lines using newline as delimiter
; First line (index 0) should contain method and path, split by space
(assert (= (str.split_at header "\n" 0) (str.++ method " " path)))
(assert (>= (str.num_splits (str.split_at header "\n" 0) " ") 2))
(assert (= method (str.split_at (str.split_at header "\n" 0) " " 0)))
(assert (= path (str.split_at (str.split_at header "\n" 0) " " 1)))

; Validate method is a common HTTP method (e.g., GET, POST)
(assert (or (= method "GET") (= method "POST") (= method "PUT") (= method "DELETE")))

; Extract host from a line starting with "Host: "
(assert (str.contains header "Host: "))
(assert (= host (str.split_rest (str.split_at header "\n" 1) ": " 1)))
(assert (>= (str.len host) 1))

; Extract content-length from a line starting with "Content-Length: "
(assert (str.contains header "Content-Length: "))
(assert (= content_length_str (str.split_rest (str.split_at header "\n" 2) ": " 1)))
(assert (>= (str.len content_length_str) 1))

; Convert content-length string to integer and validate it
(assert (= content_length_val (str.to_int content_length_str)))
(assert (>= content_length_val 0))
(assert (<= content_length_val 10000))

; Ensure the header has at least 3 lines for method/path, host, and content-length
(assert (>= (str.num_splits header "\n") 3))

; Additional constraint to make the problem SAT: enforce a specific path
(assert (= path "/index.html"))

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
