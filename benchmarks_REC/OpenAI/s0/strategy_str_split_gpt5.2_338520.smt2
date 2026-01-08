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

; Uninterpreted interface operations for string splitting

; =========================
; SAT instance: well-formed HTTP headers with Content-Length validation
; =========================
(declare-const req_headers String)
(declare-const line0 String)
(declare-const line1 String)
(declare-const line2 String)
(declare-const line3 String)
(declare-const host_key String)
(declare-const host_val String)
(declare-const cl_key String)
(declare-const cl_val String)
(declare-const ua_key String)
(declare-const ua_val String)
(declare-const accept_key String)
(declare-const accept_val String)
(declare-const body String)
(declare-const content_length Int)
(declare-const total_lines Int)

; Split header block into lines by LF
(assert (= total_lines (num_splits req_headers "\n")))
(assert (>= total_lines 4))
(assert (= line0 (split_at req_headers "\n" 0)))
(assert (= line1 (split_at req_headers "\n" 1)))
(assert (= line2 (split_at req_headers "\n" 2)))
(assert (= line3 (split_at req_headers "\n" 3)))

; Each header line is key: value (colon + single space)
(assert (= host_key (split_at line0 ": " 0)))
(assert (= host_val (split_at line0 ": " 1)))
(assert (= cl_key   (split_at line1 ": " 0)))
(assert (= cl_val   (split_at line1 ": " 1)))
(assert (= ua_key   (split_at line2 ": " 0)))
(assert (= ua_val   (split_at line2 ": " 1)))
(assert (= accept_key (split_at line3 ": " 0)))
(assert (= accept_val (split_at line3 ": " 1)))

; Ensure there is exactly one split for ": " in each line (i.e., 2 segments)
(assert (= (num_splits line0 ": ") 2))
(assert (= (num_splits line1 ": ") 2))
(assert (= (num_splits line2 ": ") 2))
(assert (= (num_splits line3 ": ") 2))

; Header keys are expected
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))
(assert (= ua_key "User-Agent"))
(assert (= accept_key "Accept"))

; Basic non-emptiness and sanity for values
(assert (>= (str.len host_val) 1))
(assert (>= (str.len ua_val) 1))
(assert (>= (str.len accept_val) 1))

; Model Content-Length numerically and validate it matches the body length
(assert (>= content_length 0))
(assert (= (str.len body) content_length))

; Tie cl_val to a specific decimal rendering to avoid needing str.to_int
(assert (= cl_val "5"))
(assert (= content_length 5))

; Concrete but still flexible structure for the whole header block
(assert (= req_headers (str.++ line0 "\n" line1 "\n" line2 "\n" line3 "\n")))

; Example value constraints to keep it realistic
(assert (str.contains host_val "."))
(assert (str.contains ua_val "/"))
(assert (or (= accept_val "*/*") (str.contains accept_val "/")))

; =========================
; UNSAT instance: contradictory Content-Length constraints
; Uses separate variables to avoid interfering with the SAT instance
; =========================
(declare-const req_headers_bad String)
(declare-const bad_line0 String)
(declare-const bad_line1 String)
(declare-const bad_cl_key String)
(declare-const bad_cl_val String)
(declare-const bad_body String)
(declare-const bad_len Int)

(assert (>= (num_splits req_headers_bad "\n") 2))
(assert (= bad_line0 (split_at req_headers_bad "\n" 0)))
(assert (= bad_line1 (split_at req_headers_bad "\n" 1)))

(assert (= (num_splits bad_line1 ": ") 2))
(assert (= bad_cl_key (split_at bad_line1 ": " 0)))
(assert (= bad_cl_val (split_at bad_line1 ": " 1)))
(assert (= bad_cl_key "Content-Length"))

; Force the textual value to be "5" but make the numeric and body inconsistent
(assert (= bad_cl_val "5"))
(assert (= bad_len 5))
(assert (= (str.len bad_body) bad_len))
(assert (= (str.len bad_body) 4))

; Also provide a minimal structure so the split variables are coherent
(assert (= req_headers_bad (str.++ bad_line0 "\n" bad_line1 "\n")))
(assert (= bad_line0 "Host: example.com"))
(assert (= bad_line1 "Content-Length: 5"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
