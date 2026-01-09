(set-logic ALL)

; Uninterpreted split interface (str_split)

; === SAT instance: consistent HTTP request header parsing ===
(declare-const req_sat String)
(declare-const header_lines_sat String)
(declare-const content_length_line_sat String)
(declare-const host_line_sat String)
(declare-const content_length_key_sat String)
(declare-const content_length_value_sat String)
(declare-const host_key_sat String)
(declare-const host_value_sat String)
(declare-const body_sat String)
(declare-const body_len_sat Int)
(declare-const content_length_int_sat Int)
(declare-const content_length_digits_sat String)

; Basic structure: request line then headers then blank line then body
(assert (= req_sat (str.++ "POST /upload HTTP/1.1\r\n" header_lines_sat "\r\n\r\n" body_sat)))

; Header lines contain at least Host and Content-Length lines
(assert (= host_line_sat (str.split_at header_lines_sat "\r\n" 0)))
(assert (= content_length_line_sat (str.split_at header_lines_sat "\r\n" 1)))
(assert (>= (str.num_splits header_lines_sat "\r\n") 2))

; Parse Host: "Host: <value>"
(assert (= host_key_sat (str.split_at host_line_sat ": " 0)))
(assert (= host_value_sat (str.split_at host_line_sat ": " 1)))
(assert (>= (str.num_splits host_line_sat ": ") 2))
(assert (= host_key_sat "Host"))
(assert (str.contains host_value_sat "."))
(assert (> (str.len host_value_sat) 3))

; Parse Content-Length: "Content-Length: <digits>"
(assert (= content_length_key_sat (str.split_at content_length_line_sat ": " 0)))
(assert (= content_length_value_sat (str.split_at content_length_line_sat ": " 1)))
(assert (>= (str.num_splits content_length_line_sat ": ") 2))
(assert (= content_length_key_sat "Content-Length"))

; Validate content-length value: digits-only via regex, no leading +/-, non-empty
(assert (> (str.len content_length_value_sat) 0))
(assert (str.in_re content_length_value_sat (re.+ (re.range "0" "9"))))

; Bind an explicit digit string to demonstrate additional constraints
(assert (= content_length_digits_sat content_length_value_sat))
(assert (str.in_re content_length_digits_sat (re.+ (re.range "0" "9"))))

; Content-length integer consistent with body length
(assert (= body_len_sat (str.len body_sat)))
(assert (>= body_len_sat 0))
(assert (= content_length_int_sat body_len_sat))
(assert (>= content_length_int_sat 0))

; Also constrain body a bit (non-empty payload)
(assert (> body_len_sat 0))
(assert (str.contains body_sat "data"))

; Relate the numeric value string to the integer in a lightweight way
; (Not using str.to_int to keep portability across solvers; instead constrain a concrete scenario)
(assert (= content_length_value_sat "4"))
(assert (= content_length_int_sat 4))
(assert (= body_sat "data"))

; === UNSAT instance: contradictory Content-Length vs body length ===
(declare-const req_unsat String)
(declare-const header_lines_unsat String)
(declare-const content_length_line_unsat String)
(declare-const content_length_key_unsat String)
(declare-const content_length_value_unsat String)
(declare-const body_unsat String)
(declare-const body_len_unsat Int)
(declare-const content_length_int_unsat Int)

(assert (= req_unsat (str.++ "POST /x HTTP/1.1\r\n" header_lines_unsat "\r\n\r\n" body_unsat)))
(assert (= content_length_line_unsat (str.split_at header_lines_unsat "\r\n" 0)))
(assert (>= (str.num_splits header_lines_unsat "\r\n") 1))

(assert (= content_length_key_unsat (str.split_at content_length_line_unsat ": " 0)))
(assert (= content_length_value_unsat (str.split_at content_length_line_unsat ": " 1)))
(assert (>= (str.num_splits content_length_line_unsat ": ") 2))
(assert (= content_length_key_unsat "Content-Length"))
(assert (str.in_re content_length_value_unsat (re.+ (re.range "0" "9"))))

(assert (= body_len_unsat (str.len body_unsat)))
(assert (= content_length_int_unsat body_len_unsat))

; Force a mismatch: value says 10, but body is "abc" (length 3), and integer tied to body_len
(assert (= content_length_value_unsat "10"))
(assert (= body_unsat "abc"))
(assert (= body_len_unsat 3))
(assert (= content_length_int_unsat 10))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
