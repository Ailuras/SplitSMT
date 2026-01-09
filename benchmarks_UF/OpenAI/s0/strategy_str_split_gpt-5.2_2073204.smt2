(set-logic ALL)

; Uninterpreted split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; ========== SAT instance: plausible HTTP header parsing ==========
(declare-const req_sat String)
(declare-const request_line_sat String)
(declare-const headers_block_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const body_sat String)
(declare-const content_length_sat Int)
(declare-const body_len_sat Int)

; Structure: request-line + newline + headers + newline newline + body
(assert (= request_line_sat (split_at req_sat "\n" 0)))
(assert (= headers_block_sat (split_rest req_sat "\n" 1)))

; At least: request line, at least two header lines, blank line, body (so >= 5 lines total)
(assert (>= (num_splits req_sat "\n") 5))

; Identify specific header lines by position (simplified parsing model)
(assert (= host_line_sat (split_at req_sat "\n" 1)))
(assert (= cl_line_sat (split_at req_sat "\n" 2)))

; Blank line separator and body after it
(assert (= "" (split_at req_sat "\n" 3)))
(assert (= body_sat (split_rest req_sat "\n" 4)))

; Parse Host header using ':' delimiter
(assert (>= (num_splits host_line_sat ":") 2))
(assert (= host_key_sat (split_at host_line_sat ":" 0)))
(assert (= host_val_sat (split_rest host_line_sat ":" 1)))
(assert (= host_key_sat "Host"))
; value may contain leading space
(assert (str.prefixof " " host_val_sat))

; Parse Content-Length header using ':' delimiter
(assert (>= (num_splits cl_line_sat ":") 2))
(assert (= cl_key_sat (split_at cl_line_sat ":" 0)))
(assert (= cl_val_sat (split_rest cl_line_sat ":" 1)))
(assert (= cl_key_sat "Content-Length"))
(assert (str.prefixof " " cl_val_sat))

; Validate Content-Length value is a decimal number (after trimming a single leading space)
; cl_val_sat == " " ++ digits
(declare-const cl_digits_sat String)
(assert (= cl_val_sat (str.++ " " cl_digits_sat)))
(assert (str.in_re cl_digits_sat (re.+ (re.range "0" "9"))))

; Relate body length and declared content_length_sat
(assert (= body_len_sat (str.len body_sat)))
(assert (>= content_length_sat 0))
(assert (= content_length_sat body_len_sat))

; Constrain req_sat to be consistent with pieces (one concrete shape, still symbolic values)
(assert (= req_sat (str.++ request_line_sat "\n" host_line_sat "\n" cl_line_sat "\n\n" body_sat)))

; Further plausibility constraints
(assert (str.contains request_line_sat "HTTP/1.1"))
(assert (str.prefixof "GET " request_line_sat))
(assert (<= (str.len host_val_sat) 256))


; ========== UNSAT instance: contradictory Content-Length vs body ==========
(declare-const req_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_val_unsat String)
(declare-const body_unsat String)
(declare-const content_length_unsat Int)
(declare-const body_len_unsat Int)
(declare-const cl_digits_unsat String)

; Minimal shape: request-line, one CL header, blank line, body
(assert (>= (num_splits req_unsat "\n") 4))
(assert (= cl_line_unsat (split_at req_unsat "\n" 1)))
(assert (= "" (split_at req_unsat "\n" 2)))
(assert (= body_unsat (split_rest req_unsat "\n" 3)))

(assert (>= (num_splits cl_line_unsat ":") 2))
(assert (= (split_at cl_line_unsat ":" 0) "Content-Length"))
(assert (= cl_val_unsat (split_rest cl_line_unsat ":" 1)))
(assert (= cl_val_unsat (str.++ " " cl_digits_unsat)))
(assert (str.in_re cl_digits_unsat (re.+ (re.range "0" "9"))))

; Force a concrete body and an incompatible declared length
(assert (= body_unsat "HELLO"))
(assert (= body_len_unsat (str.len body_unsat)))
(assert (= body_len_unsat 5))
(assert (= content_length_unsat 4))
(assert (= content_length_unsat body_len_unsat))

; Combine both instances: SAT part must hold, UNSAT part must hold => overall UNSAT
(check-sat)


; [GENERATION STATUS: SUCCESS]