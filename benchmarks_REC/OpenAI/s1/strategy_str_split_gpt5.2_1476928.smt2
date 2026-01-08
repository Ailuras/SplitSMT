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

; --- Uninterpreted split interface (str_split) ---

; --- Seed-like boolean guards preserved/mutated ---
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)

; --- Input and derived header fields ---
(declare-const var_0xINPUT_339801 String)
(declare-const request_line String)
(declare-const headers_block String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const body String)
(declare-const content_length Int)

; Non-empty input (seed structure)
(assert (= T_1 (not (= "" var_0xINPUT_339801))))
(assert T_1)

; Mutated equality check: forbid the old trivial value
(assert (= T_2 (not (= var_0xINPUT_339801 "array"))))
(assert T_2)

; --- HTTP parsing: split by CRLF into lines ---
(assert (>= (num_splits var_0xINPUT_339801 "\r\n") 3))
(assert (= request_line (split_at var_0xINPUT_339801 "\r\n" 0)))
(assert (= host_line (split_at var_0xINPUT_339801 "\r\n" 1)))
(assert (= cl_line   (split_at var_0xINPUT_339801 "\r\n" 2)))
(assert (= body      (split_rest var_0xINPUT_339801 "\r\n" 3)))
(assert (= headers_block (str.++ host_line "\r\n" cl_line "\r\n")))

; --- Validate request line shape ---
(assert (str.prefixof "POST " request_line))
(assert (str.contains request_line " HTTP/1.1"))

; --- Parse Host header by colon-space ---
(assert (>= (num_splits host_line ": ") 2))
(assert (= host_key (split_at host_line ": " 0)))
(assert (= host_value (split_at host_line ": " 1)))
(assert (= host_key "Host"))
(assert (not (= host_value "")))
(assert (not (str.contains host_value "\r")))
(assert (not (str.contains host_value "\n")))

; --- Parse Content-Length header by colon-space ---
(assert (>= (num_splits cl_line ": ") 2))
(assert (= cl_key (split_at cl_line ": " 0)))
(assert (= cl_value (split_at cl_line ": " 1)))
(assert (= cl_key "Content-Length"))

; --- Content-Length value constraints (digits only, positive) ---
(assert (str.in_re cl_value (re.+ (re.range "0" "9"))))
(assert (>= content_length 1))

; Link length to body length
(assert (= (str.len body) content_length))

; Extra structure: enforce header ordering and presence
(assert (str.contains headers_block "Host: "))
(assert (str.contains headers_block "Content-Length: "))

; Seed-like third boolean, derived from parsing sanity
(assert (= T_3 (and (>= (str.len host_value) 1) (>= (str.len cl_value) 1))))
(assert T_3)

; --- UNSAT twist: contradict the length link intentionally ---
(assert (not (= (str.len body) content_length)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
