; HTTP Header Parsing with str_split operations
(set-logic ALL)

; Declare string variables for HTTP request headers and components
(declare-const request_header String)
(declare-const content_length_key String)
(declare-const content_length_value String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const user_agent_key String)
(declare-const user_agent_value String)
(declare-const first_line String)
(declare-const header_lines String)
(declare-const num_lines Int)

; Declare uninterpreted functions for str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Define the HTTP request header with key-value pairs separated by newlines and colons
(assert (= request_header (str.++ "GET /index.html HTTP/1.1\n"
                                 "Host: example.com\n"
                                 "User-Agent: Mozilla/5.0\n"
                                 "Content-Length: 1234\n"
                                 "\n")))

; Split the header into first line and the rest of the header lines
(assert (= first_line (split_at request_header "\n" 0)))
(assert (= header_lines (split_rest request_header "\n" 1)))
(assert (>= (num_splits request_header "\n") 2))

; Extract the number of header lines (excluding the first line and empty line at the end)
(assert (= num_lines (- (num_splits request_header "\n") 2)))
(assert (>= num_lines 3))

; Split header lines into individual key-value pairs using newline delimiter
(assert (= content_length_key (split_at (split_at header_lines "\n" 2) ":" 0)))
(assert (= content_length_value (str.substr (split_at header_lines "\n" 2) 
                                            (+ (str.len content_length_key) 2) 
                                            (- (str.len (split_at header_lines "\n" 2)) 
                                               (+ (str.len content_length_key) 2)))))
(assert (= host_key (split_at (split_at header_lines "\n" 0) ":" 0)))
(assert (= host_value (str.substr (split_at header_lines "\n" 0) 
                                  (+ (str.len host_key) 2) 
                                  (- (str.len (split_at header_lines "\n" 0)) 
                                     (+ (str.len host_key) 2)))))
(assert (= user_agent_key (split_at (split_at header_lines "\n" 1) ":" 0)))
(assert (= user_agent_value (str.substr (split_at header_lines "\n" 1) 
                                        (+ (str.len user_agent_key) 2) 
                                        (- (str.len (split_at header_lines "\n" 1)) 
                                           (+ (str.len user_agent_key) 2)))))

; Validate key names
(assert (= content_length_key "Content-Length"))
(assert (= host_key "Host"))
(assert (= user_agent_key "User-Agent"))

; Validate content-length value is a positive integer
(assert (str.in_re content_length_value (re.+ (re.range "0" "9"))))
(assert (not (= content_length_value "")))
(assert (>= (str.to_int content_length_value) 0))

; Additional constraints for diversity
(assert (str.contains host_value ".com"))
(assert (str.contains user_agent_value "Mozilla"))
(assert (str.prefixof "GET" first_line))
(assert (str.suffixof "HTTP/1.1" first_line))

; Check satisfiability
(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
