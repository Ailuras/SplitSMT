; HTTP Header Parsing: Extracting values from HTTP request headers using colons and newlines, handling key-value pairs and validating content-length.
(set-logic ALL)
; Declare string variables for header components
(declare-fun header_string () String)
(declare-fun key1 () String)
(declare-fun value1 () String)
(declare-fun key2 () String)
(declare-fun value2 () String)
(declare-fun content_length_str () String)
(declare-fun content_length_val () Int)
; Declare uninterpreted functions for str_split interface
; Assert that header_string contains key-value pairs separated by newlines and colons
(assert (str.contains header_string "\n"))
(assert (str.contains header_string ":"))
; Split header_string by newline to get lines
(assert (>= (str.num_splits header_string "\n") 2))
(assert (= key1 (str.split_at header_string "\n" 0)))
(assert (= value1 (str.split_rest header_string "\n" 1)))
; Further split the first line by colon to extract key and value
(assert (>= (str.num_splits key1 ":") 2))
(assert (= key2 (str.split_at key1 ":" 0)))
(assert (= value2 (str.split_at key1 ":" 1)))
; Validate that key2 is non-empty and value2 contains digits for content-length
(assert (> (str.len key2) 0))
(assert (str.contains value2 "Content-Length"))
; Extract content-length value as a string and convert to integer
(assert (= content_length_str (str.split_at value2 " " 1)))
(assert (str.is_digit content_length_str))
(assert (= content_length_val (str.to_int content_length_str)))
(assert (>= content_length_val 0))
; Additional constraints to ensure diversity and complexity
(assert (not (= key2 "Host")))
(assert (str.prefixof "HTTP/" header_string))
; Check satisfiability
(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
