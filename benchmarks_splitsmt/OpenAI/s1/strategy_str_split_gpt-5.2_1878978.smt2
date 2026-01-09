(set-logic ALL)

; HTTP Header Parsing: split by CRLF and ':' to extract header fields, validate Content-Length


(declare-const T_1 Bool)
(declare-const var_0xINPUT_113237 String)

(declare-const request String)
(declare-const request_line String)
(declare-const headers_block String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const body String)
(declare-const cl Int)
(declare-const method String)
(declare-const path String)
(declare-const version String)

; Preserve seed core structure but repurpose input as a sanity constraint on a separate string
(assert (= T_1 (= "-" var_0xINPUT_113237)))
(assert T_1)

; Request is headers_block + blank line + body
(assert (= request (str.++ headers_block "\r\n\r\n" body)))

; First line is request line, followed by header lines
(assert (= request_line (str.split_at headers_block "\r\n" 0)))
(assert (= host_line (str.split_at headers_block "\r\n" 1)))
(assert (= cl_line (str.split_at headers_block "\r\n" 2)))
(assert (>= (str.num_splits headers_block "\r\n") 3))

; Parse request line: METHOD SP PATH SP HTTP/VERSION
(assert (= method (str.split_at request_line " " 0)))
(assert (= path (str.split_at request_line " " 1)))
(assert (= version (str.split_at request_line " " 2)))
(assert (>= (str.num_splits request_line " ") 3))
(assert (= method "POST"))
(assert (= version "HTTP/1.1"))
(assert (str.prefixof "/" path))

; Parse Host header: "Host: <value>"
(assert (= host_key (str.split_at host_line ":" 0)))
(assert (= host_value (str.split_at host_line ":" 1)))
(assert (>= (str.num_splits host_line ":") 2))
(assert (= host_key "Host"))
(assert (> (str.len host_value) 0))

; Parse Content-Length header: "Content-Length: <digits>"
(assert (= cl_key (str.split_at cl_line ":" 0)))
(assert (= cl_value (str.split_at cl_line ":" 1)))
(assert (>= (str.num_splits cl_line ":") 2))
(assert (= cl_key "Content-Length"))

; Require value to be digits (optionally with leading space)
(assert (or (str.in_re cl_value (re.++ (str.to_re " ") (re.+ (re.range "0" "9"))))
            (str.in_re cl_value (re.+ (re.range "0" "9")))))

; Link integer content-length to body length (abstracted): enforce consistent bounds and then contradict for UNSAT
(assert (>= cl 0))
(assert (= (str.len body) cl))

; Create an UNSAT twist: also assert body length differs from cl
(assert (not (= (str.len body) cl)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
