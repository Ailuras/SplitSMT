(set-logic ALL)

; Uninterpreted split interface for HTTP header parsing

; Seed-style boolean guards
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_6 () Bool)
(declare-fun T_7 () Bool)

; HTTP header input and derived fields
(declare-const var_0xINPUT_429544 String)
(declare-const request_line String)
(declare-const header_0 String)
(declare-const header_1 String)
(declare-const header_2 String)
(declare-const host_line String)
(declare-const content_length_line String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const declared_body_len Int)
(declare-const body String)

; Preserve core structure: seed-style distinctness/non-emptiness booleans
(assert (= T_1 (not (= "ywUN4ZIDAC" var_0xINPUT_429544))))
(assert T_1)
(assert (= T_2 (not (= "" var_0xINPUT_429544))))
(assert T_2)
(assert (= T_3 (= var_0xINPUT_429544 "Example:")))
(assert (= T_4 (not T_3)))
(assert T_4)
(assert (= T_5 (not (= "" var_0xINPUT_429544))))
(assert T_5)
(assert (= T_6 (not (= var_0xINPUT_429544 "4PH2ujcENG"))))
(assert (= T_7 (not T_6)))
(assert T_7)

; HTTP Header Parsing constraints
; Split request into lines by CRLF
(assert (>= (str.num_splits var_0xINPUT_429544 "\r\n") 4))
(assert (= request_line (str.split_at var_0xINPUT_429544 "\r\n" 0)))
(assert (= header_0 (str.split_at var_0xINPUT_429544 "\r\n" 1)))
(assert (= header_1 (str.split_at var_0xINPUT_429544 "\r\n" 2)))
(assert (= header_2 (str.split_at var_0xINPUT_429544 "\r\n" 3)))

; Minimal request-line sanity
(assert (str.contains request_line "HTTP/1.1"))
(assert (str.contains request_line "GET "))

; Ensure at least one colon-separated header exists
(assert (or (str.contains header_0 ":") (str.contains header_1 ":") (str.contains header_2 ":")))

; Model Host and Content-Length headers as particular lines
(assert (= host_line header_0))
(assert (= content_length_line header_1))

; Parse Host: value
(assert (>= (str.num_splits host_line ":") 2))
(assert (= host_key (str.split_at host_line ":" 0)))
(assert (= host_value (str.split_rest host_line ":" 1)))
(assert (= host_key "Host"))
(assert (> (str.len host_value) 0))

; Parse Content-Length: value
(assert (>= (str.num_splits content_length_line ":") 2))
(assert (= cl_key (str.split_at content_length_line ":" 0)))
(assert (= cl_value (str.split_rest content_length_line ":" 1)))
(assert (= cl_key "Content-Length"))

; Validate Content-Length numeric-ish: at least one digit and only digits (simplified check)
(assert (> (str.len cl_value) 0))
(assert (str.in_re cl_value (re.+ (re.range "0" "9"))))

; Body extracted after header_2 (simulate end of headers somewhere after index 3)
(assert (= body (str.split_rest var_0xINPUT_429544 "\r\n" 4)))

; Bind declared_body_len and validate against body length (deliberate UNSAT core)
(assert (>= declared_body_len 0))
(assert (= declared_body_len 0))
(assert (> (str.len body) 0))
(assert (= (str.len body) declared_body_len))

(check-sat)


; [GENERATION STATUS: SUCCESS]
