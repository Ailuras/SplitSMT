(set-logic ALL)

; Email Validation via str_split: mix SAT and UNSAT branches with domain structure checks

; --- Uninterpreted split interface ---
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

; --- Variables ---
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const domain_first_label String)
(declare-const domain_rest_labels String)
(declare-const tld String)
(declare-const second_level String)

(declare-const at_count Int)
(declare-const dot_count Int)
(declare-const local_len Int)
(declare-const domain_len Int)
(declare-const tld_len Int)

; --- Basic parsing using '@' ---
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))
(assert (= at_count (num_splits email "@")))

; Must have exactly one '@' => two segments
(assert (= at_count 2))

; Non-empty local and domain
(assert (= local_len (str.len local)))
(assert (= domain_len (str.len domain)))
(assert (>= local_len 1))
(assert (>= domain_len 1))

; Disallow spaces in email (simple hygiene)
(assert (not (str.contains email " ")))

; --- Domain parsing using '.' ---
(assert (= dot_count (num_splits domain ".")))

; Require at least one dot in domain => at least 2 labels
(assert (>= dot_count 2))

; Pull first label and the rest
(assert (= domain_first_label (split_at domain "." 0)))
(assert (= domain_rest_labels (split_rest domain "." 1)))
(assert (>= (str.len domain_first_label) 1))
(assert (>= (str.len domain_rest_labels) 1))

; Ensure domain isn't starting/ending with '.' by enforcing non-empty last label (TLD)
(assert (= tld (split_at domain "." (- dot_count 1))))
(assert (= tld_len (str.len tld)))
(assert (>= tld_len 2))
(assert (<= tld_len 24))

; If there are exactly two labels, extract second-level directly; otherwise it is the first of the "rest"
; This is a loose structural constraint to exercise split_at with computed indices.
(assert (= second_level (split_at domain "." (- dot_count 2))))
(assert (>= (str.len second_level) 1))

; A concrete SAT example witness (still consistent with constraints)
(assert (= email "alice.smith@sub.example.com"))

; --- UNSAT branch: contradict the derived segment count ---
; With the concrete email above, at_count must be 2; forcing 3 makes the whole set UNSAT.
(assert (= at_count 3))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
