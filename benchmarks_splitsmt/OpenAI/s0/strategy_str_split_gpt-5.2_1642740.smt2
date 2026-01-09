(set-logic ALL)

; Uninterpreted string split interface

; Uninterpreted helper for numeric parsing/validation
(declare-fun str_to_int (String) Int)

; =====================
; SAT instance: well-formed HTTP headers with Content-Length
; =====================
(declare-const req_sat String)
(declare-const headers_sat String)
(declare-const line0_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const cl_int_sat Int)

; Structure: split request by CRLF into header lines
(assert (>= (str.num_splits req_sat "\r\n") 4))
(assert (= line0_sat (str.split_at req_sat "\r\n" 0)))
(assert (= host_line_sat (str.split_at req_sat "\r\n" 1)))
(assert (= cl_line_sat (str.split_at req_sat "\r\n" 2)))
(assert (= headers_sat (str.split_rest req_sat "\r\n" 0)))

; Request line sanity (contains method and HTTP version)
(assert (str.contains line0_sat "HTTP/1.1"))
(assert (or (str.contains line0_sat "GET ") (str.contains line0_sat "POST ")))

; Host header parsing: "Host: <value>"
(assert (>= (str.num_splits host_line_sat ":") 2))
(assert (= host_key_sat (str.split_at host_line_sat ":" 0)))
(assert (= host_val_sat (str.split_rest host_line_sat ":" 1)))
(assert (= host_key_sat "Host"))
; Host value must be non-empty and must not contain CR or LF
(assert (> (str.len host_val_sat) 1))
(assert (not (str.contains host_val_sat "\r")))
(assert (not (str.contains host_val_sat "\n")))

; Content-Length header parsing: "Content-Length: <digits>"
(assert (>= (str.num_splits cl_line_sat ":") 2))
(assert (= cl_key_sat (str.split_at cl_line_sat ":" 0)))
(assert (= cl_val_sat (str.split_rest cl_line_sat ":" 1)))
(assert (= cl_key_sat "Content-Length"))

; Allow optional leading space before digits in value; enforce digits-only after stripping one space
; We model it by requiring either digits-only or a single leading space then digits-only.
(assert (or
  (str.in_re cl_val_sat (re.+ (re.range "0" "9")))
  (and
    (>= (str.len cl_val_sat) 2)
    (= (str.at cl_val_sat 0) " ")
    (str.in_re (str.substr cl_val_sat 1 (- (str.len cl_val_sat) 1)) (re.+ (re.range "0" "9")))
  )
))

; Link numeric conversion with an uninterpreted converter and validate range
(assert (= cl_int_sat (str_to_int cl_val_sat)))
(assert (>= cl_int_sat 0))
(assert (<= cl_int_sat 1048576))

; Constrain a concrete satisfying example
(assert (= req_sat
  (str.++
    "GET /index.html HTTP/1.1\r\n"
    "Host: example.com\r\n"
    "Content-Length: 12\r\n"
    "\r\n"
  )
))

; =====================
; UNSAT instance: contradictory Content-Length constraints
; =====================
(declare-const req_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_key_unsat String)
(declare-const cl_val_unsat String)
(declare-const cl_int_unsat Int)

(assert (>= (str.num_splits req_unsat "\r\n") 3))
(assert (= cl_line_unsat (str.split_at req_unsat "\r\n" 1)))
(assert (>= (str.num_splits cl_line_unsat ":") 2))
(assert (= cl_key_unsat (str.split_at cl_line_unsat ":" 0)))
(assert (= cl_val_unsat (str.split_rest cl_line_unsat ":" 1)))
(assert (= cl_key_unsat "Content-Length"))

; Force a specific Content-Length string
(assert (= cl_val_unsat "10"))
(assert (= cl_int_unsat (str_to_int cl_val_unsat)))

; Contradiction: same parsed integer must be 10 and 11
(assert (= cl_int_unsat 10))
(assert (= cl_int_unsat 11))

; Provide a concrete request containing the header
(assert (= req_unsat
  (str.++
    "POST /upload HTTP/1.1\r\n"
    "Content-Length:10\r\n"
    "\r\n"
  )
))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
