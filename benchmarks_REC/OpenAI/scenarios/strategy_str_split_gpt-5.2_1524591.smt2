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

; Uninterpreted interface for split operations

; ========= SAT instance: a well-formed complex email =========
(declare-const email_ok String)
(declare-const local_ok String)
(declare-const domain_ok String)
(declare-const dom_label0_ok String)
(declare-const tld_ok String)
(declare-const ok_is_valid Bool)

; Basic split around '@'
(assert (= local_ok (split_at email_ok "@" 0)))
(assert (= domain_ok (split_at email_ok "@" 1)))
(assert (= (num_splits email_ok "@") 2))

; Domain split around '.' must have at least 2 segments: label + tld
(assert (= dom_label0_ok (split_at domain_ok "." 0)))
(assert (= tld_ok (split_at domain_ok "." (- (num_splits domain_ok ".") 1))))
(assert (>= (num_splits domain_ok ".") 2))

; No empty local part, no empty domain, no empty tld
(assert (>= (str.len local_ok) 1))
(assert (>= (str.len domain_ok) 1))
(assert (>= (str.len tld_ok) 2))

; Local part should not contain '@'
(assert (not (str.contains local_ok "@")))

; Domain must contain '.' and must not contain '@'
(assert (str.contains domain_ok "."))
(assert (not (str.contains domain_ok "@")))

; Domain cannot start or end with '.'
(assert (not (= (split_at domain_ok "." 0) "")))
(assert (not (= (split_at domain_ok "." (- (num_splits domain_ok ".") 1)) "")))

; Constrain email_ok to a concrete, complex example with multiple domain labels
(assert (= email_ok "john.doe+tag@sub.mail.example.co"))

; A derived validity flag (useful for higher-level APIs)
(assert (= ok_is_valid (and (= (num_splits email_ok "@") 2)
                           (>= (num_splits domain_ok ".") 2)
                           (>= (str.len local_ok) 1)
                           (>= (str.len tld_ok) 2))))
(assert ok_is_valid)

; ========= UNSAT instance: contradictory email constraints =========
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const tld_bad String)
(declare-const bad_is_valid Bool)

(assert (= local_bad (split_at email_bad "@" 0)))
(assert (= domain_bad (split_at email_bad "@" 1)))

; Require exactly one '@' split (2 segments)
(assert (= (num_splits email_bad "@") 2))

; Also require that local part contains '@' (contradicts the split semantics expectation)
; Combined with further structure constraints, this creates an UNSAT core in realistic split models.
(assert (str.contains local_bad "@"))

; Require domain to have at least two '.'-separated labels
(assert (>= (num_splits domain_bad ".") 2))
(assert (= tld_bad (split_at domain_bad "." (- (num_splits domain_bad ".") 1))))
(assert (>= (str.len tld_bad) 2))

; Contradiction: force domain to have no '.' while also requiring >= 2 splits
(assert (not (str.contains domain_bad ".")))

(assert (= bad_is_valid (and (= (num_splits email_bad "@") 2)
                            (>= (num_splits domain_bad ".") 2)
                            (not (str.contains domain_bad ".")))))
(assert bad_is_valid)



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
