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

; Assert that the header contains at least one newline to separate lines
(assert (str.contains header "\n"))

; Split the header by newlines to get the first line (e.g., request line)
(assert (= first_line (str.split_at header "\n" 0)))
(assert (>= (str.num_splits header "\n") 1))

; Assert that the first line contains a colon to indicate a key-value pair (e.g., "Host: example.com")
(assert (str.contains first_line ":"))

; Split the first line by colon to extract key and value
(assert (= key (str.split_at first_line ":" 0)))
(assert (= value (str.split_at first_line ":" 1)))
(assert (>= (str.num_splits first_line ":") 2))

; Ensure the key is non-empty and the value is non-empty after trimming spaces (simplified)
(assert (> (str.len key) 0))
(assert (> (str.len value) 0))

; Validate content-length: find a line that starts with "Content-Length:"
(assert (str.contains header "Content-Length:"))

; Extract the content-length line by splitting the header and checking each line (simplified using split_rest)
; Use split_rest to get the part of header after "Content-Length:" and then split by newline
(declare-const after_content_length String)
(assert (= after_content_length (str.split_rest header "Content-Length:" 0)))
(assert (= content_length_str (str.split_at after_content_length "\n" 0)))

; Convert content_length_str to an integer and assert it is positive
(assert (= content_length_val (str.to_int content_length_str)))
(assert (> content_length_val 0))

; Additional constraints to ensure diversity and complexity
; Assert that the header has at least 3 lines (including the first line and content-length line)
(assert (>= (str.num_splits header "\n") 3))

; Assert that the value in the first line does not contain colons (to avoid ambiguity)
(assert (not (str.contains value ":")))

; Assert that the content-length value is less than 10000 to keep it realistic
(assert (< content_length_val 10000))

; Final check for satisfiability
(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
