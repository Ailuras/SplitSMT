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

; -----------------------------
; SAT instance: complex but valid email constraints
; -----------------------------
(declare-const email_ok String)
(declare-const local_ok String)
(declare-const domain_ok String)
(declare-const tld_ok String)
(declare-const domain_core_ok String)
(declare-const first_label_ok String)
(declare-const suffix_ok String)
(declare-const at_count_ok Int)
(declare-const dot_count_ok Int)

; Define local/domain via split at '@'
(assert (= at_count_ok (num_splits email_ok "@")))
(assert (= at_count_ok 2))
(assert (= local_ok (split_at email_ok "@" 0)))
(assert (= domain_ok (split_at email_ok "@" 1)))

; Local-part sanity: non-empty, no spaces, no '@'
(assert (> (str.len local_ok) 0))
(assert (not (str.contains local_ok " ")))
(assert (not (str.contains local_ok "@")))

; Domain sanity: non-empty, no spaces, no '@'
(assert (> (str.len domain_ok) 0))
(assert (not (str.contains domain_ok " ")))
(assert (not (str.contains domain_ok "@")))

; Domain must have at least one dot to separate TLD
(assert (= dot_count_ok (num_splits domain_ok ".")))
(assert (>= dot_count_ok 2))

; Ensure last label (TLD) exists and is non-trivial
; Using split_at at a fixed index (1) for a 2-label requirement or more.
; Also ensure there is at least one additional label before it.
(assert (not (= (split_at domain_ok "." 0) "")))
(assert (not (= (split_at domain_ok "." 1) "")))

; Strengthen: enforce at least 2 labels by using split_rest from label 1 onward to include a dot
(assert (= tld_ok (split_at domain_ok "." (- dot_count_ok 1))))
(assert (>= (str.len tld_ok) 2))

; Enforce a 3-label structure example: sub.domain.tld (at least)
; Require that domain has at least 3 segments when split by '.'
(assert (>= (num_splits domain_ok ".") 3))
(assert (= first_label_ok (split_at domain_ok "." 0)))
(assert (= domain_core_ok (split_at domain_ok "." 1)))
(assert (= suffix_ok (split_rest domain_ok "." 2)))
(assert (> (str.len first_label_ok) 0))
(assert (> (str.len domain_core_ok) 0))
(assert (> (str.len suffix_ok) 0))

; Constrain that the suffix_ok contains a dot (so there is at least a tld beyond index 2)
(assert (str.contains suffix_ok "."))

; Concrete witness to make the SAT instance satisfiable
(assert (= email_ok "john.doe+tag@sub.example.co.uk"))

(check-sat)

; -----------------------------
; UNSAT instance: contradictory email constraints
; -----------------------------
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const at_count_bad Int)
(declare-const dot_count_bad Int)

; Split at '@' and require exactly one '@'
(assert (= at_count_bad (num_splits email_bad "@")))
(assert (= at_count_bad 2))
(assert (= local_bad (split_at email_bad "@" 0)))
(assert (= domain_bad (split_at email_bad "@" 1)))

; Contradiction: force local to contain '@' while also requiring exactly one '@' total
(assert (str.contains local_bad "@"))

; Domain dot structure constraints also contradictory
(assert (= dot_count_bad (num_splits domain_bad ".")))
(assert (= dot_count_bad 1))
(assert (>= dot_count_bad 2))

; Concrete email candidate that would otherwise be reasonable
(assert (= email_bad "alice@example.com"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
