; HTTP Header Parsing with str_split operations
(set-logic ALL)

; Declare string variables for HTTP headers and components
(declare-fun header_string () String)
(declare-fun content_length_header () String)
(declare-fun content_length_value () String)
(declare-fun host_header () String)
(declare-fun host_value () String)
(declare-fun user_agent_header () String)
(declare-fun user_agent_value () String)

; Declare str_split interface functions
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; Seed constraint: original pattern constraint on header_string
(assert (str.in_re header_string (re.++ (re.+ (re.union (str.to_re "0") (str.to_re "111"))) (re.+ (re.+ (str.to_re "222"))))))
(assert (<= 15 (str.len header_string)))

; Additional constraints for HTTP header parsing
; Constraint 1: Header string must contain at least 3 key-value pairs separated by newlines
(assert (>= (num_splits header_string "\n") 3))

; Constraint 2: Extract Content-Length header (first header)
(assert (= content_length_header (split_at header_string "\n" 0)))
(assert (str.contains content_length_header ":"))
(assert (>= (num_splits content_length_header ":") 2))
(assert (= content_length_value (split_at content_length_header ":" 1)))

; Constraint 3: Content-Length value must be a positive integer
(assert (str.in_re content_length_value (re.+ (re.range "0" "9"))))
(assert (>= (str.len content_length_value) 1))

; Constraint 4: Extract Host header (second header)
(assert (= host_header (split_at header_string "\n" 1)))
(assert (str.contains host_header ":"))
(assert (>= (num_splits host_header ":") 2))
(assert (= host_value (split_at host_header ":" 1)))

; Constraint 5: Host value must contain a dot (domain name)
(assert (str.contains host_value "."))

; Constraint 6: Extract User-Agent header (third header)
(assert (= user_agent_header (split_at header_string "\n" 2)))
(assert (str.contains user_agent_header ":"))
(assert (>= (num_splits user_agent_header ":") 2))
(assert (= user_agent_value (split_at user_agent_header ":" 1)))

; Constraint 7: User-Agent value must contain "Mozilla" or "Chrome"
(assert (or (str.contains user_agent_value "Mozilla") (str.contains user_agent_value "Chrome")))

; Constraint 8: Validate that all headers are properly formatted (no empty values)
(assert (not (= content_length_value "")))
(assert (not (= host_value "")))
(assert (not (= user_agent_value "")))

; Constraint 9: Ensure header string ends properly (optional trailing newline handling)
(assert (or 
    (= (split_rest header_string "\n" 3) "")
    (str.contains (split_rest header_string "\n" 3) "\n")
))

(check-sat)
(get-model)

; [GENERATION STATUS: SUCCESS]
