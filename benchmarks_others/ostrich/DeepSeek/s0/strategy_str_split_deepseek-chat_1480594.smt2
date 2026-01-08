; HTTP Header Parsing Scenario: Extracting values from HTTP request headers using colons and newlines
; This scenario handles key-value pairs and validates content-length.
(set-logic ALL)

; Declare variables for the HTTP request header string and its components
(declare-const header String)
(declare-const first_line String)
(declare-const content_length_str String)
(declare-const content_length_val Int)
(declare-const key String)
(declare-const value String)

; Declare uninterpreted functions for string split operations as per the interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; Assert that the header contains at least one newline to separate the first line from the rest
(assert (>= (num_splits header "\n") 2))

; Extract the first line of the header (e.g., "GET / HTTP/1.1")
(assert (= first_line (split_at header "\n" 0)))

; Assert that the first line contains a space to separate method, path, and version
(assert (>= (num_splits first_line " ") 3))

; Extract the rest of the header after the first line
(assert (= (split_rest header "\n" 1) (str.substr header (+ (str.indexof header "\n" 0) 1) (- (str.len header) (+ (str.indexof header "\n" 0) 1)))))

; Assert that the header contains a "Content-Length:" key-value pair
(assert (str.contains header "Content-Length:"))

; Extract the line containing "Content-Length:" by splitting the header by newlines and finding the index
; We assume it is at index 1 for simplicity, but in a real scenario, we might need to search
(assert (= content_length_str (split_at header "\n" 1)))

; Assert that the content_length_str contains a colon to separate key and value
(assert (>= (num_splits content_length_str ":") 2))

; Extract the value part after the colon in the content_length_str
(assert (= value (split_at content_length_str ":" 1)))

; Convert the value string to an integer for content-length validation
(assert (= content_length_val (str.to_int value)))

; Validate that the content-length is a non-negative integer
(assert (>= content_length_val 0))

; Additional constraint: Ensure the header is not empty and has a reasonable length
(assert (> (str.len header) 0))
(assert (< (str.len header) 1000))

; Add a constraint to make the problem SAT by allowing flexibility in values
(assert (or (= content_length_val 0) (= content_length_val 100) (= content_length_val 512)))

; Check satisfiability
(check-sat)
(get-model)


; [GENERATION STATUS: SUCCESS]
