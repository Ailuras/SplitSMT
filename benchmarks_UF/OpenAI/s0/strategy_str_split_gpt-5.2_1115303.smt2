(set-logic ALL)

; Uninterpreted split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; ------------------------------
; SAT instance: plausible HTTP header parsing
; ------------------------------
(declare-const req_sat String)
(declare-const request_line_sat String)
(declare-const header_block_sat String)
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
(declare-const cl_digits_sat String)
(declare-const cl_len_sat Int)

; Structure: request line + headers + blank line + body
(assert (= request_line_sat (split_at req_sat "\r\n" 0)))
(assert (= header_block_sat (split_rest req_sat "\r\n" 1)))
(assert (>= (num_splits req_sat "\r\n") 3))

; Request line basic pattern: "POST <path> HTTP/1.1"
(assert (= request_line_sat "POST /submit HTTP/1.1"))

; Header block split into lines (including empty line before body)
; We enforce: Host line, Content-Length line, User-Agent line, empty line, then body
(assert (= host_line_sat (split_at header_block_sat "\r\n" 0)))
(assert (= cl_line_sat   (split_at header_block_sat "\r\n" 1)))
(assert (= ua_line_sat   (split_at header_block_sat "\r\n" 2)))
(assert (= body_sat      (split_rest header_block_sat "\r\n" 4)))
(assert (= (split_at header_block_sat "\r\n" 3) ""))
(assert (>= (num_splits header_block_sat "\r\n") 5))

; Parse each header line by the ":" delimiter (key: value)
(assert (>= (num_splits host_line_sat ":") 2))
(assert (= host_key_sat (split_at host_line_sat ":" 0)))
(assert (= host_val_sat (split_rest host_line_sat ":" 1)))

(assert (>= (num_splits cl_line_sat ":") 2))
(assert (= cl_key_sat (split_at cl_line_sat ":" 0)))
(assert (= cl_val_sat (split_rest cl_line_sat ":" 1)))

(assert (>= (num_splits ua_line_sat ":") 2))
(assert (= ua_key_sat (split_at ua_line_sat ":" 0)))
(assert (= ua_val_sat (split_rest ua_line_sat ":" 1)))

; Validate required header keys
(assert (= host_key_sat "Host"))
(assert (= cl_key_sat "Content-Length"))
(assert (= ua_key_sat "User-Agent"))

; Normalize expected spacing: values start with a single space
(assert (str.prefixof " " host_val_sat))
(assert (str.prefixof " " cl_val_sat))
(assert (str.prefixof " " ua_val_sat))

; Basic content constraints
(assert (not (= host_val_sat " ")))
(assert (str.contains ua_val_sat "Mozilla"))

; Content-Length: value = " " + digits, and integer equals body length
(assert (= cl_val_sat (str.++ " " cl_digits_sat)))
(assert (str.in_re cl_digits_sat (re.+ (re.range "0" "9"))))

; Link integer cl_len_sat to digit-string; also ensure non-negative
(assert (>= cl_len_sat 0))
(assert (= cl_digits_sat (int.to.str cl_len_sat)))

; Validate body length matches content-length
(assert (= (str.len body_sat) cl_len_sat))

; Keep body non-empty and modest in size for satisfiability
(assert (>= (str.len body_sat) 1))
(assert (<= (str.len body_sat) 100))

; Provide at least one concrete satisfiable assignment constraint (still allows others)
(assert (= host_line_sat "Host: example.com"))
(assert (= ua_line_sat "User-Agent: Mozilla/5.0"))

; ------------------------------
; UNSAT instance: contradictory content-length
; ------------------------------
(declare-const req_unsat String)
(declare-const request_line_unsat String)
(declare-const header_block_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_key_unsat String)
(declare-const cl_val_unsat String)
(declare-const cl_digits_unsat String)
(declare-const body_unsat String)
(declare-const cl_len_unsat Int)

(assert (= request_line_unsat (split_at req_unsat "\r\n" 0)))
(assert (= header_block_unsat (split_rest req_unsat "\r\n" 1)))
(assert (>= (num_splits req_unsat "\r\n") 3))
(assert (= request_line_unsat "POST /x HTTP/1.1"))

; Place Content-Length as first header, then blank line, then body
(assert (= cl_line_unsat (split_at header_block_unsat "\r\n" 0)))
(assert (= (split_at header_block_unsat "\r\n" 1) ""))
(assert (= body_unsat (split_rest header_block_unsat "\r\n" 2)))
(assert (>= (num_splits header_block_unsat "\r\n") 3))

; Parse Content-Length
(assert (>= (num_splits cl_line_unsat ":") 2))
(assert (= cl_key_unsat (split_at cl_line_unsat ":" 0)))
(assert (= cl_val_unsat (split_rest cl_line_unsat ":" 1)))
(assert (= cl_key_unsat "Content-Length"))
(assert (str.prefixof " " cl_val_unsat))
(assert (= cl_val_unsat (str.++ " " cl_digits_unsat)))
(assert (str.in_re cl_digits_unsat (re.+ (re.range "0" "9"))))
(assert (>= cl_len_unsat 0))
(assert (= cl_digits_unsat (int.to.str cl_len_unsat)))

; Contradiction: force body to a fixed length but force content-length to a different value
(assert (= body_unsat "abcd"))
(assert (= cl_len_unsat 3))
(assert (= (str.len body_unsat) cl_len_unsat))

(check-sat)


; [GENERATION STATUS: SUCCESS]