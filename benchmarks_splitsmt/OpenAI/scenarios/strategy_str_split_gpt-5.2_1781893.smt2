(set-logic ALL)

; Uninterpreted functions for str_split interface

; =====================
; SAT instance: consistent HTTP header parsing
; =====================
(declare-const req_sat String)
(declare-const headers_sat String)
(declare-const line_host_sat String)
(declare-const line_cl_sat String)
(declare-const host_key_sat String)
(declare-const host_value_sat String)
(declare-const cl_key_sat String)
(declare-const cl_value_sat String)
(declare-const cl_value_sat_int Int)
(declare-const body_sat String)

; Separate headers from body using CRLFCRLF
(assert (= headers_sat (str.split_at req_sat "\r\n\r\n" 0)))
(assert (= body_sat (str.split_rest req_sat "\r\n\r\n" 1)))
(assert (>= (str.num_splits req_sat "\r\n\r\n") 2))

; Extract key lines from headers
(assert (= line_host_sat (str.split_at headers_sat "\r\n" 1)))
(assert (= line_cl_sat (str.split_at headers_sat "\r\n" 2)))
(assert (>= (str.num_splits headers_sat "\r\n") 3))

; Parse Host line: "Host: <value>"
(assert (= host_key_sat (str.split_at line_host_sat ":" 0)))
(assert (= host_value_sat (str.split_at line_host_sat ":" 1)))
(assert (>= (str.num_splits line_host_sat ":") 2))
(assert (= host_key_sat "Host"))
(assert (str.contains host_value_sat "example.com"))
(assert (not (= host_value_sat "")))

; Parse Content-Length line: "Content-Length: <digits>"
(assert (= cl_key_sat (str.split_at line_cl_sat ":" 0)))
(assert (= cl_value_sat (str.split_at line_cl_sat ":" 1)))
(assert (>= (str.num_splits line_cl_sat ":") 2))
(assert (= cl_key_sat "Content-Length"))

; Constrain content-length value to be digits only (optionally with leading space)
(assert (str.in_re cl_value_sat (re.++ (re.* (str.to_re " ")) (re.+ (re.range "0" "9")))))

; Bind to integer and validate against actual body length
(assert (= cl_value_sat_int (str.to_int cl_value_sat)))
(assert (>= cl_value_sat_int 0))
(assert (= (str.len body_sat) cl_value_sat_int))

; Provide a concrete satisfying structure
(assert (= line_host_sat "Host: example.com"))
(assert (= line_cl_sat "Content-Length: 5"))
(assert (= body_sat "Hello"))


; =====================
; UNSAT instance: contradictory content-length
; =====================
(declare-const req_unsat String)
(declare-const headers_unsat String)
(declare-const line_cl_unsat String)
(declare-const cl_value_unsat String)
(declare-const body_unsat String)
(declare-const cl_value_unsat_int Int)

(assert (= headers_unsat (str.split_at req_unsat "\r\n\r\n" 0)))
(assert (= body_unsat (str.split_rest req_unsat "\r\n\r\n" 1)))
(assert (>= (str.num_splits req_unsat "\r\n\r\n") 2))

; Assume Content-Length is on line 1 after request line
(assert (= line_cl_unsat (str.split_at headers_unsat "\r\n" 1)))
(assert (>= (str.num_splits headers_unsat "\r\n") 2))

(assert (= cl_value_unsat (str.split_at line_cl_unsat ":" 1)))
(assert (>= (str.num_splits line_cl_unsat ":") 2))

; Digits-only constraint
(assert (str.in_re cl_value_unsat (re.++ (re.* (str.to_re " ")) (re.+ (re.range "0" "9")))))

(assert (= cl_value_unsat_int (str.to_int cl_value_unsat)))
(assert (>= cl_value_unsat_int 0))

; Force a concrete body and a mismatching content length -> UNSAT
(assert (= body_unsat "DATA"))
(assert (= line_cl_unsat "Content-Length: 10"))
(assert (= (str.len body_unsat) cl_value_unsat_int))

(check-sat)
(exit)
