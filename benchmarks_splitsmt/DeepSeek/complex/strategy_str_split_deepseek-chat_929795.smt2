; HTTP Header Parsing Scenario: Extracting values from HTTP request headers using colons and newlines
; Logic includes string and integer arithmetic for validation
(set-logic ALL)

; Declare string variables for the HTTP header and its components
(declare-const header String)
(declare-const content_length_header String)
(declare-const content_length_value String)
(declare-const host_header String)
(declare-const host_value String)

; Declare integer variables for validation
(declare-const content_length_int Int)
(declare-const header_length Int)

; Declare uninterpreted functions for str_split interface

; Assert that the header contains at least one newline to separate lines
(assert (str.contains header "\n"))

; Split the header by newlines to get individual header lines
; Assume the first line is the request line (e.g., "GET / HTTP/1.1") and subsequent lines are key-value pairs
; Extract the Content-Length header line by splitting and checking for the key
(assert (str.contains header "Content-Length:"))
(assert (= content_length_header (str.split_at header "\n" 1))) ; Assuming Content-Length is the second line (index 1)

; Split the Content-Length header line by colon to get the value
(assert (>= (str.num_splits content_length_header ":") 2))
(assert (= content_length_value (str.split_at content_length_header ":" 1))) ; Value is after the colon

; Validate that the content_length_value is a non-empty string of digits
(assert (str.in_re content_length_value (re.+ (re.range "0" "9"))))

; Convert the content_length_value string to an integer for arithmetic validation
(assert (= content_length_int (str.to_int content_length_value)))
(assert (>= content_length_int 0))
(assert (<= content_length_int 10000)) ; Arbitrary upper bound for realism

; Extract the Host header line similarly
(assert (str.contains header "Host:"))
(assert (= host_header (str.split_at header "\n" 2))) ; Assuming Host is the third line (index 2)
(assert (>= (str.num_splits host_header ":") 2))
(assert (= host_value (str.split_at host_header ":" 1)))

; Validate that the host_value is a non-empty string without spaces
(assert (not (str.contains host_value " ")))
(assert (>= (str.len host_value) 1))

; Additional constraint: total header length must be reasonable
(assert (= header_length (str.len header)))
(assert (>= header_length 20))
(assert (<= header_length 1000))

; Ensure the header ends with a double newline (common in HTTP)
(assert (str.suffixof "\n\n" header))

; Check satisfiability

; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
