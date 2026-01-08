; HTTP Header Parsing Scenario: Extracting values from HTTP request headers using colons and newlines
; This includes handling key-value pairs and validating content-length
(set-logic ALL)

; Declare variables for the HTTP header string and its components
(declare-const header String)
(declare-const key1 String)
(declare-const value1 String)
(declare-const key2 String)
(declare-const value2 String)
(declare-const content_length_str String)
(declare-const content_length_val Int)

; Declare uninterpreted functions for string split operations as per the interface

; Assert that the header contains at least two key-value pairs separated by newlines
(assert (>= (str.num_splits header "\n") 2))

; Extract the first key-value pair: split by newline, then by colon
(assert (= key1 (str.split_at (str.split_at header "\n" 0) ":" 0)))
(assert (= value1 (str.split_at (str.split_at header "\n" 0) ":" 1)))

; Extract the second key-value pair: split by newline, then by colon
(assert (= key2 (str.split_at (str.split_at header "\n" 1) ":" 0)))
(assert (= value2 (str.split_at (str.split_at header "\n" 1) ":" 1)))

; Validate that one of the keys is "Content-Length" and extract its value
(assert (or (str.contains header "Content-Length:") (str.contains header "content-length:")))
(assert (= content_length_str (str.split_at (str.split_rest header "Content-Length:" 0) "\n" 0)))
(assert (str.is_digit content_length_str))
(assert (= content_length_val (str.to_int content_length_str)))
(assert (>= content_length_val 0))

; Additional constraints to create a SAT instance: ensure non-empty keys and values
(assert (> (str.len key1) 0))
(assert (> (str.len value1) 0))
(assert (> (str.len key2) 0))
(assert (> (str.len value2) 0))
(assert (distinct key1 key2))

; Check satisfiability
(check-sat)
(get-value (header key1 value1 key2 value2 content_length_val))

; [GENERATION STATUS: SUCCESS]
