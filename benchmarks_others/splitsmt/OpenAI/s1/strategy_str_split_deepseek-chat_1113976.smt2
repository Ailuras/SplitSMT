(set-logic ALL)

; --- Uninterpreted interface operations: str_split ---

; --- HTTP header parsing variables ---
(declare-const request String)
(declare-const header_block String)
(declare-const line0 String)
(declare-const line1 String)
(declare-const host_key String)
(declare-const host_val String)
(declare-const cl_key String)
(declare-const cl_val String)
(declare-const content_len Int)
(declare-const body String)

; Mutated seed core structure: keep a simple contradictory-free string-length fact
(assert (not (not (= (str.len "") 0))))

; Split request into headers and body at CRLFCRLF
(assert (= header_block (str.split_at request "\r\n\r\n" 0)))
(assert (= body (str.split_at request "\r\n\r\n" 1)))
(assert (>= (str.num_splits request "\r\n\r\n") 2))

; Split header block into lines at CRLF
(assert (>= (str.num_splits header_block "\r\n") 3))
(assert (= line0 (str.split_at header_block "\r\n" 0)))
(assert (= line1 (str.split_at header_block "\r\n" 1)))

; Parse line0 as Host: <value>
(assert (= host_key (str.split_at line0 ":" 0)))
(assert (= host_val (str.split_rest line0 ":" 1)))
(assert (= host_key "Host"))
(assert (not (str.contains host_val "\r")))
(assert (not (str.contains host_val "\n")))
(assert (not (str.contains host_val ":")))
(assert (>= (str.len host_val) 1))

; Parse line1 as Content-Length: <digits>
(assert (= cl_key (str.split_at line1 ":" 0)))
(assert (= cl_val (str.split_rest line1 ":" 1)))
(assert (= cl_key "Content-Length"))

; Content-Length value must be numeric digits only (non-empty)
(assert (str.in_re cl_val (re.++ (str.to_re "") (re.+ (re.range "0" "9")))))

; Relate the numeric value to body length (simple integer binding)
(assert (>= content_len 0))
(assert (= (str.len body) content_len))

; Additional sanity: no embedded CRLF in individual header lines
(assert (not (str.contains line0 "\r\n")))
(assert (not (str.contains line1 "\r\n")))

; --- Make this instance UNSAT: contradict Content-Length with body length ---
(assert (= content_len (+ (str.len body) 1)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
