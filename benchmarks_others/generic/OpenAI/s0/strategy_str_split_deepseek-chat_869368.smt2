(set-logic ALL)

; Uninterpreted interface for string split operations
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; -------------------------------
; Scenario: HTTP Header Parsing
; -------------------------------

; Full raw HTTP request header block (request line + headers + blank line + optional body)
(declare-const http_req String)

; Common delimiters
(declare-const DCRLF String)
(declare-const DCOLON String)

(assert (= DCRLF "\r\n"))
(assert (= DCOLON ":"))

; Request line (first line)
(declare-const req_line String)
(assert (= req_line (split_at http_req DCRLF 0)))

; Method and path parsed using spaces
(declare-const method String)
(declare-const path String)
(declare-const version String)
(assert (= method (split_at req_line " " 0)))
(assert (= path   (split_at req_line " " 1)))
(assert (= version (split_at req_line " " 2)))
(assert (or (= method "GET") (= method "POST")))
(assert (str.prefixof "HTTP/1." version))
(assert (str.prefixof "/" path))

; Ensure there is at least one header line and the header section terminates with an empty line
; Lines: 0=req line, 1=Host, 2=Content-Length, 3=User-Agent, 4="" (blank), 5=body (possibly empty)
(assert (>= (num_splits http_req DCRLF) 5))

(declare-const line1 String)
(declare-const line2 String)
(declare-const line3 String)
(declare-const line4 String)
(declare-const body String)

(assert (= line1 (split_at http_req DCRLF 1)))
(assert (= line2 (split_at http_req DCRLF 2)))
(assert (= line3 (split_at http_req DCRLF 3)))
(assert (= line4 (split_at http_req DCRLF 4)))

(assert (= line4 ""))
(assert (= body (split_rest http_req DCRLF 5)))

; --- Parse Host header: "Host: <value>"
(declare-const host_key String)
(declare-const host_val String)
(assert (= host_key (split_at line1 DCOLON 0)))
(assert (= host_val (split_at line1 DCOLON 1)))
(assert (= host_key "Host"))
(assert (str.prefixof " " host_val))
(assert (>= (str.len host_val) 2))

; --- Parse Content-Length header: "Content-Length: <digits>"
(declare-const cl_key String)
(declare-const cl_val_raw String)
(declare-const cl_val String)
(assert (= cl_key (split_at line2 DCOLON 0)))
(assert (= cl_val_raw (split_at line2 DCOLON 1)))
(assert (= cl_key "Content-Length"))
(assert (str.prefixof " " cl_val_raw))
(assert (= cl_val (str.substr cl_val_raw 1 (- (str.len cl_val_raw) 1))))

; Content-Length must be all digits and non-empty
(assert (>= (str.len cl_val) 1))
(assert (str.in_re cl_val (re.+ (re.range "0" "9"))))

; Convert Content-Length to Int with str.to_int, constrain it to be valid
(declare-const cl_int Int)
(assert (= cl_int (str.to_int cl_val)))
(assert (>= cl_int 0))
(assert (<= cl_int 1000000))

; If POST, require a Content-Length and enforce body length equals it.
; If GET, enforce Content-Length is 0 and body is empty.
(assert (=> (= method "POST") (= (str.len body) cl_int)))
(assert (=> (= method "GET") (and (= cl_int 0) (= body ""))))

; --- Parse User-Agent header (allow any value, but validate format has a colon)
(declare-const ua_key String)
(declare-const ua_val String)
(assert (= ua_key (split_at line3 DCOLON 0)))
(assert (= ua_val (split_at line3 DCOLON 1)))
(assert (= ua_key "User-Agent"))
(assert (str.prefixof " " ua_val))

; Ensure header lines actually contain ':' by requiring at least 2 segments when split on ':'
(assert (>= (num_splits line1 DCOLON) 2))
(assert (>= (num_splits line2 DCOLON) 2))
(assert (>= (num_splits line3 DCOLON) 2))

; -------------------------------
; Additional diversity constraints (SAT-leaning core)
; -------------------------------

; Host value cannot contain CRLF
(assert (not (str.contains host_val DCRLF)))

; User-Agent value should contain at least one slash or space (typical tokens)
(assert (or (str.contains ua_val "/") (str.contains ua_val " ")))

; -------------------------------
; Embedded UNSAT instance (guarded)
; Toggle make_unsat to true to force contradiction.
; -------------------------------

(declare-const make_unsat Bool)

; Contradiction: if enabled, require method=GET but also require positive content-length and matching non-empty body.
(assert (=> make_unsat (and (= method "GET") (> cl_int 0))))
(assert (=> make_unsat (and (> (str.len body) 0) (= (str.len body) cl_int))))

; Also add an independent contradiction for demonstration: Host key must be Host and not Host.
(assert (=> make_unsat (and (= host_key "Host") (not (= host_key "Host")))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
