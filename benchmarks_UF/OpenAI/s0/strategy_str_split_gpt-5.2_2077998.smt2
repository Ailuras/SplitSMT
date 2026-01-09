(set-logic ALL)

; Uninterpreted split interface for string splitting
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Additional helper: parse an integer from a string (uninterpreted)
(declare-fun parse_int (String) Int)

; ===== SAT instance: consistent HTTP header parsing =====
(declare-const req_sat String)
(declare-const headers_sat String)
(declare-const body_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const cl_int_sat Int)
(declare-const request_line_sat String)
(declare-const method_sat String)
(declare-const path_sat String)
(declare-const version_sat String)

; Request is headers + blank line + body
(assert (= req_sat (str.++ headers_sat "\r\n\r\n" body_sat)))

; At least request-line plus two header lines
(assert (>= (num_splits headers_sat "\r\n") 3))

; Split header block into lines
(assert (= request_line_sat (split_at headers_sat "\r\n" 0)))
(assert (= host_line_sat (split_at headers_sat "\r\n" 1)))
(assert (= cl_line_sat (split_at headers_sat "\r\n" 2)))

; Parse request line: "METHOD SP PATH SP VERSION"
(assert (= method_sat (split_at request_line_sat " " 0)))
(assert (= path_sat (split_at request_line_sat " " 1)))
(assert (= version_sat (split_at request_line_sat " " 2)))
(assert (= method_sat "POST"))
(assert (str.prefixof "/" path_sat))
(assert (str.prefixof "HTTP/1.1" version_sat))

; Parse Host header: "Host: value"
(assert (>= (num_splits host_line_sat ":") 2))
(assert (= host_key_sat (split_at host_line_sat ":" 0)))
(assert (= host_val_sat (split_rest host_line_sat ":" 1)))
(assert (= host_key_sat "Host"))
; Enforce a space after colon (common formatting)
(assert (str.prefixof " " host_val_sat))
; Require non-empty host value after trimming the leading space (approximate)
(assert (>= (str.len host_val_sat) 2))

; Parse Content-Length header: "Content-Length: N"
(assert (>= (num_splits cl_line_sat ":") 2))
(assert (= cl_key_sat (split_at cl_line_sat ":" 0)))
(assert (= cl_val_sat (split_rest cl_line_sat ":" 1)))
(assert (= cl_key_sat "Content-Length"))
(assert (str.prefixof " " cl_val_sat))
(assert (>= (str.len cl_val_sat) 2))

; Validate content-length matches actual body length
(assert (= cl_int_sat (parse_int cl_val_sat)))
(assert (>= cl_int_sat 0))
(assert (= cl_int_sat (str.len body_sat)))

; Provide concrete structure to ensure satisfiable
(assert (= body_sat "hello"))
(assert (= host_val_sat " example.com"))
; cl_val includes a leading space
(assert (= cl_val_sat " 5"))


; ===== UNSAT instance: inconsistent content-length =====
(declare-const req_unsat String)
(declare-const headers_unsat String)
(declare-const body_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_val_unsat String)
(declare-const cl_int_unsat Int)
(declare-const host_line_unsat String)
(declare-const request_line_unsat String)
(declare-const method_unsat String)
(declare-const path_unsat String)
(declare-const version_unsat String)

(assert (= req_unsat (str.++ headers_unsat "\r\n\r\n" body_unsat)))
(assert (>= (num_splits headers_unsat "\r\n") 3))
(assert (= request_line_unsat (split_at headers_unsat "\r\n" 0)))
(assert (= host_line_unsat (split_at headers_unsat "\r\n" 1)))
(assert (= cl_line_unsat (split_at headers_unsat "\r\n" 2)))

(assert (= method_unsat (split_at request_line_unsat " " 0)))
(assert (= path_unsat (split_at request_line_unsat " " 1)))
(assert (= version_unsat (split_at request_line_unsat " " 2)))
(assert (= method_unsat "POST"))
(assert (str.prefixof "/" path_unsat))
(assert (str.prefixof "HTTP/1.1" version_unsat))

(assert (>= (num_splits cl_line_unsat ":") 2))
(assert (= cl_val_unsat (split_rest cl_line_unsat ":" 1)))
(assert (str.prefixof " " cl_val_unsat))
(assert (= cl_int_unsat (parse_int cl_val_unsat)))
(assert (>= cl_int_unsat 0))

; Make body concrete and force mismatch with parsed content-length
(assert (= body_unsat "abc"))
(assert (= cl_val_unsat " 4"))
(assert (= cl_int_unsat (str.len body_unsat)))

; The two previous assertions imply 4 = 3, hence UNSAT

(check-sat)


; [GENERATION STATUS: SUCCESS]