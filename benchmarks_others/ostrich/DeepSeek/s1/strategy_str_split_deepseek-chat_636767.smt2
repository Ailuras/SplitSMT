; HTTP Header Parsing with str_split operations
(set-logic ALL)

; Declare string variables for HTTP request headers
(declare-const header_block String)
(declare-const content_length_header String)
(declare-const content_length_value String)
(declare-const host_header String)
(declare-const host_value String)
(declare-const user_agent_header String)
(declare-const user_agent_value String)

; Declare integer variables for validation
(declare-const content_length_int Int)
(declare-const header_count Int)

; Declare uninterpreted functions for str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; Define header block with key-value pairs separated by newlines
(assert (= header_block (str.++ "Host: example.com\n" "Content-Length: 1024\n" "User-Agent: Mozilla/5.0\n")))

; Extract Content-Length header using split operations
(assert (= content_length_header (split_at header_block "\n" 1))) ; Second header (index 1)
(assert (= content_length_value (split_at content_length_header ": " 1))) ; Value part after ": "

; Extract Host header
(assert (= host_header (split_at header_block "\n" 0))) ; First header (index 0)
(assert (= host_value (split_at host_header ": " 1))) ; Value part after ": "

; Extract User-Agent header
(assert (= user_agent_header (split_at header_block "\n" 2))) ; Third header (index 2)
(assert (= user_agent_value (split_at user_agent_header ": " 1))) ; Value part after ": "

; Validate number of headers
(assert (= header_count (num_splits header_block "\n")))
(assert (>= header_count 3)) ; At least three headers

; Convert content-length value to integer and validate
(assert (= content_length_int (str.to_int content_length_value)))
(assert (>= content_length_int 0)) ; Non-negative content length
(assert (<= content_length_int 10000)) ; Reasonable upper bound

; Additional constraints for header values
(assert (str.contains host_value ".")) ; Host must contain a dot
(assert (str.contains user_agent_value "Mozilla")) ; User-Agent must contain Mozilla

; Ensure all headers have proper key-value format
(assert (>= (num_splits host_header ": ") 2))
(assert (>= (num_splits content_length_header ": ") 2))
(assert (>= (num_splits user_agent_header ": ") 2))

; Check for no empty values
(assert (not (= host_value "")))
(assert (not (= content_length_value "")))
(assert (not (= user_agent_value "")))

; Final consistency check
(assert (distinct host_value content_length_value user_agent_value))

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
