(set-logic ALL)

; Uninterpreted split interface
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

; Seed-like Boolean scaffolding (preserved core structure, extended)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-const var_0xINPUT_81724 String)

; HTTP header parsing variables
(declare-const request String)
(declare-const request_line String)
(declare-const header_block String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const host_value String)
(declare-const cl_value String)
(declare-const cl_int Int)
(declare-const body String)

; Relate seed input to the request
(assert (= request var_0xINPUT_81724))

; Split request into request-line and remainder using CRLF
(assert (= request_line (split_at request "\r\n" 0)))
(assert (= header_block (split_rest request "\r\n" 1)))
(assert (>= (num_splits request "\r\n") 2))

; Within the header block, first header lines for Host and Content-Length
(assert (= host_line (split_at header_block "\r\n" 0)))
(assert (= cl_line (split_at header_block "\r\n" 1)))
(assert (>= (num_splits header_block "\r\n") 2))

; Parse Host header using colon delimiter
(assert (= (split_at host_line ":" 0) "Host"))
(assert (= host_value (split_rest host_line ":" 1)))
(assert (>= (num_splits host_line ":") 2))

; Parse Content-Length header using colon delimiter
(assert (= (split_at cl_line ":" 0) "Content-Length"))
(assert (= cl_value (split_rest cl_line ":" 1)))
(assert (>= (num_splits cl_line ":") 2))

; Body is whatever remains after the second header line
(assert (= body (split_rest header_block "\r\n" 2)))

; Basic sanity constraints on extracted values
(assert (> (str.len host_value) 0))
(assert (> (str.len cl_value) 0))

; Content-Length numeric constraints
(assert (>= cl_int 0))
(assert (= (str.len body) cl_int))

; Boolean structure: keep the seed style but mutate to encode a parsing property
(assert (= T_1 (not (= "qXdHDo7IZR" var_0xINPUT_81724))))
; Require Content-Length line to exist and be non-empty: T_2 expresses the negation of that (for UNSAT)
(assert (= T_2 (not (and (>= (num_splits cl_line ":") 2) (> (str.len cl_value) 0)))))

; Force both: input differs from magic string AND parsing property fails (contradiction with earlier constraints)
(assert T_1)
(assert T_2)

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
