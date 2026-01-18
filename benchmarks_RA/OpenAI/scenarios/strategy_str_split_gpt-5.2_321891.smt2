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

; Uninterpreted interface for string splitting

; =====================
; Email validation (SAT instance)
; =====================
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const domain_tail_sat String)
(declare-const sub0_sat String)
(declare-const sub1_sat String)
(declare-const tld_sat String)
(declare-const plus_part_sat String)

; Split into local@domain
(assert (= local_sat (split_at email_sat "@" 0)))
(assert (= domain_sat (split_at email_sat "@" 1)))
(assert (= domain_tail_sat (split_rest email_sat "@" 1)))
(assert (= domain_tail_sat domain_sat))

; Exactly one '@' => two segments
(assert (= (num_splits email_sat "@") 2))

; Basic non-emptiness
(assert (>= (str.len local_sat) 1))
(assert (>= (str.len domain_sat) 3))

; Local-part constraints: allow optional "+tag" but require non-empty base before '+'
(assert (>= (num_splits local_sat "+") 1))
(assert (= plus_part_sat (split_at local_sat "+" 1)))
(assert (=> (>= (num_splits local_sat "+") 2)
            (and (>= (str.len (split_at local_sat "+" 0)) 1)
                 (>= (str.len plus_part_sat) 1))))

; Domain structure: at least one '.' (so at least 2 labels)
(assert (>= (num_splits domain_sat ".") 2))

; Constrain labels and TLD
(assert (= sub0_sat (split_at domain_sat "." 0)))
(assert (= sub1_sat (split_at domain_sat "." 1)))
(assert (= tld_sat (split_at domain_sat "." (- (num_splits domain_sat ".") 1))))
(assert (>= (str.len sub0_sat) 1))
(assert (>= (str.len sub1_sat) 1))
(assert (>= (str.len tld_sat) 2))

; No empty labels via avoiding ".." in domain
(assert (not (str.contains domain_sat "..")))

; Simple validity: local and domain cannot contain spaces
(assert (not (str.contains local_sat " ")))
(assert (not (str.contains domain_sat " ")))

; Ensure '@' is not at beginning or end by length relationships
(assert (< 0 (str.len local_sat)))
(assert (< 0 (str.len domain_sat)))

; Concrete satisfiable witness
(assert (= email_sat "alice+dev@sub.example.com"))

; =====================
; Email validation (UNSAT instance)
; =====================
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const tld_unsat String)

(assert (= local_unsat (split_at email_unsat "@" 0)))
(assert (= domain_unsat (split_at email_unsat "@" 1)))

; Require exactly one '@'
(assert (= (num_splits email_unsat "@") 2))

; Require at least one '.' in domain
(assert (>= (num_splits domain_unsat ".") 2))
(assert (= tld_unsat (split_at domain_unsat "." (- (num_splits domain_unsat ".") 1))))
(assert (>= (str.len tld_unsat) 2))

; But force a domain without any '.' by fixing the whole email to contradict the above
(assert (= email_unsat "bob@localhost"))

; =====================
; Cross-check: mixed constraints to ensure distinct variables and structural diversity
; =====================
(declare-const email_mixed String)
(declare-const local_mixed String)
(declare-const domain_mixed String)
(declare-const first_label_mixed String)
(declare-const rest_labels_mixed String)

(assert (= local_mixed (split_at email_mixed "@" 0)))
(assert (= domain_mixed (split_at email_mixed "@" 1)))
(assert (= rest_labels_mixed (split_rest domain_mixed "." 1)))
(assert (= first_label_mixed (split_at domain_mixed "." 0)))

; If domain has 3+ labels, then rest_labels contains at least one '.'
(assert (=> (>= (num_splits domain_mixed ".") 3)
            (str.contains rest_labels_mixed ".")))

; Make the mixed email satisfiable but non-trivial
(assert (= email_mixed "carol@test.co"))
(assert (= (num_splits email_mixed "@") 2))
(assert (>= (num_splits domain_mixed ".") 2))
(assert (>= (str.len first_label_mixed) 1))
(assert (not (str.contains local_mixed "@")))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
