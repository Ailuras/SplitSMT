(set-logic ALL)

; Uninterpreted split interface (str_split)
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

; ----------------------------
; SAT instance: consistent HTTP header parsing and Content-Length validation
; ----------------------------
(declare-const req_sat String)
(declare-const header_block_sat String)
(declare-const request_line_sat String)
(declare-const cl_line_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const host_line_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const body_sat String)
(declare-const content_length_sat Int)
(declare-const body_len_sat Int)

; Structure: request-line + \r\n + headers + \r\n\r\n + body
(assert (>= (num_splits req_sat "\r\n\r\n") 2))
(assert (= header_block_sat (split_at req_sat "\r\n\r\n" 0)))
(assert (= body_sat (split_rest req_sat "\r\n\r\n" 1)))

; Header block: first line is request line, subsequent lines are headers
(assert (>= (num_splits header_block_sat "\r\n") 3))
(assert (= request_line_sat (split_at header_block_sat "\r\n" 0)))
(assert (= cl_line_sat (split_at header_block_sat "\r\n" 1)))
(assert (= host_line_sat (split_at header_block_sat "\r\n" 2)))

; Request line basic shape checks
(assert (str.contains request_line_sat "HTTP/1.1"))
(assert (str.contains request_line_sat "GET "))

; Parse Content-Length line by ':'
(assert (>= (num_splits cl_line_sat ":") 2))
(assert (= cl_key_sat (split_at cl_line_sat ":" 0)))
(assert (= cl_val_sat (split_rest cl_line_sat ":" 1)))

; Parse Host line by ':'
(assert (>= (num_splits host_line_sat ":") 2))
(assert (= host_key_sat (split_at host_line_sat ":" 0)))
(assert (= host_val_sat (split_rest host_line_sat ":" 1)))

; Expected keys and basic formatting
(assert (= cl_key_sat "Content-Length"))
(assert (= host_key_sat "Host"))

; Require a space after ':' in values
(assert (str.prefixof " " cl_val_sat))
(assert (str.prefixof " " host_val_sat))

; Constrain a concrete, parseable digit-only content-length value with optional leading space
(assert (= cl_val_sat " 5"))
(assert (= content_length_sat 5))

; Host value sanity (must include a dot after optional leading space)
(assert (str.contains host_val_sat "."))

; Validate body length equals Content-Length
(assert (= body_len_sat (str.len body_sat)))
(assert (= body_len_sat content_length_sat))

; Ensure body is exactly 5 bytes by construction possibility
(assert (>= (str.len body_sat) 0))
(assert (= body_sat "hello"))

; Additional header safety: no embedded CRLF in individual header lines
(assert (= (num_splits cl_line_sat "\r\n") 1))
(assert (= (num_splits host_line_sat "\r\n") 1))

(check-sat)

; ----------------------------
; UNSAT instance: conflicting Content-Length vs body length
; ----------------------------
(declare-const req_unsat String)
(declare-const header_block_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_key_unsat String)
(declare-const cl_val_unsat String)
(declare-const body_unsat String)
(declare-const content_length_unsat Int)
(declare-const body_len_unsat Int)

(assert (>= (num_splits req_unsat "\r\n\r\n") 2))
(assert (= header_block_unsat (split_at req_unsat "\r\n\r\n" 0)))
(assert (= body_unsat (split_rest req_unsat "\r\n\r\n" 1)))

(assert (>= (num_splits header_block_unsat "\r\n") 2))
(assert (= cl_line_unsat (split_at header_block_unsat "\r\n" 1)))

(assert (>= (num_splits cl_line_unsat ":") 2))
(assert (= cl_key_unsat (split_at cl_line_unsat ":" 0)))
(assert (= cl_val_unsat (split_rest cl_line_unsat ":" 1)))
(assert (= cl_key_unsat "Content-Length"))
(assert (str.prefixof " " cl_val_unsat))

; Force Content-Length to 0 but body to non-empty => contradiction with length check
(assert (= cl_val_unsat " 0"))
(assert (= content_length_unsat 0))
(assert (= body_unsat "X"))
(assert (= body_len_unsat (str.len body_unsat)))
(assert (= body_len_unsat content_length_unsat))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
