(set-logic ALL)

; Uninterpreted interface operations for string splitting

; Additional helper operations as uninterpreted functions
(declare-fun trim (String) String)
(declare-fun to_int (String) Int)

; =====================
; SAT instance: well-formed HTTP header parsing
; =====================
(declare-const req_sat String)
(declare-const header_block_sat String)
(declare-const body_sat String)

(declare-const line0_sat String)
(declare-const line1_sat String)
(declare-const line2_sat String)

(declare-const key1_sat String)
(declare-const val1_sat String)
(declare-const key2_sat String)
(declare-const val2_sat String)

(declare-const host_sat String)
(declare-const content_length_str_sat String)
(declare-const content_length_sat Int)

; Split request into header-block and body using CRLFCRLF
(assert (= header_block_sat (str.split_at req_sat "\r\n\r\n" 0)))
(assert (= body_sat (str.split_at req_sat "\r\n\r\n" 1)))
(assert (>= (str.num_splits req_sat "\r\n\r\n") 2))

; Header block contains request line + at least two header lines
(assert (>= (str.num_splits header_block_sat "\r\n") 3))

; Identify specific lines by position
(assert (= line0_sat (str.split_at header_block_sat "\r\n" 0)))
(assert (= line1_sat (str.split_at header_block_sat "\r\n" 1)))
(assert (= line2_sat (str.split_at header_block_sat "\r\n" 2)))

; Basic request line sanity (method and HTTP version tokens present)
(assert (str.prefixof "GET " line0_sat))
(assert (str.contains line0_sat " HTTP/1.1"))

; Parse line1 into key/value around first ": " delimiter
(assert (>= (str.num_splits line1_sat ": ") 2))
(assert (= key1_sat (str.split_at line1_sat ": " 0)))
(assert (= val1_sat (str.split_rest line1_sat ": " 1)))

; Parse line2 into key/value around first ": " delimiter
(assert (>= (str.num_splits line2_sat ": ") 2))
(assert (= key2_sat (str.split_at line2_sat ": " 0)))
(assert (= val2_sat (str.split_rest line2_sat ": " 1)))

; Constrain keys to expected headers (Host and Content-Length), allow either order
(assert (or (and (= key1_sat "Host") (= key2_sat "Content-Length"))
            (and (= key1_sat "Content-Length") (= key2_sat "Host"))))

; Bind extracted values
(assert (= host_sat (ite (= key1_sat "Host") (trim val1_sat) (trim val2_sat))))
(assert (= content_length_str_sat (ite (= key1_sat "Content-Length") (trim val1_sat) (trim val2_sat))))

; Host constraints: non-empty and contains at least one dot
(assert (> (str.len host_sat) 0))
(assert (str.contains host_sat "."))

; Content-Length validation: numeric and matches body length
(assert (= content_length_sat (to_int content_length_str_sat)))
(assert (>= content_length_sat 0))
(assert (= content_length_sat (str.len body_sat)))

; Also require that Content-Length string is composed of digits only (regex)
(assert (str.in_re content_length_str_sat (re.+ (re.range "0" "9"))))

; Provide a concrete satisfying shape (still leaves trim/to_int unconstrained but consistent)
(assert (= host_sat "example.com"))
(assert (= body_sat "HELLO"))
(assert (= content_length_sat 5))

; =====================
; UNSAT instance: conflicting content-length constraints
; =====================
(declare-const req_unsat String)
(declare-const header_block_unsat String)
(declare-const body_unsat String)

(declare-const line0_unsat String)
(declare-const line1_unsat String)
(declare-const key_unsat String)
(declare-const val_unsat String)
(declare-const cl_str_unsat String)
(declare-const cl_unsat Int)

(assert (= header_block_unsat (str.split_at req_unsat "\r\n\r\n" 0)))
(assert (= body_unsat (str.split_at req_unsat "\r\n\r\n" 1)))
(assert (>= (str.num_splits req_unsat "\r\n\r\n") 2))

(assert (>= (str.num_splits header_block_unsat "\r\n") 2))
(assert (= line0_unsat (str.split_at header_block_unsat "\r\n" 0)))
(assert (= line1_unsat (str.split_at header_block_unsat "\r\n" 1)))

(assert (str.prefixof "POST " line0_unsat))
(assert (str.contains line0_unsat " HTTP/1.1"))

; Parse Content-Length line
(assert (>= (str.num_splits line1_unsat ":") 2))
(assert (= key_unsat (trim (str.split_at line1_unsat ":" 0))))
(assert (= val_unsat (trim (str.split_rest line1_unsat ":" 1))))
(assert (= key_unsat "Content-Length"))
(assert (= cl_str_unsat val_unsat))

; Numeric-only constraint
(assert (str.in_re cl_str_unsat (re.+ (re.range "0" "9"))))
(assert (= cl_unsat (to_int cl_str_unsat)))
(assert (>= cl_unsat 0))

; Force a specific body and contradicting content-length equalities
(assert (= body_unsat "ABCDE"))
(assert (= (str.len body_unsat) 5))
(assert (= cl_unsat (str.len body_unsat)))
(assert (= cl_unsat 6))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
