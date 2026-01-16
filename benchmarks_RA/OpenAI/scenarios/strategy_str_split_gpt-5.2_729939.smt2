(set-logic ALL)
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

; Uninterpreted split interface for header parsing

; =========================
; SAT instance: well-formed HTTP header parsing
; =========================

(declare-const header1 String)
(declare-const request_line1 String)
(declare-const line1_1 String)
(declare-const line1_2 String)
(declare-const line1_3 String)
(declare-const line1_4 String)
(declare-const host_kv1 String)
(declare-const clen_kv1 String)
(declare-const body1 String)
(declare-const host_key1 String)
(declare-const host_val1 String)
(declare-const clen_key1 String)
(declare-const clen_val1 String)
(declare-const content_length1 Int)

; Shape: request-line + header lines separated by \r\n, blank line, then body
(assert (= request_line1 (split_at header1 "\r\n" 0)))
(assert (= line1_1 (split_at header1 "\r\n" 1)))
(assert (= line1_2 (split_at header1 "\r\n" 2)))
(assert (= line1_3 (split_at header1 "\r\n" 3)))
(assert (= line1_4 (split_at header1 "\r\n" 4)))

(assert (>= (num_splits header1 "\r\n") 6))

; Concrete structure to force a consistent parse
(assert (= request_line1 "POST /submit HTTP/1.1"))
(assert (= host_kv1 "Host: example.com"))
(assert (= clen_kv1 "Content-Length: 5"))
(assert (= line1_1 host_kv1))
(assert (= line1_2 clen_kv1))
(assert (= line1_3 "X-Note: hello"))
(assert (= line1_4 ""))

; body begins after the blank line; use split_rest
(assert (= body1 (split_rest header1 "\r\n" 5)))
(assert (= body1 "abcde"))

; Parse key-value by colon+space
(assert (= host_key1 (split_at host_kv1 ": " 0)))
(assert (= host_val1 (split_at host_kv1 ": " 1)))
(assert (= clen_key1 (split_at clen_kv1 ": " 0)))
(assert (= clen_val1 (split_at clen_kv1 ": " 1)))

(assert (= host_key1 "Host"))
(assert (= host_val1 "example.com"))
(assert (= clen_key1 "Content-Length"))

; Validate Content-Length value is digits and matches body length
(assert (str.in_re clen_val1 (re.+ (re.range "0" "9"))))
(assert (= content_length1 (str.to_int clen_val1)))
(assert (>= content_length1 0))
(assert (= content_length1 (str.len body1)))

; Additional robustness checks: ensure key/value separator exists (at least 2 splits)
(assert (>= (num_splits host_kv1 ": ") 2))
(assert (>= (num_splits clen_kv1 ": ") 2))


; =========================
; UNSAT instance: conflicting Content-Length vs body length
; =========================

(declare-const header2 String)
(declare-const request_line2 String)
(declare-const h2_line1 String)
(declare-const h2_line2 String)
(declare-const h2_blank String)
(declare-const body2 String)
(declare-const clen_kv2 String)
(declare-const clen_val2 String)
(declare-const content_length2 Int)

(assert (= request_line2 (split_at header2 "\r\n" 0)))
(assert (= h2_line1 (split_at header2 "\r\n" 1)))
(assert (= h2_line2 (split_at header2 "\r\n" 2)))
(assert (= h2_blank (split_at header2 "\r\n" 3)))
(assert (>= (num_splits header2 "\r\n") 5))

(assert (= request_line2 "POST /data HTTP/1.1"))
(assert (= h2_line1 "Host: a"))
(assert (= clen_kv2 "Content-Length: 4"))
(assert (= h2_line2 clen_kv2))
(assert (= h2_blank ""))

(assert (= body2 (split_rest header2 "\r\n" 4)))
(assert (= body2 "XYZ"))

(assert (= clen_val2 (split_at clen_kv2 ": " 1)))
(assert (str.in_re clen_val2 (re.+ (re.range "0" "9"))))
(assert (= content_length2 (str.to_int clen_val2)))

; Contradiction: declared length 4 but body length is 3
(assert (= content_length2 (str.len body2)))




; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
