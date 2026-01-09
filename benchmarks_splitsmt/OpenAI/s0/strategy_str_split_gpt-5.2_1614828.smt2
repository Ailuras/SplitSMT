(set-logic ALL)

; Uninterpreted split interface (str_split)

; =========================
; SAT instance: well-formed HTTP header parsing
; =========================
(declare-const req_sat String)
(declare-const line0_sat String)
(declare-const line1_sat String)
(declare-const line2_sat String)
(declare-const request_line_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const host_key_sat String)
(declare-const host_value_sat String)
(declare-const cl_key_sat String)
(declare-const cl_value_sat String)
(declare-const body_sat String)
(declare-const content_length_sat Int)

; Build a concrete-ish request layout using newlines
(assert (= req_sat (str.++ request_line_sat "\n" host_line_sat "\n" cl_line_sat "\n\n" body_sat)))

; Lines via split on newline
(assert (>= (str.num_splits req_sat "\n") 4))
(assert (= line0_sat (str.split_at req_sat "\n" 0)))
(assert (= line1_sat (str.split_at req_sat "\n" 1)))
(assert (= line2_sat (str.split_at req_sat "\n" 2)))
(assert (= request_line_sat line0_sat))
(assert (= host_line_sat line1_sat))
(assert (= cl_line_sat line2_sat))

; Request line sanity (simple)
(assert (str.prefixof "GET " request_line_sat))
(assert (str.contains request_line_sat " HTTP/1.1"))

; Parse Host header: "Host: <value>"
(assert (>= (str.num_splits host_line_sat ":") 2))
(assert (= host_key_sat (str.split_at host_line_sat ":" 0)))
(assert (= host_value_sat (str.split_rest host_line_sat ":" 1)))
(assert (= host_key_sat "Host"))
; allow optional leading space in value
(assert (or (str.prefixof " " host_value_sat) (not (str.prefixof " " host_value_sat))))
(assert (> (str.len host_value_sat) 0))

; Parse Content-Length header: "Content-Length: <digits>"
(assert (>= (str.num_splits cl_line_sat ":") 2))
(assert (= cl_key_sat (str.split_at cl_line_sat ":" 0)))
(assert (= cl_value_sat (str.split_rest cl_line_sat ":" 1)))
(assert (= cl_key_sat "Content-Length"))

; constrain cl_value_sat to be a non-negative integer encoding possibly preceded by a single space
(assert (or (= cl_value_sat (str.++ " " (str.from_int content_length_sat)))
            (= cl_value_sat (str.from_int content_length_sat))))
(assert (>= content_length_sat 0))

; validate body length matches content-length
(assert (= (str.len body_sat) content_length_sat))

; ensure header terminator exists
(assert (str.contains req_sat "\n\n"))

; =========================
; UNSAT instance: contradictory Content-Length/body length
; =========================
(declare-const req_unsat String)
(declare-const body_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_key_unsat String)
(declare-const cl_value_unsat String)
(declare-const bad_len Int)

(assert (= req_unsat (str.++ "POST /upload HTTP/1.1\n" cl_line_unsat "\n\n" body_unsat)))

; parse Content-Length
(assert (>= (str.num_splits cl_line_unsat ":") 2))
(assert (= cl_key_unsat (str.split_at cl_line_unsat ":" 0)))
(assert (= cl_value_unsat (str.split_rest cl_line_unsat ":" 1)))
(assert (= cl_key_unsat "Content-Length"))

; make header claim a specific length via string form
(assert (>= bad_len 0))
(assert (= cl_value_unsat (str.++ " " (str.from_int bad_len))))

; force a contradiction: body length must both equal and differ from bad_len
(assert (= (str.len body_unsat) bad_len))
(assert (not (= (str.len body_unsat) bad_len)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
