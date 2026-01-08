(set-logic ALL)
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

; Uninterpreted interface for string splitting

; =========================
; SAT instance: well-formed HTTP header parsing with consistent Content-Length
; =========================
(declare-const req_sat String)
(declare-const header_block_sat String)
(declare-const body_sat String)
(declare-const request_line_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const cl_val_num_sat Int)

; req_sat = header_block_sat + "\r\n\r\n" + body_sat
(assert (= req_sat (str.++ header_block_sat "\r\n\r\n" body_sat)))

; Split header block into lines
(assert (>= (num_splits header_block_sat "\r\n") 3))
(assert (= request_line_sat (split_at header_block_sat "\r\n" 0)))
(assert (= host_line_sat (split_at header_block_sat "\r\n" 1)))
(assert (= cl_line_sat (split_at header_block_sat "\r\n" 2)))

; Request line contains spaces and starts with a method token (simple check)
(assert (str.contains request_line_sat " "))
(assert (or (str.prefixof "GET " request_line_sat)
            (str.prefixof "POST " request_line_sat)
            (str.prefixof "HEAD " request_line_sat)))

; Parse Host header: "Host: <value>"
(assert (= host_key_sat (split_at host_line_sat ":" 0)))
(assert (= host_val_sat (split_at host_line_sat ":" 1)))
(assert (= host_key_sat "Host"))
(assert (> (str.len host_val_sat) 0))
; avoid embedded newlines in the value segment
(assert (not (str.contains host_val_sat "\r")))
(assert (not (str.contains host_val_sat "\n")))

; Parse Content-Length header: "Content-Length: <digits>"
(assert (= cl_key_sat (split_at cl_line_sat ":" 0)))
(assert (= cl_val_sat (split_at cl_line_sat ":" 1)))
(assert (= cl_key_sat "Content-Length"))

; cl_val_sat is digits only (possibly with leading spaces not allowed here)
(assert (str.in_re cl_val_sat (re.+ (re.range "0" "9"))))

; Numeric conversion for Content-Length and validation against body length
(assert (= cl_val_num_sat (str.to_int cl_val_sat)))
(assert (>= cl_val_num_sat 0))
(assert (= cl_val_num_sat (str.len body_sat)))

; Additional structural sanity: at least one slash in request target
(assert (str.contains request_line_sat "/"))

; Witness construction to guarantee SAT
(assert (= body_sat "HELLO"))
(assert (= request_line_sat "POST /submit HTTP/1.1"))
(assert (= host_line_sat "Host:example.com"))
(assert (= cl_line_sat "Content-Length:5"))
(assert (= header_block_sat (str.++ request_line_sat "\r\n" host_line_sat "\r\n" cl_line_sat)))


; =========================
; UNSAT instance: conflicting Content-Length constraints for the same body
; =========================
(declare-const req_unsat String)
(declare-const header_block_unsat String)
(declare-const body_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_key_unsat String)
(declare-const cl_val_unsat String)
(declare-const cl_val_num_unsat Int)

(assert (= req_unsat (str.++ header_block_unsat "\r\n\r\n" body_unsat)))

; Require at least 2 lines so we can read a Content-Length line at index 1
(assert (>= (num_splits header_block_unsat "\r\n") 2))
(assert (= cl_line_unsat (split_at header_block_unsat "\r\n" 1)))

(assert (= cl_key_unsat (split_at cl_line_unsat ":" 0)))
(assert (= cl_val_unsat (split_at cl_line_unsat ":" 1)))
(assert (= cl_key_unsat "Content-Length"))
(assert (str.in_re cl_val_unsat (re.+ (re.range "0" "9"))))
(assert (= cl_val_num_unsat (str.to_int cl_val_unsat)))
(assert (>= cl_val_num_unsat 0))

; Contradiction: length equals body length and also differs by 1
(assert (= cl_val_num_unsat (str.len body_unsat)))
(assert (= (+ cl_val_num_unsat 1) (str.len body_unsat)))

; Provide witnesses that still cannot satisfy the arithmetic contradiction
(assert (= body_unsat "DATA"))
(assert (= header_block_unsat (str.++ "GET / HTTP/1.1" "\r\n" "Content-Length:4")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
