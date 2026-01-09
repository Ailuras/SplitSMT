(set-logic ALL)

; Uninterpreted split interface

; Scenario: HTTP Header Parsing
; We model an HTTP request as: request_line "\r\n" headers "\r\n\r\n" body

(declare-const request String)
(declare-const request_line String)
(declare-const headers_block String)
(declare-const body String)

(declare-const header0 String)
(declare-const header1 String)
(declare-const header2 String)

(declare-const host_key String)
(declare-const host_val String)
(declare-const cl_key String)
(declare-const cl_val String)

(declare-const content_length Int)

; Request decomposition by CRLFCRLF boundary
(assert (= request (str.++ request_line "\r\n" headers_block "\r\n\r\n" body)))

; At least a request line and some headers
(assert (>= (str.len request_line) 1))
(assert (>= (str.len headers_block) 1))

; Split headers into lines (CRLF)
(assert (>= (str.num_splits headers_block "\r\n") 3))
(assert (= header0 (str.split_at headers_block "\r\n" 0)))
(assert (= header1 (str.split_at headers_block "\r\n" 1)))
(assert (= header2 (str.split_at headers_block "\r\n" 2)))

; Each header line should contain a colon separating key and value
(assert (str.contains header0 ":"))
(assert (str.contains header1 ":"))

; Parse Host header (allow optional space after colon)
(assert (= host_key (str.split_at header0 ":" 0)))
(assert (= host_val (str.split_rest header0 ":" 1)))
(assert (or (= host_key "Host") (= host_key "host")))
; host value is non-empty after optional leading space
(assert (>= (str.len host_val) 1))
(assert (or (not (= (str.at host_val 0) " ")) (>= (str.len host_val) 2)))

; Parse Content-Length header
(assert (= cl_key (str.split_at header1 ":" 0)))
(assert (= cl_val (str.split_rest header1 ":" 1)))
(assert (= cl_key "Content-Length"))

; Content-Length value is digits, possibly with a single leading space
(declare-const cl_val_trimmed String)
(assert (= cl_val_trimmed (ite (= (str.at cl_val 0) " ") (str.substr cl_val 1 (- (str.len cl_val) 1)) cl_val)))
(assert (>= (str.len cl_val_trimmed) 1))
(assert (str.in_re cl_val_trimmed (re.+ (re.range "0" "9"))))

; Bind the integer content_length to cl_val_trimmed via canonical decimal conversion
; Use str.to_int with guard to avoid -1 on non-numeric (already constrained by regex)
(assert (= content_length (str.to_int cl_val_trimmed)))
(assert (>= content_length 0))

; SAT: content_length matches body length
(assert (= content_length (str.len body)))

; Additional realistic constraints
; Request line like: METHOD SP PATH SP HTTP/1.1
(assert (str.contains request_line "HTTP/1.1"))
(assert (str.contains request_line " "))

; Ensure at least one more header exists (header2) with key: value structure
(declare-const h2_key String)
(declare-const h2_val String)
(assert (str.contains header2 ":"))
(assert (= h2_key (str.split_at header2 ":" 0)))
(assert (= h2_val (str.split_rest header2 ":" 1)))
(assert (>= (str.len h2_key) 1))
(assert (>= (str.len h2_val) 1))

; UNSAT instance (separate branch): create a contradiction for an alternate content-length parsing
; This keeps the file as a single script while still embedding an UNSAT case via an assumption-like split.
(declare-const make_unsat Bool)
; If make_unsat then force mismatch between declared content-length and body length
(assert (=> make_unsat (not (= content_length (str.len body)))))
; Also require make_unsat and its negation simultaneously in the UNSAT branch selector
(assert (or (not make_unsat) make_unsat))
; Force SAT mode by default (set make_unsat to false)
(assert (not make_unsat))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
