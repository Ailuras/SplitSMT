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
; First line is the request line (e.g., "GET /index.html HTTP/1.1")
(assert (= method (str.split_at header "\n" 0)))
(assert (>= (str.num_splits header "\n") 2))

; Extract the request line components: assume it has spaces
; For simplicity, split the first line by space to get method and path
(declare-const request_line String)
(assert (= request_line (str.split_at header "\n" 0)))
(assert (>= (str.num_splits request_line " ") 2))
(assert (= method (str.split_at request_line " " 0)))
(assert (= path (str.split_at request_line " " 1)))

; Extract the Host header from the second line (index 1 after splitting by newline)
(declare-const second_line String)
(assert (= second_line (str.split_at header "\n" 1)))
(assert (str.contains second_line "Host:"))
(assert (= host (str.split_rest second_line ":" 1)))

; Extract the Content-Length header value
; Find a line containing "Content-Length:" and split by colon
(declare-const content_line String)
; Assume it's the third line for this example
(assert (= content_line (str.split_at header "\n" 2)))
(assert (str.contains content_line "Content-Length:"))
(assert (= content_length_str (str.split_rest content_line ":" 1)))

; Convert the content-length string to an integer and validate it
(assert (str.is_digit content_length_str))
(assert (= content_length_val (str.to_int content_length_str)))
(assert (>= content_length_val 0))
(assert (<= content_length_val 10000))

; Additional constraints to ensure diversity and meaningful parsing
; Method must be one of common HTTP methods
(assert (or (= method "GET") (= method "POST") (= method "PUT") (= method "DELETE")))
; Path must start with a slash
(assert (str.prefixof "/" path))
; Host must not be empty
(assert (> (str.len host) 0))

; Check satisfiability
(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
