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

; Uninterpreted interface for string split constraints

; Primitive parsing / helper functions as uninterpreted where needed
(declare-fun atoi (String) Int)

; -------------------------
; SAT instance: well-formed HTTP headers and content-length validation
; -------------------------
(declare-const req_sat String)
(declare-const headers_sat String)
(declare-const body_sat String)
(declare-const line0_sat String)
(declare-const line1_sat String)
(declare-const line2_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const cl_int_sat Int)

; Request split at header/body separator
(assert (= headers_sat (split_at req_sat "\r\n\r\n" 0)))
(assert (= body_sat (split_at req_sat "\r\n\r\n" 1)))
(assert (>= (num_splits req_sat "\r\n\r\n") 2))

; Require at least three header lines: request-line + Host + Content-Length
(assert (>= (num_splits headers_sat "\r\n") 3))
(assert (= line0_sat (split_at headers_sat "\r\n" 0)))
(assert (= line1_sat (split_at headers_sat "\r\n" 1)))
(assert (= line2_sat (split_at headers_sat "\r\n" 2)))

; Request line basic shape: METHOD SP PATH SP HTTP/VERSION
(assert (>= (num_splits line0_sat " " ) 3))
(assert (= (split_at line0_sat " " 2) "HTTP/1.1"))
(assert (or (= (split_at line0_sat " " 0) "GET")
            (= (split_at line0_sat " " 0) "POST")))
(assert (>= (str.len (split_at line0_sat " " 1)) 1))

; Parse Host header: "Host: value" using split on ": "
(assert (= host_key_sat (split_at line1_sat ": " 0)))
(assert (= host_val_sat (split_at line1_sat ": " 1)))
(assert (= host_key_sat "Host"))
(assert (>= (num_splits line1_sat ": ") 2))
(assert (not (= host_val_sat "")))

; Parse Content-Length header: "Content-Length: N"
(assert (= cl_key_sat (split_at line2_sat ": " 0)))
(assert (= cl_val_sat (split_at line2_sat ": " 1)))
(assert (= cl_key_sat "Content-Length"))
(assert (>= (num_splits line2_sat ": ") 2))

; Content-Length must be a natural integer string and match body length
(assert (= cl_int_sat (atoi cl_val_sat)))
(assert (>= cl_int_sat 0))
(assert (= cl_int_sat (str.len body_sat)))

; Additional safety: header lines should not contain embedded CRLF
(assert (not (str.contains line1_sat "\r\n")))
(assert (not (str.contains line2_sat "\r\n")))

; Encourage realistic formatting: ensure header block ends with CRLF
(assert (str.contains headers_sat "\r\n"))

; -------------------------
; UNSAT instance: contradictory content-length constraints
; -------------------------
(declare-const req_unsat String)
(declare-const headers_unsat String)
(declare-const body_unsat String)
(declare-const u_line0 String)
(declare-const u_line1 String)
(declare-const u_line2 String)
(declare-const u_cl_key String)
(declare-const u_cl_val String)
(declare-const u_cl_int Int)

(assert (= headers_unsat (split_at req_unsat "\r\n\r\n" 0)))
(assert (= body_unsat (split_at req_unsat "\r\n\r\n" 1)))
(assert (>= (num_splits req_unsat "\r\n\r\n") 2))

(assert (>= (num_splits headers_unsat "\r\n") 3))
(assert (= u_line0 (split_at headers_unsat "\r\n" 0)))
(assert (= u_line1 (split_at headers_unsat "\r\n" 1)))
(assert (= u_line2 (split_at headers_unsat "\r\n" 2)))

; Require a valid-looking request line
(assert (>= (num_splits u_line0 " ") 3))
(assert (= (split_at u_line0 " " 2) "HTTP/1.1"))

; Content-Length line parses correctly
(assert (= u_cl_key (split_at u_line2 ": " 0)))
(assert (= u_cl_val (split_at u_line2 ": " 1)))
(assert (= u_cl_key "Content-Length"))
(assert (>= (num_splits u_line2 ": ") 2))
(assert (= u_cl_int (atoi u_cl_val)))
(assert (>= u_cl_int 0))

; Contradiction: length equals body length AND also equals body length + 1
(assert (= u_cl_int (str.len body_unsat)))
(assert (= u_cl_int (+ (str.len body_unsat) 1)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
