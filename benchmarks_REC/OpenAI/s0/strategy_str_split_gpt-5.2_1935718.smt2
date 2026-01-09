(set-logic ALL)

; Uninterpreted interface for string split (as provided)
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

; Additional uninterpreted helpers for header parsing
(declare-fun header_value (String String) String) ; header_value(rawHeaders, key) -> value (without key prefix)
(declare-fun is_digits (String) Bool)
(declare-fun to_int (String) Int)

; =====================
; SAT instance: consistent header block with content-length validation
; =====================
(declare-const headers_sat String)
(declare-const request_line_sat String)
(declare-const header_lines_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const ua_line_sat String)
(declare-const host_value_sat String)
(declare-const cl_value_sat String)
(declare-const ua_value_sat String)
(declare-const body_len_sat Int)
(declare-const cl_int_sat Int)

; Request line and header block split by CRLF
(assert (>= (num_splits headers_sat "\r\n") 4))
(assert (= request_line_sat (split_at headers_sat "\r\n" 0)))
(assert (= header_lines_sat (split_rest headers_sat "\r\n" 1)))

; Require a plausible request line
(assert (or (= request_line_sat "GET / HTTP/1.1")
            (= request_line_sat "POST /submit HTTP/1.1")))

; Pick specific lines (after request line) as headers
(assert (= host_line_sat (split_at headers_sat "\r\n" 1)))
(assert (= cl_line_sat (split_at headers_sat "\r\n" 2)))
(assert (= ua_line_sat (split_at headers_sat "\r\n" 3)))

; Each header line must contain exactly one ": " separator into key and value
(assert (>= (num_splits host_line_sat ": ") 2))
(assert (>= (num_splits cl_line_sat ": ") 2))
(assert (>= (num_splits ua_line_sat ": ") 2))

; Enforce header keys
(assert (= (split_at host_line_sat ": " 0) "Host"))
(assert (= (split_at cl_line_sat ": " 0) "Content-Length"))
(assert (= (split_at ua_line_sat ": " 0) "User-Agent"))

; Extract values via split
(assert (= host_value_sat (split_rest host_line_sat ": " 1)))
(assert (= cl_value_sat (split_rest cl_line_sat ": " 1)))
(assert (= ua_value_sat (split_rest ua_line_sat ": " 1)))

; Additional extraction via uninterpreted header_value (consistency)
(assert (= host_value_sat (header_value headers_sat "Host")))
(assert (= cl_value_sat (header_value headers_sat "Content-Length")))
(assert (= ua_value_sat (header_value headers_sat "User-Agent")))

; Basic value constraints
(assert (> (str.len host_value_sat) 0))
(assert (not (str.contains host_value_sat "\r")))
(assert (not (str.contains host_value_sat "\n")))

(assert (> (str.len ua_value_sat) 0))
(assert (not (str.contains ua_value_sat "\r")))
(assert (not (str.contains ua_value_sat "\n")))

; Content-Length must be digits and consistent with integer conversion
(assert (is_digits cl_value_sat))
(assert (= cl_int_sat (to_int cl_value_sat)))
(assert (>= cl_int_sat 0))

; Validate content-length against an abstract body length
(assert (>= body_len_sat 0))
(assert (= body_len_sat cl_int_sat))

; Ensure the overall header string resembles HTTP headers with trailing blank line
(assert (str.contains headers_sat "\r\n\r\n"))

; =====================
; UNSAT instance: contradictory content-length constraints for another header block
; =====================
(declare-const headers_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_value_unsat String)
(declare-const cl_int_unsat Int)
(declare-const body_len_unsat Int)

(assert (>= (num_splits headers_unsat "\r\n") 3))
(assert (= cl_line_unsat (split_at headers_unsat "\r\n" 1)))
(assert (= (split_at cl_line_unsat ": " 0) "Content-Length"))
(assert (= cl_value_unsat (split_rest cl_line_unsat ": " 1)))

(assert (is_digits cl_value_unsat))
(assert (= cl_int_unsat (to_int cl_value_unsat)))
(assert (>= cl_int_unsat 0))
(assert (>= body_len_unsat 0))

; Contradiction: body_len_unsat must equal cl_int_unsat, but also differ
(assert (= body_len_unsat cl_int_unsat))
(assert (not (= body_len_unsat cl_int_unsat)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
