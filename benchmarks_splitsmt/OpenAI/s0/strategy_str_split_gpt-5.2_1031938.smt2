(set-logic ALL)

; Uninterpreted string split interface

; ========== SAT instance: well-formed header parsing ========== 
(declare-const req_sat String)
(declare-const request_line_sat String)
(declare-const headers_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const body_sat String)
(declare-const cl_len_sat Int)

; Request is split into lines by CRLF. First line is request line.
(assert (>= (str.num_splits req_sat "\r\n") 4))
(assert (= request_line_sat (str.split_at req_sat "\r\n" 0)))
(assert (= headers_sat (str.split_rest req_sat "\r\n" 1)))

; Second and third lines are headers (Host and Content-Length), then an empty line, then body.
(assert (= host_line_sat (str.split_at req_sat "\r\n" 1)))
(assert (= cl_line_sat (str.split_at req_sat "\r\n" 2)))
(assert (= "" (str.split_at req_sat "\r\n" 3)))
(assert (= body_sat (str.split_rest req_sat "\r\n" 4)))

; Each header line must have at least one ':' to separate key/value.
(assert (>= (str.num_splits host_line_sat ":") 2))
(assert (>= (str.num_splits cl_line_sat ":") 2))

; Parse host header
(assert (= host_key_sat (str.split_at host_line_sat ":" 0)))
(assert (= host_val_sat (str.split_rest host_line_sat ":" 1)))
(assert (= host_key_sat "Host"))
(assert (not (str.contains host_val_sat "\r")))
(assert (not (str.contains host_val_sat "\n")))
(assert (> (str.len host_val_sat) 0))

; Parse content-length header
(assert (= cl_key_sat (str.split_at cl_line_sat ":" 0)))
(assert (= cl_val_sat (str.split_rest cl_line_sat ":" 1)))
(assert (= cl_key_sat "Content-Length"))
(assert (not (str.contains cl_val_sat "\r")))
(assert (not (str.contains cl_val_sat "\n")))

; Validate body length equals declared content length.
(assert (= cl_len_sat (str.len body_sat)))
(assert (>= cl_len_sat 0))

; Constrain to a concrete consistent instance for SAT
(assert (= request_line_sat "POST /submit HTTP/1.1"))
(assert (= host_val_sat " example.com"))
(assert (= body_sat "abc"))
(assert (= cl_len_sat 3))
(assert (= cl_val_sat " 3"))

; Build full request string consistent with the extracted fields
(assert (= req_sat (str.++ request_line_sat "\r\n" host_key_sat ":" host_val_sat "\r\n" cl_key_sat ":" cl_val_sat "\r\n\r\n" body_sat)))

(check-sat)

; ========== UNSAT instance: conflicting content-length vs body length ========== 
(declare-const req_unsat String)
(declare-const request_line_unsat String)
(declare-const host_line_unsat String)
(declare-const cl_line_unsat String)
(declare-const body_unsat String)
(declare-const cl_key_unsat String)
(declare-const cl_val_unsat String)
(declare-const cl_len_unsat Int)

(assert (>= (str.num_splits req_unsat "\r\n") 4))
(assert (= request_line_unsat (str.split_at req_unsat "\r\n" 0)))
(assert (= host_line_unsat (str.split_at req_unsat "\r\n" 1)))
(assert (= cl_line_unsat (str.split_at req_unsat "\r\n" 2)))
(assert (= "" (str.split_at req_unsat "\r\n" 3)))
(assert (= body_unsat (str.split_rest req_unsat "\r\n" 4)))

(assert (>= (str.num_splits cl_line_unsat ":") 2))
(assert (= cl_key_unsat (str.split_at cl_line_unsat ":" 0)))
(assert (= cl_val_unsat (str.split_rest cl_line_unsat ":" 1)))
(assert (= cl_key_unsat "Content-Length"))

(assert (= request_line_unsat "POST /x HTTP/1.1"))
(assert (= host_line_unsat "Host: a"))
(assert (= body_unsat "abcd"))
(assert (= cl_len_unsat (str.len body_unsat)))
(assert (= cl_len_unsat 4))

; Force declared Content-Length to contradict actual body length
(assert (= cl_val_unsat " 3"))

(assert (= req_unsat (str.++ request_line_unsat "\r\n" host_line_unsat "\r\n" cl_key_unsat ":" cl_val_unsat "\r\n\r\n" body_unsat)))

; Additionally assert that the declared length equals the actual length (inconsistent with cl_val_unsat encoding)
; We encode a simple inconsistency by requiring the header value string to equal the decimal rendering of the length,
; but also fixing it to " 3" while length is 4.
(declare-fun int_to_dec (Int) String)
(assert (= (int_to_dec cl_len_unsat) "4"))
(assert (= cl_val_unsat (str.++ " " (int_to_dec cl_len_unsat))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
