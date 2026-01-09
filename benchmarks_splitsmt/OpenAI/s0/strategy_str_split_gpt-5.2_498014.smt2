(set-logic ALL)

; Uninterpreted interface functions for str_split

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
(assert (= local_sat (str.split_at email_sat "@" 0)))
(assert (= domain_sat (str.split_at email_sat "@" 1)))
(assert (= 2 (str.num_splits email_sat "@")))

; Local part constraints (basic sanity)
(assert (>= (str.len local_sat) 1))
(assert (not (str.contains local_sat "@")))
(assert (not (str.contains local_sat " ")))

; Domain must contain at least one dot and no spaces or '@'
(assert (>= (str.num_splits domain_sat ".") 2))
(assert (not (str.contains domain_sat "@")))
(assert (not (str.contains domain_sat " ")))

; Take last label as TLD, and the label before it as second-level (requires at least 2 labels)
(assert (= tld_sat (str.split_at domain_sat "." (- (str.num_splits domain_sat ".") 1))))
(assert (= second_level_sat (str.split_at domain_sat "." (- (str.num_splits domain_sat ".") 2))))

; TLD constraints
(assert (>= (str.len tld_sat) 2))
(assert (<= (str.len tld_sat) 24))

; Second-level constraints
(assert (>= (str.len second_level_sat) 1))

; Domain left part: everything before the last dot
(assert (= domain_left_sat (str.split_rest domain_sat "." 0)))
(assert (= domain_left_sat domain_sat))

; Constrain email_sat by construction to a known-valid example
(assert (= email_sat "alice.smith+tag@example.co.uk"))

; Additional structural checks to tie split behavior to the example
(assert (= local_sat "alice.smith+tag"))
(assert (= domain_sat "example.co.uk"))
(assert (>= (str.num_splits domain_sat ".") 3))


; -------------------------------
; UNSAT instance 1: requires exactly one '@' but also contains two
; -------------------------------
(declare-const email_unsat_at String)
(declare-const local_unsat_at String)
(declare-const domain_unsat_at String)

(assert (= email_unsat_at "bob@@example.com"))
(assert (= 2 (str.num_splits email_unsat_at "@")))
(assert (= local_unsat_at (str.split_at email_unsat_at "@" 0)))
(assert (= domain_unsat_at (str.split_at email_unsat_at "@" 1)))
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
(assert (= 2 (str.num_splits email_unsat_dot "@")))
(assert (= local_unsat_dot (str.split_at email_unsat_dot "@" 0)))
(assert (= domain_unsat_dot (str.split_at email_unsat_dot "@" 1)))
(assert (>= (str.len local_unsat_dot) 1))
; Require at least one dot in domain (at least 2 segments when split by '.')
(assert (>= (str.num_splits domain_unsat_dot ".") 2))
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
(assert (= 2 (str.num_splits email_sat2 "@")))
(assert (= local_sat2 (str.split_at email_sat2 "@" 0)))
(assert (= domain_sat2 (str.split_at email_sat2 "@" 1)))
(assert (>= (str.len local_sat2) 1))
(assert (not (str.contains local_sat2 " ")))
(assert (>= (str.num_splits domain_sat2 ".") 2))
(assert (= tld_sat2 (str.split_at domain_sat2 "." (- (str.num_splits domain_sat2 ".") 1))))
(assert (= sld_sat2 (str.split_at domain_sat2 "." (- (str.num_splits domain_sat2 ".") 2))))
(assert (>= (str.len tld_sat2) 2))
(assert (>= (str.len sld_sat2) 1))


(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
