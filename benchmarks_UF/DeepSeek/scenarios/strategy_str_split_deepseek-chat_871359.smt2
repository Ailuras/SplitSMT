; HTTP Header Parsing Scenario: Extracting values from HTTP request headers using colons and newlines
; This scenario validates content-length and key-value pairs with str_split operations
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Declare variables for HTTP request string and components
(declare-const request String)
(declare-const header_lines String)
(declare-const content_length_value String)
(declare-const host_value String)
(declare-const user_agent_value String)
(declare-const num_lines Int)
(declare-const line_delimiter String)
(declare-const kv_delimiter String)

; Define uninterpreted functions for str_split interface

; Set delimiters for splitting
(assert (= line_delimiter "\n"))
(assert (= kv_delimiter ":"))

; Define the HTTP request string with headers including content-length
(assert (= request "GET /index.html HTTP/1.1\nHost: example.com\nUser-Agent: Mozilla/5.0\nContent-Length: 12345\nAccept: */*\n\nBody data here"))

; Split request into header lines (before empty line)
(assert (= header_lines (split_at request "\n\n" 0)))
(assert (>= (num_splits request "\n\n") 1))

; Count number of header lines
(assert (= num_lines (num_splits header_lines line_delimiter)))
(assert (>= num_lines 3))

; Extract specific header values using split operations
; Get Host value (second line, index 1 after splitting by newline)
(assert (= host_value (split_at (split_at header_lines line_delimiter 1) kv_delimiter 1)))
(assert (str.contains host_value "example"))

; Get User-Agent value (third line, index 2)
(assert (= user_agent_value (split_at (split_at header_lines line_delimiter 2) kv_delimiter 1)))
(assert (str.contains user_agent_value "Mozilla"))

; Extract and validate Content-Length value
; Find the line containing "Content-Length"
(declare-const cl_line String)
(assert (str.contains header_lines "Content-Length"))
; Use split_rest to get substring after "Content-Length:"
(assert (= cl_line (split_rest header_lines "Content-Length:" 0)))
(assert (= content_length_value (split_at cl_line line_delimiter 0)))
; Validate content-length is numeric and within bounds
(assert (str.in_re content_length_value (re.+ (re.range "0" "9"))))
(assert (>= (str.to_int content_length_value) 0))
(assert (<= (str.to_int content_length_value) 100000))

; Additional constraints for robustness
(assert (not (= host_value "")))
(assert (not (= user_agent_value "")))
(assert (not (= content_length_value "")))
(assert (<= (str.len host_value) 100))
(assert (<= (str.len user_agent_value) 200))

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
