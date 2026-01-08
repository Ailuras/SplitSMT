(set-logic ALL)

; Uninterpreted interface for string splitting

; Additional uninterpreted helpers (non-primitive ops)
(declare-fun to_int (String) Int)
(declare-fun is_digits (String) Bool)

; =========
; SAT instance: consistent HTTP header parsing
; =========

(declare-const request String)
(declare-const headers_block String)
(declare-const first_line String)
(declare-const header_line0 String)
(declare-const header_line1 String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const cl_value_trim String)
(declare-const body String)
(declare-const declared_len Int)

; Basic shape: request is split into headers and body by CRLFCRLF
(assert (= headers_block (str.split_at request "\r\n\r\n" 0)))
(assert (= body (str.split_rest request "\r\n\r\n" 1)))
(assert (>= (str.num_splits request "\r\n\r\n") 2))

; Header lines separated by CRLF
(assert (= first_line (str.split_at headers_block "\r\n" 0)))
(assert (= header_line0 (str.split_at headers_block "\r\n" 1)))
(assert (= header_line1 (str.split_at headers_block "\r\n" 2)))
(assert (>= (str.num_splits headers_block "\r\n") 3))

; Request line plausibility
(assert (str.prefixof "GET " first_line))
(assert (str.contains first_line " HTTP/1.1"))

; Parse Host header: "Host: <value>"
(assert (= host_key (str.split_at header_line0 ":" 0)))
(assert (= host_value (str.split_rest header_line0 ":" 1)))
(assert (= host_key "Host"))
(assert (>= (str.num_splits header_line0 ":") 2))
(assert (str.prefixof " " host_value))
(assert (> (str.len host_value) 1))
(assert (str.contains host_value "."))

; Parse Content-Length header: "Content-Length: <digits>"
(assert (= cl_key (str.split_at header_line1 ":" 0)))
(assert (= cl_value (str.split_rest header_line1 ":" 1)))
(assert (= cl_key "Content-Length"))
(assert (>= (str.num_splits header_line1 ":") 2))

; Allow a single leading space before the numeric value
(assert (str.prefixof " " cl_value))
(assert (= cl_value_trim (str.substr cl_value 1 (- (str.len cl_value) 1))))
(assert (>= (str.len cl_value) 2))

; Digit validation + integer conversion (abstracted)
(assert (is_digits cl_value_trim))
(assert (= declared_len (to_int cl_value_trim)))
(assert (>= declared_len 0))

; Validate that body length matches declared Content-Length
(assert (= (str.len body) declared_len))

; Constrain the body to look like payload data (not required by HTTP, but helps structure)
(assert (or (= body "") (str.contains body "=")))

; =========
; UNSAT instance: contradictory constraints over another request
; =========

(declare-const bad_request String)
(declare-const bad_headers String)
(declare-const bad_body String)
(declare-const bad_cl_line String)
(declare-const bad_cl_val String)
(declare-const bad_cl_val_trim String)
(declare-const bad_declared_len Int)

(assert (= bad_headers (str.split_at bad_request "\r\n\r\n" 0)))
(assert (= bad_body (str.split_rest bad_request "\r\n\r\n" 1)))
(assert (>= (str.num_splits bad_request "\r\n\r\n") 2))

; Pick some header line as Content-Length
(assert (= bad_cl_line (str.split_at bad_headers "\r\n" 1)))
(assert (>= (str.num_splits bad_headers "\r\n") 2))
(assert (str.prefixof "Content-Length:" bad_cl_line))

(assert (= bad_cl_val (str.split_rest bad_cl_line ":" 1)))
(assert (str.prefixof " " bad_cl_val))
(assert (= bad_cl_val_trim (str.substr bad_cl_val 1 (- (str.len bad_cl_val) 1))))
(assert (>= (str.len bad_cl_val) 2))

; Declare it parses to some integer
(assert (is_digits bad_cl_val_trim))
(assert (= bad_declared_len (to_int bad_cl_val_trim)))
(assert (>= bad_declared_len 0))

; Contradiction: body length both equals and differs from declared length
(assert (= (str.len bad_body) bad_declared_len))
(assert (not (= (str.len bad_body) bad_declared_len)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
