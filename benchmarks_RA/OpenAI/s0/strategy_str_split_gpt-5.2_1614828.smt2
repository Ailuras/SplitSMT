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

; =========================
; SAT instance: well-formed HTTP header parsing
; =========================
(declare-const req_sat String)
(declare-const line0_sat String)
(declare-const line1_sat String)
(declare-const line2_sat String)
(declare-const request_line_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const host_key_sat String)
(declare-const host_value_sat String)
(declare-const cl_key_sat String)
(declare-const cl_value_sat String)
(declare-const body_sat String)
(declare-const content_length_sat Int)

; Build a concrete-ish request layout using newlines
(assert (= req_sat (str.++ request_line_sat "\n" host_line_sat "\n" cl_line_sat "\n\n" body_sat)))

; Lines via split on newline
(assert (>= (num_splits req_sat "\n") 4))
(assert (= line0_sat (split_at req_sat "\n" 0)))
(assert (= line1_sat (split_at req_sat "\n" 1)))
(assert (= line2_sat (split_at req_sat "\n" 2)))
(assert (= request_line_sat line0_sat))
(assert (= host_line_sat line1_sat))
(assert (= cl_line_sat line2_sat))

; Request line sanity (simple)
(assert (str.prefixof "GET " request_line_sat))
(assert (str.contains request_line_sat " HTTP/1.1"))

; Parse Host header: "Host: <value>"
(assert (>= (num_splits host_line_sat ":") 2))
(assert (= host_key_sat (split_at host_line_sat ":" 0)))
(assert (= host_value_sat (split_rest host_line_sat ":" 1)))
(assert (= host_key_sat "Host"))
; allow optional leading space in value
(assert (or (str.prefixof " " host_value_sat) (not (str.prefixof " " host_value_sat))))
(assert (> (str.len host_value_sat) 0))

; Parse Content-Length header: "Content-Length: <digits>"
(assert (>= (num_splits cl_line_sat ":") 2))
(assert (= cl_key_sat (split_at cl_line_sat ":" 0)))
(assert (= cl_value_sat (split_rest cl_line_sat ":" 1)))
(assert (= cl_key_sat "Content-Length"))

; constrain cl_value_sat to be a non-negative integer encoding possibly preceded by a single space
(assert (or (= cl_value_sat (str.++ " " (str.from_int content_length_sat)))
            (= cl_value_sat (str.from_int content_length_sat))))
(assert (>= content_length_sat 0))

; validate body length matches content-length
(assert (= (str.len body_sat) content_length_sat))

; ensure header terminator exists
(assert (str.contains req_sat "\n\n"))

; =========================
; UNSAT instance: contradictory Content-Length/body length
; =========================
(declare-const req_unsat String)
(declare-const body_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_key_unsat String)
(declare-const cl_value_unsat String)
(declare-const bad_len Int)

(assert (= req_unsat (str.++ "POST /upload HTTP/1.1\n" cl_line_unsat "\n\n" body_unsat)))

; parse Content-Length
(assert (>= (num_splits cl_line_unsat ":") 2))
(assert (= cl_key_unsat (split_at cl_line_unsat ":" 0)))
(assert (= cl_value_unsat (split_rest cl_line_unsat ":" 1)))
(assert (= cl_key_unsat "Content-Length"))

; make header claim a specific length via string form
(assert (>= bad_len 0))
(assert (= cl_value_unsat (str.++ " " (str.from_int bad_len))))

; force a contradiction: body length must both equal and differ from bad_len
(assert (= (str.len body_unsat) bad_len))
(assert (not (= (str.len body_unsat) bad_len)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
