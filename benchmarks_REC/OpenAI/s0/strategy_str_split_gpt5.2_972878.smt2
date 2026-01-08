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

; Email Validation using str_split interface

; --- Uninterpreted interface functions (str_split) ---

; --- SAT instance variables ---
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const domain_name_sat String)
(declare-const tld_sat String)
(declare-const combined_domain_sat String)

; Parse around '@'
(assert (= local_sat (split_at email_sat "@" 0)))
(assert (= domain_sat (split_at email_sat "@" 1)))
(assert (= (num_splits email_sat "@") 2))

; Basic local-part constraints
(assert (>= (str.len local_sat) 1))
(assert (not (str.contains local_sat " ")))
(assert (not (str.contains local_sat "@")))

; Domain must be non-empty and contain at least one '.'
(assert (>= (str.len domain_sat) 3))
(assert (>= (num_splits domain_sat ".") 2))

; Require exactly one dot separating domain name and TLD (simple-but-nontrivial structure)
(assert (= (num_splits domain_sat ".") 2))
(assert (= domain_name_sat (split_at domain_sat "." 0)))
(assert (= tld_sat (split_at domain_sat "." 1)))
(assert (>= (str.len domain_name_sat) 1))
(assert (>= (str.len tld_sat) 2))

; Disallow spaces and '@' in domain pieces
(assert (not (str.contains domain_sat " ")))
(assert (not (str.contains domain_sat "@")))
(assert (not (str.contains domain_name_sat "@")))
(assert (not (str.contains tld_sat "@")))

; Ensure dot does not appear inside either piece for the exact-1-dot domain shape
(assert (= (num_splits domain_name_sat ".") 1))
(assert (= (num_splits tld_sat ".") 1))

; Reconstruct domain via concatenation for consistency
(assert (= combined_domain_sat (str.++ domain_name_sat "." tld_sat)))
(assert (= combined_domain_sat domain_sat))

; Concrete witness to make SAT easy for solvers even with uninterpreted split
(assert (= email_sat "alice@example.com"))
(assert (= local_sat "alice"))
(assert (= domain_sat "example.com"))
(assert (= domain_name_sat "example"))
(assert (= tld_sat "com"))
(assert (= combined_domain_sat "example.com"))

; --- UNSAT instance variables ---
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const dom_a_unsat String)
(declare-const dom_b_unsat String)
(declare-const dom_c_unsat String)

; Parse around '@'
(assert (= local_unsat (split_at email_unsat "@" 0)))
(assert (= domain_unsat (split_at email_unsat "@" 1)))
(assert (= (num_splits email_unsat "@") 2))

; Domain is required to have at least one '.'
(assert (>= (num_splits domain_unsat ".") 2))

; Also require exactly three segments by '.' (e.g., sub.domain.tld)
(assert (= (num_splits domain_unsat ".") 3))
(assert (= dom_a_unsat (split_at domain_unsat "." 0)))
(assert (= dom_b_unsat (split_at domain_unsat "." 1)))
(assert (= dom_c_unsat (split_at domain_unsat "." 2)))
(assert (>= (str.len dom_a_unsat) 1))
(assert (>= (str.len dom_b_unsat) 1))
(assert (>= (str.len dom_c_unsat) 2))

; Make it contradictory by forcing the domain to be a concrete 2-segment domain
(assert (= email_unsat "bob@example.com"))
(assert (= domain_unsat "example.com"))

; If domain_unsat is "example.com", then it cannot have 3 segments under '.'
; The contradiction is expressed via the required num_splits=3 above.

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
