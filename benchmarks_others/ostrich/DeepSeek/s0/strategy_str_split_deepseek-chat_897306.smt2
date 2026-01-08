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
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

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

; Extract the host header line by finding the line starting with "Host:"
(declare-const host_line String)
(assert (str.contains header "Host:"))
; Use split_rest to get the part after "Host:" in the header, then split by newline to isolate the line
(declare-const after_host String)
(assert (= after_host (str.substr header (str.indexof header "Host:" 0) (str.len header))))
(assert (= host_line (split_at after_host "\n" 0)))
(assert (>= (num_splits host_line ":") 2))
(assert (= host (str.substr (split_at host_line ":" 1) 1 (str.len (split_at host_line ":" 1)))))

; Extract the content-length header value
(assert (str.contains header "Content-Length:"))
(declare-const content_length_line String)
(declare-const after_content_length String)
(assert (= after_content_length (str.substr header (str.indexof header "Content-Length:" 0) (str.len header))))
(assert (= content_length_line (split_at after_content_length "\n" 0)))
(assert (>= (num_splits content_length_line ":") 2))
(assert (= content_length_str (str.substr (split_at content_length_line ":" 1) 1 (str.len (split_at content_length_line ":" 1)))))

; Convert content-length string to integer and validate it
(assert (str.is_digit content_length_str))
(assert (= content_length_val (str.to_int content_length_str)))
(assert (>= content_length_val 0))

; Additional constraint: content-length must be consistent with the body length if present (simplified)
(declare-const body String)
(assert (str.contains header "\n\n"))
(assert (= body (split_rest header "\n\n" 1)))
(assert (= (str.len body) content_length_val))

; Ensure the header ends with a newline for proper formatting
(assert (str.suffixof "\n" header))

; Check satisfiability
(check-sat)
(get-value (header method path version host content_length_val))


; [GENERATION STATUS: SUCCESS]
