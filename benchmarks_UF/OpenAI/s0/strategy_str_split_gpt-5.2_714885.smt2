(set-logic ALL)

; Uninterpreted interface for str_split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Basic HTTP header parsing variables
(declare-const req String)
(declare-const request_line String)
(declare-const headers_block String)
(declare-const body String)

(declare-const host_line String)
(declare-const cl_line String)
(declare-const ua_line String)

(declare-const host_key String)
(declare-const host_value_raw String)
(declare-const host_value String)

(declare-const cl_key String)
(declare-const cl_value_raw String)
(declare-const cl_value_str String)
(declare-const content_length Int)

(declare-const ua_key String)
(declare-const ua_value_raw String)

(declare-const n_lines Int)
(declare-const body_len Int)

; Another set for an UNSAT variant within the same file (guarded)
(declare-const req_bad String)
(declare-const headers_block_bad String)
(declare-const body_bad String)
(declare-const cl_line_bad String)
(declare-const cl_value_str_bad String)
(declare-const content_length_bad Int)
(declare-const bad_case Bool)

; ---------------------------
; Structure: split request into lines by CRLF
; ---------------------------
(assert (= request_line (split_at req "\r\n" 0)))
(assert (= headers_block (split_rest req "\r\n" 1)))
(assert (>= (num_splits req "\r\n") 2))

; Request line sanity: "METHOD SP PATH SP HTTP/1.1"
(assert (str.contains request_line " HTTP/1.1"))
(assert (or (str.contains request_line "GET ") (str.contains request_line "POST ")))

; For header parsing, we assume the next few lines exist
(assert (= n_lines (num_splits headers_block "\r\n")))
(assert (>= n_lines 4))

; Extract three header lines (order fixed for this scenario)
(assert (= host_line (split_at headers_block "\r\n" 0)))
(assert (= cl_line (split_at headers_block "\r\n" 1)))
(assert (= ua_line (split_at headers_block "\r\n" 2)))

; Body is everything after a blank line separator "\r\n\r\n"
(assert (= body (split_at req "\r\n\r\n" 1)))
(assert (>= (num_splits req "\r\n\r\n") 2))
(assert (= body_len (str.len body)))

; ---------------------------
; Parse "Host: value"
; ---------------------------
(assert (= host_key (split_at host_line ":" 0)))
(assert (= host_value_raw (split_rest host_line ":" 1)))
(assert (= host_key "Host"))
; normalize by requiring a leading space before host value
(assert (str.prefixof " " host_value_raw))
(assert (= host_value (str.substr host_value_raw 1 (- (str.len host_value_raw) 1))))
(assert (>= (str.len host_value) 1))
(assert (not (str.contains host_value "\r")))
(assert (not (str.contains host_value "\n")))

; ---------------------------
; Parse "Content-Length: digits" and validate against body length
; ---------------------------
(assert (= cl_key (split_at cl_line ":" 0)))
(assert (= cl_value_raw (split_rest cl_line ":" 1)))
(assert (= cl_key "Content-Length"))
(assert (str.prefixof " " cl_value_raw))
(assert (= cl_value_str (str.substr cl_value_raw 1 (- (str.len cl_value_raw) 1))))

; digits-only constraint using regex
(assert (str.in_re cl_value_str (re.+ (re.range "0" "9"))))

; relate string digits to integer content_length (simple bounded mapping)
; We avoid full base-10 conversion by constraining a few common cases.
(assert (or
  (and (= cl_value_str "0") (= content_length 0))
  (and (= cl_value_str "1") (= content_length 1))
  (and (= cl_value_str "2") (= content_length 2))
  (and (= cl_value_str "3") (= content_length 3))
  (and (= cl_value_str "4") (= content_length 4))
  (and (= cl_value_str "5") (= content_length 5))
  (and (= cl_value_str "10") (= content_length 10))
  (and (= cl_value_str "11") (= content_length 11))
  (and (= cl_value_str "12") (= content_length 12))
  (and (= cl_value_str "20") (= content_length 20))
  (and (= cl_value_str "100") (= content_length 100))
))

(assert (>= content_length 0))
(assert (= content_length body_len))

; ---------------------------
; Parse "User-Agent: value" (optional validation)
; ---------------------------
(assert (= ua_key (split_at ua_line ":" 0)))
(assert (= ua_value_raw (split_rest ua_line ":" 1)))
(assert (= ua_key "User-Agent"))
(assert (str.prefixof " " ua_value_raw))
(assert (>= (str.len ua_value_raw) 2))
(assert (not (str.contains ua_value_raw "\r")))
(assert (not (str.contains ua_value_raw "\n")))

; Additional header formatting constraints
(assert (str.contains host_line ":"))
(assert (str.contains cl_line ":"))
(assert (str.contains ua_line ":"))
(assert (< (str.len host_line) 200))
(assert (< (str.len cl_line) 200))
(assert (< (str.len ua_line) 400))

; ---------------------------
; SAT instance witness (pin down a concrete request)
; ---------------------------
(assert (= req (str.++
  "POST /submit HTTP/1.1\r\n"
  "Host: example.com\r\n"
  "Content-Length: 5\r\n"
  "User-Agent: test-agent\r\n"
  "\r\n"
  "abcde")))

; ---------------------------
; UNSAT variant guarded by bad_case
; If bad_case is true, enforce a contradictory content-length vs body length.
; ---------------------------
(assert (= req_bad (str.++
  "POST /submit HTTP/1.1\r\n"
  "Host: example.com\r\n"
  "Content-Length: 4\r\n"
  "User-Agent: test-agent\r\n"
  "\r\n"
  "abcde")))
(assert (= headers_block_bad (split_rest req_bad "\r\n" 1)))
(assert (= cl_line_bad (split_at headers_block_bad "\r\n" 1)))
(assert (= body_bad (split_at req_bad "\r\n\r\n" 1)))
(assert (=> bad_case (= cl_value_str_bad (str.substr (split_rest cl_line_bad ":" 1) 1 (- (str.len (split_rest cl_line_bad ":" 1)) 1)))))
(assert (=> bad_case (str.in_re cl_value_str_bad (re.+ (re.range "0" "9")))) )
(assert (=> bad_case (or
  (and (= cl_value_str_bad "0") (= content_length_bad 0))
  (and (= cl_value_str_bad "1") (= content_length_bad 1))
  (and (= cl_value_str_bad "2") (= content_length_bad 2))
  (and (= cl_value_str_bad "3") (= content_length_bad 3))
  (and (= cl_value_str_bad "4") (= content_length_bad 4))
  (and (= cl_value_str_bad "5") (= content_length_bad 5))
)))
(assert (=> bad_case (= content_length_bad (str.len body_bad))))
; Force the bad case and also force the known mismatch: body is length 5 but header says 4
(assert (= bad_case true))
(assert (=> bad_case (= cl_value_str_bad "4")))
(assert (=> bad_case (= (str.len body_bad) 5)))

(check-sat)


; [GENERATION STATUS: SUCCESS]