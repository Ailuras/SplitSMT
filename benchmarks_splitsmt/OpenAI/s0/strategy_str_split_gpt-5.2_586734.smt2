(set-logic ALL)

; Uninterpreted split interface

; =====================
; SAT instance: well-formed HTTP headers, extract Host and Content-Length
; =====================
(declare-const req_sat String)
(declare-const header_lines_sat String)
(declare-const request_line_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const cl_int_sat Int)

; Request is split by CRLF; line 0 is request line; subsequent lines are headers
(assert (= request_line_sat (str.split_at req_sat "\r\n" 0)))
(assert (>= (str.num_splits req_sat "\r\n") 4))

; Take remaining lines after the request line
(assert (= header_lines_sat (str.split_rest req_sat "\r\n" 1)))
(assert (>= (str.num_splits header_lines_sat "\r\n") 3))

; Assume header order: Host then Content-Length then empty line
(assert (= host_line_sat (str.split_at header_lines_sat "\r\n" 0)))
(assert (= cl_line_sat (str.split_at header_lines_sat "\r\n" 1)))

; Key-value parsing using colon delimiter
(assert (>= (str.num_splits host_line_sat ":") 2))
(assert (>= (str.num_splits cl_line_sat ":") 2))
(assert (= host_key_sat (str.split_at host_line_sat ":" 0)))
(assert (= host_val_sat (str.split_rest host_line_sat ":" 1)))
(assert (= cl_key_sat (str.split_at cl_line_sat ":" 0)))
(assert (= cl_val_sat (str.split_rest cl_line_sat ":" 1)))

; Canonical keys
(assert (= host_key_sat "Host"))
(assert (= cl_key_sat "Content-Length"))

; Validate host value: non-empty and contains a dot
(assert (> (str.len host_val_sat) 0))
(assert (str.contains host_val_sat "."))

; Validate Content-Length: it is a digit string and within bounds
(assert (= cl_val_sat (str.from_int cl_int_sat)))
(assert (and (<= 0 cl_int_sat) (<= cl_int_sat 1000000)))

; Constrain whole request format via a concrete construction (ensures SAT)
(assert (= req_sat
  (str.++
    "POST /upload HTTP/1.1\r\n"
    "Host:example.com\r\n"
    "Content-Length:12\r\n"
    "\r\n"
    "hello=world!")))

; =====================
; UNSAT instance: contradictory Content-Length (forces inconsistency)
; =====================
(declare-const req_unsat String)
(declare-const header_lines_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_key_unsat String)
(declare-const cl_val_unsat String)
(declare-const cl_int_unsat Int)
(declare-const body_unsat String)
(declare-const body_len_unsat Int)

; Split request into headers and body at double CRLF
(assert (>= (str.num_splits req_unsat "\r\n\r\n") 2))
(assert (= header_lines_unsat (str.split_at req_unsat "\r\n\r\n" 0)))
(assert (= body_unsat (str.split_rest req_unsat "\r\n\r\n" 1)))
(assert (= body_len_unsat (str.len body_unsat)))

; Assume Content-Length line is the last header line
(assert (>= (str.num_splits header_lines_unsat "\r\n") 2))
(assert (= cl_line_unsat (str.split_at header_lines_unsat "\r\n" (- (str.num_splits header_lines_unsat "\r\n") 1))))

; Parse Content-Length header
(assert (>= (str.num_splits cl_line_unsat ":") 2))
(assert (= cl_key_unsat (str.split_at cl_line_unsat ":" 0)))
(assert (= cl_val_unsat (str.split_rest cl_line_unsat ":" 1)))
(assert (= cl_key_unsat "Content-Length"))

; Relate numeric value
(assert (= cl_val_unsat (str.from_int cl_int_unsat)))
(assert (and (<= 0 cl_int_unsat) (<= cl_int_unsat 1000000)))

; Contradictory validation: body length must equal CL, but also forced different
(assert (= body_len_unsat cl_int_unsat))
(assert (not (= body_len_unsat cl_int_unsat)))

; Concrete request for UNSAT part
(assert (= req_unsat
  (str.++
    "PUT /x HTTP/1.1\r\n"
    "Host:example.com\r\n"
    "Content-Length:3\r\n"
    "\r\n"
    "abcd")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
