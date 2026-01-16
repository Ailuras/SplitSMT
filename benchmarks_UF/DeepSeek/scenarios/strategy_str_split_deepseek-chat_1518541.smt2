; HTTP Header Parsing with str_split operations
; Extracting values from HTTP request headers using colons and newlines
; Validating content-length and handling key-value pairs
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Declare string variables for HTTP headers
(declare-fun request_headers () String)
(declare-fun header_key () String)
(declare-fun header_value () String)
(declare-fun content_length_str () String)
(declare-fun content_type () String)

; Declare integer variables for validation
(declare-const content_length_val Int)
(declare-const colon_index Int)
(declare-const newline_index Int)

; Declare str_split interface functions

; Core constraints for HTTP header parsing
; Extract first header line using newline delimiter
(assert (= header_key (split_at request_headers "\n" 0)))
(assert (>= (num_splits request_headers "\n") 2))

; Split the first header line by colon to get key-value pair
(assert (= colon_index (str.indexof header_key ":" 0)))
(assert (> colon_index 0))
(assert (= header_value (str.substr header_key (+ colon_index 1) (- (str.len header_key) (+ colon_index 1)))))

; Extract content-length header using str_split
(assert (= content_length_str (split_at request_headers "Content-Length:" 1)))
(assert (>= (num_splits request_headers "Content-Length:") 2))

; Convert content-length string to integer
(assert (str.is_digit content_length_str))
(assert (= content_length_val (str.to_int content_length_str)))
(assert (>= content_length_val 0))
(assert (<= content_length_val 10000))

; Extract content-type header
(assert (= content_type (split_at request_headers "Content-Type:" 1)))
(assert (>= (num_splits request_headers "Content-Type:") 2))

; Validate content-type values
(assert (or (= content_type "text/html")
            (= content_type "application/json")
            (= content_type "text/plain")))

; Additional constraints for header structure
(assert (str.contains request_headers "\n\n"))  ; Empty line separating headers and body
(assert (str.contains header_key ":"))
(assert (not (str.contains header_value ":")))  ; Value should not contain colon

; Ensure header key is not empty
(assert (> (str.len header_key) 0))
(assert (> (str.len header_value) 0))

; Check for specific required headers
(assert (str.contains request_headers "Host:"))
(assert (str.contains request_headers "User-Agent:"))

; Final consistency check
(assert (>= (num_splits request_headers "\n") 3))


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
