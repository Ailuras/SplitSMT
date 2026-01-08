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

; Uninterpreted interface operations for string split reasoning

; HTTP header parsing variables
(declare-const request String)
(declare-const header_block String)
(declare-const request_line String)
(declare-const headers_and_body String)
(declare-const body String)

(declare-const host_line String)
(declare-const cl_line String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)

(declare-const declared_len Int)
(declare-const actual_len Int)

; Preserve core seed structure but adapt to header parsing: require a meaningful replace effect
(declare-const x String)
(declare-const y String)
(assert (= x request))
(assert (= y "\r\n"))
(assert (not (= (str.replace x y y) x)))

; Structure: request_line, header_block, and body separated by CRLF CRLF
(assert (= request_line (split_at request "\r\n" 0)))
(assert (= headers_and_body (split_rest request "\r\n" 1)))

; Require at least request-line + at least 1 header line
(assert (>= (num_splits request "\r\n") 3))

; header_block ends at the empty line; model as two segments split by CRLFCRLF
(assert (= header_block (split_at request "\r\n\r\n" 0)))
(assert (= body (split_at request "\r\n\r\n" 1)))
(assert (>= (num_splits request "\r\n\r\n") 2))

; Constrain header_block to have multiple lines
(assert (>= (num_splits header_block "\r\n") 2))

; Extract specific header lines (position-dependent for this scenario)
(assert (= host_line (split_at header_block "\r\n" 1)))
(assert (= cl_line (split_at header_block "\r\n" 2)))

; Each header line is key:value
(assert (= host_key (split_at host_line ":" 0)))
(assert (= host_value (split_at host_line ":" 1)))
(assert (>= (num_splits host_line ":") 2))

(assert (= cl_key (split_at cl_line ":" 0)))
(assert (= cl_value (split_at cl_line ":" 1)))
(assert (>= (num_splits cl_line ":") 2))

; Keys are as expected
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))

; Values should be non-empty (allowing optional leading space is not modeled; enforce length > 0)
(assert (> (str.len host_value) 0))
(assert (> (str.len cl_value) 0))

; Content-Length validation: declared_len equals actual body length
(assert (= actual_len (str.len body)))
(assert (>= declared_len 0))
(assert (= declared_len actual_len))

; Additional sanity constraints: ensure body exists and contains no CRLFCRLF (single header/body split)
(assert (> (str.len body) 0))
(assert (= (num_splits request "\r\n\r\n") 2))

; Create both SAT and UNSAT instances: this block forces UNSAT via contradictory length requirement
; If host header exists and content-length matches body length, also assert mismatch
(assert (not (= declared_len actual_len)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
