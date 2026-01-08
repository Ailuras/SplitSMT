(set-logic ALL)

; Uninterpreted interface operations for string split reasoning

; HTTP header parsing scenario variables
(declare-const req String)
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
(declare-const content_length Int)

; Preserve mutated seed core structure (prefix + replace interaction)
(declare-const x String)
(declare-const y String)
(assert (not (= (str.prefixof x (str.replace "B" y y)) (str.prefixof x "B"))))

; Model request split into request-line and remainder by first newline
(assert (= request_line (str.split_at req "\n" 0)))
(assert (= headers_and_body (str.split_rest req "\n" 1)))
(assert (>= (str.num_splits req "\n") 2))

; Split headers and body by empty line separator
(assert (= header_block (str.split_at headers_and_body "\n\n" 0)))
(assert (= body (str.split_at headers_and_body "\n\n" 1)))
(assert (>= (str.num_splits headers_and_body "\n\n") 2))

; Require at least two header lines: Host and Content-Length
(assert (>= (str.num_splits header_block "\n") 2))
(assert (= host_line (str.split_at header_block "\n" 0)))
(assert (= cl_line (str.split_at header_block "\n" 1)))

; Parse Host: key/value by colon
(assert (= host_key (str.split_at host_line ":" 0)))
(assert (= host_value (str.split_rest host_line ":" 1)))
(assert (= host_key "Host"))
(assert (not (str.contains host_value "\n")))
(assert (> (str.len host_value) 0))

; Parse Content-Length: key/value by colon
(assert (= cl_key (str.split_at cl_line ":" 0)))
(assert (= cl_value (str.split_rest cl_line ":" 1)))
(assert (= cl_key "Content-Length"))

; Content-Length value must be digits only (no spaces, no signs)
(assert (str.in_re cl_value (re.+ (re.range "0" "9"))))

; Relate numeric content_length to body size (typical validation constraint)
(assert (>= content_length 0))
(assert (= content_length (str.len body)))

; Additional header sanity: request line must mention HTTP/1.1
(assert (str.contains request_line "HTTP/1.1"))

; UNSAT instance: force a mismatch between declared and actual body length
(assert (not (= (str.len body) content_length)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
