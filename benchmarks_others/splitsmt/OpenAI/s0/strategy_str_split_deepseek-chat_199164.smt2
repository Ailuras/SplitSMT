(set-logic ALL)

; Uninterpreted interface functions for str_split

; Uninterpreted helper functions (non-primitive)
(declare-fun to_int (String) Int)
(declare-fun is_digits (String) Bool)

; ----------------------------
; SAT instance: well-formed HTTP header parsing
; ----------------------------
(declare-const req String)
(declare-const request_line String)
(declare-const headers_block String)
(declare-const method String)
(declare-const path String)
(declare-const version String)

(declare-const host_line String)
(declare-const host_key String)
(declare-const host_value String)

(declare-const cl_line String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const content_length Int)

(declare-const ua_line String)
(declare-const ua_key String)
(declare-const ua_value String)

; Split request into lines by newline "\n": request-line then headers
(assert (>= (str.num_splits req "\n") 4))
(assert (= request_line (str.split_at req "\n" 0)))
(assert (= headers_block (str.split_rest req "\n" 1)))

; Parse request line by spaces: METHOD SP PATH SP VERSION
(assert (>= (str.num_splits request_line " ") 3))
(assert (= method (str.split_at request_line " " 0)))
(assert (= path (str.split_at request_line " " 1)))
(assert (= version (str.split_at request_line " " 2)))

; Simple validation for request line parts
(assert (or (= method "GET") (= method "POST")))
(assert (str.prefixof "/" path))
(assert (or (= version "HTTP/1.1") (= version "HTTP/1.0")))

; Constrain first three header lines to be of form Key:Value
(assert (= host_line (str.split_at req "\n" 1)))
(assert (= cl_line   (str.split_at req "\n" 2)))
(assert (= ua_line   (str.split_at req "\n" 3)))

; Parse Host header
(assert (>= (str.num_splits host_line ":") 2))
(assert (= host_key (str.split_at host_line ":" 0)))
(assert (= host_value (str.split_rest host_line ":" 1)))
(assert (= host_key "Host"))
(assert (> (str.len host_value) 0))
(assert (not (str.contains host_value "\n")))

; Parse Content-Length header
(assert (>= (str.num_splits cl_line ":") 2))
(assert (= cl_key (str.split_at cl_line ":" 0)))
(assert (= cl_value (str.split_rest cl_line ":" 1)))
(assert (= cl_key "Content-Length"))

; Validate Content-Length numeric content
(assert (is_digits cl_value))
(assert (= content_length (to_int cl_value)))
(assert (>= content_length 0))
(assert (<= content_length 1000000))

; Parse User-Agent header
(assert (>= (str.num_splits ua_line ":") 2))
(assert (= ua_key (str.split_at ua_line ":" 0)))
(assert (= ua_value (str.split_rest ua_line ":" 1)))
(assert (= ua_key "User-Agent"))
(assert (> (str.len ua_value) 0))

; Additional consistency checks: keys are non-empty, no newline embedded in a single header line
(assert (> (str.len host_key) 0))
(assert (> (str.len cl_key) 0))
(assert (> (str.len ua_key) 0))
(assert (not (str.contains host_line "\n")))
(assert (not (str.contains cl_line "\n")))
(assert (not (str.contains ua_line "\n")))

; Ensure the header block actually contains the three lines in order (lightweight containment constraints)
(assert (str.contains headers_block host_line))
(assert (str.contains headers_block cl_line))
(assert (str.contains headers_block ua_line))

; ----------------------------
; UNSAT instance: contradictory Content-Length requirements on same line
; ----------------------------
(declare-const req_bad String)
(declare-const cl_bad_line String)
(declare-const cl_bad_key String)
(declare-const cl_bad_value String)
(declare-const cl_bad_int Int)

(assert (>= (str.num_splits req_bad "\n") 2))
(assert (= cl_bad_line (str.split_at req_bad "\n" 1)))
(assert (>= (str.num_splits cl_bad_line ":") 2))
(assert (= cl_bad_key (str.split_at cl_bad_line ":" 0)))
(assert (= cl_bad_value (str.split_rest cl_bad_line ":" 1)))
(assert (= cl_bad_key "Content-Length"))
(assert (is_digits cl_bad_value))
(assert (= cl_bad_int (to_int cl_bad_value)))

; Contradiction: Content-Length must be both 0 and 1
(assert (= cl_bad_int 0))
(assert (= cl_bad_int 1))

(check-sat)


; [GENERATION STATUS: SUCCESS]
