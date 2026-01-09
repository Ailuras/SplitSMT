(set-logic ALL)

; Uninterpreted interface for string split reasoning

; Seed-style booleans preserved (core structure) and extended
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_6 () Bool)

; HTTP header parsing scenario variables
(declare-fun var_0xINPUT_49116 () String)
(declare-const request_line String)
(declare-const headers_block String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const body String)
(declare-const content_length Int)

; Keep the seed structure: contradictory emptiness checks
(assert (= T_1 (not (= "" var_0xINPUT_49116))))
(assert (= T_2 (not T_1)))
(assert T_2)
(assert (= T_3 (not (= "" var_0xINPUT_49116))))
(assert (= T_4 (not T_3)))
(assert T_4)

; HTTP request structure using split by CRLF
(assert (= request_line (str.split_at var_0xINPUT_49116 "\r\n" 0)))
(assert (= headers_block (str.split_rest var_0xINPUT_49116 "\r\n" 1)))
(assert (>= (str.num_splits var_0xINPUT_49116 "\r\n") 3))

; Identify header lines: Host and Content-Length present
(assert (= host_line (str.split_at headers_block "\r\n" 0)))
(assert (= cl_line (str.split_at headers_block "\r\n" 1)))
(assert (>= (str.num_splits headers_block "\r\n") 2))

; Parse key/value with colon delimiter
(assert (>= (str.num_splits host_line ":") 2))
(assert (= host_key (str.split_at host_line ":" 0)))
(assert (= host_value (str.split_rest host_line ":" 1)))

(assert (>= (str.num_splits cl_line ":") 2))
(assert (= cl_key (str.split_at cl_line ":" 0)))
(assert (= cl_value (str.split_rest cl_line ":" 1)))

; Basic validations
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))
(assert (not (= host_value "")))
(assert (str.contains host_value "."))

; Content-Length validation (integer) and consistency with body length
(assert (>= content_length 0))
(assert (= (str.len body) content_length))

; Intentionally contradictory Content-Length constraints for an UNSAT instance
(assert (= T_5 (= content_length 0)))
(assert (= T_6 (not T_5)))
(assert T_5)
(assert T_6)

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
