(set-logic ALL)

; Uninterpreted interface functions for str_split
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

; Email validation scenario: mix of SAT and UNSAT instances

; -------------------------------
; SAT instance: a plausible email structure
; -------------------------------
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const tld_sat String)
(declare-const second_level_sat String)
(declare-const domain_left_sat String)

; Split into local and domain parts
(assert (= local_sat (split_at email_sat "@" 0)))
(assert (= domain_sat (split_at email_sat "@" 1)))
(assert (= 2 (num_splits email_sat "@")))

; Local part constraints (basic sanity)
(assert (>= (str.len local_sat) 1))
(assert (not (str.contains local_sat "@")))
(assert (not (str.contains local_sat " ")))

; Domain must contain at least one dot and no spaces or '@'
(assert (>= (num_splits domain_sat ".") 2))
(assert (not (str.contains domain_sat "@")))
(assert (not (str.contains domain_sat " ")))

; Take last label as TLD, and the label before it as second-level (requires at least 2 labels)
(assert (= tld_sat (split_at domain_sat "." (- (num_splits domain_sat ".") 1))))
(assert (= second_level_sat (split_at domain_sat "." (- (num_splits domain_sat ".") 2))))

; TLD constraints
(assert (>= (str.len tld_sat) 2))
(assert (<= (str.len tld_sat) 24))

; Second-level constraints
(assert (>= (str.len second_level_sat) 1))

; Domain left part: everything before the last dot
(assert (= domain_left_sat (split_rest domain_sat "." 0)))
(assert (= domain_left_sat domain_sat))

; Constrain email_sat by construction to a known-valid example
(assert (= email_sat "alice.smith+tag@example.co.uk"))

; Additional structural checks to tie split behavior to the example
(assert (= local_sat "alice.smith+tag"))
(assert (= domain_sat "example.co.uk"))
(assert (>= (num_splits domain_sat ".") 3))


; -------------------------------
; UNSAT instance 1: requires exactly one '@' but also contains two
; -------------------------------
(declare-const email_unsat_at String)
(declare-const local_unsat_at String)
(declare-const domain_unsat_at String)

(assert (= email_unsat_at "bob@@example.com"))
(assert (= 2 (num_splits email_unsat_at "@")))
(assert (= local_unsat_at (split_at email_unsat_at "@" 0)))
(assert (= domain_unsat_at (split_at email_unsat_at "@" 1)))
; Contradiction: enforce that there is no '@' inside the local part while also forcing local part to contain '@'
(assert (not (str.contains local_unsat_at "@")))
(assert (str.contains local_unsat_at "@"))


; -------------------------------
; UNSAT instance 2: domain must have a dot, but example lacks dot
; -------------------------------
(declare-const email_unsat_dot String)
(declare-const local_unsat_dot String)
(declare-const domain_unsat_dot String)

(assert (= email_unsat_dot "carol@localhost"))
(assert (= 2 (num_splits email_unsat_dot "@")))
(assert (= local_unsat_dot (split_at email_unsat_dot "@" 0)))
(assert (= domain_unsat_dot (split_at email_unsat_dot "@" 1)))
(assert (>= (str.len local_unsat_dot) 1))
; Require at least one dot in domain (at least 2 segments when split by '.')
(assert (>= (num_splits domain_unsat_dot ".") 2))
; Contradiction: also assert domain contains no dot at all
(assert (not (str.contains domain_unsat_dot ".")))


; -------------------------------
; SAT instance 2: minimal but valid structure (single dot domain)
; -------------------------------
(declare-const email_sat2 String)
(declare-const local_sat2 String)
(declare-const domain_sat2 String)
(declare-const tld_sat2 String)
(declare-const sld_sat2 String)

(assert (= email_sat2 "dave@ex.io"))
(assert (= 2 (num_splits email_sat2 "@")))
(assert (= local_sat2 (split_at email_sat2 "@" 0)))
(assert (= domain_sat2 (split_at email_sat2 "@" 1)))
(assert (>= (str.len local_sat2) 1))
(assert (not (str.contains local_sat2 " ")))
(assert (>= (num_splits domain_sat2 ".") 2))
(assert (= tld_sat2 (split_at domain_sat2 "." (- (num_splits domain_sat2 ".") 1))))
(assert (= sld_sat2 (split_at domain_sat2 "." (- (num_splits domain_sat2 ".") 2))))
(assert (>= (str.len tld_sat2) 2))
(assert (>= (str.len sld_sat2) 1))


(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
