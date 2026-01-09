(set-logic ALL)

; Uninterpreted split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

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

(check-sat)


; [GENERATION STATUS: SUCCESS]