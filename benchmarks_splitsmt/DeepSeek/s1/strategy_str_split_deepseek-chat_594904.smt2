; HTTP Header Parsing with str_split: Extracting key-value pairs and validating content-length
(set-logic ALL)
; Declare string variables for HTTP headers and components
(declare-fun header_string () String)
(declare-fun content_length_header () String)
(declare-fun content_length_value () String)
(declare-fun host_header () String)
(declare-fun host_value () String)
(declare-fun user_agent_header () String)
(declare-fun user_agent_value () String)
(declare-fun parsed_content_length () Int)
; Declare uninterpreted functions for str_split interface
; Assert header_string is a multi-line HTTP request header
(assert (str.contains header_string "Content-Length:"))
(assert (str.contains header_string "Host:"))
(assert (str.contains header_string "User-Agent:"))
; Split header_string by newline to get individual headers
(assert (>= (str.num_splits header_string "\n") 3))
(assert (= content_length_header (str.split_at header_string "\n" 0)))
(assert (= host_header (str.split_at header_string "\n" 1)))
(assert (= user_agent_header (str.split_at header_string "\n" 2)))
; Extract values by splitting each header by colon and space
(assert (>= (str.num_splits content_length_header ": ") 2))
(assert (= content_length_value (str.split_at content_length_header ": " 1)))
(assert (>= (str.num_splits host_header ": ") 2))
(assert (= host_value (str.split_at host_header ": " 1)))
(assert (>= (str.num_splits user_agent_header ": ") 2))
(assert (= user_agent_value (str.split_at user_agent_header ": " 1)))
; Validate content-length value is a positive integer
(assert (str.in_re content_length_value (re.+ (re.range "0" "9"))))
(assert (not (= content_length_value "")))
(assert (= parsed_content_length (str.to_int content_length_value)))
(assert (> parsed_content_length 0))
; Ensure host and user-agent values are non-empty
(assert (not (= host_value "")))
(assert (not (= user_agent_value "")))
; Additional constraint: total length of header_string is reasonable
(assert (<= (str.len header_string) 1000))
; Create a UNSAT condition: content-length value must be less than 10 but parsed as > 10
(assert (> parsed_content_length 10))
(assert (< (str.len content_length_value) 2))
(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
