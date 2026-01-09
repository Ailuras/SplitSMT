(set-logic ALL)

; Uninterpreted interface operations for string splitting

; -------------------------
; SAT instance: well-formed HTTP header parsing with Content-Length
; -------------------------
(declare-const header_sat String)
(declare-const request_line_sat String)
(declare-const headers_block_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const body_sat String)
(declare-const body_len_sat Int)
(declare-const cl_int_sat Int)

; Structure: request-line \n headers... \n\n body
(assert (>= (str.num_splits header_sat "\n\n") 2))
(assert (= request_line_sat (str.split_at header_sat "\n" 0)))
(assert (= headers_block_sat (str.split_rest header_sat "\n" 1)))
(assert (= body_sat (str.split_at header_sat "\n\n" 1)))

; Request line sanity: must start with method token and contain HTTP version
(assert (or (= (str.split_at request_line_sat " " 0) "GET")
            (= (str.split_at request_line_sat " " 0) "POST")))
(assert (= (str.split_at request_line_sat " " 2) "HTTP/1.1"))

; Ensure at least two header lines exist in headers_block
(assert (>= (str.num_splits headers_block_sat "\n") 2))
(assert (= host_line_sat (str.split_at headers_block_sat "\n" 0)))
(assert (= cl_line_sat (str.split_at headers_block_sat "\n" 1)))

; Parse header lines as key:value
(assert (>= (str.num_splits host_line_sat ":") 2))
(assert (>= (str.num_splits cl_line_sat ":") 2))
(assert (= host_key_sat (str.split_at host_line_sat ":" 0)))
(assert (= host_val_sat (str.split_rest host_line_sat ":" 1)))
(assert (= cl_key_sat (str.split_at cl_line_sat ":" 0)))
(assert (= cl_val_sat (str.split_rest cl_line_sat ":" 1)))

; Validate header keys
(assert (= host_key_sat "Host"))
(assert (= cl_key_sat "Content-Length"))

; Basic value constraints (trim-like: allow optional leading space)
(assert (or (= (str.at host_val_sat 0) " ") (not (= (str.at host_val_sat 0) " "))))
(assert (or (= (str.at cl_val_sat 0) " ") (not (= (str.at cl_val_sat 0) " "))))
(assert (>= (str.len host_val_sat) 2))
(assert (>= (str.len cl_val_sat) 2))

; Require host contains a dot (e.g., example.com)
(assert (str.contains host_val_sat "."))

; Constrain Content-Length numeric via a witness integer and string rendering
(assert (>= cl_int_sat 0))
(assert (= cl_val_sat (str.++ " " (int.to.str cl_int_sat))))

; Body length must match Content-Length
(assert (>= body_len_sat 0))
(assert (= body_len_sat (str.len body_sat)))
(assert (= body_len_sat cl_int_sat))

; Provide additional consistency constraints
(assert (not (str.contains request_line_sat "\n")))
(assert (not (str.contains host_line_sat "\n")))
(assert (not (str.contains cl_line_sat "\n")))

; Make the SAT instance concrete enough
(assert (= header_sat
  (str.++
    "POST /submit HTTP/1.1\n"
    "Host: example.com\n"
    "Content-Length: 5\n"
    "\n"
    "abcde")))

; -------------------------
; UNSAT instance: conflicting Content-Length vs body length
; -------------------------
(declare-const header_unsat String)
(declare-const request_line_unsat String)
(declare-const headers_block_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_val_unsat String)
(declare-const cl_int_unsat Int)
(declare-const body_unsat String)

(assert (>= (str.num_splits header_unsat "\n\n") 2))
(assert (= request_line_unsat (str.split_at header_unsat "\n" 0)))
(assert (= headers_block_unsat (str.split_rest header_unsat "\n" 1)))
(assert (= body_unsat (str.split_at header_unsat "\n\n" 1)))

(assert (= (str.split_at request_line_unsat " " 0) "POST"))
(assert (= (str.split_at request_line_unsat " " 2) "HTTP/1.1"))

(assert (>= (str.num_splits headers_block_unsat "\n") 1))
(assert (= cl_line_unsat (str.split_at headers_block_unsat "\n" 0)))
(assert (>= (str.num_splits cl_line_unsat ":") 2))
(assert (= (str.split_at cl_line_unsat ":" 0) "Content-Length"))
(assert (= cl_val_unsat (str.split_rest cl_line_unsat ":" 1)))

(assert (>= cl_int_unsat 0))
(assert (= cl_val_unsat (str.++ " " (int.to.str cl_int_unsat))))

; Force a body of length 3
(assert (= body_unsat "XYZ"))

; But force Content-Length to be 5 => UNSAT with body length
(assert (= cl_int_unsat 5))
(assert (= (str.len body_unsat) cl_int_unsat))

; Make header_unsat concrete too
(assert (= header_unsat
  (str.++
    "POST /x HTTP/1.1\n"
    "Content-Length: 5\n"
    "\n"
    "XYZ")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
