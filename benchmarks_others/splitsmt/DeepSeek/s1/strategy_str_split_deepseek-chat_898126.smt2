; HTTP Header Parsing with str_split operations
; Extracting values from HTTP request headers using colons and newlines
; Validating content-length and handling key-value pairs
(set-logic ALL)

; Declare string variables for headers and components
(declare-const header_block String)
(declare-const content_length_key String)
(declare-const content_length_value String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const user_agent_key String)
(declare-const user_agent_value String)
(declare-const parsed_content_length Int)

; Declare str_split interface functions

; Assert that header_block contains multiple lines separated by newline
(assert (>= (str.num_splits header_block "\n") 3))

; Extract first line as host header
(assert (= host_key (str.split_at (str.split_at header_block "\n" 0) ":" 0)))
(assert (= host_value (str.split_at (str.split_at header_block "\n" 0) ":" 1)))
(assert (>= (str.num_splits (str.split_at header_block "\n" 0) ":") 2))

; Extract second line as user-agent header
(assert (= user_agent_key (str.split_at (str.split_at header_block "\n" 1) ":" 0)))
(assert (= user_agent_value (str.split_at (str.split_at header_block "\n" 1) ":" 1)))
(assert (>= (str.num_splits (str.split_at header_block "\n" 1) ":") 2))

; Extract third line as content-length header
(assert (= content_length_key (str.split_at (str.split_at header_block "\n" 2) ":" 0)))
(assert (= content_length_value (str.split_at (str.split_at header_block "\n" 2) ":" 1)))
(assert (>= (str.num_splits (str.split_at header_block "\n" 2) ":") 2))

; Validate key names
(assert (= host_key "Host"))
(assert (= user_agent_key "User-Agent"))
(assert (= content_length_key "Content-Length"))

; Content-length value must be a non-negative integer
(assert (str.in_re content_length_value (re.+ (re.range "0" "9"))))
(assert (>= (str.len content_length_value) 1))

; Parse content-length value to integer
(assert (= parsed_content_length (str.to_int content_length_value)))
(assert (>= parsed_content_length 0))
(assert (<= parsed_content_length 10000))

; Additional constraints for realistic header values
(assert (str.contains host_value "."))
(assert (>= (str.len host_value) 5))
(assert (str.contains user_agent_value "Mozilla"))

; Ensure no extra colons in values (simple validation)
(assert (not (str.contains host_value ":")))
(assert (not (str.contains user_agent_value ":")))

; Check that header_block ends properly (optional)
(assert (str.suffixof "\n" (str.split_rest header_block "\n" 3)))

; Make it SAT by allowing reasonable values
(assert (>= (str.len header_block) 50))
(assert (<= (str.len header_block) 500))

(check-sat)
(get-model)

; [GENERATION STATUS: SUCCESS]
