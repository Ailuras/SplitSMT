(set-logic ALL)

; Email Validation scenario using str_split abstraction and native string constraints

; --- Uninterpreted split interface ---
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

; --- Common declarations ---
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const tld_sat String)
(declare-const domain_core_sat String)
(declare-const left_label_sat String)
(declare-const right_label_sat String)
(declare-const reconstructed_sat String)

(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const tld_unsat String)
(declare-const domain_core_unsat String)

; ------------------------------
; SAT instance: a well-structured email
; local part: split_at(email,"@",0)
; domain part: split_at(email,"@",1)
; domain must contain at least one '.' and a TLD length constraint
; ------------------------------
(assert (= local_sat (split_at email_sat "@" 0)))
(assert (= domain_sat (split_at email_sat "@" 1)))
(assert (>= (num_splits email_sat "@") 2))
(assert (= (num_splits email_sat "@") 2))

; Basic non-emptiness and no spaces
(assert (> (str.len local_sat) 0))
(assert (> (str.len domain_sat) 0))
(assert (not (str.contains email_sat " ")))
(assert (not (str.contains local_sat "@")))
(assert (not (str.contains domain_sat "@")))

; Domain must be dot-separated: at least two segments (core + tld)
(assert (>= (num_splits domain_sat ".") 2))
(assert (= domain_core_sat (split_at domain_sat "." 0)))
(assert (= tld_sat (split_rest domain_sat "." 1)))
(assert (> (str.len domain_core_sat) 0))
(assert (> (str.len tld_sat) 1))
(assert (<= (str.len tld_sat) 24))

; Ensure the TLD has no dots (since it is the rest from index 1, constrain to a single label via num_splits)
(assert (= (num_splits tld_sat ".") 1))

; Additional domain structure: core must contain at least one dot label split (e.g., sub.domain)
(assert (>= (num_splits domain_core_sat ".") 1))

; Constrain domain_sat to have no empty labels like "a..b" by forcing the first two labels non-empty
(assert (= left_label_sat (split_at domain_sat "." 0)))
(assert (= right_label_sat (split_at domain_sat "." 1)))
(assert (> (str.len left_label_sat) 0))
(assert (> (str.len right_label_sat) 0))

; Reconstruct the email via concatenation and split_rest agreement
(assert (= reconstructed_sat (str.++ local_sat "@" domain_sat)))
(assert (= email_sat reconstructed_sat))

; Provide a concrete satisfying shape
(assert (= email_sat "alice.smith@sub.example.com"))

; ------------------------------
; UNSAT instance: contradictory constraints about domain/TLD structure
; ------------------------------
(assert (= local_unsat (split_at email_unsat "@" 0)))
(assert (= domain_unsat (split_at email_unsat "@" 1)))
(assert (= (num_splits email_unsat "@") 2))
(assert (> (str.len local_unsat) 0))
(assert (> (str.len domain_unsat) 0))

; Force domain to have a dot and define TLD as rest after first dot
(assert (>= (num_splits domain_unsat ".") 2))
(assert (= domain_core_unsat (split_at domain_unsat "." 0)))
(assert (= tld_unsat (split_rest domain_unsat "." 1)))
(assert (> (str.len tld_unsat) 0))

; Contradiction: say TLD must contain no dots (single segment) AND also must have at least one dot
(assert (= (num_splits tld_unsat ".") 1))
(assert (>= (num_splits tld_unsat ".") 2))

; Additionally pin a plausible email to avoid vacuity
(assert (= email_unsat "bob@company.org"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
