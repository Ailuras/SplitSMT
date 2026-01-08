; HTTP Header Parsing with str_split operations
(set-logic ALL)

; Declare string variables for HTTP headers and components
(declare-const headers String)
(declare-const content_length_header String)
(declare-const content_length_value String)
(declare-const user_agent_header String)
(declare-const user_agent_value String)
(declare-const host_header String)
(declare-const host_value String)

; Declare integer variable for content-length validation
(declare-const content_length_int Int)

; Declare str_split interface functions
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; Constraint 1: Headers must contain at least 3 key-value pairs separated by newlines
(assert (>= (num_splits headers "\n") 3))

; Constraint 2: Extract content-length header (first header line)
(assert (= content_length_header (split_at headers "\n" 0)))

; Constraint 3: Content-length header must have format "Content-Length: <value>"
(assert (>= (num_splits content_length_header ":") 2))
(assert (= content_length_value (split_at content_length_header ":" 1)))

; Constraint 4: Content-length value must be a positive integer
(assert (str.in_re content_length_value (re.+ (re.range "0" "9"))))
(assert (> (str.len content_length_value) 0))

; Constraint 5: Convert content-length value to integer and validate range
(assert (= content_length_int (str.to_int content_length_value)))
(assert (<= content_length_int 10000))
(assert (>= content_length_int 0))

; Constraint 6: Extract user-agent header (second header line)
(assert (= user_agent_header (split_at headers "\n" 1)))
(assert (>= (num_splits user_agent_header ":") 2))
(assert (= user_agent_value (split_at user_agent_header ":" 1)))

; Constraint 7: User-agent value must contain common browser identifiers
(assert (str.contains user_agent_value "Mozilla"))

; Constraint 8: Extract host header (third header line)
(assert (= host_header (split_at headers "\n" 2)))
(assert (>= (num_splits host_header ":") 2))
(assert (= host_value (split_at host_header ":" 1)))

; Constraint 9: Host value must be a valid domain name
(assert (str.in_re host_value (re.++ (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-"))) (str.to_re ".") (re.union ((_ re.loop 2 2) (re.range "a" "z")) ((_ re.loop 3 3) (re.range "a" "z"))))))

; Constraint 10: Headers must end with double newline (\n\n)
(assert (str.suffixof "\n\n" headers))

; Constraint 11: Ensure no duplicate header keys
(assert (not (str.contains (split_rest headers "\n" 1) "Content-Length:")))

; Constraint 12: Additional validation - headers must start with valid HTTP method
(assert (str.prefixof "GET " (split_at headers "\n" 0)))

(check-sat)
(get-model)

; [GENERATION STATUS: SUCCESS]
