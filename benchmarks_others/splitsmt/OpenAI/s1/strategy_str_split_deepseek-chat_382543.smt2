(set-logic ALL)

; Uninterpreted interface operations for string split reasoning

; HTTP header parsing variables
(declare-const request String)
(declare-const header_block String)
(declare-const request_line String)
(declare-const headers_and_body String)
(declare-const body String)

(declare-const host_line String)
(declare-const cl_line String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)

(declare-const declared_len Int)
(declare-const actual_len Int)

; Preserve core seed structure but adapt to header parsing: require a meaningful replace effect
(declare-const x String)
(declare-const y String)
(assert (= x request))
(assert (= y "\r\n"))
(assert (not (= (str.replace x y y) x)))

; Structure: request_line, header_block, and body separated by CRLF CRLF
(assert (= request_line (str.split_at request "\r\n" 0)))
(assert (= headers_and_body (str.split_rest request "\r\n" 1)))

; Require at least request-line + at least 1 header line
(assert (>= (str.num_splits request "\r\n") 3))

; header_block ends at the empty line; model as two segments split by CRLFCRLF
(assert (= header_block (str.split_at request "\r\n\r\n" 0)))
(assert (= body (str.split_at request "\r\n\r\n" 1)))
(assert (>= (str.num_splits request "\r\n\r\n") 2))

; Constrain header_block to have multiple lines
(assert (>= (str.num_splits header_block "\r\n") 2))

; Extract specific header lines (position-dependent for this scenario)
(assert (= host_line (str.split_at header_block "\r\n" 1)))
(assert (= cl_line (str.split_at header_block "\r\n" 2)))

; Each header line is key:value
(assert (= host_key (str.split_at host_line ":" 0)))
(assert (= host_value (str.split_at host_line ":" 1)))
(assert (>= (str.num_splits host_line ":") 2))

(assert (= cl_key (str.split_at cl_line ":" 0)))
(assert (= cl_value (str.split_at cl_line ":" 1)))
(assert (>= (str.num_splits cl_line ":") 2))

; Keys are as expected
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))

; Values should be non-empty (allowing optional leading space is not modeled; enforce length > 0)
(assert (> (str.len host_value) 0))
(assert (> (str.len cl_value) 0))

; Content-Length validation: declared_len equals actual body length
(assert (= actual_len (str.len body)))
(assert (>= declared_len 0))
(assert (= declared_len actual_len))

; Additional sanity constraints: ensure body exists and contains no CRLFCRLF (single header/body split)
(assert (> (str.len body) 0))
(assert (= (str.num_splits request "\r\n\r\n") 2))

; Create both SAT and UNSAT instances: this block forces UNSAT via contradictory length requirement
; If host header exists and content-length matches body length, also assert mismatch
(assert (not (= declared_len actual_len)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
