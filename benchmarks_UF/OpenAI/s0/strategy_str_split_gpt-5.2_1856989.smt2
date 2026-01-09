(set-logic ALL)

; Uninterpreted interface functions for string splitting
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; -------------------------
; SAT instance: well-formed HTTP header parsing and content-length validation
; -------------------------
(declare-const req_sat String)
(declare-const header_block_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const body_sat String)
(declare-const content_length_sat Int)

; Model the request as headers + blank line + body
(assert (= header_block_sat (split_at req_sat "\r\n\r\n" 0)))
(assert (= body_sat (split_at req_sat "\r\n\r\n" 1)))
(assert (>= (num_splits req_sat "\r\n\r\n") 2))

; Split header block into lines
(assert (= host_line_sat (split_at header_block_sat "\r\n" 0)))
(assert (= cl_line_sat (split_at header_block_sat "\r\n" 1)))
(assert (>= (num_splits header_block_sat "\r\n") 2))

; Parse Host line: "Host: <value>"
(assert (= host_key_sat (split_at host_line_sat ":" 0)))
(assert (= host_val_sat (split_rest host_line_sat ":" 1)))
(assert (= host_key_sat "Host"))
(assert (>= (num_splits host_line_sat ":") 2))
(assert (> (str.len host_val_sat) 0))

; Parse Content-Length line: "Content-Length: <digits>"
(assert (= cl_key_sat (split_at cl_line_sat ":" 0)))
(assert (= cl_val_sat (split_rest cl_line_sat ":" 1)))
(assert (= cl_key_sat "Content-Length"))
(assert (>= (num_splits cl_line_sat ":") 2))

; Whitelist body is arbitrary but length must match parsed Content-Length
(assert (= content_length_sat (str.to_int cl_val_sat)))
(assert (>= content_length_sat 0))
(assert (= (str.len body_sat) content_length_sat))

; Ensure numeric Content-Length via regex: [0-9]+ with optional leading spaces
(declare-const digit_re RegLan)
(declare-const digits_re RegLan)
(declare-const sp_re RegLan)
(declare-const sps_re RegLan)
(declare-const cl_val_re RegLan)
(assert (= digit_re (re.range "0" "9")))
(assert (= digits_re (re.+ digit_re)))
(assert (= sp_re (str.to_re " ")))
(assert (= sps_re (re.* sp_re)))
(assert (= cl_val_re (re.++ sps_re digits_re)))
(assert (str.in_re cl_val_sat cl_val_re))

; Additional realism constraints
(assert (str.contains req_sat "\r\n\r\n"))
(assert (not (str.contains host_val_sat "\r\n")))
(assert (not (str.contains cl_val_sat "\r\n")))

; -------------------------
; UNSAT instance: contradictory content-length constraints on the same request
; -------------------------
(declare-const req_unsat String)
(declare-const header_block_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_val_unsat String)
(declare-const body_unsat String)
(declare-const content_length_unsat Int)

(assert (= header_block_unsat (split_at req_unsat "\r\n\r\n" 0)))
(assert (= body_unsat (split_at req_unsat "\r\n\r\n" 1)))
(assert (>= (num_splits req_unsat "\r\n\r\n") 2))

(assert (= cl_line_unsat (split_at header_block_unsat "\r\n" 0)))
(assert (>= (num_splits header_block_unsat "\r\n") 1))

(assert (= cl_val_unsat (split_rest cl_line_unsat ":" 1)))
(assert (>= (num_splits cl_line_unsat ":") 2))

(assert (= content_length_unsat (str.to_int cl_val_unsat)))
(assert (>= content_length_unsat 0))

; Contradiction: force body length to equal Content-Length AND also differ by 1
(assert (= (str.len body_unsat) content_length_unsat))
(assert (= (str.len body_unsat) (+ content_length_unsat 1)))

; Also require cl_val_unsat be digits (to avoid "to_int" = -1 escape)
(declare-const cl_val_unsat_re RegLan)
(assert (= cl_val_unsat_re (re.+ (re.range "0" "9"))))
(assert (str.in_re cl_val_unsat cl_val_unsat_re))

(check-sat)


; [GENERATION STATUS: SUCCESS]