(set-logic ALL)

; Uninterpreted string-split interface

; Uninterpreted helpers for parsing and validation
(declare-fun trim (String) String)
(declare-fun to_int (String) Int)

; =====================
; SAT instance: well-formed HTTP header parsing
; =====================
(declare-const req_sat String)
(declare-const headers_sat String)
(declare-const reqline_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const ua_line_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const ua_key_sat String)
(declare-const ua_val_sat String)
(declare-const content_length_sat Int)
(declare-const body_sat String)

; Concrete request with headers and body
(assert (= req_sat
  (str.++
    "POST /submit HTTP/1.1\r\n"
    "Host: example.com\r\n"
    "Content-Length: 5\r\n"
    "User-Agent: test\r\n"
    "\r\n"
    "abcde")))

; Split request line and remaining block by CRLF
(assert (= reqline_sat (str.split_at req_sat "\r\n" 0)))
(assert (= headers_sat (str.split_rest req_sat "\r\n" 1)))

; Headers section ends with an empty line; body after that
(assert (= body_sat (str.split_rest headers_sat "\r\n\r\n" 1)))

; Header lines: indices in bounds (at least 4 segments before blank line)
(assert (>= (str.num_splits req_sat "\r\n") 5))

; Extract specific header lines by known order in this scenario
(assert (= host_line_sat (str.split_at req_sat "\r\n" 1)))
(assert (= cl_line_sat (str.split_at req_sat "\r\n" 2)))
(assert (= ua_line_sat (str.split_at req_sat "\r\n" 3)))

; Parse "Key: Value" using ":" delimiter
(assert (= host_key_sat (trim (str.split_at host_line_sat ":" 0))))
(assert (= host_val_sat (trim (str.split_rest host_line_sat ":" 1))))
(assert (= cl_key_sat (trim (str.split_at cl_line_sat ":" 0))))
(assert (= cl_val_sat (trim (str.split_rest cl_line_sat ":" 1))))
(assert (= ua_key_sat (trim (str.split_at ua_line_sat ":" 0))))
(assert (= ua_val_sat (trim (str.split_rest ua_line_sat ":" 1))))

; Validate keys and basic value presence
(assert (= host_key_sat "Host"))
(assert (= cl_key_sat "Content-Length"))
(assert (= ua_key_sat "User-Agent"))
(assert (> (str.len host_val_sat) 0))
(assert (> (str.len ua_val_sat) 0))

; Content-Length validation: numeric and matches body length
(assert (= content_length_sat (to_int cl_val_sat)))
(assert (= content_length_sat 5))
(assert (= (str.len body_sat) content_length_sat))

; Request line sanity: method and version presence
(assert (str.contains reqline_sat "HTTP/1.1"))
(assert (or (str.contains reqline_sat "POST") (str.contains reqline_sat "GET")))

; =====================
; UNSAT instance: conflicting Content-Length vs actual body
; =====================
(declare-const req_unsat String)
(declare-const headers_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_val_unsat String)
(declare-const content_length_unsat Int)
(declare-const body_unsat String)

(assert (= req_unsat
  (str.++
    "POST /upload HTTP/1.1\r\n"
    "Host: example.com\r\n"
    "Content-Length: 4\r\n"
    "\r\n"
    "ABCDE")))

(assert (= headers_unsat (str.split_rest req_unsat "\r\n" 1)))
(assert (= body_unsat (str.split_rest headers_unsat "\r\n\r\n" 1)))
(assert (= cl_line_unsat (str.split_at req_unsat "\r\n" 2)))
(assert (= cl_val_unsat (trim (str.split_rest cl_line_unsat ":" 1))))
(assert (= content_length_unsat (to_int cl_val_unsat)))

; Force numeric interpretation
(assert (= content_length_unsat 4))
; But actual body is length 5 ("ABCDE") -> inconsistency
(assert (= (str.len body_unsat) content_length_unsat))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
