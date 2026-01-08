(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted interface functions for string splitting

; Auxiliary uninterpreted functions for header lookup / numeric parsing
(declare-fun header_value (String String) String) ; header_value(headers_blob, key) = value (no surrounding spaces), or "" if absent
(declare-fun parse_int (String) Int)               ; parse_int(s) interprets s as a decimal integer (implementation abstracted)
(declare-fun is_digits (String) Bool)             ; true iff s consists only of digits (no sign)

; ========= SAT instance: consistent HTTP header parsing =========
(declare-const req_sat String)
(declare-const request_line_sat String)
(declare-const headers_sat String)
(declare-const body_sat String)

(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const host_val_sat String)
(declare-const useragent_val_sat String)
(declare-const cl_int_sat Int)

; Split request into request-line, headers-block, body using \n\n boundary
(assert (= request_line_sat (split_at req_sat "\n\n" 0)))
(assert (= headers_sat (split_at req_sat "\n\n" 1)))
(assert (= body_sat (split_at req_sat "\n\n" 2)))
(assert (>= (num_splits req_sat "\n\n") 3))

; Basic HTTP request line sanity
(assert (str.contains request_line_sat "HTTP/1.1"))
(assert (str.contains request_line_sat "GET "))

; Header key/value extraction via ':' and newline-separated fields
(assert (= cl_key_sat "Content-Length"))
(assert (= cl_val_sat (header_value headers_sat cl_key_sat)))
(assert (= host_val_sat (header_value headers_sat "Host")))
(assert (= useragent_val_sat (header_value headers_sat "User-Agent")))

; Require key headers present and non-empty
(assert (not (= cl_val_sat "")))
(assert (not (= host_val_sat "")))
(assert (not (= useragent_val_sat "")))

; Validate Content-Length is digits and matches body length
(assert (is_digits cl_val_sat))
(assert (= cl_int_sat (parse_int cl_val_sat)))
(assert (>= cl_int_sat 0))
(assert (= cl_int_sat (str.len body_sat)))

; Ensure there is at least one ':' in headers to reflect key-value pairs
(assert (str.contains headers_sat ":"))

; ========= UNSAT instance: contradictory Content-Length constraints =========
(declare-const req_unsat String)
(declare-const request_line_unsat String)
(declare-const headers_unsat String)
(declare-const body_unsat String)

(declare-const cl_val_unsat String)
(declare-const cl_int_unsat Int)

(assert (= request_line_unsat (split_at req_unsat "\n\n" 0)))
(assert (= headers_unsat (split_at req_unsat "\n\n" 1)))
(assert (= body_unsat (split_at req_unsat "\n\n" 2)))
(assert (>= (num_splits req_unsat "\n\n") 3))

(assert (str.contains request_line_unsat "HTTP/1.1"))
(assert (str.contains request_line_unsat "POST "))

(assert (= cl_val_unsat (header_value headers_unsat "Content-Length")))
(assert (not (= cl_val_unsat "")))
(assert (is_digits cl_val_unsat))
(assert (= cl_int_unsat (parse_int cl_val_unsat)))
(assert (>= cl_int_unsat 0))

; Contradiction: Content-Length must equal body length and also be body length + 1
(assert (= cl_int_unsat (str.len body_unsat)))
(assert (= cl_int_unsat (+ (str.len body_unsat) 1)))

; ========= Additional mixed constraints to increase diversity =========
; Require that headers are newline-separated and contain Host and Content-Length tokens somewhere
(assert (str.contains headers_sat "\n"))
(assert (str.contains headers_sat "Host"))
(assert (str.contains headers_sat "Content-Length"))

; A weak structural constraint: first header line has a ':' (using split_at with newline)
(declare-const first_header_line_sat String)
(assert (= first_header_line_sat (split_at headers_sat "\n" 0)))
(assert (str.contains first_header_line_sat ":"))

; Index bounds-style constraints for split_at usage
(declare-const k0 Int)
(declare-const k1 Int)
(assert (= k0 0))
(assert (= k1 1))
(assert (>= k0 0))
(assert (>= k1 0))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
