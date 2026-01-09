(set-logic ALL)

; Uninterpreted interface for string split methodology
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; -----------------------------
; SAT instance: plausible complex email
; -----------------------------
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const d_first_sat String)
(declare-const d_second_sat String)
(declare-const d_tld_sat String)
(declare-const local_dot0_sat String)
(declare-const local_dot1_sat String)

; Basic structure around '@'
(assert (= local_sat (split_at email_sat "@" 0)))
(assert (= domain_sat (split_at email_sat "@" 1)))
(assert (= "" (split_at email_sat "@" 2)))
(assert (= 2 (num_splits email_sat "@")))
(assert (not (str.contains local_sat "@")))
(assert (not (str.contains domain_sat "@")))
(assert (> (str.len local_sat) 0))
(assert (> (str.len domain_sat) 0))

; Local-part: require at least two dot-separated segments (e.g., first.last)
(assert (>= (num_splits local_sat ".") 2))
(assert (= local_dot0_sat (split_at local_sat "." 0)))
(assert (= local_dot1_sat (split_at local_sat "." 1)))
(assert (> (str.len local_dot0_sat) 0))
(assert (> (str.len local_dot1_sat) 0))
(assert (not (str.contains local_dot0_sat ".")))
(assert (not (str.contains local_dot1_sat ".")))

; Domain: enforce at least three labels: subdomain + domain + tld
(assert (>= (num_splits domain_sat ".") 3))
(assert (= d_first_sat (split_at domain_sat "." 0)))
(assert (= d_second_sat (split_at domain_sat "." 1)))
(assert (= d_tld_sat (split_at domain_sat "." (- (num_splits domain_sat ".") 1))))
(assert (> (str.len d_first_sat) 0))
(assert (> (str.len d_second_sat) 0))
(assert (> (str.len d_tld_sat) 1))

; Ban empty labels and consecutive dots in the domain
(assert (not (str.contains domain_sat "..")))

; Require that the rest from label 1 begins with a dot + the second label (sanity with split_rest)
(assert (str.prefixof (str.++ "." d_second_sat) (split_rest domain_sat "." 1)))

; Mild TLD constraints: alphabetic only, length 2..6
(assert (str.in_re d_tld_sat (re.++ (re.range "a" "z") (re.* (re.range "a" "z")))))
(assert (<= (str.len d_tld_sat) 6))
(assert (>= (str.len d_tld_sat) 2))

; Construct a concrete satisfying example to anchor semantics
(assert (= email_sat "first.last@sub.example.com"))

; -----------------------------
; UNSAT instance: contradicting requirements for '@' splits
; -----------------------------
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)

(assert (= local_unsat (split_at email_unsat "@" 0)))
(assert (= domain_unsat (split_at email_unsat "@" 1)))

; Contradiction: require exactly 2 segments and at least 3 segments when splitting by '@'
(assert (= 2 (num_splits email_unsat "@")))
(assert (>= (num_splits email_unsat "@") 3))

; Additional email-like constraints (do not affect UNSAT core but keep scenario realistic)
(assert (> (str.len local_unsat) 0))
(assert (> (str.len domain_unsat) 0))
(assert (not (str.contains email_unsat " ")))

(check-sat)


; [GENERATION STATUS: SUCCESS]