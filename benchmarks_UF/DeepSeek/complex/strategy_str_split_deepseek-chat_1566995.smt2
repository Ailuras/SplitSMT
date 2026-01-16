; HTTP Header Parsing Scenario: Extracting values from HTTP request headers using colons and newlines, with content-length validation.
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

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
(assert (>= (num_splits header "\n") 2))

; Extract the first line (request line) and split it by spaces to get method, path, and version
(declare-const request_line String)
(assert (= request_line (split_at header "\n" 0)))
(assert (>= (num_splits request_line " ") 3))
(assert (= method (split_at request_line " " 0)))
(assert (= path (split_at request_line " " 1)))
(assert (= version (split_at request_line " " 2)))

; Validate that the method is one of common HTTP methods (e.g., GET, POST)
(assert (or (= method "GET") (= method "POST") (= method "PUT") (= method "DELETE") (= method "HEAD")))

; Extract the Host header line (assuming it's the second line for simplicity)
(declare-const host_line String)
(assert (= host_line (split_at header "\n" 1)))
(assert (str.contains host_line "Host:"))
(assert (>= (num_splits host_line ":") 2))
(assert (= host (split_at host_line ":" 1)))
(assert (>= (str.len host) 1))

; Extract the Content-Length header line by searching through the header
(declare-const content_length_line String)
(assert (str.contains header "Content-Length:"))
; Use split_rest to get the part of header after "Content-Length:" and then split by newline to isolate the line
(declare-const after_content_length String)
(assert (= after_content_length (split_rest header "Content-Length:" 0)))
(assert (= content_length_line (split_at after_content_length "\n" 0)))
(assert (>= (num_splits content_length_line ":") 2))
(assert (= content_length_str (split_at content_length_line ":" 1)))

; Convert content_length_str to an integer and validate it
(assert (str.is_digit content_length_str))
(assert (= content_length_val (str.to_int content_length_str)))
(assert (>= content_length_val 0))
(assert (<= content_length_val 1000000))

; Additional constraint to ensure the header ends with a double newline (indicating end of headers)
(assert (str.suffixof "\n\n" header))

; Check satisfiability

; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
