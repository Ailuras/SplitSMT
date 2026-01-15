(set-logic ALL)

; Uninterpreted split interface (str_split)

; HTTP header parsing scenario
(declare-const request String)
(declare-const headers_block String)
(declare-const request_line String)
(declare-const host_line String)
(declare-const content_length_line String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const body String)
(declare-const cl_int Int)

; --- Basic shape: request-line + CRLF + headers + CRLFCRLF + body
(assert (= request_line (str.split_at request "\r\n" 0)))
(assert (= headers_block (str.split_rest request "\r\n" 1)))
(assert (>= (str.num_splits request "\r\n") 3))

; Ensure there is an empty line separator: some header line is empty (""), i.e., CRLFCRLF occurs.
; Model this by forcing one of the early lines to be empty.
(assert (= (str.split_at request "\r\n" 3) ""))

; Host and Content-Length lines appear in fixed positions for this scenario
(assert (= host_line (str.split_at request "\r\n" 1)))
(assert (= content_length_line (str.split_at request "\r\n" 2)))

; Split header lines by ":" into key/value
(assert (= host_key (str.split_at host_line ":" 0)))
(assert (= host_value (str.split_at host_line ":" 1)))
(assert (>= (str.num_splits host_line ":") 2))

(assert (= cl_key (str.split_at content_length_line ":" 0)))
(assert (= cl_value (str.split_at content_length_line ":" 1)))
(assert (>= (str.num_splits content_length_line ":") 2))

; Expected header keys
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))

; Host value: require it contains a dot and is non-empty (after colon)
(assert (> (str.len host_value) 0))
(assert (str.contains host_value "."))

; Content-Length value: constrain to be decimal digits (allow optional leading spaces)
(assert (str.in_re cl_value (re.++ (re.* (str.to_re " ")) (re.+ (re.range "0" "9")))))

; Define numeric content length and basic bounds
(assert (>= cl_int 0))
(assert (<= cl_int 4096))

; Link body length to content length (abstracting body extraction)
; Body is everything after the empty line; for this fixed-position template, body starts at line index 4.
(assert (= body (str.split_rest request "\r\n" 4)))
(assert (= (str.len body) cl_int))

; Additional sanity: request-line looks like "METHOD SP PATH SP HTTP/1.1"
(declare-const method String)
(declare-const path String)
(declare-const version String)
(assert (= method (str.split_at request_line " " 0)))
(assert (= path (str.split_at request_line " " 1)))
(assert (= version (str.split_at request_line " " 2)))
(assert (>= (str.num_splits request_line " ") 3))
(assert (or (= method "GET") (= method "POST")))
(assert (str.in_re path (re.++ (str.to_re "/") (re.* re.allchar))))
(assert (= version "HTTP/1.1"))

; -----------------------------------------------------------------------------
; SAT instance: consistent header parsing and content-length/body
; -----------------------------------------------------------------------------
(assert (= request_line "POST /submit HTTP/1.1"))
(assert (= host_line "Host:example.com"))
(assert (= content_length_line "Content-Length:5"))
(assert (= body "abcde"))
(assert (= cl_int 5))
(check-sat)
(exit)
