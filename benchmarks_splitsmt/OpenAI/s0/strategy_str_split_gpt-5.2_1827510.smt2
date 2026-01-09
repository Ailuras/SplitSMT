(set-logic ALL)

; Uninterpreted interface for str_split

; =========================
; SAT instance: parse request headers and validate Content-Length
; =========================
(declare-const request String)
(declare-const header_block String)
(declare-const headers_sep String)
(declare-const request_line String)
(declare-const body String)

(declare-const host_line String)
(declare-const cl_line String)
(declare-const ua_line String)

(declare-const host_key String)
(declare-const host_val String)
(declare-const cl_key String)
(declare-const cl_val String)
(declare-const ua_key String)
(declare-const ua_val String)

(declare-const cl_len Int)

(assert (= headers_sep "\r\n\r\n"))
(assert (= request (str.++ header_block headers_sep body)))
(assert (>= (str.num_splits request headers_sep) 2))

; Split header block into request line + subsequent header lines
(assert (= request_line (str.split_at header_block "\r\n" 0)))
(assert (>= (str.num_splits header_block "\r\n") 4))

; Constrain the request line structure roughly: METHOD SP PATH SP HTTP/VERSION
(assert (str.in_re request_line (re.++ (str.to_re "GET ") (re.* re.allchar) (str.to_re " HTTP/1.1"))))

; Extract specific header lines by index (order chosen for determinism)
(assert (= host_line (str.split_at header_block "\r\n" 1)))
(assert (= cl_line   (str.split_at header_block "\r\n" 2)))
(assert (= ua_line   (str.split_at header_block "\r\n" 3)))

; Each header line must contain a colon separator producing at least 2 segments
(assert (>= (str.num_splits host_line ":") 2))
(assert (>= (str.num_splits cl_line ":") 2))
(assert (>= (str.num_splits ua_line ":") 2))

; Key is before the first colon
(assert (= host_key (str.split_at host_line ":" 0)))
(assert (= cl_key   (str.split_at cl_line ":" 0)))
(assert (= ua_key   (str.split_at ua_line ":" 0)))

; Value is everything after the first colon (may include additional colons)
(assert (= host_val (str.split_rest host_line ":" 1)))
(assert (= cl_val   (str.split_rest cl_line ":" 1)))
(assert (= ua_val   (str.split_rest ua_line ":" 1)))

; Enforce required header keys
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))
(assert (= ua_key "User-Agent"))

; Basic sanity: values non-empty after trimming at least one char
(assert (>= (str.len host_val) 1))
(assert (>= (str.len cl_val) 1))
(assert (>= (str.len ua_val) 1))

; Content-Length value is digits with optional leading spaces
(assert (str.in_re cl_val (re.++ (re.* (str.to_re " ")) (re.+ (re.range "0" "9")))))

; Connect Content-Length numeric interpretation to body length (simplified constraint)
(assert (>= cl_len 0))
(assert (= cl_len (str.len body)))
(assert (<= cl_len 2048))

; Additional constraints to avoid degenerate headers
(assert (not (str.contains host_val "\r")))
(assert (not (str.contains host_val "\n")))
(assert (not (str.contains ua_val "\r")))
(assert (not (str.contains ua_val "\n")))

; Body must match the length (implicitly by cl_len = len(body)) and may be arbitrary
(assert (str.in_re body (re.* re.allchar)))

(check-sat)

; =========================
; UNSAT instance: force conflicting Content-Length vs body length
; =========================
(declare-const request_u String)
(declare-const header_block_u String)
(declare-const body_u String)
(declare-const request_line_u String)
(declare-const cl_line_u String)
(declare-const cl_key_u String)
(declare-const cl_val_u String)
(declare-const cl_len_u Int)

(assert (= request_u (str.++ header_block_u headers_sep body_u)))
(assert (>= (str.num_splits request_u headers_sep) 2))
(assert (= request_line_u (str.split_at header_block_u "\r\n" 0)))
(assert (= cl_line_u (str.split_at header_block_u "\r\n" 1)))

(assert (str.in_re request_line_u (re.++ (str.to_re "POST ") (re.* re.allchar) (str.to_re " HTTP/1.1"))))

(assert (>= (str.num_splits cl_line_u ":") 2))
(assert (= cl_key_u (str.split_at cl_line_u ":" 0)))
(assert (= cl_val_u (str.split_rest cl_line_u ":" 1)))
(assert (= cl_key_u "Content-Length"))

(assert (str.in_re cl_val_u (re.++ (re.* (str.to_re " ")) (re.+ (re.range "0" "9")))))

; Contradiction: enforce two different body lengths simultaneously
(assert (= cl_len_u (str.len body_u)))
(assert (= cl_len_u 5))
(assert (= (str.len body_u) 7))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
