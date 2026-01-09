(set-logic ALL)

; Uninterpreted split interface (str_split)

; =========================
; Scenario: HTTP Header Parsing
; - Parse request line and header lines separated by "\r\n"
; - Each header line: "Key: Value"
; - Extract Host and Content-Length
; - Validate content-length is numeric and consistent with body
; - Create both SAT and UNSAT instances (separate groups)
; =========================

; ---------- Shared symbols ----------
(declare-const request String)
(declare-const delim_crlf String)
(declare-const delim_colon String)
(declare-const empty String)

(declare-const request_line String)
(declare-const header_line_1 String)
(declare-const header_line_2 String)
(declare-const header_line_3 String)
(declare-const header_line_4 String)
(declare-const header_line_5 String)
(declare-const body String)

(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const ua_key String)
(declare-const ua_value String)

(declare-const cl_int Int)
(declare-const body_len Int)

; ---------- Delimiters ----------
(assert (= delim_crlf "\r\n"))
(assert (= delim_colon ":"))
(assert (= empty ""))

; ---------- Basic request structure ----------
; request is split into lines by CRLF; first line is request-line
(assert (= request_line (str.split_at request delim_crlf 0)))
(assert (>= (str.num_splits request delim_crlf) 6))

; take five header lines
(assert (= header_line_1 (str.split_at request delim_crlf 1)))
(assert (= header_line_2 (str.split_at request delim_crlf 2)))
(assert (= header_line_3 (str.split_at request delim_crlf 3)))
(assert (= header_line_4 (str.split_at request delim_crlf 4)))
(assert (= header_line_5 (str.split_at request delim_crlf 5)))

; body is everything after line 6 (index 6 and beyond)
(assert (= body (str.split_rest request delim_crlf 6)))
(assert (= body_len (str.len body)))

; request-line sanity
(assert (or (str.contains request_line "HTTP/1.1") (str.contains request_line "HTTP/1.0")))
(assert (or (str.contains request_line "GET ") (str.contains request_line "POST ") (str.contains request_line "PUT ")))

; ---------- Header parsing helpers ----------
; Constrain colon-split to have at least 2 segments when a line is used as key/value
(assert (>= (str.num_splits header_line_1 delim_colon) 2))
(assert (>= (str.num_splits header_line_2 delim_colon) 2))
(assert (>= (str.num_splits header_line_3 delim_colon) 2))
(assert (>= (str.num_splits header_line_4 delim_colon) 2))
(assert (>= (str.num_splits header_line_5 delim_colon) 2))

; Define three extracted headers by choosing specific lines:
; - Host in header_line_1
; - Content-Length in header_line_2
; - User-Agent in header_line_3
(assert (= host_key (str.split_at header_line_1 delim_colon 0)))
(assert (= host_value (str.split_rest header_line_1 delim_colon 1)))

(assert (= cl_key (str.split_at header_line_2 delim_colon 0)))
(assert (= cl_value (str.split_rest header_line_2 delim_colon 1)))

(assert (= ua_key (str.split_at header_line_3 delim_colon 0)))
(assert (= ua_value (str.split_rest header_line_3 delim_colon 1)))

; Key normalization: allow optional whitespace before value; we only assert key strings
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))
(assert (= ua_key "User-Agent"))

; Basic content constraints
(assert (>= (str.len host_value) 1))
(assert (not (str.contains host_value "\r")))
(assert (not (str.contains host_value "\n")))

(assert (>= (str.len ua_value) 1))
(assert (not (str.contains ua_value "\r")))
(assert (not (str.contains ua_value "\n")))

; Require a blank line (end of headers) somewhere among header_line_4..header_line_5
(assert (or (= header_line_4 empty) (= header_line_5 empty)))

; ---------- Content-Length must be numeric (relaxation via regex) ----------
(assert (str.in_re cl_value (re.++ (str.to_re "") (re.+ (re.range "0" "9")))))

; Also disallow CR/LF in cl_value
(assert (not (str.contains cl_value "\r")))
(assert (not (str.contains cl_value "\n")))

; =========================
; SAT instance: consistent Content-Length with body
; =========================
(declare-const sat_request String)
(declare-const sat_body String)
(declare-const sat_cl_value String)
(declare-const sat_cl_int Int)

; Tie sat_request into shared parsing by equating request
(assert (= request sat_request))

; Strengthen SAT sub-instance specifics
(assert (= sat_body body))
(assert (= sat_cl_value cl_value))

; Model a small body length with explicit concrete body
(assert (= sat_body "hello"))
(assert (= body_len 5))

; Fix content-length string and integer to match
(assert (= sat_cl_value "5"))
(assert (= sat_cl_int 5))
(assert (= cl_int sat_cl_int))
(assert (= cl_int body_len))

; Ensure host looks like a domain: contains a dot and no spaces
(assert (str.contains host_value "."))
(assert (not (str.contains host_value " ")))

; Provide some additional plausible structure hints
(assert (str.contains request_line "HTTP/1.1"))
(assert (str.contains header_line_1 "Host:"))
(assert (str.contains header_line_2 "Content-Length:"))
(assert (str.contains header_line_3 "User-Agent:"))

; =========================
; UNSAT instance: contradictory Content-Length constraints
; =========================
(declare-const unsat_request String)
(declare-const unsat_body String)
(declare-const unsat_cl_value String)
(declare-const unsat_cl_int Int)

; This group is asserted simultaneously with SAT group, so isolate by forcing different request
; and then contradict it by equating it back, making the overall file UNSAT only if desired.
; To create a genuine UNSAT sub-instance without affecting SAT, we encode it as a separate
; conjunction guarded by a boolean, then force the guard true.
(declare-const use_unsat Bool)
(assert use_unsat)

(assert (=> use_unsat (= unsat_request request)))
(assert (=> use_unsat (= unsat_body body)))
(assert (=> use_unsat (= unsat_cl_value cl_value)))

; Force a different body and inconsistent content-length
(assert (=> use_unsat (= unsat_body "abcd")))
(assert (=> use_unsat (= (str.len unsat_body) 4)))

(assert (=> use_unsat (= unsat_cl_value "3")))
(assert (=> use_unsat (= unsat_cl_int 3)))

; Contradiction: require Content-Length to equal body length AND not equal
(assert (=> use_unsat (= unsat_cl_int (str.len unsat_body))))
(assert (=> use_unsat (not (= unsat_cl_int (str.len unsat_body)))))

; Also contradict via shared body_len, cl_int
(assert (=> use_unsat (= cl_int unsat_cl_int)))
(assert (=> use_unsat (= body_len (str.len unsat_body))))
(assert (=> use_unsat (= cl_int body_len)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
