(set-logic ALL)

; Uninterpreted interface for string split operations
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Uninterpreted interface for parsing integer from decimal string
(declare-fun parse_int (String) Int)

; =========================
; SAT instance: well-formed HTTP header parsing
; =========================

(declare-const req_sat String)
(declare-const header_block_sat String)
(declare-const headers_sat String)
(declare-const first_line_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const ua_line_sat String)

(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const ua_key_sat String)
(declare-const ua_val_sat String)

(declare-const body_sat String)
(declare-const cl_int_sat Int)

; Request structure: start-line + headers + blank line + body
(assert (= header_block_sat (split_at req_sat "\r\n\r\n" 0)))
(assert (= body_sat (split_at req_sat "\r\n\r\n" 1)))
(assert (>= (num_splits req_sat "\r\n\r\n") 2))

; Constrain header block to have at least a request line and some header lines
(assert (>= (num_splits header_block_sat "\r\n") 4))
(assert (= first_line_sat (split_at header_block_sat "\r\n" 0)))
(assert (= host_line_sat (split_at header_block_sat "\r\n" 1)))
(assert (= cl_line_sat (split_at header_block_sat "\r\n" 2)))
(assert (= ua_line_sat (split_at header_block_sat "\r\n" 3)))

; Minimal request line constraint
(assert (str.prefixof "GET " first_line_sat))
(assert (str.contains first_line_sat " HTTP/1.1"))

; Each header line must contain a colon separating key and value
(assert (>= (num_splits host_line_sat ":") 2))
(assert (>= (num_splits cl_line_sat ":") 2))
(assert (>= (num_splits ua_line_sat ":") 2))

(assert (= host_key_sat (split_at host_line_sat ":" 0)))
(assert (= host_val_sat (split_rest host_line_sat ":" 1)))
(assert (= cl_key_sat (split_at cl_line_sat ":" 0)))
(assert (= cl_val_sat (split_rest cl_line_sat ":" 1)))
(assert (= ua_key_sat (split_at ua_line_sat ":" 0)))
(assert (= ua_val_sat (split_rest ua_line_sat ":" 1)))

; Canonicalize keys and require expected header names
(assert (= host_key_sat "Host"))
(assert (= cl_key_sat "Content-Length"))
(assert (= ua_key_sat "User-Agent"))

; Values: allow leading space after ':' but not empty overall
(assert (> (str.len host_val_sat) 0))
(assert (> (str.len cl_val_sat) 0))
(assert (> (str.len ua_val_sat) 0))

; A typical formatting constraint: value starts with a space
(assert (= (str.at host_val_sat 0) " "))
(assert (= (str.at cl_val_sat 0) " "))

; Content-Length must be decimal digits after optional leading space
(declare-const cl_digits_sat String)
(assert (= cl_digits_sat (str.replace cl_val_sat " " "")))
(assert (str.in_re cl_digits_sat (re.+ (re.range "0" "9"))))

; Parse integer and validate against body length
(assert (= cl_int_sat (parse_int cl_digits_sat)))
(assert (>= cl_int_sat 0))
(assert (= cl_int_sat (str.len body_sat)))

; Additional sanity: forbid CR/LF inside individual header values
(assert (not (str.contains host_val_sat "\r")))
(assert (not (str.contains host_val_sat "\n")))
(assert (not (str.contains cl_val_sat "\r")))
(assert (not (str.contains cl_val_sat "\n")))
(assert (not (str.contains ua_val_sat "\r")))
(assert (not (str.contains ua_val_sat "\n")))

; =========================
; UNSAT instance: conflicting Content-Length constraints
; =========================

(declare-const req_unsat String)
(declare-const header_block_unsat String)
(declare-const body_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_key_unsat String)
(declare-const cl_val_unsat String)
(declare-const cl_digits_unsat String)
(declare-const cl_int_unsat Int)

(assert (= header_block_unsat (split_at req_unsat "\r\n\r\n" 0)))
(assert (= body_unsat (split_at req_unsat "\r\n\r\n" 1)))
(assert (>= (num_splits req_unsat "\r\n\r\n") 2))

; Ensure there is at least a request line and the Content-Length line
(assert (>= (num_splits header_block_unsat "\r\n") 2))
(assert (= cl_line_unsat (split_at header_block_unsat "\r\n" 1)))

(assert (>= (num_splits cl_line_unsat ":") 2))
(assert (= cl_key_unsat (split_at cl_line_unsat ":" 0)))
(assert (= cl_val_unsat (split_rest cl_line_unsat ":" 1)))
(assert (= cl_key_unsat "Content-Length"))

; Digits after trimming spaces
(assert (= cl_digits_unsat (str.replace cl_val_unsat " " "")))
(assert (str.in_re cl_digits_unsat (re.+ (re.range "0" "9"))))
(assert (= cl_int_unsat (parse_int cl_digits_unsat)))
(assert (>= cl_int_unsat 0))

; Force a specific Content-Length but contradict with a different body length
(assert (= cl_int_unsat 5))
(assert (= (str.len body_unsat) 7))
(assert (= cl_int_unsat (str.len body_unsat)))

(check-sat)


; [GENERATION STATUS: SUCCESS]