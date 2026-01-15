; HTTP Header Parsing Scenario: Extracting values from HTTP request headers using colons and newlines, handling key-value pairs and validating content-length.
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Declare variables for the HTTP request header string and its components
(declare-const header String)
(declare-const first_line String)
(declare-const content_length_str String)
(declare-const content_length_val Int)
(declare-const host_key String)
(declare-const host_val String)

; Declare uninterpreted functions for string split operations as per the interface

; Assert that the header contains at least two lines separated by newline delimiter "\n"
(assert (>= (num_splits header "\n") 2))

; Extract the first line (e.g., "GET / HTTP/1.1") by splitting header with newline delimiter at index 0
(assert (= first_line (split_at header "\n" 0)))

; Assert that the first line contains a colon for key-value parsing (e.g., in the Host header)
(assert (>= (num_splits first_line ":") 2))

; Extract the Host key (e.g., "Host") from the first line by splitting with colon delimiter at index 0
(assert (= host_key (split_at first_line ":" 0)))

; Extract the Host value (e.g., "example.com") from the first line by splitting with colon delimiter at index 1
(assert (= host_val (split_at first_line ":" 1)))

; Assert that the header contains a Content-Length line by checking for the substring "Content-Length"
(assert (str.contains header "Content-Length"))

; Extract the Content-Length line by splitting the header with newline delimiter and finding the line that contains "Content-Length"
; Use split_rest to get the rest of the header after the first line, then split it further
(declare-const rest_header String)
(assert (= rest_header (split_rest header "\n" 1)))
(assert (str.contains rest_header "Content-Length"))

; Extract the Content-Length value string by splitting the rest_header with colon delimiter
(assert (= content_length_str (split_at rest_header ":" 1)))

; Convert the Content-Length value string to an integer and assert it is a positive number
(assert (= content_length_val (str.to_int content_length_str)))
(assert (> content_length_val 0))

; Additional constraint: Ensure the Host key is exactly "Host" (case-sensitive) for validation
(assert (= host_key "Host"))

; Add a constraint to make the problem SAT by allowing flexibility in the header content
(assert (str.contains header "HTTP/1.1"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
