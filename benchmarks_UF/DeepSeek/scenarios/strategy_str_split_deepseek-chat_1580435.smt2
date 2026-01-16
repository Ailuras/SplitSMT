; HTTP Header Parsing: Extracting values from HTTP request headers using colons and newlines, handling key-value pairs and validating content-length.
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Declare variables for HTTP request string and extracted components
(declare-const request String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const content_length_key String)
(declare-const content_length_value String)
(declare-const content_length_num Int)

; Declare functions for string split operations

; Constraint 1: Request must contain at least two lines separated by newline (\n)
(assert (>= (num_splits request "\n") 2))

; Constraint 2: First line must start with "Host:" and have a colon separator
(assert (str.contains (split_at request "\n" 0) ":"))
(assert (= host_key (split_at (split_at request "\n" 0) ":" 0)))
(assert (= host_value (split_at (split_at request "\n" 0) ":" 1)))
(assert (= host_key "Host"))

; Constraint 3: Second line must contain "Content-Length:" and a valid integer value
(assert (str.contains (split_at request "\n" 1) ":"))
(assert (= content_length_key (split_at (split_at request "\n" 1) ":" 0)))
(assert (= content_length_value (split_at (split_at request "\n" 1) ":" 1)))
(assert (= content_length_key "Content-Length"))
(assert (str.in_re content_length_value (re.+ (re.range "0" "9"))))

; Constraint 4: Convert content_length_value to integer and ensure it is positive
(assert (= content_length_num (str.to_int content_length_value)))
(assert (> content_length_num 0))

; Constraint 5: Additional validation: request must not contain malicious patterns (e.g., "phpinfo")
(assert (not (str.contains request "phpinfo")))

; Constraint 6: Ensure the request ends with a newline
(assert (str.suffixof "\n" request))

; Constraint 7: Host value must be a valid domain (simplified regex for alphanumeric and dots)
(assert (str.in_re host_value (re.++ (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9"))) (re.* (re.++ (str.to_re ".") (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9"))))))))

; Constraint 8: Add a complex pattern to make the problem SAT (e.g., request contains "Logger" and "aresflashdownloader.com")
(assert (str.in_re request (re.++ (str.to_re "Logger") (re.* re.allchar) (str.to_re "aresflashdownloader.com\n"))))

; Constraint 9: Ensure no invalid characters in key names (only alphanumeric and hyphens)
(assert (str.in_re host_key (re.+ (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "-")))))
(assert (str.in_re content_length_key (re.+ (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "-")))))


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
