; HTTP Header Parsing Scenario: Extracting values from HTTP request headers using colons and newlines, with content-length validation.
(set-logic ALL)

; Declare variables for the HTTP header string and its components
(declare-const header String)
(declare-const content_length_str String)
(declare-const content_length_val Int)
(declare-const method String)
(declare-const path String)
(declare-const version String)
(declare-const host String)

; Declare uninterpreted functions for string split operations as per the interface

; Assert that the header contains at least one newline to separate lines
(assert (str.contains header "\n"))

; Split the header into lines using newline as delimiter
(assert (>= (str.num_splits header "\n") 2))

; Extract the first line (request line) and split it by spaces to get method, path, and version
(declare-const request_line String)
(assert (= request_line (str.split_at header "\n" 0)))
(assert (>= (str.num_splits request_line " ") 3))
(assert (= method (str.split_at request_line " " 0)))
(assert (= path (str.split_at request_line " " 1)))
(assert (= version (str.split_at request_line " " 2)))

; Validate that the method is one of common HTTP methods (e.g., GET, POST)
(assert (or (= method "GET") (= method "POST") (= method "PUT") (= method "DELETE") (= method "HEAD")))

; Extract the host header by finding a line starting with "Host:"
(declare-const host_line String)
(assert (str.contains header "Host:"))
; Use split_rest to get the part after "Host:" in the line containing it
(assert (= host_line (str.split_rest header "Host:" 0)))
(assert (str.contains host_line "\n"))
(assert (= host (str.split_at host_line "\n" 0)))
(assert (> (str.len host) 0))

; Extract the content-length header value
(assert (str.contains header "Content-Length:"))
(declare-const content_length_line String)
(assert (= content_length_line (str.split_rest header "Content-Length:" 0)))
(assert (str.contains content_length_line "\n"))
(assert (= content_length_str (str.split_at content_length_line "\n" 0)))

; Convert content-length string to integer and validate it
(assert (str.is_digit content_length_str))
(assert (= content_length_val (str.to_int content_length_str)))
(assert (>= content_length_val 0))
(assert (<= content_length_val 1000000)) ; Arbitrary upper bound for realism

; Additional constraint: Ensure the header ends with a double newline (\n\n) to indicate end of headers
(assert (str.suffixof "\n\n" header))

; Create a UNSAT instance by adding a contradictory assertion: content-length must be positive if method is POST
(assert (=> (= method "POST") (> content_length_val 0)))
(assert (= method "POST"))
(assert (= content_length_val 0))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
