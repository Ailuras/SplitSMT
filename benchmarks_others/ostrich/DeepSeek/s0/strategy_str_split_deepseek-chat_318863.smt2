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
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; Assert that the header contains at least one newline to separate lines
(assert (str.contains header "\n"))

; Split the header into lines using newline as delimiter
; First line (index 0) should contain method and path, split by space
(assert (= (split_at header "\n" 0) (str.++ method " " path)))
(assert (>= (num_splits (split_at header "\n" 0) " ") 2))
(assert (= method (split_at (split_at header "\n" 0) " " 0)))
(assert (= path (split_at (split_at header "\n" 0) " " 1)))

; Validate method is a common HTTP method (e.g., GET, POST)
(assert (or (= method "GET") (= method "POST") (= method "PUT") (= method "DELETE")))

; Extract host from a line starting with "Host: "
(assert (str.contains header "Host: "))
(assert (= host (split_rest (split_at header "\n" 1) ": " 1)))
(assert (>= (str.len host) 1))

; Extract content-length from a line starting with "Content-Length: "
(assert (str.contains header "Content-Length: "))
(assert (= content_length_str (split_rest (split_at header "\n" 2) ": " 1)))
(assert (>= (str.len content_length_str) 1))

; Convert content-length string to integer and validate it
(assert (= content_length_val (str.to_int content_length_str)))
(assert (>= content_length_val 0))
(assert (<= content_length_val 10000))

; Ensure the header has at least 3 lines for method/path, host, and content-length
(assert (>= (num_splits header "\n") 3))

; Additional constraint to make the problem SAT: enforce a specific path
(assert (= path "/index.html"))

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
