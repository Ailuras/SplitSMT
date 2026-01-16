; HTTP Header Parsing with str_split operations
(set-logic ALL)

; Declare variables for HTTP headers and components
(declare-fun header_line1 () String)
(declare-fun header_line2 () String)
(declare-fun header_line3 () String)
(declare-fun full_header () String)
(declare-fun key1 () String)
(declare-fun value1 () String)
(declare-fun key2 () String)
(declare-fun value2 () String)
(declare-fun content_length_str () String)
(declare-fun content_length_val () Int)

; Declare str_split interface functions

; Define full_header as concatenation of header lines with newline delimiters
(assert (= full_header (str.++ header_line1 "\n" header_line2 "\n" header_line3)))

; Assert that each header line contains a colon to separate key and value
(assert (str.contains header_line1 ":"))
(assert (str.contains header_line2 ":"))
(assert (str.contains header_line3 ":"))

; Parse key1 and value1 from header_line1 using split_at
(assert (= key1 (str.split_at header_line1 ":" 0)))
(assert (= value1 (str.split_at header_line1 ":" 1)))
(assert (>= (str.num_splits header_line1 ":") 2))

; Parse key2 and value2 from header_line2 using split_at
(assert (= key2 (str.split_at header_line2 ":" 0)))
(assert (= value2 (str.split_at header_line2 ":" 1)))
(assert (>= (str.num_splits header_line2 ":") 2))

; Validate that key2 is "content-length" (case-sensitive)
(assert (= key2 "content-length"))

; Extract content_length_str from value2 by trimming whitespace
(assert (not (str.contains value2 " ")))
(assert (not (str.contains value2 "\t")))
(assert (not (str.contains value2 "\n")))
(assert (not (str.contains value2 "\r")))
(assert (= content_length_str value2))

; Convert content_length_str to an integer and assert it's positive
(assert (str.is_digit content_length_str))
(assert (= content_length_val (str.to_int content_length_str)))
(assert (> content_length_val 0))

; Additional constraints for header_line3: key must be "user-agent" and value non-empty
(declare-fun key3 () String)
(declare-fun value3 () String)
(assert (= key3 (str.split_at header_line3 ":" 0)))
(assert (= value3 (str.split_at header_line3 ":" 1)))
(assert (>= (str.num_splits header_line3 ":") 2))
(assert (= key3 "user-agent"))
(assert (> (str.len value3) 0))

; Ensure no duplicate keys in the header lines
(assert (not (= key1 key2)))
(assert (not (= key1 key3)))
(assert (not (= key2 key3)))

; Final check for satisfiability

; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
