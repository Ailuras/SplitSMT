; HTTP Header Parsing Scenario: Extracting values from HTTP request headers using colons and newlines, handling key-value pairs and validating content-length.
(set-logic ALL)

; Declare variables for the HTTP header string and its components
(declare-const header String)
(declare-const first_line String)
(declare-const content_length_str String)
(declare-const content_length_val Int)
(declare-const key String)
(declare-const value String)

; Declare functions for string split operations as per the interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; Assert that the header contains at least one newline to separate lines
(assert (>= (num_splits header "\n") 2))

; Extract the first line of the header (e.g., "GET / HTTP/1.1")
(assert (= first_line (split_at header "\n" 0)))

; Assert that the first line contains a space to separate method, path, and version
(assert (>= (num_splits first_line " ") 3))

; Extract the content-length line from the header by splitting with newlines and checking each line
; We assume the content-length line is at index 1 (second line) for simplicity
(assert (= content_length_str (split_at header "\n" 1)))

; Assert that the content-length line contains a colon to separate key and value
(assert (>= (num_splits content_length_str ":") 2))

; Extract the key (should be "Content-Length" or similar) and value from the content-length line
(assert (= key (split_at content_length_str ":" 0)))
(assert (= value (split_at content_length_str ":" 1)))

; Assert that the key is "Content-Length" (case-insensitive handling not supported in SLIA, so use exact match)
(assert (= key "Content-Length"))

; Convert the value string to an integer for validation (using str.to.int)
(assert (= content_length_val (str.to_int value)))

; Validate that the content-length value is a positive integer (e.g., > 0)
(assert (> content_length_val 0))

; Additional constraint: Ensure the header ends with a double newline (\n\n) to indicate end of headers
(assert (str.suffixof "\n\n" header))

; Add a constraint to make the problem SAT by allowing some flexibility in the header content
(assert (str.contains header "HTTP/1.1"))

(check-sat)
(get-model)


; [GENERATION STATUS: SUCCESS]
