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

; --- Uninterpreted interface: str_split ---

; --- Helpers as uninterpreted functions (non-primitive) ---
(declare-fun trim (String) String)
(declare-fun to_int (String) Int)
(declare-fun is_digits (String) Bool)
(declare-fun body_of (String) String)

; -----------------------
; SAT instance: parse headers and validate Content-Length
; -----------------------
(declare-const req_sat String)
(declare-const headers_sat String)
(declare-const body_sat String)

(declare-const h0_sat String)
(declare-const h1_sat String)
(declare-const h2_sat String)

(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const ua_line_sat String)

(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_raw_sat String)
(declare-const cl_val_sat String)
(declare-const ua_key_sat String)
(declare-const ua_val_sat String)

(declare-const content_length_sat Int)

; Structure: headers then blank line then body
(assert (= headers_sat (split_at req_sat "\r\n\r\n" 0)))
(assert (= body_sat (split_at req_sat "\r\n\r\n" 1)))
(assert (>= (num_splits req_sat "\r\n\r\n") 2))

; Split headers into lines (at least request-line + 3 header lines)
(assert (= h0_sat (split_at headers_sat "\r\n" 0)))
(assert (= h1_sat (split_at headers_sat "\r\n" 1)))
(assert (= h2_sat (split_at headers_sat "\r\n" 2)))
(assert (>= (num_splits headers_sat "\r\n") 4))

; Fix the header lines we care about (allowing arbitrary request-line in h0_sat)
(assert (= host_line_sat h1_sat))
(assert (= cl_line_sat h2_sat))
(assert (= ua_line_sat (split_at headers_sat "\r\n" 3)))

; Each header line is key ":" value (value may have leading space)
(assert (= host_key_sat (split_at host_line_sat ":" 0)))
(assert (= host_val_sat (trim (split_at host_line_sat ":" 1))))
(assert (>= (num_splits host_line_sat ":") 2))

(assert (= cl_key_sat (split_at cl_line_sat ":" 0)))
(assert (= cl_val_raw_sat (split_at cl_line_sat ":" 1)))
(assert (= cl_val_sat (trim cl_val_raw_sat)))
(assert (>= (num_splits cl_line_sat ":") 2))

(assert (= ua_key_sat (split_at ua_line_sat ":" 0)))
(assert (= ua_val_sat (trim (split_at ua_line_sat ":" 1))))
(assert (>= (num_splits ua_line_sat ":") 2))

; Constrain expected keys
(assert (= host_key_sat "Host"))
(assert (= cl_key_sat "Content-Length"))
(assert (= ua_key_sat "User-Agent"))

; Basic semantic expectations
(assert (not (= host_val_sat "")))
(assert (not (= ua_val_sat "")))

; Validate Content-Length is digits and equals body length
(assert (is_digits cl_val_sat))
(assert (= content_length_sat (to_int cl_val_sat)))
(assert (>= content_length_sat 0))
(assert (= content_length_sat (str.len body_sat)))

; Provide a consistent concrete-ish request (still symbolic but constrained)
(assert (str.prefixof "POST /upload HTTP/1.1" h0_sat))
(assert (= host_val_sat "example.com"))
(assert (= ua_val_sat "curl/8.0"))
(assert (= body_sat "abcd"))
(assert (= cl_val_sat "4"))

; A body_of view (non-primitive) consistent with split-based extraction
(assert (= (body_of req_sat) body_sat))

(check-sat)

; -----------------------
; UNSAT instance: contradictory Content-Length validation
; -----------------------
(declare-const req_unsat String)
(declare-const headers_unsat String)
(declare-const body_unsat String)

(declare-const cl_line_unsat String)
(declare-const cl_key_unsat String)
(declare-const cl_val_unsat String)
(declare-const content_length_unsat Int)

(assert (= headers_unsat (split_at req_unsat "\r\n\r\n" 0)))
(assert (= body_unsat (split_at req_unsat "\r\n\r\n" 1)))
(assert (>= (num_splits req_unsat "\r\n\r\n") 2))

; Assume Content-Length line appears as second line (index 1)
(assert (= cl_line_unsat (split_at headers_unsat "\r\n" 1)))
(assert (>= (num_splits headers_unsat "\r\n") 2))

(assert (= cl_key_unsat (split_at cl_line_unsat ":" 0)))
(assert (= cl_val_unsat (trim (split_at cl_line_unsat ":" 1))))
(assert (>= (num_splits cl_line_unsat ":") 2))

(assert (= cl_key_unsat "Content-Length"))
(assert (is_digits cl_val_unsat))
(assert (= content_length_unsat (to_int cl_val_unsat)))
(assert (>= content_length_unsat 0))

; Force a concrete mismatch: body length 3 but Content-Length says 4
(assert (= body_unsat "abc"))
(assert (= cl_val_unsat "4"))
(assert (= content_length_unsat (str.len body_unsat)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
