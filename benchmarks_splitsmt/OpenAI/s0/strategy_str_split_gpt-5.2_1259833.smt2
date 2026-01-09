(set-logic ALL)

; Uninterpreted functions for string splitting interface

; Uninterpreted helper operations (non-primitive)
(declare-fun header_value (String String) String)
(declare-fun trim (String) String)
(declare-fun to_int (String) Int)
(declare-fun is_digits (String) Bool)

; =========================
; SAT instance: well-formed HTTP headers with valid Content-Length
; =========================
(declare-const req_sat String)
(declare-const headers_sat String)
(declare-const request_line_sat String)
(declare-const body_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const cl_val_trim_sat String)
(declare-const host_val_trim_sat String)
(declare-const cl_int_sat Int)

; Model a request split into header section and body by CRLFCRLF
(assert (>= (str.num_splits req_sat "\r\n\r\n") 2))
(assert (= headers_sat (str.split_at req_sat "\r\n\r\n" 0)))
(assert (= body_sat (str.split_rest req_sat "\r\n\r\n" 1)))

; First line is request line, remaining are header lines
(assert (>= (str.num_splits headers_sat "\r\n") 2))
(assert (= request_line_sat (str.split_at headers_sat "\r\n" 0)))

; Ensure request line resembles METHOD SP PATH SP HTTP/1.1
(assert (str.in_re request_line_sat (re.++ (str.to_re "GET") (str.to_re " ") (re.* re.allchar) (str.to_re " HTTP/1.1"))))

; Constrain specific header lines positions to parse
(assert (>= (str.num_splits headers_sat "\r\n") 3))
(assert (= host_line_sat (str.split_at headers_sat "\r\n" 1)))
(assert (= cl_line_sat (str.split_at headers_sat "\r\n" 2)))

; Parse "Host: value" by colon delimiter
(assert (>= (str.num_splits host_line_sat ":") 2))
(assert (= host_key_sat (str.split_at host_line_sat ":" 0)))
(assert (= host_val_sat (str.split_rest host_line_sat ":" 1)))
(assert (= host_val_trim_sat (trim host_val_sat)))
(assert (= host_key_sat "Host"))
(assert (> (str.len host_val_trim_sat) 0))

; Parse "Content-Length: n" by colon delimiter
(assert (>= (str.num_splits cl_line_sat ":") 2))
(assert (= cl_key_sat (str.split_at cl_line_sat ":" 0)))
(assert (= cl_val_sat (str.split_rest cl_line_sat ":" 1)))
(assert (= cl_val_trim_sat (trim cl_val_sat)))
(assert (= cl_key_sat "Content-Length"))

; Validate Content-Length is digits and matches body length
(assert (is_digits cl_val_trim_sat))
(assert (= cl_int_sat (to_int cl_val_trim_sat)))
(assert (>= cl_int_sat 0))
(assert (= cl_int_sat (str.len body_sat)))

; Provide concrete body to make satisfiable even with uninterpreted to_int/is_digits/trim
; We force a concrete body and corresponding numeric string value, allowing a consistent interpretation.
(assert (= body_sat "hello"))
(assert (= cl_val_trim_sat "5"))

; Also connect via a generic lookup function (uninterpreted) for diversity
(declare-const cl_lookup_sat String)
(declare-const host_lookup_sat String)
(assert (= cl_lookup_sat (header_value headers_sat "Content-Length")))
(assert (= host_lookup_sat (header_value headers_sat "Host")))

; =========================
; UNSAT instance: contradictory Content-Length constraints
; =========================
(declare-const req_unsat String)
(declare-const headers_unsat String)
(declare-const body_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_key_unsat String)
(declare-const cl_val_unsat String)
(declare-const cl_val_trim_unsat String)
(declare-const cl_int_unsat Int)

(assert (>= (str.num_splits req_unsat "\r\n\r\n") 2))
(assert (= headers_unsat (str.split_at req_unsat "\r\n\r\n" 0)))
(assert (= body_unsat (str.split_rest req_unsat "\r\n\r\n" 1)))

(assert (>= (str.num_splits headers_unsat "\r\n") 2))
(assert (= cl_line_unsat (str.split_at headers_unsat "\r\n" 1)))

(assert (>= (str.num_splits cl_line_unsat ":") 2))
(assert (= cl_key_unsat (str.split_at cl_line_unsat ":" 0)))
(assert (= cl_val_unsat (str.split_rest cl_line_unsat ":" 1)))
(assert (= cl_val_trim_unsat (trim cl_val_unsat)))
(assert (= cl_key_unsat "Content-Length"))

(assert (is_digits cl_val_trim_unsat))
(assert (= cl_int_unsat (to_int cl_val_trim_unsat)))
(assert (>= cl_int_unsat 0))

; Force body and numeric string, then add inconsistent length requirement
(assert (= body_unsat "hello"))
(assert (= cl_val_trim_unsat "5"))
(assert (= cl_int_unsat (str.len body_unsat)))
(assert (not (= cl_int_unsat (str.len body_unsat))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
