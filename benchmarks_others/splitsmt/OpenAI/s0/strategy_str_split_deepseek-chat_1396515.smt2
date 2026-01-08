(set-logic ALL)

; Uninterpreted interface for string split constraints

; Primitive parsing / helper functions as uninterpreted where needed
(declare-fun atoi (String) Int)

; -------------------------
; SAT instance: well-formed HTTP headers and content-length validation
; -------------------------
(declare-const req_sat String)
(declare-const headers_sat String)
(declare-const body_sat String)
(declare-const line0_sat String)
(declare-const line1_sat String)
(declare-const line2_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const cl_int_sat Int)

; Request split at header/body separator
(assert (= headers_sat (str.split_at req_sat "\r\n\r\n" 0)))
(assert (= body_sat (str.split_at req_sat "\r\n\r\n" 1)))
(assert (>= (str.num_splits req_sat "\r\n\r\n") 2))

; Require at least three header lines: request-line + Host + Content-Length
(assert (>= (str.num_splits headers_sat "\r\n") 3))
(assert (= line0_sat (str.split_at headers_sat "\r\n" 0)))
(assert (= line1_sat (str.split_at headers_sat "\r\n" 1)))
(assert (= line2_sat (str.split_at headers_sat "\r\n" 2)))

; Request line basic shape: METHOD SP PATH SP HTTP/VERSION
(assert (>= (str.num_splits line0_sat " " ) 3))
(assert (= (str.split_at line0_sat " " 2) "HTTP/1.1"))
(assert (or (= (str.split_at line0_sat " " 0) "GET")
            (= (str.split_at line0_sat " " 0) "POST")))
(assert (>= (str.len (str.split_at line0_sat " " 1)) 1))

; Parse Host header: "Host: value" using split on ": "
(assert (= host_key_sat (str.split_at line1_sat ": " 0)))
(assert (= host_val_sat (str.split_at line1_sat ": " 1)))
(assert (= host_key_sat "Host"))
(assert (>= (str.num_splits line1_sat ": ") 2))
(assert (not (= host_val_sat "")))

; Parse Content-Length header: "Content-Length: N"
(assert (= cl_key_sat (str.split_at line2_sat ": " 0)))
(assert (= cl_val_sat (str.split_at line2_sat ": " 1)))
(assert (= cl_key_sat "Content-Length"))
(assert (>= (str.num_splits line2_sat ": ") 2))

; Content-Length must be a natural integer string and match body length
(assert (= cl_int_sat (atoi cl_val_sat)))
(assert (>= cl_int_sat 0))
(assert (= cl_int_sat (str.len body_sat)))

; Additional safety: header lines should not contain embedded CRLF
(assert (not (str.contains line1_sat "\r\n")))
(assert (not (str.contains line2_sat "\r\n")))

; Encourage realistic formatting: ensure header block ends with CRLF
(assert (str.contains headers_sat "\r\n"))

; -------------------------
; UNSAT instance: contradictory content-length constraints
; -------------------------
(declare-const req_unsat String)
(declare-const headers_unsat String)
(declare-const body_unsat String)
(declare-const u_line0 String)
(declare-const u_line1 String)
(declare-const u_line2 String)
(declare-const u_cl_key String)
(declare-const u_cl_val String)
(declare-const u_cl_int Int)

(assert (= headers_unsat (str.split_at req_unsat "\r\n\r\n" 0)))
(assert (= body_unsat (str.split_at req_unsat "\r\n\r\n" 1)))
(assert (>= (str.num_splits req_unsat "\r\n\r\n") 2))

(assert (>= (str.num_splits headers_unsat "\r\n") 3))
(assert (= u_line0 (str.split_at headers_unsat "\r\n" 0)))
(assert (= u_line1 (str.split_at headers_unsat "\r\n" 1)))
(assert (= u_line2 (str.split_at headers_unsat "\r\n" 2)))

; Require a valid-looking request line
(assert (>= (str.num_splits u_line0 " ") 3))
(assert (= (str.split_at u_line0 " " 2) "HTTP/1.1"))

; Content-Length line parses correctly
(assert (= u_cl_key (str.split_at u_line2 ": " 0)))
(assert (= u_cl_val (str.split_at u_line2 ": " 1)))
(assert (= u_cl_key "Content-Length"))
(assert (>= (str.num_splits u_line2 ": ") 2))
(assert (= u_cl_int (atoi u_cl_val)))
(assert (>= u_cl_int 0))

; Contradiction: length equals body length AND also equals body length + 1
(assert (= u_cl_int (str.len body_unsat)))
(assert (= u_cl_int (+ (str.len body_unsat) 1)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
