(set-logic ALL)

; Uninterpreted interface functions for string splitting
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

; Common helper uninterpreted functions for parsing/validation
(declare-fun to_int (String) Int)
(declare-fun is_digits (String) Bool)

; ======== SAT instance: consistent HTTP header parsing ========
(declare-const req_sat String)
(declare-const request_line_sat String)
(declare-const headers_blob_sat String)
(declare-const body_sat String)
(declare-const header_line0_sat String)
(declare-const header_line1_sat String)
(declare-const header_line2_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const ua_key_sat String)
(declare-const ua_val_sat String)
(declare-const cl_int_sat Int)

; Split request into start-line and the rest at first newline
(assert (= request_line_sat (split_at req_sat "\n" 0)))
(assert (= headers_blob_sat (split_rest req_sat "\n" 1)))
(assert (>= (num_splits req_sat "\n") 4))

; Headers are first three lines after request line, followed by body
(assert (= header_line0_sat (split_at headers_blob_sat "\n" 0)))
(assert (= header_line1_sat (split_at headers_blob_sat "\n" 1)))
(assert (= header_line2_sat (split_at headers_blob_sat "\n" 2)))
(assert (= body_sat (split_rest headers_blob_sat "\n" 3)))

; Each header line is "Key: Value" and must have at least 2 segments
(assert (>= (num_splits header_line0_sat ": ") 2))
(assert (>= (num_splits header_line1_sat ": ") 2))
(assert (>= (num_splits header_line2_sat ": ") 2))

; Parse Host header from line0
(assert (= host_key_sat (split_at header_line0_sat ": " 0)))
(assert (= host_val_sat (split_rest header_line0_sat ": " 1)))
(assert (= host_key_sat "Host"))
(assert (str.contains host_val_sat "."))
(assert (>= (str.len host_val_sat) 4))

; Parse Content-Length header from line1
(assert (= cl_key_sat (split_at header_line1_sat ": " 0)))
(assert (= cl_val_sat (split_rest header_line1_sat ": " 1)))
(assert (= cl_key_sat "Content-Length"))
(assert (is_digits cl_val_sat))
(assert (= cl_int_sat (to_int cl_val_sat)))
(assert (>= cl_int_sat 0))
(assert (= (str.len body_sat) cl_int_sat))

; Parse User-Agent header from line2
(assert (= ua_key_sat (split_at header_line2_sat ": " 0)))
(assert (= ua_val_sat (split_rest header_line2_sat ": " 1)))
(assert (= ua_key_sat "User-Agent"))
(assert (>= (str.len ua_val_sat) 1))
(assert (not (str.contains ua_val_sat "\n")))

; Constrain request line format loosely: "METHOD SP PATH SP HTTP/1.1"
(assert (str.contains request_line_sat " HTTP/1.1"))
(assert (or (str.contains request_line_sat "GET ") (str.contains request_line_sat "POST ")))

; Provide one concrete satisfiable example shape (still allows flexibility)
(assert (str.contains req_sat "Host: "))
(assert (str.contains req_sat "Content-Length: "))
(assert (str.contains req_sat "User-Agent: "))


; ======== UNSAT instance: contradictory Content-Length vs body length ========
(declare-const req_unsat String)
(declare-const headers_blob_unsat String)
(declare-const body_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_key_unsat String)
(declare-const cl_val_unsat String)
(declare-const cl_int_unsat Int)

(assert (= headers_blob_unsat (split_rest req_unsat "\n" 1)))
(assert (>= (num_splits req_unsat "\n") 3))

; Assume the first header line in headers_blob is Content-Length
(assert (= cl_line_unsat (split_at headers_blob_unsat "\n" 0)))
(assert (>= (num_splits cl_line_unsat ": ") 2))
(assert (= cl_key_unsat (split_at cl_line_unsat ": " 0)))
(assert (= cl_val_unsat (split_rest cl_line_unsat ": " 1)))
(assert (= cl_key_unsat "Content-Length"))
(assert (is_digits cl_val_unsat))
(assert (= cl_int_unsat (to_int cl_val_unsat)))
(assert (>= cl_int_unsat 0))

; Body is whatever remains after two lines (one header + blank line)
(assert (= body_unsat (split_rest headers_blob_unsat "\n" 2)))

; Contradiction: enforce body length equals Content-Length and also differs
(assert (= (str.len body_unsat) cl_int_unsat))
(assert (not (= (str.len body_unsat) cl_int_unsat)))


(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
