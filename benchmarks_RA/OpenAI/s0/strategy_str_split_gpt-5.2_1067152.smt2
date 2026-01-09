(set-logic ALL)

; HTTP Header Parsing via str_split: key:value lines separated by CRLF, validate Content-Length

; --- Uninterpreted interface functions (str_split) ---
(define-const delta String "\u{2FFFF}")

(define-fun convert_for_split ((s String) (sep String)) String
  (str.replace_all s sep delta))

(define-fun count_matches ((s String)) Int
  (ite (= (str.len s) 0) 0
    (let ((len_s (str.len s))
          (len_removed (str.len (str.replace_all s delta ""))))
      (- len_s len_removed))))

(define-fun-rec nth_match_start ((s String) (n Int) (from Int)) Int
  (ite (<= n 0) (- 1)
    (let ((p (str.indexof s delta from)))
      (ite (= n 1) p
        (nth_match_start s (- n 1) (+ p (str.len delta)))))))

(define-fun split_at ((s String) (sep String) (k Int)) String
  (ite (or (< k 0) (= (str.len sep) 0)) ""
    (let ((tmp (convert_for_split s sep)))
      (let ((num (+ 1 (count_matches tmp))))
        (ite (>= k num) ""
          (let ((start_match_k (nth_match_start tmp k 0)))
            (let ((start_k (ite (= k 0) (- 1) start_match_k)))
              (let ((start_match_next (nth_match_start tmp (+ k 1) 0)))
                (let ((end_k (ite (= start_match_next (- 1))
                                  (str.len tmp)
                                  start_match_next)))
                  (ite (< end_k start_k)
                    (str.substr tmp (+ start_k 1) (- (str.len tmp) start_k 1))
                    (str.substr tmp (+ start_k 1) (- end_k start_k 1))))))))))))

(define-fun-rec replace_iter ((s String) (sep String) (i Int)) String
  (ite (<= i 0) s
    (replace_iter (str.replace s sep delta) sep (- i 1))))

(define-fun split_rest ((s String) (sep String) (k Int)) String
  (ite (or (< k 0) (= (str.len sep) 0)) ""
    (let ((tmp (convert_for_split s sep)))
      (let ((num (count_matches tmp)))
        (ite (< num k) ""
          (let ((s_iter (replace_iter s sep k)))
            (let ((start_match_k (nth_match_start s_iter k 0)))
              (let ((lens (str.len s_iter)))
                (ite (< start_match_k 0) s
                  (str.substr s_iter (+ start_match_k 1)
                              (- lens start_match_k 1)))))))))))

(define-fun num_splits ((s String) (sep String)) Int
  (let ((tmp (convert_for_split s sep)))
    (+ 1 (count_matches tmp))))

(define-fun convert_for_split_re ((s String) (r (RegEx String))) String
  (str.replace_re_all s r delta))

(define-fun-rec replace_iter_re ((s String) (r (RegEx String)) (i Int)) String
  (ite (<= i 0) s
    (replace_iter_re (str.replace_re s r delta) r (- i 1))))

(define-fun split_at_re ((s String) (r (RegEx String)) (k Int)) String
  (ite (< k 0) ""
    (let ((tmp (convert_for_split_re s r)))
      (let ((num (+ 1 (count_matches tmp))))
        (ite (>= k num) ""
          (let ((start_match_k (nth_match_start tmp k 0)))
            (let ((start_k (ite (= k 0) (- 1) start_match_k)))
              (let ((start_match_next (nth_match_start tmp (+ k 1) 0)))
                (let ((end_k (ite (= start_match_next (- 1))
                                  (str.len tmp)
                                  start_match_next)))
                  (ite (< end_k start_k)
                    (str.substr tmp (+ start_k 1) (- (str.len tmp) start_k 1))
                    (str.substr tmp (+ start_k 1) (- end_k start_k 1))))))))))))

(define-fun split_rest_re ((s String) (r (RegEx String)) (k Int)) String
  (ite (< k 0) ""
    (let ((tmp (convert_for_split_re s r)))
      (let ((num (count_matches tmp)))
        (ite (< num k) ""
          (let ((s_iter (replace_iter_re s r k)))
            (let ((start_match_k (nth_match_start s_iter k 0)))
              (let ((lens (str.len s_iter)))
                (ite (< start_match_k 0) s
                  (str.substr s_iter (+ start_match_k 1)
                              (- lens start_match_k 1)))))))))))

(define-fun num_splits_re ((s String) (r (RegEx String))) Int
  (let ((tmp (convert_for_split_re s r)))
    (+ 1 (count_matches tmp))))

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
(assert (= header_block (split_at request (str.++ crlf crlf) 0)))
(assert (= body (split_at request (str.++ crlf crlf) 1)))
(assert (>= (num_splits request (str.++ crlf crlf)) 2))

; Header block consists of at least 4 CRLF-separated lines
(assert (>= (num_splits header_block crlf) 4))
(assert (= line0 (split_at header_block crlf 0)))
(assert (= line1 (split_at header_block crlf 1)))
(assert (= line2 (split_at header_block crlf 2)))
(assert (= line3 (split_at header_block crlf 3)))

; Request line sanity: "METHOD SP URI SP HTTP/1.1"
(assert (str.contains line0 "HTTP/1.1"))
(assert (str.contains line0 " "))

; ---- Parse Content-Length header line1: key:value ----
(assert (>= (num_splits line1 colon) 2))
(assert (= cl_key_raw (split_at line1 colon 0)))
(assert (= cl_val_raw (split_rest line1 colon 1)))
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
(assert (>= (num_splits line2 colon) 2))
(assert (= host_key_raw (split_at line2 colon 0)))
(assert (= host_val_raw (split_rest line2 colon 1)))
(assert (= host_key (trim host_key_raw)))
(assert (= host_val (trim host_val_raw)))
(assert (= host_key "Host"))
(assert (>= (str.len host_val) 1))
(assert (not (str.contains host_val " ")))

; ---- Parse User-Agent header line3 ----
(assert (>= (num_splits line3 colon) 2))
(assert (= ua_key_raw (split_at line3 colon 0)))
(assert (= ua_val_raw (split_rest line3 colon 1)))
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
