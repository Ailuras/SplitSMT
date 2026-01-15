(set-logic ALL)

; Uninterpreted interface for string split reasoning
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

; Standard string/int conversion (declare here to be explicit in ALL)
(declare-fun str.to_int (String) Int)

; -----------------------------
; SAT instance: well-formed HTTP header parsing
; -----------------------------
(declare-const req_sat String)
(declare-const header_block_sat String)
(declare-const line0_sat String)
(declare-const line1_sat String)
(declare-const line2_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const body_sat String)
(declare-const content_len_sat Int)
(declare-const host_sat String)

; Split request into header block and body at CRLFCRLF
(assert (= header_block_sat (split_at req_sat "\r\n\r\n" 0)))
(assert (= body_sat (split_at req_sat "\r\n\r\n" 1)))
(assert (>= (num_splits req_sat "\r\n\r\n") 2))

; Header block split into lines
(assert (= line0_sat (split_at header_block_sat "\r\n" 0)))
(assert (= line1_sat (split_at header_block_sat "\r\n" 1)))
(assert (= line2_sat (split_at header_block_sat "\r\n" 2)))
(assert (>= (num_splits header_block_sat "\r\n") 3))

; Fix request-line and two header lines
(assert (= line0_sat "POST /upload HTTP/1.1"))
(assert (= host_line_sat line1_sat))
(assert (= cl_line_sat line2_sat))

; Parse Host header with colon delimiter
(assert (= host_key_sat (split_at host_line_sat ":" 0)))
(assert (= host_val_sat (split_rest host_line_sat ":" 1)))
(assert (>= (num_splits host_line_sat ":") 2))
(assert (= host_key_sat "Host"))

; Ensure value begins with a single space then hostname (simple normalization)
(assert (= host_sat "example.com"))
(assert (= host_val_sat (str.++ " " host_sat)))

; Parse Content-Length header
(assert (= cl_key_sat (split_at cl_line_sat ":" 0)))
(assert (= cl_val_sat (split_rest cl_line_sat ":" 1)))
(assert (>= (num_splits cl_line_sat ":") 2))
(assert (= cl_key_sat "Content-Length"))

; Content-Length value is " 5"
(assert (= cl_val_sat " 5"))
(assert (= content_len_sat (str.to_int (split_rest cl_val_sat " " 1))))
(assert (= (split_at cl_val_sat " " 0) ""))
(assert (>= (num_splits cl_val_sat " ") 2))

; Validate body length against content-length and basic sanity
(assert (= (str.len body_sat) content_len_sat))
(assert (>= content_len_sat 0))
(assert (= body_sat "abcde"))

; Assemble a concrete request consistent with the parsing constraints
(assert (= req_sat
  (str.++
    "POST /upload HTTP/1.1\r\n"
    "Host: example.com\r\n"
    "Content-Length: 5\r\n"
    "\r\n"
    "abcde")))

; -----------------------------
; UNSAT instance: inconsistent Content-Length vs actual body
; -----------------------------
(declare-const req_unsat String)
(declare-const header_block_unsat String)
(declare-const body_unsat String)
(declare-const line0_unsat String)
(declare-const line1_unsat String)
(declare-const line2_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_key_unsat String)
(declare-const cl_val_unsat String)
(declare-const content_len_unsat Int)

(assert (= header_block_unsat (split_at req_unsat "\r\n\r\n" 0)))
(assert (= body_unsat (split_at req_unsat "\r\n\r\n" 1)))
(assert (>= (num_splits req_unsat "\r\n\r\n") 2))

(assert (= line0_unsat (split_at header_block_unsat "\r\n" 0)))
(assert (= line1_unsat (split_at header_block_unsat "\r\n" 1)))
(assert (= line2_unsat (split_at header_block_unsat "\r\n" 2)))
(assert (>= (num_splits header_block_unsat "\r\n") 3))

(assert (= line0_unsat "POST /upload HTTP/1.1"))
(assert (= line1_unsat "Host: example.com"))
(assert (= cl_line_unsat line2_unsat))

(assert (= cl_key_unsat (split_at cl_line_unsat ":" 0)))
(assert (= cl_val_unsat (split_rest cl_line_unsat ":" 1)))
(assert (>= (num_splits cl_line_unsat ":") 2))
(assert (= cl_key_unsat "Content-Length"))

; Claim Content-Length: 10 but provide a body of length 5 => contradiction
(assert (= cl_val_unsat " 10"))
(assert (= content_len_unsat (str.to_int (split_rest cl_val_unsat " " 1))))
(assert (= (split_at cl_val_unsat " " 0) ""))
(assert (>= (num_splits cl_val_unsat " ") 2))

(assert (= body_unsat "abcde"))
(assert (= (str.len body_unsat) 5))
(assert (= (str.len body_unsat) content_len_unsat))

(assert (= req_unsat
  (str.++
    "POST /upload HTTP/1.1\r\n"
    "Host: example.com\r\n"
    "Content-Length: 10\r\n"
    "\r\n"
    "abcde")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
