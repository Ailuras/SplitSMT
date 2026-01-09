(set-logic ALL)

; Uninterpreted split interface

; Seed-like Boolean scaffolding (preserved core structure, extended)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-const var_0xINPUT_81724 String)

; HTTP header parsing variables
(declare-const request String)
(declare-const request_line String)
(declare-const header_block String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const host_value String)
(declare-const cl_value String)
(declare-const cl_int Int)
(declare-const body String)

; Relate seed input to the request
(assert (= request var_0xINPUT_81724))

; Split request into request-line and remainder using CRLF
(assert (= request_line (str.split_at request "\r\n" 0)))
(assert (= header_block (str.split_rest request "\r\n" 1)))
(assert (>= (str.num_splits request "\r\n") 2))

; Within the header block, first header lines for Host and Content-Length
(assert (= host_line (str.split_at header_block "\r\n" 0)))
(assert (= cl_line (str.split_at header_block "\r\n" 1)))
(assert (>= (str.num_splits header_block "\r\n") 2))

; Parse Host header using colon delimiter
(assert (= (str.split_at host_line ":" 0) "Host"))
(assert (= host_value (str.split_rest host_line ":" 1)))
(assert (>= (str.num_splits host_line ":") 2))

; Parse Content-Length header using colon delimiter
(assert (= (str.split_at cl_line ":" 0) "Content-Length"))
(assert (= cl_value (str.split_rest cl_line ":" 1)))
(assert (>= (str.num_splits cl_line ":") 2))

; Body is whatever remains after the second header line
(assert (= body (str.split_rest header_block "\r\n" 2)))

; Basic sanity constraints on extracted values
(assert (> (str.len host_value) 0))
(assert (> (str.len cl_value) 0))

; Content-Length numeric constraints
(assert (>= cl_int 0))
(assert (= (str.len body) cl_int))

; Boolean structure: keep the seed style but mutate to encode a parsing property
(assert (= T_1 (not (= "qXdHDo7IZR" var_0xINPUT_81724))))
; Require Content-Length line to exist and be non-empty: T_2 expresses the negation of that (for UNSAT)
(assert (= T_2 (not (and (>= (str.num_splits cl_line ":") 2) (> (str.len cl_value) 0)))))

; Force both: input differs from magic string AND parsing property fails (contradiction with earlier constraints)
(assert T_1)
(assert T_2)

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
