; HTTP Header Parsing with str_split operations
(set-logic ALL)

; Declare variables for HTTP header components
(declare-const header String)
(declare-const content_length_key String)
(declare-const content_length_value String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const user_agent_key String)
(declare-const user_agent_value String)
(declare-const header_line1 String)
(declare-const header_line2 String)
(declare-const header_line3 String)
(declare-const delimiter String)
(declare-const colon String)
(declare-const newline String)

; Define constants for delimiters
(assert (= colon ":"))
(assert (= newline "\n"))
(assert (= delimiter (str.++ colon " "))) ; Colon followed by space for key-value separation

; Define header as a multi-line string with key-value pairs
(assert (= header (str.++ "Content-Length: 1024" newline "Host: example.com" newline "User-Agent: Mozilla/5.0")))

; Split header into lines using newline delimiter
(assert (= header_line1 (split_at header newline 0)))
(assert (= header_line2 (split_at header newline 1)))
(assert (= header_line3 (split_at header newline 2)))
(assert (= (num_splits header newline) 3)) ; Ensure exactly 3 lines

; Parse Content-Length line
(assert (= content_length_key (split_at header_line1 delimiter 0)))
(assert (= content_length_value (split_at header_line1 delimiter 1)))
(assert (= (num_splits header_line1 delimiter) 2)) ; Key and value only
(assert (= content_length_key "Content-Length"))

; Parse Host line
(assert (= host_key (split_at header_line2 delimiter 0)))
(assert (= host_value (split_at header_line2 delimiter 1)))
(assert (= (num_splits header_line2 delimiter) 2))
(assert (= host_key "Host"))

; Parse User-Agent line
(assert (= user_agent_key (split_at header_line3 delimiter 0)))
(assert (= user_agent_value (split_at header_line3 delimiter 1)))
(assert (= (num_splits header_line3 delimiter) 2))
(assert (= user_agent_key "User-Agent"))

; Validate content-length value is a positive integer
(declare-const cl_int Int)
(assert (str.is_digit content_length_value)) ; Ensure all characters are digits
(assert (= cl_int (str.to_int content_length_value)))
(assert (> cl_int 0))
(assert (<= cl_int 10000)) ; Upper bound for content-length

; Additional constraints for robustness
(assert (not (str.contains header "\r"))) ; No carriage returns allowed
(assert (str.prefixof "Content-Length" header)) ; Header must start with Content-Length
(assert (str.suffixof "Mozilla/5.0" header)) ; Header must end with User-Agent value

; Introduce a potential conflict to create UNSAT scenario
; Uncomment below to make UNSAT:
; (assert (str.contains content_length_value "a")) ; Content-length value cannot contain 'a'

(check-sat)
(get-value (header content_length_value host_value user_agent_value))

; [GENERATION STATUS: SUCCESS]
