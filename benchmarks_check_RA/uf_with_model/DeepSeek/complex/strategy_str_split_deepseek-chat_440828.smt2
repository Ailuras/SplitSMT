; HTTP Header Parsing Scenario: Extracting values from HTTP request headers using colons and newlines, handling key-value pairs and validating content-length.
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Declare variables for the HTTP header string and its components
(declare-const header String)
(declare-const first_line String)
(declare-const content_length_str String)
(declare-const content_length_val Int)
(declare-const key1 String)
(declare-const value1 String)
(declare-const key2 String)
(declare-const value2 String)

; Declare uninterpreted functions for string split operations as per the interface

; Assert that the header contains at least two lines separated by newline delimiter "\n"
(assert (>= (num_splits header "\n") 2))

; Extract the first line (e.g., request line like "GET / HTTP/1.1") by splitting on newline
(assert (= first_line (split_at header "\n" 0)))

; Extract the second line (e.g., a header line like "Content-Length: 123") by splitting on newline
(assert (= content_length_str (split_at header "\n" 1)))

; Assert that the second line contains a colon delimiter to separate key and value
(assert (>= (num_splits content_length_str ":") 2))

; Extract the key part (e.g., "Content-Length") from the second line by splitting on colon
(assert (= key1 (split_at content_length_str ":" 0)))

; Extract the value part (e.g., "123") from the second line by splitting on colon
(assert (= value1 (split_at content_length_str ":" 1)))

; Assert that the key is exactly "Content-Length" to validate the header
(assert (= key1 "Content-Length"))

; Convert the value string to an integer for content-length validation
(assert (= content_length_val (str.to_int value1)))

; Assert that the content-length is a positive integer (e.g., greater than 0)
(assert (> content_length_val 0))

; Additional constraint: Ensure the header has at least one more key-value pair after the first two lines
(assert (>= (num_splits header "\n") 3))

; Extract the third line (e.g., "Host: example.com") by splitting on newline
(assert (= (split_at header "\n" 2) (str.++ key2 ":" value2)))

; Assert that the third line also contains a colon delimiter
(assert (>= (num_splits (split_at header "\n" 2) ":") 2))

; Extract key and value from the third line
(assert (= key2 (split_at (split_at header "\n" 2) ":" 0)))
(assert (= value2 (split_at (split_at header "\n" 2) ":" 1)))

; Assert that the key in the third line is non-empty to ensure a valid header
(assert (> (str.len key2) 0))

; Final check: Ensure the entire header string is non-empty
(assert (> (str.len header) 0))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(get-model)
(exit)
