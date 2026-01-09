(set-logic ALL)

; Uninterpreted string-split interface
(define-const delta String "\u{2FFFF}")

(define-fun convert_for_split ((s String) (sep String)) String
  (str.replace_all s sep delta))

(define-fun-rec count_matches_rec ((s String) (from Int)) Int
  (let ((pos (str.indexof s delta from)))
    (ite (= pos (- 0 1))
         0
         (+ 1 (count_matches_rec s (+ pos (str.len delta)))))))

(define-fun count_matches ((s String)) Int
  (count_matches_rec s 0))

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

; Uninterpreted helpers for parsing and validation
(declare-fun trim (String) String)
(declare-fun to_int (String) Int)

; =====================
; SAT instance: well-formed HTTP header parsing
; =====================
(declare-const req_sat String)
(declare-const headers_sat String)
(declare-const reqline_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const ua_line_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const ua_key_sat String)
(declare-const ua_val_sat String)
(declare-const content_length_sat Int)
(declare-const body_sat String)

; Concrete request with headers and body
(assert (= req_sat
  (str.++
    "POST /submit HTTP/1.1\r\n"
    "Host: example.com\r\n"
    "Content-Length: 5\r\n"
    "User-Agent: test\r\n"
    "\r\n"
    "abcde")))

; Split request line and remaining block by CRLF
(assert (= reqline_sat (split_at req_sat "\r\n" 0)))
(assert (= headers_sat (split_rest req_sat "\r\n" 1)))

; Headers section ends with an empty line; body after that
(assert (= body_sat (split_rest headers_sat "\r\n\r\n" 1)))

; Header lines: indices in bounds (at least 4 segments before blank line)
(assert (>= (num_splits req_sat "\r\n") 5))

; Extract specific header lines by known order in this scenario
(assert (= host_line_sat (split_at req_sat "\r\n" 1)))
(assert (= cl_line_sat (split_at req_sat "\r\n" 2)))
(assert (= ua_line_sat (split_at req_sat "\r\n" 3)))

; Parse "Key: Value" using ":" delimiter
(assert (= host_key_sat (trim (split_at host_line_sat ":" 0))))
(assert (= host_val_sat (trim (split_rest host_line_sat ":" 1))))
(assert (= cl_key_sat (trim (split_at cl_line_sat ":" 0))))
(assert (= cl_val_sat (trim (split_rest cl_line_sat ":" 1))))
(assert (= ua_key_sat (trim (split_at ua_line_sat ":" 0))))
(assert (= ua_val_sat (trim (split_rest ua_line_sat ":" 1))))

; Validate keys and basic value presence
(assert (= host_key_sat "Host"))
(assert (= cl_key_sat "Content-Length"))
(assert (= ua_key_sat "User-Agent"))
(assert (> (str.len host_val_sat) 0))
(assert (> (str.len ua_val_sat) 0))

; Content-Length validation: numeric and matches body length
(assert (= content_length_sat (to_int cl_val_sat)))
(assert (= content_length_sat 5))
(assert (= (str.len body_sat) content_length_sat))

; Request line sanity: method and version presence
(assert (str.contains reqline_sat "HTTP/1.1"))
(assert (or (str.contains reqline_sat "POST") (str.contains reqline_sat "GET")))

; =====================
; UNSAT instance: conflicting Content-Length vs actual body
; =====================
(declare-const req_unsat String)
(declare-const headers_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_val_unsat String)
(declare-const content_length_unsat Int)
(declare-const body_unsat String)

(assert (= req_unsat
  (str.++
    "POST /upload HTTP/1.1\r\n"
    "Host: example.com\r\n"
    "Content-Length: 4\r\n"
    "\r\n"
    "ABCDE")))

(assert (= headers_unsat (split_rest req_unsat "\r\n" 1)))
(assert (= body_unsat (split_rest headers_unsat "\r\n\r\n" 1)))
(assert (= cl_line_unsat (split_at req_unsat "\r\n" 2)))
(assert (= cl_val_unsat (trim (split_rest cl_line_unsat ":" 1))))
(assert (= content_length_unsat (to_int cl_val_unsat)))

; Force numeric interpretation
(assert (= content_length_unsat 4))
; But actual body is length 5 ("ABCDE") -> inconsistency
(assert (= (str.len body_unsat) content_length_unsat))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
