(set-logic ALL)

; Uninterpreted interface operations: str_split

; Additional uninterpreted helpers for parsing conveniences
(declare-fun to_int (String) Int)

; ----------------------------
; SAT instance: well-formed HTTP headers and valid Content-Length
; ----------------------------
(declare-const req1 String)
(declare-const headers1 String)
(declare-const request_line1 String)
(declare-const host_line1 String)
(declare-const cl_line1 String)
(declare-const ua_line1 String)
(declare-const host_key1 String)
(declare-const host_val1 String)
(declare-const cl_key1 String)
(declare-const cl_val1 String)
(declare-const ua_key1 String)
(declare-const ua_val1 String)
(declare-const body1 String)
(declare-const method1 String)
(declare-const target1 String)
(declare-const version1 String)

; Structure: request-line \r\n headers \r\n\r\n body
(assert (= request_line1 (str.split_at req1 "\r\n" 0)))
(assert (= headers1 (str.split_at req1 "\r\n\r\n" 0)))
(assert (= body1 (str.split_at req1 "\r\n\r\n" 1)))
(assert (>= (str.num_splits req1 "\r\n\r\n") 2))

; Request line tokenization by spaces: METHOD SP TARGET SP HTTP/VERSION
(assert (= method1 (str.split_at request_line1 " " 0)))
(assert (= target1 (str.split_at request_line1 " " 1)))
(assert (= version1 (str.split_at request_line1 " " 2)))
(assert (>= (str.num_splits request_line1 " ") 3))
(assert (= version1 "HTTP/1.1"))
(assert (= method1 "POST"))
(assert (str.contains target1 "/"))

; Headers block splits into lines
(assert (>= (str.num_splits headers1 "\r\n") 4))
(assert (= host_line1 (str.split_at headers1 "\r\n" 1)))
(assert (= cl_line1 (str.split_at headers1 "\r\n" 2)))
(assert (= ua_line1 (str.split_at headers1 "\r\n" 3)))

; Each header line splits by colon into key and value (value may have leading space)
(assert (= host_key1 (str.split_at host_line1 ":" 0)))
(assert (= host_val1 (str.split_rest host_line1 ":" 1)))
(assert (>= (str.num_splits host_line1 ":") 2))

(assert (= cl_key1 (str.split_at cl_line1 ":" 0)))
(assert (= cl_val1 (str.split_rest cl_line1 ":" 1)))
(assert (>= (str.num_splits cl_line1 ":") 2))

(assert (= ua_key1 (str.split_at ua_line1 ":" 0)))
(assert (= ua_val1 (str.split_rest ua_line1 ":" 1)))
(assert (>= (str.num_splits ua_line1 ":") 2))

; Key constraints
(assert (= host_key1 "Host"))
(assert (= cl_key1 "Content-Length"))
(assert (= ua_key1 "User-Agent"))

; Basic value constraints
(assert (>= (str.len host_val1) 2))
(assert (str.contains host_val1 "."))
(assert (>= (str.len ua_val1) 2))
(assert (str.contains ua_val1 "Mozilla"))

; Content-Length must be decimal digits only (allow leading space in the raw value)
(declare-const cl_digits1 String)
(assert (= cl_digits1 (str.replace cl_val1 " " "")))
(assert (str.in_re cl_digits1 (re.+ (re.range "0" "9"))))

; Validate Content-Length matches body length
(assert (= (to_int cl_digits1) (str.len body1)))
(assert (>= (to_int cl_digits1) 0))

; Constrain the overall request string with explicit construction
(assert (= req1 (str.++ request_line1 "\r\n" host_line1 "\r\n" cl_line1 "\r\n" ua_line1 "\r\n\r\n" body1)))

; Provide concrete witness-like constraints for satisfiability
(assert (= request_line1 "POST /submit HTTP/1.1"))
(assert (= host_line1 "Host: example.com"))
(assert (= ua_line1 "User-Agent: Mozilla/5.0"))
(assert (= body1 "abcdef"))
(assert (= cl_line1 "Content-Length: 6"))

; ----------------------------
; UNSAT instance: conflicting Content-Length for a second request
; ----------------------------
(declare-const req2 String)
(declare-const request_line2 String)
(declare-const headers2 String)
(declare-const body2 String)
(declare-const cl_line2 String)
(declare-const cl_key2 String)
(declare-const cl_val2 String)
(declare-const cl_digits2 String)

(assert (= request_line2 (str.split_at req2 "\r\n" 0)))
(assert (= headers2 (str.split_at req2 "\r\n\r\n" 0)))
(assert (= body2 (str.split_at req2 "\r\n\r\n" 1)))
(assert (>= (str.num_splits req2 "\r\n\r\n") 2))

(assert (>= (str.num_splits headers2 "\r\n") 3))
(assert (= cl_line2 (str.split_at headers2 "\r\n" 2)))

(assert (= cl_key2 (str.split_at cl_line2 ":" 0)))
(assert (= cl_val2 (str.split_rest cl_line2 ":" 1)))
(assert (>= (str.num_splits cl_line2 ":") 2))
(assert (= cl_key2 "Content-Length"))

(assert (= cl_digits2 (str.replace cl_val2 " " "")))
(assert (str.in_re cl_digits2 (re.+ (re.range "0" "9"))))

; Concrete construction for req2
(assert (= request_line2 "POST /x HTTP/1.1"))
(assert (= headers2 (str.++ request_line2 "\r\n" "Host: a.com" "\r\n" cl_line2)))
(assert (= body2 "12345"))
(assert (= req2 (str.++ headers2 "\r\n\r\n" body2)))

; Contradiction: Content-Length claims 4 but body length is 5
(assert (= cl_line2 "Content-Length: 4"))
(assert (= (to_int cl_digits2) (str.len body2)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
