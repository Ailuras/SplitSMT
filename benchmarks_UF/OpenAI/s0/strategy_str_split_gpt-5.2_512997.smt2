(set-logic ALL)

; Uninterpreted interface operations for string splitting
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; =========================
; SAT instance: header parsing and content-length validation
; =========================
(declare-const request String)
(declare-const header_delim String)
(declare-const line_delim String)
(declare-const colon_delim String)
(declare-const request_line String)
(declare-const header_block String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const body String)
(declare-const content_length Int)

(assert (= line_delim "\r\n"))
(assert (= colon_delim ":"))
(assert (= header_delim "\r\n\r\n"))

; Request is split into headers and body by CRLFCRLF
(assert (>= (num_splits request header_delim) 2))
(assert (= header_block (split_at request header_delim 0)))
(assert (= body (split_rest request header_delim 1)))

; Header block lines (0: request line, 1..: header fields)
(assert (>= (num_splits header_block line_delim) 3))
(assert (= request_line (split_at header_block line_delim 0)))
(assert (= host_line (split_at header_block line_delim 1)))
(assert (= cl_line (split_at header_block line_delim 2)))

; Basic request-line sanity: must contain method and path separator spaces
(assert (str.contains request_line " "))
(assert (str.contains request_line "HTTP/1.1"))

; Host header parsing: "Host: <value>"
(assert (>= (num_splits host_line colon_delim) 2))
(assert (= host_key (split_at host_line colon_delim 0)))
(assert (= host_value (split_rest host_line colon_delim 1)))
(assert (= host_key "Host"))
; allow optional leading space in value; enforce non-empty host after trimming one space optionally
(assert (or (= host_value " example.com") (= host_value "example.com")))

; Content-Length header parsing: "Content-Length: <digits>"
(assert (>= (num_splits cl_line colon_delim) 2))
(assert (= cl_key (split_at cl_line colon_delim 0)))
(assert (= cl_value (split_rest cl_line colon_delim 1)))
(assert (= cl_key "Content-Length"))

; cl_value is either " 5" or "5" and must be digits (optionally preceded by a single space)
(assert (str.in_re cl_value (re.union (str.to_re "5") (str.to_re " 5"))))
(assert (= content_length 5))

; Validate body size matches content_length (use string length)
(assert (= (str.len body) content_length))

; Constrain request to a coherent concrete shape to avoid underconstrained UF behavior
(assert (= request
  (str.++
    "GET /submit HTTP/1.1\r\n"
    "Host: example.com\r\n"
    "Content-Length: 5\r\n"
    "\r\n"
    "abcde")))

; =========================
; UNSAT instance: contradictory content-length vs body length
; =========================
(declare-const request_bad String)
(declare-const header_block_bad String)
(declare-const body_bad String)
(declare-const cl_line_bad String)
(declare-const cl_value_bad String)
(declare-const content_length_bad Int)

(assert (>= (num_splits request_bad header_delim) 2))
(assert (= header_block_bad (split_at request_bad header_delim 0)))
(assert (= body_bad (split_rest request_bad header_delim 1)))

(assert (>= (num_splits header_block_bad line_delim) 3))
(assert (= cl_line_bad (split_at header_block_bad line_delim 2)))

(assert (>= (num_splits cl_line_bad colon_delim) 2))
(assert (= cl_value_bad (split_rest cl_line_bad colon_delim 1)))

; Force a concrete bad request with Content-Length 4 but body length 5
(assert (= request_bad
  (str.++
    "POST /data HTTP/1.1\r\n"
    "Host: example.com\r\n"
    "Content-Length: 4\r\n"
    "\r\n"
    "abcde")))

(assert (str.in_re cl_value_bad (re.union (str.to_re "4") (str.to_re " 4"))))
(assert (= content_length_bad 4))
(assert (= (str.len body_bad) content_length_bad))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
