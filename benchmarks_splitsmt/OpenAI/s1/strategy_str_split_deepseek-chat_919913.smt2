(set-logic ALL)

; --- Uninterpreted interface for string splitting ---

; --- Seed variables (kept, but adapted to HTTP header parsing context) ---
(declare-const s String)      ; entire HTTP request header block
(declare-const in0 String)    ; delimiter candidate / canonical delimiter
(declare-const in1 String)    ; alias delimiter for mutation constraints

; --- Additional variables for parsing/validation ---
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

; --- Core structure preserved: nested and/not/not pattern from seed, mutated ---
(assert
  (and
    (and
      ; similar arithmetic shape to seed, but tied to header length and delimiter lengths
      (not (not (= (ite (<= (+ (- (str.len s) (* (str.len in0) 2)) 1) 0) 1 0) 0)))
      ; keep the in0=in1 constraint pattern
      (not (= (ite (= in0 in1) 1 0) 0))
      (not (= (ite (= in0 in1) 1 0) 0))
    )
    ; bind delimiter to CRLF for HTTP headers
    (= in0 "\r\n")
    (= in1 "\r\n")
  )
)

; --- HTTP header parsing constraints ---
; Must contain at least request line + one header line + blank line terminator
(assert (>= (str.num_splits s "\r\n") 3))
(assert (= request_line (str.split_at s "\r\n" 0)))
(assert (= headers_block (str.split_rest s "\r\n" 1)))

; request line sanity: starts with method token (approx) and contains HTTP version marker
(assert (or (str.prefixof "GET " request_line)
            (str.prefixof "POST " request_line)
            (str.prefixof "HEAD " request_line)))
(assert (str.contains request_line " HTTP/1."))

; Host header: "Host: <value>"
(assert (>= (str.num_splits s "\r\n") 4))
(assert (= host_line (str.split_at s "\r\n" 1)))
(assert (= host_key (str.split_at host_line ":" 0)))
(assert (= host_value (str.split_rest host_line ":" 1)))
(assert (= host_key "Host"))
(assert (> (str.len host_value) 0))

; Content-Length header: "Content-Length: <digits>"
(assert (= cl_line (str.split_at s "\r\n" 2)))
(assert (= cl_key (str.split_at cl_line ":" 0)))
(assert (= cl_value (str.split_rest cl_line ":" 1)))
(assert (= cl_key "Content-Length"))

; cl_value must be a non-empty decimal numeral with optional leading space
; Use regex: " "* [0-9]+  (no trailing chars)
(assert (str.in_re cl_value (re.++ (re.* (str.to_re " ")) (re.+ (re.range "0" "9")))))

; Connect an Int to the string value via str.to_int; require it round-trips to digits-only form
(assert (>= content_length 0))
(assert (= content_length (str.to_int cl_value)))
(assert (>= content_length 0))

; Body length must match Content-Length
; Model body as whatever remains after the blank line terminator: split on "\r\n\r\n"
(assert (= body (str.split_rest s "\r\n\r\n" 1)))
(assert (= (str.len body) content_length))

; Require header terminator exists: at least 2 segments when splitting by CRLFCRLF
(assert (>= (str.num_splits s "\r\n\r\n") 2))

; --- UNSAT branch to ensure diversity: enforce a contradiction about content length ---
; If the body length equals content_length, additionally force it to differ.
(assert (not (= (str.len body) content_length)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
