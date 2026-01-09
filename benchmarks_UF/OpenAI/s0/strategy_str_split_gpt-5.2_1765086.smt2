(set-logic ALL)

; Uninterpreted interface: str_split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Additional helper uninterpreted functions (non-primitive operations)
(declare-fun is_digits (String) Bool)
(declare-fun to_int (String) Int)

; =====================
; SAT instance: well-formed header parsing
; =====================
(declare-const req_sat String)
(declare-const request_line_sat String)
(declare-const headers_block_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const cl_value_sat String)
(declare-const body_sat String)
(declare-const host_key_sat String)
(declare-const host_value_sat String)
(declare-const cl_key_sat String)

; Structural: request line + headers + blank line + body
(assert (= request_line_sat (split_at req_sat "\r\n" 0)))
(assert (= headers_block_sat (split_at req_sat "\r\n\r\n" 0)))
(assert (= body_sat (split_at req_sat "\r\n\r\n" 1)))
(assert (>= (num_splits req_sat "\r\n\r\n") 2))

; Ensure request line looks like an HTTP request line fragment
(assert (str.contains request_line_sat "HTTP/1.1"))
(assert (str.contains request_line_sat "GET "))

; Work within the header block: take some header lines
(assert (>= (num_splits headers_block_sat "\r\n") 3))
(assert (= host_line_sat (split_at headers_block_sat "\r\n" 1)))
(assert (= cl_line_sat (split_at headers_block_sat "\r\n" 2)))

; Parse Host header: "Host: <value>"
(assert (>= (num_splits host_line_sat ":") 2))
(assert (= host_key_sat (split_at host_line_sat ":" 0)))
(assert (= host_value_sat (split_rest host_line_sat ":" 1)))
(assert (= host_key_sat "Host"))
(assert (str.contains host_value_sat "example.com"))

; Parse Content-Length header: "Content-Length: <digits>"
(assert (>= (num_splits cl_line_sat ":") 2))
(assert (= cl_key_sat (split_at cl_line_sat ":" 0)))
(assert (= cl_value_sat (split_rest cl_line_sat ":" 1)))
(assert (= cl_key_sat "Content-Length"))

; Value validation and consistency with body length
(assert (is_digits cl_value_sat))
(assert (>= (to_int cl_value_sat) 0))
(assert (= (to_int cl_value_sat) (str.len body_sat)))

; Make the instance concretely satisfiable
(assert (= req_sat
  (str.++
    "GET /upload HTTP/1.1\r\n"
    "Host: example.com\r\n"
    "Content-Length: 5\r\n"
    "\r\n"
    "abcde")))

; =====================
; UNSAT instance: conflicting content-length vs body length
; =====================
(declare-const req_unsat String)
(declare-const headers_block_unsat String)
(declare-const body_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_value_unsat String)
(declare-const cl_key_unsat String)

(assert (= headers_block_unsat (split_at req_unsat "\r\n\r\n" 0)))
(assert (= body_unsat (split_at req_unsat "\r\n\r\n" 1)))
(assert (>= (num_splits req_unsat "\r\n\r\n") 2))

; Find Content-Length line (assume it is the second header line for this test)
(assert (>= (num_splits headers_block_unsat "\r\n") 3))
(assert (= cl_line_unsat (split_at headers_block_unsat "\r\n" 2)))
(assert (>= (num_splits cl_line_unsat ":") 2))
(assert (= cl_key_unsat (split_at cl_line_unsat ":" 0)))
(assert (= cl_value_unsat (split_rest cl_line_unsat ":" 1)))
(assert (= cl_key_unsat "Content-Length"))

; Validate digits, then impose contradictory length constraint
(assert (is_digits cl_value_unsat))
(assert (= (to_int cl_value_unsat) (str.len body_unsat)))

; Concrete request: body length is 4 but Content-Length says 5 (unsat with above equality)
(assert (= req_unsat
  (str.++
    "POST /submit HTTP/1.1\r\n"
    "Host: bad.example\r\n"
    "Content-Length: 5\r\n"
    "\r\n"
    "wxyz")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
