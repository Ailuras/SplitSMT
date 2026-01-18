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

; Uninterpreted interface operations for string split

; -----------------------------
; Scenario: Email Validation
; We model splitting by '@' and '.' and constrain segment counts and structure.
; This file contains both SAT and UNSAT instances in one run.
; -----------------------------

; ===== SAT instance =====
(declare-const email_ok String)
(declare-const local_ok String)
(declare-const domain_ok String)
(declare-const tld_ok String)
(declare-const domain_labels_ok Int)

; Basic split by '@'
(assert (= local_ok (split_at email_ok "@" 0)))
(assert (= domain_ok (split_at email_ok "@" 1)))
(assert (= (num_splits email_ok "@") 2))

; Local-part constraints
(assert (>= (str.len local_ok) 1))
(assert (not (str.contains local_ok "@")))
(assert (not (str.contains local_ok " ")))
(assert (not (str.contains local_ok "..")))

; Domain constraints via '.'
(assert (>= (str.len domain_ok) 3))
(assert (not (str.contains domain_ok "@")))
(assert (not (str.contains domain_ok " ")))
(assert (not (str.contains domain_ok "..")))

(assert (= domain_labels_ok (num_splits domain_ok ".")))
(assert (>= domain_labels_ok 2))

; TLD is last label; ensure at least 2 chars
(assert (= tld_ok (split_at domain_ok "." (- domain_labels_ok 1))))
(assert (>= (str.len tld_ok) 2))

; Domain label sanity: first label non-empty and doesn't contain '.'
(assert (>= (str.len (split_at domain_ok "." 0)) 1))
(assert (not (str.contains (split_at domain_ok "." 0) ".")))

; Also ensure the remainder from first dot onwards is non-empty
(assert (>= (str.len (split_rest domain_ok "." 1)) 1))

; Tie to a concrete satisfying example (still consistent with above)
(assert (= email_ok "john.doe+tag@sub.example.co"))

; ===== UNSAT instance =====
; Force inconsistent '@' splitting and domain structure simultaneously.
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const tld_bad String)
(declare-const domain_labels_bad Int)

(assert (= local_bad (split_at email_bad "@" 0)))
(assert (= domain_bad (split_at email_bad "@" 1)))

; Contradiction: require exactly one segment, but also refer to segment 1 and nonempty domain.
(assert (= (num_splits email_bad "@") 1))
(assert (>= (str.len domain_bad) 1))

; Additionally require domain to have at least 2 dot-separated labels and a long TLD.
(assert (= domain_labels_bad (num_splits domain_bad ".")))
(assert (>= domain_labels_bad 2))
(assert (= tld_bad (split_at domain_bad "." (- domain_labels_bad 1))))
(assert (>= (str.len tld_bad) 10))

; Provide a candidate bad email that still cannot satisfy the '@' constraint combo above.
(assert (= email_bad "a@b.co"))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
