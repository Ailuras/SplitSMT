(set-logic ALL)

; Uninterpreted interface for string split constraints

; Uninterpreted helpers for header parsing
(declare-fun header_value (String String) String) ; header_value(headers, key) -> value string
(declare-fun header_present (String String) Bool)  ; header_present(headers, key)
(declare-fun to_int (String) Int)                  ; parse decimal integer from string
(declare-fun is_digits (String) Bool)              ; whether string is non-empty digits
(declare-fun body_of (String) String)              ; extract message body from full request

; ======== SAT instance: well-formed HTTP header parsing ========
(declare-const req_sat String)
(declare-const headers_sat String)
(declare-const body_sat String)
(declare-const cl_val_sat String)
(declare-const host_val_sat String)
(declare-const first_line_sat String)
(declare-const method_sat String)
(declare-const path_sat String)
(declare-const version_sat String)
(declare-const reconstructed_sat String)

; Basic structure: headers and body separated by CRLFCRLF
(assert (= headers_sat (str.split_at req_sat "\r\n\r\n" 0)))
(assert (= body_sat (str.split_at req_sat "\r\n\r\n" 1)))
(assert (= body_sat (body_of req_sat)))
(assert (= reconstructed_sat (str.++ headers_sat "\r\n\r\n" body_sat)))
(assert (= req_sat reconstructed_sat))
(assert (>= (str.num_splits req_sat "\r\n\r\n") 2))

; Parse request line: METHOD SP PATH SP HTTP/VERSION
(assert (= first_line_sat (str.split_at headers_sat "\r\n" 0)))
(assert (>= (str.num_splits headers_sat "\r\n") 2))
(assert (= method_sat (str.split_at first_line_sat " " 0)))
(assert (= path_sat (str.split_at first_line_sat " " 1)))
(assert (= version_sat (str.split_at first_line_sat " " 2)))
(assert (>= (str.num_splits first_line_sat " ") 3))
(assert (= method_sat "POST"))
(assert (str.in_re version_sat (str.to_re "HTTP/1.1")))
(assert (str.prefixof "/" path_sat))

; Header presence and values (uninterpreted mapping constraints + split-based shaping)
(assert (header_present headers_sat "Host"))
(assert (header_present headers_sat "Content-Length"))
(assert (= host_val_sat (header_value headers_sat "Host")))
(assert (= cl_val_sat (header_value headers_sat "Content-Length")))

; Shape the Host header line as "Host: <value>" somewhere in headers
(declare-const host_line_sat String)
(assert (= host_line_sat (str.++ "Host:" " " host_val_sat)))
(assert (str.contains headers_sat (str.++ host_line_sat "\r\n")))
(assert (>= (str.len host_val_sat) 1))

; Shape the Content-Length header line as "Content-Length: <digits>"
(declare-const cl_line_sat String)
(assert (= cl_line_sat (str.++ "Content-Length:" " " cl_val_sat)))
(assert (str.contains headers_sat (str.++ cl_line_sat "\r\n")))
(assert (is_digits cl_val_sat))
(assert (>= (str.len cl_val_sat) 1))

; Validate Content-Length matches body length
(assert (= (to_int cl_val_sat) (str.len body_sat)))
(assert (>= (to_int cl_val_sat) 0))

; Concrete satisfiable construction with consistency
(assert (= host_val_sat "example.com"))
(assert (= body_sat "ABCDE"))
(assert (= cl_val_sat "5"))
(assert (= headers_sat (str.++ "POST /upload HTTP/1.1\r\n"
                              "Host: example.com\r\n"
                              "Content-Length: 5\r\n"
                              "User-Agent: test\r\n")))
(assert (= req_sat (str.++ headers_sat "\r\n\r\n" body_sat)))

; Additional split constraints using ':' for key-value pairs (structural, relaxed)
(declare-const cl_kv_sat String)
(declare-const cl_key_sat String)
(declare-const cl_value_with_space_sat String)
(assert (= cl_kv_sat cl_line_sat))
(assert (= cl_key_sat (str.split_at cl_kv_sat ":" 0)))
(assert (= cl_value_with_space_sat (str.split_at cl_kv_sat ":" 1)))
(assert (= cl_key_sat "Content-Length"))
(assert (str.prefixof " " cl_value_with_space_sat))

; Check satisfiable instance
(check-sat)

; ======== UNSAT instance: contradictory Content-Length ========
(declare-const req_unsat String)
(declare-const headers_unsat String)
(declare-const body_unsat String)
(declare-const cl_val_unsat String)
(declare-const reconstructed_unsat String)

(assert (= headers_unsat (str.split_at req_unsat "\r\n\r\n" 0)))
(assert (= body_unsat (str.split_at req_unsat "\r\n\r\n" 1)))
(assert (= reconstructed_unsat (str.++ headers_unsat "\r\n\r\n" body_unsat)))
(assert (= req_unsat reconstructed_unsat))
(assert (>= (str.num_splits req_unsat "\r\n\r\n") 2))

; Must contain Content-Length header, digits, and must match body length
(assert (header_present headers_unsat "Content-Length"))
(assert (= cl_val_unsat (header_value headers_unsat "Content-Length")))
(assert (is_digits cl_val_unsat))
(assert (= (to_int cl_val_unsat) (str.len body_unsat)))

; Concrete conflicting assignments: header says 3 but body length is 5
(assert (= body_unsat "HELLO"))
(assert (= cl_val_unsat "3"))
(assert (str.contains headers_unsat (str.++ "Content-Length: 3\r\n")))
(assert (= headers_unsat (str.++ "POST /x HTTP/1.1\r\n"
                                "Host: a\r\n"
                                "Content-Length: 3\r\n")))
(assert (= req_unsat (str.++ headers_unsat "\r\n\r\n" body_unsat)))

; Check unsatisfiable instance
(check-sat)



; [GENERATION STATUS: SUCCESS]
(exit)
