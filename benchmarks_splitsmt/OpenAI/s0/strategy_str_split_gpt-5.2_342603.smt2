(set-logic ALL)

; Uninterpreted split interface (str_split)

; ----------------------------
; SAT instance: consistent HTTP header parsing and Content-Length validation
; ----------------------------
(declare-const req_sat String)
(declare-const header_block_sat String)
(declare-const request_line_sat String)
(declare-const cl_line_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const host_line_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const body_sat String)
(declare-const content_length_sat Int)
(declare-const body_len_sat Int)

; Structure: request-line + \r\n + headers + \r\n\r\n + body
(assert (>= (str.num_splits req_sat "\r\n\r\n") 2))
(assert (= header_block_sat (str.split_at req_sat "\r\n\r\n" 0)))
(assert (= body_sat (str.split_rest req_sat "\r\n\r\n" 1)))

; Header block: first line is request line, subsequent lines are headers
(assert (>= (str.num_splits header_block_sat "\r\n") 3))
(assert (= request_line_sat (str.split_at header_block_sat "\r\n" 0)))
(assert (= cl_line_sat (str.split_at header_block_sat "\r\n" 1)))
(assert (= host_line_sat (str.split_at header_block_sat "\r\n" 2)))

; Request line basic shape checks
(assert (str.contains request_line_sat "HTTP/1.1"))
(assert (str.contains request_line_sat "GET "))

; Parse Content-Length line by ':'
(assert (>= (str.num_splits cl_line_sat ":") 2))
(assert (= cl_key_sat (str.split_at cl_line_sat ":" 0)))
(assert (= cl_val_sat (str.split_rest cl_line_sat ":" 1)))

; Parse Host line by ':'
(assert (>= (str.num_splits host_line_sat ":") 2))
(assert (= host_key_sat (str.split_at host_line_sat ":" 0)))
(assert (= host_val_sat (str.split_rest host_line_sat ":" 1)))

; Expected keys and basic formatting
(assert (= cl_key_sat "Content-Length"))
(assert (= host_key_sat "Host"))

; Require a space after ':' in values
(assert (str.prefixof " " cl_val_sat))
(assert (str.prefixof " " host_val_sat))

; Constrain a concrete, parseable digit-only content-length value with optional leading space
(assert (= cl_val_sat " 5"))
(assert (= content_length_sat 5))

; Host value sanity (must include a dot after optional leading space)
(assert (str.contains host_val_sat "."))

; Validate body length equals Content-Length
(assert (= body_len_sat (str.len body_sat)))
(assert (= body_len_sat content_length_sat))

; Ensure body is exactly 5 bytes by construction possibility
(assert (>= (str.len body_sat) 0))
(assert (= body_sat "hello"))

; Additional header safety: no embedded CRLF in individual header lines
(assert (= (str.num_splits cl_line_sat "\r\n") 1))
(assert (= (str.num_splits host_line_sat "\r\n") 1))

(check-sat)

; ----------------------------
; UNSAT instance: conflicting Content-Length vs body length
; ----------------------------
(declare-const req_unsat String)
(declare-const header_block_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_key_unsat String)
(declare-const cl_val_unsat String)
(declare-const body_unsat String)
(declare-const content_length_unsat Int)
(declare-const body_len_unsat Int)

(assert (>= (str.num_splits req_unsat "\r\n\r\n") 2))
(assert (= header_block_unsat (str.split_at req_unsat "\r\n\r\n" 0)))
(assert (= body_unsat (str.split_rest req_unsat "\r\n\r\n" 1)))

(assert (>= (str.num_splits header_block_unsat "\r\n") 2))
(assert (= cl_line_unsat (str.split_at header_block_unsat "\r\n" 1)))

(assert (>= (str.num_splits cl_line_unsat ":") 2))
(assert (= cl_key_unsat (str.split_at cl_line_unsat ":" 0)))
(assert (= cl_val_unsat (str.split_rest cl_line_unsat ":" 1)))
(assert (= cl_key_unsat "Content-Length"))
(assert (str.prefixof " " cl_val_unsat))

; Force Content-Length to 0 but body to non-empty => contradiction with length check
(assert (= cl_val_unsat " 0"))
(assert (= content_length_unsat 0))
(assert (= body_unsat "X"))
(assert (= body_len_unsat (str.len body_unsat)))
(assert (= body_len_unsat content_length_unsat))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
