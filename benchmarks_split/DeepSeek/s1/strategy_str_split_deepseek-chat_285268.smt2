(set-logic ALL)
; Declare variables for HTTP header parsing
(declare-fun header_string () String)
(declare-fun content_length_key () String)
(declare-fun content_length_value () String)
(declare-fun host_key () String)
(declare-fun host_value () String)
(declare-fun user_agent_key () String)
(declare-fun user_agent_value () String)
(declare-fun total_segments () Int)
; Declare functions for string split operations
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
; Assert that header_string is non-empty and contains newlines and colons
(assert (>= (str.len header_string) 10))
(assert (str.contains header_string "\n"))
(assert (str.contains header_string ":"))
; Split header_string by newline to get lines
(assert (= total_segments (num_splits header_string "\n")))
(assert (>= total_segments 3))
; Extract key-value pairs from specific lines using colon as delimiter
(assert (= content_length_key (split_at (split_at header_string "\n" 0) ":" 0)))
(assert (= content_length_value (split_at (split_at header_string "\n" 0) ":" 1)))
(assert (= host_key (split_at (split_at header_string "\n" 1) ":" 0)))
(assert (= host_value (split_at (split_at header_string "\n" 1) ":" 1)))
(assert (= user_agent_key (split_at (split_at header_string "\n" 2) ":" 0)))
(assert (= user_agent_value (split_at (split_at header_string "\n" 2) ":" 1)))
; Validate that keys are non-empty and specific
(assert (= content_length_key "Content-Length"))
(assert (= host_key "Host"))
(assert (= user_agent_key "User-Agent"))
; Validate content-length value is a positive integer
(assert (str.in_re content_length_value (re.+ (re.range "0" "9"))))
(assert (>= (str.to_int content_length_value) 0))
; Ensure no percent signs in any value to avoid URL encoding issues
(assert (not (str.contains content_length_value "%")))
(assert (not (str.contains host_value "%")))
(assert (not (str.contains user_agent_value "%")))
; Additional constraint: host_value must contain a dot for domain
(assert (str.contains host_value "."))
; Check satisfiability
(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)