; HTTP Header Parsing with str_split operations
(set-logic ALL)
; Declare string variables for HTTP request header and components
(declare-fun header () String)
(declare-fun content_length_key () String)
(declare-fun content_length_value () String)
(declare-fun host_key () String)
(declare-fun host_value () String)
(declare-fun user_agent_key () String)
(declare-fun user_agent_value () String)
(declare-fun first_line () String)
(declare-fun rest_headers () String)
; Declare integer variables for validation
(declare-fun content_length_int () Int)
(declare-fun total_length () Int)
; Declare uninterpreted functions for str_split interface
; Assert initial constraints on header structure
(assert (str.contains header "\n"))
(assert (>= (str.len header) 10))
; Split header into first line and rest using newline delimiter
(assert (= first_line (str.split_at header "\n" 0)))
(assert (= rest_headers (str.split_rest header "\n" 1)))
(assert (>= (str.num_splits header "\n") 2))
; Extract key-value pairs from rest_headers using colon delimiter
(assert (= content_length_key (str.split_at rest_headers ":" 0)))
(assert (= content_length_value (str.split_at rest_headers ":" 1)))
(assert (>= (str.num_splits rest_headers ":") 2))
; Validate content-length key and value
(assert (= content_length_key "Content-Length"))
(assert (str.is_digit content_length_value))
(assert (>= (str.len content_length_value) 1))
; Convert content_length_value to integer for arithmetic validation
(assert (= content_length_int (str.to_int content_length_value)))
(assert (>= content_length_int 0))
(assert (<= content_length_int 10000))
; Additional header fields for diversity
(assert (= host_key (str.split_at rest_headers "\n" 0)))
(assert (= host_value (str.split_at rest_headers "\n" 1)))
(assert (str.contains host_key "Host"))
(assert (>= (str.len host_value) 5))
(assert (= user_agent_key (str.split_at rest_headers "\n" 2)))
(assert (= user_agent_value (str.split_at rest_headers "\n" 3)))
(assert (str.contains user_agent_key "User-Agent"))
(assert (>= (str.len user_agent_value) 10))
; Ensure total length of header matches content-length constraint
(assert (= total_length (str.len header)))
(assert (<= content_length_int total_length))
; Add a contradictory constraint to create an UNSAT instance
(assert (> content_length_int total_length))
(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
