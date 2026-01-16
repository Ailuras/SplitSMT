(set-logic ALL)
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

; Email Validation via str_split interface

; --- Uninterpreted split interface ---

; --- Core variables ---
(declare-const email String)
(declare-const local_part String)
(declare-const domain String)
(declare-const domain_name String)
(declare-const tld String)
(declare-const first_label String)
(declare-const second_label String)

; --- Helper/aux variables ---
(declare-const at_count Int)
(declare-const dot_count Int)
(declare-const local_len Int)
(declare-const domain_len Int)
(declare-const tld_len Int)
(declare-const first_label_len Int)
(declare-const second_label_len Int)

; =====================
; SAT instance: plausible complex email
; =====================

; Exactly one '@' meaning two segments when splitting by '@'
(assert (= at_count (num_splits email "@")))
(assert (= at_count 2))

; Bind local and domain from split
(assert (= local_part (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))

; Basic non-empty segments
(assert (= local_len (str.len local_part)))
(assert (= domain_len (str.len domain)))
(assert (>= local_len 1))
(assert (>= domain_len 3))

; Avoid empty local/domain and forbid extra '@' by requiring remainder past index 2 is empty
(assert (= (split_rest email "@" 2) ""))

; Domain structure: at least one '.' producing at least two segments
(assert (= dot_count (num_splits domain ".")))
(assert (>= dot_count 2))

; Bind first two labels and tld via split
(assert (= first_label (split_at domain "." 0)))
(assert (= second_label (split_at domain "." 1)))
(assert (= tld (split_at domain "." (- dot_count 1))))

(assert (= first_label_len (str.len first_label)))
(assert (= second_label_len (str.len second_label)))
(assert (= tld_len (str.len tld)))

; Non-empty labels and tld length constraints
(assert (>= first_label_len 1))
(assert (>= second_label_len 1))
(assert (>= tld_len 2))
(assert (<= tld_len 10))

; Disallow leading/trailing '.' in domain (implied by non-empty first and last segments)
; Require no empty segments anywhere for first two; for additional labels, require domain doesn't contain ".."
(assert (not (str.contains domain "..")))

; Ensure local part does not contain '@' (redundant given split count, but explicit)
(assert (not (str.contains local_part "@")))

; Simple local constraints: no spaces
(assert (not (str.contains local_part " ")))
(assert (not (str.contains domain " ")))

; Ensure the email reconstructs from local and domain
(assert (= email (str.++ local_part "@" domain)))

; A concrete satisfiable example to anchor the SAT instance
(assert (= email "john.doe+tag@sub.example.com"))

; =====================
; UNSAT instance: contradictory requirements (separate variables)
; =====================

(declare-const bad_email String)
(declare-const bad_local String)
(declare-const bad_domain String)
(declare-const bad_at_count Int)

; Force exactly one '@'
(assert (= bad_at_count (num_splits bad_email "@")))
(assert (= bad_at_count 2))
(assert (= bad_local (split_at bad_email "@" 0)))
(assert (= bad_domain (split_at bad_email "@" 1)))

; Contradiction: also force bad_email to have two '@' characters by matching "@" twice via containment patterns
; and simultaneously require num_splits to be 2.
(assert (str.contains bad_email "@"))
(assert (str.contains bad_email "@@"))

; Additionally require split_rest beyond index 2 to be empty (consistent with one '@')
(assert (= (split_rest bad_email "@" 2) ""))

; Anchor a concrete email with two '@' which conflicts with (= (num_splits ..) 2)
(assert (= bad_email "a@@b.com"))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
