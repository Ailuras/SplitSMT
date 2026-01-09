(set-logic ALL)

; Uninterpreted string split interface
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

; ========== SAT instance: well-formed header parsing ========== 
(declare-const req_sat String)
(declare-const request_line_sat String)
(declare-const headers_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const body_sat String)
(declare-const cl_len_sat Int)

; Request is split into lines by CRLF. First line is request line.
(assert (>= (num_splits req_sat "\r\n") 4))
(assert (= request_line_sat (split_at req_sat "\r\n" 0)))
(assert (= headers_sat (split_rest req_sat "\r\n" 1)))

; Second and third lines are headers (Host and Content-Length), then an empty line, then body.
(assert (= host_line_sat (split_at req_sat "\r\n" 1)))
(assert (= cl_line_sat (split_at req_sat "\r\n" 2)))
(assert (= "" (split_at req_sat "\r\n" 3)))
(assert (= body_sat (split_rest req_sat "\r\n" 4)))

; Each header line must have at least one ':' to separate key/value.
(assert (>= (num_splits host_line_sat ":") 2))
(assert (>= (num_splits cl_line_sat ":") 2))

; Parse host header
(assert (= host_key_sat (split_at host_line_sat ":" 0)))
(assert (= host_val_sat (split_rest host_line_sat ":" 1)))
(assert (= host_key_sat "Host"))
(assert (not (str.contains host_val_sat "\r")))
(assert (not (str.contains host_val_sat "\n")))
(assert (> (str.len host_val_sat) 0))

; Parse content-length header
(assert (= cl_key_sat (split_at cl_line_sat ":" 0)))
(assert (= cl_val_sat (split_rest cl_line_sat ":" 1)))
(assert (= cl_key_sat "Content-Length"))
(assert (not (str.contains cl_val_sat "\r")))
(assert (not (str.contains cl_val_sat "\n")))

; Validate body length equals declared content length.
(assert (= cl_len_sat (str.len body_sat)))
(assert (>= cl_len_sat 0))

; Constrain to a concrete consistent instance for SAT
(assert (= request_line_sat "POST /submit HTTP/1.1"))
(assert (= host_val_sat " example.com"))
(assert (= body_sat "abc"))
(assert (= cl_len_sat 3))
(assert (= cl_val_sat " 3"))

; Build full request string consistent with the extracted fields
(assert (= req_sat (str.++ request_line_sat "\r\n" host_key_sat ":" host_val_sat "\r\n" cl_key_sat ":" cl_val_sat "\r\n\r\n" body_sat)))

(check-sat)

; ========== UNSAT instance: conflicting content-length vs body length ========== 
(declare-const req_unsat String)
(declare-const request_line_unsat String)
(declare-const host_line_unsat String)
(declare-const cl_line_unsat String)
(declare-const body_unsat String)
(declare-const cl_key_unsat String)
(declare-const cl_val_unsat String)
(declare-const cl_len_unsat Int)

(assert (>= (num_splits req_unsat "\r\n") 4))
(assert (= request_line_unsat (split_at req_unsat "\r\n" 0)))
(assert (= host_line_unsat (split_at req_unsat "\r\n" 1)))
(assert (= cl_line_unsat (split_at req_unsat "\r\n" 2)))
(assert (= "" (split_at req_unsat "\r\n" 3)))
(assert (= body_unsat (split_rest req_unsat "\r\n" 4)))

(assert (>= (num_splits cl_line_unsat ":") 2))
(assert (= cl_key_unsat (split_at cl_line_unsat ":" 0)))
(assert (= cl_val_unsat (split_rest cl_line_unsat ":" 1)))
(assert (= cl_key_unsat "Content-Length"))

(assert (= request_line_unsat "POST /x HTTP/1.1"))
(assert (= host_line_unsat "Host: a"))
(assert (= body_unsat "abcd"))
(assert (= cl_len_unsat (str.len body_unsat)))
(assert (= cl_len_unsat 4))

; Force declared Content-Length to contradict actual body length
(assert (= cl_val_unsat " 3"))

(assert (= req_unsat (str.++ request_line_unsat "\r\n" host_line_unsat "\r\n" cl_key_unsat ":" cl_val_unsat "\r\n\r\n" body_unsat)))

; Additionally assert that the declared length equals the actual length (inconsistent with cl_val_unsat encoding)
; We encode a simple inconsistency by requiring the header value string to equal the decimal rendering of the length,
; but also fixing it to " 3" while length is 4.
(declare-fun int_to_dec (Int) String)
(assert (= (int_to_dec cl_len_unsat) "4"))
(assert (= cl_val_unsat (str.++ " " (int_to_dec cl_len_unsat))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
