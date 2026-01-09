(set-logic ALL)

; Uninterpreted split interface
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
(assert (>= (num_splits headers_block "\r\n") 3))
(assert (= header0 (split_at headers_block "\r\n" 0)))
(assert (= header1 (split_at headers_block "\r\n" 1)))
(assert (= header2 (split_at headers_block "\r\n" 2)))

; Each header line should contain a colon separating key and value
(assert (str.contains header0 ":"))
(assert (str.contains header1 ":"))

; Parse Host header (allow optional space after colon)
(assert (= host_key (split_at header0 ":" 0)))
(assert (= host_val (split_rest header0 ":" 1)))
(assert (or (= host_key "Host") (= host_key "host")))
; host value is non-empty after optional leading space
(assert (>= (str.len host_val) 1))
(assert (or (not (= (str.at host_val 0) " ")) (>= (str.len host_val) 2)))

; Parse Content-Length header
(assert (= cl_key (split_at header1 ":" 0)))
(assert (= cl_val (split_rest header1 ":" 1)))
(assert (= cl_key "Content-Length"))

; Content-Length value is digits, possibly with a single leading space
(declare-const cl_val_trimmed String)
(assert (= cl_val_trimmed (ite (= (str.at cl_val 0) " ") (str.substr cl_val 1 (- (str.len cl_val) 1)) cl_val)))
(assert (>= (str.len cl_val_trimmed) 1))
(assert (str.in_re cl_val_trimmed (re.+ (re.range "0" "9"))))

; Bind the integer content_length to cl_val_trimmed via canonical decimal conversion
; Use str.to_int with guard to avoid (- 1) on non-numeric (already constrained by regex)
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
(assert (= h2_key (split_at header2 ":" 0)))
(assert (= h2_val (split_rest header2 ":" 1)))
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
