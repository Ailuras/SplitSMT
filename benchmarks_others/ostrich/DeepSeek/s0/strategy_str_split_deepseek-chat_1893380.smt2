; HTTP Header Parsing Scenario: Extracting values from HTTP request headers using colons and newlines
; Logic includes string and integer arithmetic for validation
(set-logic ALL)

; Declare variables for the HTTP header string and its components
(declare-const header String)
(declare-const content_length_str String)
(declare-const content_length_val Int)
(declare-const host_str String)
(declare-const host_val String)
(declare-const user_agent_str String)
(declare-const user_agent_val String)

; Declare uninterpreted functions for str_split interface operations
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; Assert that the header contains at least one newline to ensure multiple lines
(assert (str.contains header "\n"))

; Split the header by newlines to get individual header lines
; First line (index 0) should be the request line, e.g., "GET / HTTP/1.1"
(assert (>= (num_splits header "\n") 2))
(declare-const request_line String)
(assert (= request_line (split_at header "\n" 0)))

; Extract Content-Length header value
; Assume Content-Length line format: "Content-Length: 123"
(declare-const content_length_line String)
; Find Content-Length line by checking each split; for simplicity, assume it's at index 1
(assert (= content_length_line (split_at header "\n" 1)))
(assert (str.contains content_length_line ":"))
(assert (= content_length_str (split_at content_length_line ":" 1)))
; Convert content_length_str to integer for validation
(assert (= content_length_val (str.to_int content_length_str)))
(assert (>= content_length_val 0))
(assert (<= content_length_val 10000)) ; Reasonable upper bound

; Extract Host header value
(declare-const host_line String)
; Assume Host line is at index 2
(assert (= host_line (split_at header "\n" 2)))
(assert (str.contains host_line ":"))
(assert (= host_val (split_at host_line ":" 1)))
(assert (>= (str.len host_val) 1)) ; Host must not be empty

; Extract User-Agent header value
(declare-const user_agent_line String)
; Assume User-Agent line is at index 3
(assert (= user_agent_line (split_at header "\n" 3)))
(assert (str.contains user_agent_line ":"))
(assert (= user_agent_val (split_at user_agent_line ":" 1)))
(assert (>= (str.len user_agent_val) 1)) ; User-Agent must not be empty

; Additional constraints to ensure diversity and complexity
; Validate that the header ends with a newline for proper formatting
(assert (str.suffixof "\n" header))
; Ensure Content-Length value is numeric (digits only)
(assert (str.in_re content_length_str (re.+ (re.range "0" "9"))))
; Host value should not contain spaces
(assert (not (str.contains host_val " ")))
; User-Agent value should contain a common browser string
(assert (or (str.contains user_agent_val "Mozilla") (str.contains user_agent_val "Chrome") (str.contains user_agent_val "Safari")))

; Final check for satisfiability
(check-sat)


; [GENERATION STATUS: SUCCESS]
(get-model)
