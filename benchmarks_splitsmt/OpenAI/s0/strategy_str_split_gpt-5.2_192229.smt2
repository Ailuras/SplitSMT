(set-logic ALL)

; Uninterpreted interface: str_split

; -----------------------------
; Scenario: HTTP Header Parsing
; -----------------------------

; Common delimiters
(declare-const delim_crlf String)
(declare-const delim_colon String)
(assert (= delim_crlf "\r\n"))
(assert (= delim_colon ":"))

; Whole HTTP header block (request-line + headers + blank line + optional body)
(declare-const http_blob String)

; Split request into lines
(declare-const request_line String)
(declare-const line_host String)
(declare-const line_content_length String)
(declare-const line_user_agent String)
(declare-const line_blank_or_rest String)

(assert (>= (str.num_splits http_blob delim_crlf) 4))
(assert (= request_line (str.split_at http_blob delim_crlf 0)))
(assert (= line_host (str.split_at http_blob delim_crlf 1)))
(assert (= line_content_length (str.split_at http_blob delim_crlf 2)))
(assert (= line_user_agent (str.split_at http_blob delim_crlf 3)))
(assert (= line_blank_or_rest (str.split_rest http_blob delim_crlf 4)))

; Request line basic structure: METHOD SP PATH SP HTTP/VERSION
(declare-const method String)
(declare-const path String)
(declare-const version String)
(assert (= method (str.split_at request_line " " 0)))
(assert (= path (str.split_at request_line " " 1)))
(assert (= version (str.split_at request_line " " 2)))
(assert (>= (str.num_splits request_line " ") 3))

; Constrain method/version to plausible forms
(assert (or (= method "GET") (= method "POST")))
(assert (str.in_re version (str.to_re "HTTP/1.1")))

; -----------------------------
; SAT parsing/validation branch
; -----------------------------

; Parse Host header: "Host: <value>"
(declare-const host_key String)
(declare-const host_value String)
(assert (>= (str.num_splits line_host delim_colon) 2))
(assert (= host_key (str.split_at line_host delim_colon 0)))
(assert (= host_value (str.split_rest line_host delim_colon 1)))

; Parse Content-Length header: "Content-Length: <digits>"
(declare-const cl_key String)
(declare-const cl_value_raw String)
(declare-const cl_value String)
(assert (>= (str.num_splits line_content_length delim_colon) 2))
(assert (= cl_key (str.split_at line_content_length delim_colon 0)))
(assert (= cl_value_raw (str.split_rest line_content_length delim_colon 1)))

; Normalize by requiring a leading space before the value and then extracting digits
; Example: cl_value_raw == " 123"
(assert (>= (str.len cl_value_raw) 2))
(assert (= (str.at cl_value_raw 0) " "))
(assert (= cl_value (str.substr cl_value_raw 1 (- (str.len cl_value_raw) 1))))

; Digit regex for Content-Length
(define-fun re_digit () RegLan (re.range "0" "9"))
(define-fun re_digits_plus () RegLan (re.++ (re.range "0" "9") (re.* (re.range "0" "9"))))
(assert (str.in_re cl_value re_digits_plus))

; Convert Content-Length string to Int via str.to_int, require it is defined (not -1)
(declare-const content_length Int)
(assert (= content_length (str.to_int cl_value)))
(assert (>= content_length 0))

; Parse User-Agent similarly, but allow any non-empty value after ":"
(declare-const ua_key String)
(declare-const ua_value_raw String)
(declare-const ua_value String)
(assert (>= (str.num_splits line_user_agent delim_colon) 2))
(assert (= ua_key (str.split_at line_user_agent delim_colon 0)))
(assert (= ua_value_raw (str.split_rest line_user_agent delim_colon 1)))
(assert (>= (str.len ua_value_raw) 2))
(assert (= (str.at ua_value_raw 0) " "))
(assert (= ua_value (str.substr ua_value_raw 1 (- (str.len ua_value_raw) 1))))
(assert (>= (str.len ua_value) 1))

; Keys match expected names
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))
(assert (= ua_key "User-Agent"))

; Host value sanity: require it contains a dot and no CRLF
(assert (str.contains host_value "."))
(assert (not (str.contains host_value delim_crlf)))

; Body begins after the blank line; enforce that there is a blank line and a body segment exists
; Require the remainder to start with CRLF (i.e., empty line) then body
(declare-const rest_after_headers String)
(declare-const body String)
(assert (= rest_after_headers line_blank_or_rest))

; For simplicity, require rest_after_headers begins with "\r\n" then body
(assert (>= (str.len rest_after_headers) 2))
(assert (= (str.substr rest_after_headers 0 2) delim_crlf))
(assert (= body (str.substr rest_after_headers 2 (- (str.len rest_after_headers) 2))))

; Validate Content-Length equals actual body length (SAT instance)
(assert (= content_length (str.len body)))

; Additional plausibility: path starts with '/'
(assert (>= (str.len path) 1))
(assert (= (str.at path 0) "/"))

; -----------------------------
; UNSAT sub-instance (guarded)
; Mix in an explicit contradictory requirement to create an UNSAT branch,
; but guard it with a boolean that is asserted false for overall SAT.
; This demonstrates both SAT/UNSAT patterns in one file.
; -----------------------------

(declare-const enable_unsat_branch Bool)
(assert (= enable_unsat_branch false))

; Contradiction: if enabled, force content_length to differ from body length
(assert (=> enable_unsat_branch (not (= content_length (str.len body)))))

; Another contradiction: if enabled, require Content-Length value to be non-digits
(assert (=> enable_unsat_branch (not (str.in_re cl_value re_digits_plus))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
