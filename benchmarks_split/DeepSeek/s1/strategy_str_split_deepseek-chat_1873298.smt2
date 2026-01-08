; HTTP Header Parsing with str_split operations
; Extracting values from HTTP request headers using colons and newlines
; Validating content-length and handling key-value pairs
(set-logic ALL)

; Declare string variables for header components
(declare-fun header_string () String)
(declare-fun host_key () String)
(declare-fun host_value () String)
(declare-fun content_length_key () String)
(declare-fun content_length_value () String)
(declare-fun user_agent_key () String)
(declare-fun user_agent_value () String)
(declare-fun delimiter () String)

; Declare integer variables for validation
(declare-fun parsed_content_length () Int)
(declare-fun header_length () Int)

; Declare str_split interface functions
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Set delimiter for header lines (colon followed by space)
(assert (= delimiter ": "))

; Define header string with multiple key-value pairs separated by newlines
(assert (= header_string (str.++ "Host: example.com\n" 
                                 "Content-Length: 1024\n" 
                                 "User-Agent: Mozilla/5.0\n" 
                                 "Accept: */*")))

; Extract Host header using split operations
(assert (= host_key (split_at header_string "\n" 0)))
(assert (= host_value (split_at host_key delimiter 1)))
(assert (>= (num_splits host_key delimiter) 2))

; Extract Content-Length header
(assert (= content_length_key (split_at header_string "\n" 1)))
(assert (= content_length_value (split_at content_length_key delimiter 1)))
(assert (>= (num_splits content_length_key delimiter) 2))

; Extract User-Agent header
(assert (= user_agent_key (split_at header_string "\n" 2)))
(assert (= user_agent_value (split_at user_agent_key delimiter 1)))
(assert (>= (num_splits user_agent_key delimiter) 2))

; Validate Content-Length value is numeric and within reasonable bounds
(assert (str.is_digit content_length_value))
(assert (>= (str.to_int content_length_value) 0))
(assert (<= (str.to_int content_length_value) 10000))
(assert (= parsed_content_length (str.to_int content_length_value)))

; Ensure header has at least 3 lines (Host, Content-Length, User-Agent)
(assert (>= (num_splits header_string "\n") 3))

; Additional constraint: Host value must contain a dot
(assert (str.contains host_value "."))

; Additional constraint: User-Agent must contain "Mozilla"
(assert (str.contains user_agent_value "Mozilla"))

; Additional constraint: Total header length is reasonable
(assert (= header_length (str.len header_string)))
(assert (>= header_length 50))
(assert (<= header_length 500))

; Complex constraint: Verify split_rest functionality for remaining headers
(assert (str.contains (split_rest header_string "\n" 3) "Accept"))

; Seed constraint from original problem (modified to fit context)
(declare-fun x1 () String)
(declare-fun x2 () String)
(declare-fun z1 () String)
(declare-fun z2 () String)
(declare-fun t1 () String)
(declare-fun t2 () String)
(assert (= (str.++ (str.++ (str.++ x1 "dcb") x2) 
                   (str.++ (str.++ z2 (str.++ "abf" z1)) 
                           (str.++ t1 t2))) 
           (str.++ (str.++ (str.++ x2 "bcd") x1) 
                   (str.++ (str.++ z1 (str.++ "fba" z2)) 
                           "x"))))

; Final check
(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)