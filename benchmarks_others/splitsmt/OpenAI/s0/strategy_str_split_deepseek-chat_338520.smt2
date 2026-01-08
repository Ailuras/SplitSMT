(set-logic ALL)

; Uninterpreted interface operations for string splitting

; =========================
; SAT instance: well-formed HTTP headers with Content-Length validation
; =========================
(declare-const req_headers String)
(declare-const line0 String)
(declare-const line1 String)
(declare-const line2 String)
(declare-const line3 String)
(declare-const host_key String)
(declare-const host_val String)
(declare-const cl_key String)
(declare-const cl_val String)
(declare-const ua_key String)
(declare-const ua_val String)
(declare-const accept_key String)
(declare-const accept_val String)
(declare-const body String)
(declare-const content_length Int)
(declare-const total_lines Int)

; Split header block into lines by LF
(assert (= total_lines (str.num_splits req_headers "\n")))
(assert (>= total_lines 4))
(assert (= line0 (str.split_at req_headers "\n" 0)))
(assert (= line1 (str.split_at req_headers "\n" 1)))
(assert (= line2 (str.split_at req_headers "\n" 2)))
(assert (= line3 (str.split_at req_headers "\n" 3)))

; Each header line is key: value (colon + single space)
(assert (= host_key (str.split_at line0 ": " 0)))
(assert (= host_val (str.split_at line0 ": " 1)))
(assert (= cl_key   (str.split_at line1 ": " 0)))
(assert (= cl_val   (str.split_at line1 ": " 1)))
(assert (= ua_key   (str.split_at line2 ": " 0)))
(assert (= ua_val   (str.split_at line2 ": " 1)))
(assert (= accept_key (str.split_at line3 ": " 0)))
(assert (= accept_val (str.split_at line3 ": " 1)))

; Ensure there is exactly one split for ": " in each line (i.e., 2 segments)
(assert (= (str.num_splits line0 ": ") 2))
(assert (= (str.num_splits line1 ": ") 2))
(assert (= (str.num_splits line2 ": ") 2))
(assert (= (str.num_splits line3 ": ") 2))

; Header keys are expected
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))
(assert (= ua_key "User-Agent"))
(assert (= accept_key "Accept"))

; Basic non-emptiness and sanity for values
(assert (>= (str.len host_val) 1))
(assert (>= (str.len ua_val) 1))
(assert (>= (str.len accept_val) 1))

; Model Content-Length numerically and validate it matches the body length
(assert (>= content_length 0))
(assert (= (str.len body) content_length))

; Tie cl_val to a specific decimal rendering to avoid needing str.to_int
(assert (= cl_val "5"))
(assert (= content_length 5))

; Concrete but still flexible structure for the whole header block
(assert (= req_headers (str.++ line0 "\n" line1 "\n" line2 "\n" line3 "\n")))

; Example value constraints to keep it realistic
(assert (str.contains host_val "."))
(assert (str.contains ua_val "/"))
(assert (or (= accept_val "*/*") (str.contains accept_val "/")))

; =========================
; UNSAT instance: contradictory Content-Length constraints
; Uses separate variables to avoid interfering with the SAT instance
; =========================
(declare-const req_headers_bad String)
(declare-const bad_line0 String)
(declare-const bad_line1 String)
(declare-const bad_cl_key String)
(declare-const bad_cl_val String)
(declare-const bad_body String)
(declare-const bad_len Int)

(assert (>= (str.num_splits req_headers_bad "\n") 2))
(assert (= bad_line0 (str.split_at req_headers_bad "\n" 0)))
(assert (= bad_line1 (str.split_at req_headers_bad "\n" 1)))

(assert (= (str.num_splits bad_line1 ": ") 2))
(assert (= bad_cl_key (str.split_at bad_line1 ": " 0)))
(assert (= bad_cl_val (str.split_at bad_line1 ": " 1)))
(assert (= bad_cl_key "Content-Length"))

; Force the textual value to be "5" but make the numeric and body inconsistent
(assert (= bad_cl_val "5"))
(assert (= bad_len 5))
(assert (= (str.len bad_body) bad_len))
(assert (= (str.len bad_body) 4))

; Also provide a minimal structure so the split variables are coherent
(assert (= req_headers_bad (str.++ bad_line0 "\n" bad_line1 "\n")))
(assert (= bad_line0 "Host: example.com"))
(assert (= bad_line1 "Content-Length: 5"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
