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

; Uninterpreted split interface

; Email candidates
(declare-const email_sat String)
(declare-const email_unsat String)

; Common derived parts for SAT email
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const tld_sat String)
(declare-const domain_core_sat String)
(declare-const sub0_sat String)
(declare-const sub1_sat String)

; Common derived parts for UNSAT email
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const tld_unsat String)
(declare-const domain_core_unsat String)
(declare-const sub0_unsat String)
(declare-const sub1_unsat String)

; Some helper strings for structure checks
(declare-const dot String)
(declare-const atsym String)
(assert (= dot "."))
(assert (= atsym "@"))

; ----------------------
; SAT instance constraints (complex but satisfiable)
; ----------------------

; Exactly one '@' => two segments when split by '@'
(assert (= (num_splits email_sat atsym) 2))
(assert (= local_sat (split_at email_sat atsym 0)))
(assert (= domain_sat (split_at email_sat atsym 1)))

; local-part constraints (non-empty, no spaces, no '@')
(assert (> (str.len local_sat) 0))
(assert (not (str.contains local_sat " ")))
(assert (not (str.contains local_sat atsym)))

; domain constraints: at least one dot; non-empty overall
(assert (> (str.len domain_sat) 0))
(assert (>= (num_splits domain_sat dot) 2))

; Extract last label as TLD and the rest as core
(assert (= tld_sat (split_at domain_sat dot (- (num_splits domain_sat dot) 1))))
(assert (= domain_core_sat (split_rest domain_sat dot 0)))

; Enforce TLD properties
(assert (>= (str.len tld_sat) 2))
(assert (not (str.contains tld_sat dot)))
(assert (not (str.contains tld_sat "-")))

; Ensure domain does not start/end with '.' and has at least one subdomain segment
(assert (> (str.len (split_at domain_sat dot 0)) 0))
(assert (> (str.len (split_at domain_sat dot 1)) 0))

; Force at least two labels in domain and constrain first two labels (adds complexity)
(assert (>= (num_splits domain_sat dot) 3))
(assert (= sub0_sat (split_at domain_sat dot 0)))
(assert (= sub1_sat (split_at domain_sat dot 1)))
(assert (>= (str.len sub0_sat) 1))
(assert (>= (str.len sub1_sat) 1))
(assert (not (str.contains sub0_sat "_")))
(assert (not (str.contains sub1_sat "_")))

; Concrete satisfiable witness to anchor the model
(assert (= email_sat "alice.smith+tag@sub.example.com"))

; ----------------------
; UNSAT instance constraints (intentionally contradictory)
; ----------------------

; Claim: exactly one '@'
(assert (= (num_splits email_unsat atsym) 2))
(assert (= local_unsat (split_at email_unsat atsym 0)))
(assert (= domain_unsat (split_at email_unsat atsym 1)))

; Additional domain structure requirements
(assert (>= (num_splits domain_unsat dot) 2))
(assert (= tld_unsat (split_at domain_unsat dot (- (num_splits domain_unsat dot) 1))))
(assert (= domain_core_unsat (split_rest domain_unsat dot 0)))
(assert (>= (str.len tld_unsat) 2))

; Contradiction anchor: choose an email with TWO '@' symbols
(assert (= email_unsat "a@b@c.com"))

; Extra constraints to emphasize intended validation intent
(assert (> (str.len local_unsat) 0))
(assert (> (str.len domain_unsat) 0))
(assert (not (str.contains domain_unsat atsym)))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
