(set-logic ALL)

; HTTP Header Parsing via str_split: key:value lines separated by CRLF, validate Content-Length

; --- Uninterpreted interface functions (str_split) ---

; --- Helper uninterpreted functions for non-primitive operations ---
(declare-fun trim (String) String)
(declare-fun to_int (String) Int)

; --- Core strings ---
(declare-const request String)
(declare-const header_block String)
(declare-const body String)
(declare-const crlf String)
(declare-const colon String)

; --- Header lines ---
(declare-const line0 String)
(declare-const line1 String)
(declare-const line2 String)
(declare-const line3 String)

; --- Parsed key/value for line1 (Content-Length) ---
(declare-const cl_key_raw String)
(declare-const cl_val_raw String)
(declare-const cl_key String)
(declare-const cl_val_str String)
(declare-const content_length Int)

; --- Parsed key/value for line2 (Host) ---
(declare-const host_key_raw String)
(declare-const host_val_raw String)
(declare-const host_key String)
(declare-const host_val String)

; --- Parsed key/value for line3 (User-Agent) ---
(declare-const ua_key_raw String)
(declare-const ua_val_raw String)
(declare-const ua_key String)
(declare-const ua_val String)

; --- Digits regex for numeric validation ---
(declare-const re_digits RegLan)

(assert (= crlf "\r\n"))
(assert (= colon ":"))
(assert (= re_digits (re.+ (re.range "0" "9"))))

; Request split into header block and body by double CRLF
(assert (= header_block (str.split_at request (str.++ crlf crlf) 0)))
(assert (= body (str.split_at request (str.++ crlf crlf) 1)))
(assert (>= (str.num_splits request (str.++ crlf crlf)) 2))

; Header block consists of at least 4 CRLF-separated lines
(assert (>= (str.num_splits header_block crlf) 4))
(assert (= line0 (str.split_at header_block crlf 0)))
(assert (= line1 (str.split_at header_block crlf 1)))
(assert (= line2 (str.split_at header_block crlf 2)))
(assert (= line3 (str.split_at header_block crlf 3)))

; Request line sanity: "METHOD SP URI SP HTTP/1.1"
(assert (str.contains line0 "HTTP/1.1"))
(assert (str.contains line0 " "))

; ---- Parse Content-Length header line1: key:value ----
(assert (>= (str.num_splits line1 colon) 2))
(assert (= cl_key_raw (str.split_at line1 colon 0)))
(assert (= cl_val_raw (str.split_rest line1 colon 1)))
(assert (= cl_key (trim cl_key_raw)))
(assert (= cl_val_str (trim cl_val_raw)))

; Must be Content-Length
(assert (= cl_key "Content-Length"))

; Numeric validation of content-length
(assert (str.in_re cl_val_str re_digits))
(assert (= content_length (to_int cl_val_str)))
(assert (>= content_length 0))

; Body length must match Content-Length
(assert (= (str.len body) content_length))

; ---- Parse Host header line2 ----
(assert (>= (str.num_splits line2 colon) 2))
(assert (= host_key_raw (str.split_at line2 colon 0)))
(assert (= host_val_raw (str.split_rest line2 colon 1)))
(assert (= host_key (trim host_key_raw)))
(assert (= host_val (trim host_val_raw)))
(assert (= host_key "Host"))
(assert (>= (str.len host_val) 1))
(assert (not (str.contains host_val " ")))

; ---- Parse User-Agent header line3 ----
(assert (>= (str.num_splits line3 colon) 2))
(assert (= ua_key_raw (str.split_at line3 colon 0)))
(assert (= ua_val_raw (str.split_rest line3 colon 1)))
(assert (= ua_key (trim ua_key_raw)))
(assert (= ua_val (trim ua_val_raw)))
(assert (= ua_key "User-Agent"))
(assert (>= (str.len ua_val) 1))

; --- SAT instance: enforce an example-like structure but allow variability ---
(assert (str.prefixof "POST " line0))
(assert (str.contains line0 " /upload "))
(assert (str.contains ua_val "Mozilla"))

; Ensure header block equals concatenation of the four lines separated by CRLF
(assert (= header_block (str.++ line0 crlf line1 crlf line2 crlf line3)))

(check-sat)

; =========================
; Additional UNSAT instance in the same file using push/pop
; Conflicting constraints: body length must equal Content-Length and also differ
; =========================

(declare-const forced_len Int)
(assert (= forced_len (+ content_length 1)))
(assert (= (str.len body) forced_len))

(check-sat)
(exit)
