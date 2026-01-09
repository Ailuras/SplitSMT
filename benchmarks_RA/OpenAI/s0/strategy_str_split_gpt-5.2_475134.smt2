(set-logic ALL)

; Uninterpreted split interface (str_split)
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

; === SAT instance: consistent HTTP request header parsing ===
(declare-const req_sat String)
(declare-const header_lines_sat String)
(declare-const content_length_line_sat String)
(declare-const host_line_sat String)
(declare-const content_length_key_sat String)
(declare-const content_length_value_sat String)
(declare-const host_key_sat String)
(declare-const host_value_sat String)
(declare-const body_sat String)
(declare-const body_len_sat Int)
(declare-const content_length_int_sat Int)
(declare-const content_length_digits_sat String)

; Basic structure: request line then headers then blank line then body
(assert (= req_sat (str.++ "POST /upload HTTP/1.1\r\n" header_lines_sat "\r\n\r\n" body_sat)))

; Header lines contain at least Host and Content-Length lines
(assert (= host_line_sat (split_at header_lines_sat "\r\n" 0)))
(assert (= content_length_line_sat (split_at header_lines_sat "\r\n" 1)))
(assert (>= (num_splits header_lines_sat "\r\n") 2))

; Parse Host: "Host: <value>"
(assert (= host_key_sat (split_at host_line_sat ": " 0)))
(assert (= host_value_sat (split_at host_line_sat ": " 1)))
(assert (>= (num_splits host_line_sat ": ") 2))
(assert (= host_key_sat "Host"))
(assert (str.contains host_value_sat "."))
(assert (> (str.len host_value_sat) 3))

; Parse Content-Length: "Content-Length: <digits>"
(assert (= content_length_key_sat (split_at content_length_line_sat ": " 0)))
(assert (= content_length_value_sat (split_at content_length_line_sat ": " 1)))
(assert (>= (num_splits content_length_line_sat ": ") 2))
(assert (= content_length_key_sat "Content-Length"))

; Validate content-length value: digits-only via regex, no leading +/-, non-empty
(assert (> (str.len content_length_value_sat) 0))
(assert (str.in_re content_length_value_sat (re.+ (re.range "0" "9"))))

; Bind an explicit digit string to demonstrate additional constraints
(assert (= content_length_digits_sat content_length_value_sat))
(assert (str.in_re content_length_digits_sat (re.+ (re.range "0" "9"))))

; Content-length integer consistent with body length
(assert (= body_len_sat (str.len body_sat)))
(assert (>= body_len_sat 0))
(assert (= content_length_int_sat body_len_sat))
(assert (>= content_length_int_sat 0))

; Also constrain body a bit (non-empty payload)
(assert (> body_len_sat 0))
(assert (str.contains body_sat "data"))

; Relate the numeric value string to the integer in a lightweight way
; (Not using str.to_int to keep portability across solvers; instead constrain a concrete scenario)
(assert (= content_length_value_sat "4"))
(assert (= content_length_int_sat 4))
(assert (= body_sat "data"))

; === UNSAT instance: contradictory Content-Length vs body length ===
(declare-const req_unsat String)
(declare-const header_lines_unsat String)
(declare-const content_length_line_unsat String)
(declare-const content_length_key_unsat String)
(declare-const content_length_value_unsat String)
(declare-const body_unsat String)
(declare-const body_len_unsat Int)
(declare-const content_length_int_unsat Int)

(assert (= req_unsat (str.++ "POST /x HTTP/1.1\r\n" header_lines_unsat "\r\n\r\n" body_unsat)))
(assert (= content_length_line_unsat (split_at header_lines_unsat "\r\n" 0)))
(assert (>= (num_splits header_lines_unsat "\r\n") 1))

(assert (= content_length_key_unsat (split_at content_length_line_unsat ": " 0)))
(assert (= content_length_value_unsat (split_at content_length_line_unsat ": " 1)))
(assert (>= (num_splits content_length_line_unsat ": ") 2))
(assert (= content_length_key_unsat "Content-Length"))
(assert (str.in_re content_length_value_unsat (re.+ (re.range "0" "9"))))

(assert (= body_len_unsat (str.len body_unsat)))
(assert (= content_length_int_unsat body_len_unsat))

; Force a mismatch: value says 10, but body is "abc" (length 3), and integer tied to body_len
(assert (= content_length_value_unsat "10"))
(assert (= body_unsat "abc"))
(assert (= body_len_unsat 3))
(assert (= content_length_int_unsat 10))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
