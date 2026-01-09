(set-logic ALL)

; Uninterpreted interface for str_split
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

; -----------------------------
; SAT instance: well-formed HTTP header parsing with Content-Length validation
; -----------------------------
(declare-const req_sat String)
(declare-const request_line_sat String)
(declare-const headers_sat String)
(declare-const host_line_sat String)
(declare-const host_key_sat String)
(declare-const host_value_sat String)
(declare-const cl_line_sat String)
(declare-const cl_key_sat String)
(declare-const cl_value_sat String)
(declare-const body_sat String)
(declare-const content_length_sat Int)
(declare-const body_len_sat Int)

; Basic structure: request-line + headers + blank-line + body
(assert (= request_line_sat (split_at req_sat "\r\n" 0)))
(assert (= headers_sat (split_rest req_sat "\r\n" 1)))
(assert (>= (num_splits req_sat "\r\n") 4))

; Pin a concrete satisfiable request skeleton
(assert (= request_line_sat "POST /submit HTTP/1.1"))
(assert (= host_line_sat (split_at req_sat "\r\n" 1)))
(assert (= cl_line_sat (split_at req_sat "\r\n" 2)))
(assert (= (split_at req_sat "\r\n" 3) ""))
(assert (= body_sat (split_rest req_sat "\r\n" 4)))

; Host header: "Host: example.com"
(assert (= host_key_sat (split_at host_line_sat ":" 0)))
(assert (= host_value_sat (split_at host_line_sat ":" 1)))
(assert (= host_key_sat "Host"))
(assert (= host_value_sat " example.com"))
(assert (= (num_splits host_line_sat ":") 2))

; Content-Length header: "Content-Length: 5"
(assert (= cl_key_sat (split_at cl_line_sat ":" 0)))
(assert (= cl_value_sat (split_at cl_line_sat ":" 1)))
(assert (= cl_key_sat "Content-Length"))
(assert (= cl_value_sat " 5"))
(assert (= (num_splits cl_line_sat ":") 2))

; Body fixed to length 5
(assert (= body_sat "hello"))
(assert (= body_len_sat (str.len body_sat)))
(assert (= content_length_sat 5))
(assert (= body_len_sat content_length_sat))

; Additional sanity constraints: keys are non-empty, no newline inside header lines
(assert (> (str.len host_key_sat) 0))
(assert (> (str.len cl_key_sat) 0))
(assert (not (str.contains host_line_sat "\r\n")))
(assert (not (str.contains cl_line_sat "\r\n")))

; -----------------------------
; UNSAT instance: conflicting Content-Length vs actual body length
; -----------------------------
(declare-const req_unsat String)
(declare-const request_line_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_value_unsat String)
(declare-const body_unsat String)
(declare-const content_length_unsat Int)
(declare-const body_len_unsat Int)

(assert (= request_line_unsat (split_at req_unsat "\r\n" 0)))
(assert (= cl_line_unsat (split_at req_unsat "\r\n" 1)))
(assert (= (split_at req_unsat "\r\n" 2) ""))
(assert (= body_unsat (split_rest req_unsat "\r\n" 3)))
(assert (>= (num_splits req_unsat "\r\n") 3))

; Concrete request with body length 4 but claims Content-Length 3 (inconsistent)
(assert (= request_line_unsat "POST /x HTTP/1.1"))
(assert (= cl_line_unsat "Content-Length: 3"))
(assert (= cl_value_unsat (split_at cl_line_unsat ":" 1)))
(assert (= cl_value_unsat " 3"))
(assert (= body_unsat "DATA"))
(assert (= body_len_unsat (str.len body_unsat)))
(assert (= content_length_unsat 3))
(assert (= body_len_unsat content_length_unsat))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
