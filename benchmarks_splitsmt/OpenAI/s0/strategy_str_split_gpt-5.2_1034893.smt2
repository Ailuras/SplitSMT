(set-logic ALL)

; Uninterpreted split interface

; =====================
; SAT instance: well-formed HTTP header parsing
; =====================
(declare-const req String)
(declare-const request_line String)
(declare-const headers_blob String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const ua_line String)
(declare-const host_key String)
(declare-const host_val String)
(declare-const cl_key String)
(declare-const cl_val String)
(declare-const ua_key String)
(declare-const ua_val String)
(declare-const content_length Int)
(declare-const body String)
(declare-const cl_digits_re RegLan)

; Concrete request (typical request-line + headers + empty line + body)
(assert (= req
  (str.++
    "GET /upload HTTP/1.1\r\n"
    "Host: example.com\r\n"
    "Content-Length: 5\r\n"
    "User-Agent: UA\r\n"
    "\r\n"
    "HELLO")))

; Split request into lines
(assert (>= (str.num_splits req "\r\n") 5))
(assert (= request_line (str.split_at req "\r\n" 0)))
(assert (= host_line    (str.split_at req "\r\n" 1)))
(assert (= cl_line      (str.split_at req "\r\n" 2)))
(assert (= ua_line      (str.split_at req "\r\n" 3)))
(assert (= body         (str.split_rest req "\r\n\r\n" 1)))

; Basic request line validation
(assert (str.contains request_line "HTTP/1.1"))
(assert (str.contains request_line "GET "))

; Parse header key/value via ':' delimiter
(assert (>= (str.num_splits host_line ":") 2))
(assert (>= (str.num_splits cl_line ":") 2))
(assert (>= (str.num_splits ua_line ":") 2))

(assert (= host_key (str.split_at host_line ":" 0)))
(assert (= host_val (str.split_rest host_line ":" 1)))
(assert (= cl_key   (str.split_at cl_line ":" 0)))
(assert (= cl_val   (str.split_rest cl_line ":" 1)))
(assert (= ua_key   (str.split_at ua_line ":" 0)))
(assert (= ua_val   (str.split_rest ua_line ":" 1)))

; Header name constraints
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))
(assert (= ua_key "User-Agent"))

; Minimal value constraints (allow leading space after ':')
(assert (str.contains host_val "example.com"))
(assert (str.contains ua_val "UA"))

; Content-Length must be digits with optional leading space
(assert (= cl_digits_re (re.++ (str.to_re " ") (re.+ (re.range "0" "9")))))
(assert (str.in_re cl_val cl_digits_re))

; Check the content-length matches body length for this concrete request
(assert (= content_length 5))
(assert (= (str.len body) content_length))

; Additional sanity: no empty host
(assert (> (str.len host_val) 1))

(check-sat)

; =====================
; UNSAT instance: contradictory Content-Length
; =====================
(declare-const req_bad String)
(declare-const cl_line_bad String)
(declare-const cl_val_bad String)
(declare-const body_bad String)
(declare-const content_length_bad Int)

(assert (= req_bad
  (str.++
    "POST /data HTTP/1.1\r\n"
    "Host: example.com\r\n"
    "Content-Length: 10\r\n"
    "\r\n"
    "HELLO")))

(assert (>= (str.num_splits req_bad "\r\n") 4))
(assert (= cl_line_bad (str.split_at req_bad "\r\n" 2)))
(assert (>= (str.num_splits cl_line_bad ":") 2))
(assert (= cl_val_bad (str.split_rest cl_line_bad ":" 1)))

; Ensure it looks like a digit value with leading space
(assert (str.in_re cl_val_bad cl_digits_re))

(assert (= body_bad (str.split_rest req_bad "\r\n\r\n" 1)))

; Contradiction: force parsed content-length to be 10 while body length is 5
(assert (= content_length_bad 10))
(assert (= (str.len body_bad) 5))
(assert (= (str.len body_bad) content_length_bad))

(check-sat)
(exit)
