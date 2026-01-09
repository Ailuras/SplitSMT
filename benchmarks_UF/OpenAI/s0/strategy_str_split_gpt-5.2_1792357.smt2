(set-logic ALL)

; Uninterpreted split interface (str_split)
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; -------------------------------
; SAT instance: a plausible email address satisfying structural constraints
; -------------------------------
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const domain_first_sat String)
(declare-const tld_sat String)
(declare-const rest_after_first_dot_sat String)
(declare-const num_domain_parts_sat Int)

(assert (= local_sat (split_at email_sat "@" 0)))
(assert (= domain_sat (split_at email_sat "@" 1)))
(assert (= (num_splits email_sat "@") 2))

; local part constraints
(assert (>= (str.len local_sat) 1))
(assert (not (str.contains local_sat "@")))
(assert (not (str.contains local_sat " ")))
(assert (not (str.contains local_sat "..")))
(assert (not (= (str.at local_sat 0) ".")))
(assert (not (= (str.at local_sat (- (str.len local_sat) 1)) ".")))

; domain constraints based on '.' segments
(assert (= num_domain_parts_sat (num_splits domain_sat ".")))
(assert (>= num_domain_parts_sat 2))

(assert (= domain_first_sat (split_at domain_sat "." 0)))
(assert (= rest_after_first_dot_sat (split_rest domain_sat "." 1)))
(assert (= tld_sat (split_at domain_sat "." (- num_domain_parts_sat 1))))

(assert (>= (str.len domain_first_sat) 1))
(assert (>= (str.len tld_sat) 2))
(assert (<= (str.len tld_sat) 24))
(assert (not (str.contains domain_sat "@")))
(assert (not (str.contains domain_sat " ")))
(assert (not (str.contains domain_sat "..")))
(assert (not (= (str.at domain_sat 0) ".")))
(assert (not (= (str.at domain_sat (- (str.len domain_sat) 1)) ".")))

; Ensure there is at least one '.' after '@' by requiring rest_after_first_dot_sat to start with a non-empty suffix
(assert (>= (str.len rest_after_first_dot_sat) 1))

; Make SAT concrete
(assert (= email_sat "alice.smith+tag@example.co.uk"))

; -------------------------------
; UNSAT instance: contradictory requirements for domain structure
; -------------------------------
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const tld_unsat String)
(declare-const num_domain_parts_unsat Int)

(assert (= local_unsat (split_at email_unsat "@" 0)))
(assert (= domain_unsat (split_at email_unsat "@" 1)))
(assert (= (num_splits email_unsat "@") 2))

(assert (>= (str.len local_unsat) 1))
(assert (not (str.contains local_unsat "@")))

(assert (= num_domain_parts_unsat (num_splits domain_unsat ".")))
(assert (>= num_domain_parts_unsat 2))
(assert (= tld_unsat (split_at domain_unsat "." (- num_domain_parts_unsat 1))))

; Contradiction: require TLD length >= 2 but also force it to be exactly "x" (length 1)
(assert (>= (str.len tld_unsat) 2))
(assert (= tld_unsat "x"))

; Make the rest concrete (still UNSAT due to the contradiction above)
(assert (= email_unsat "bob@domain.x"))

(check-sat)


; [GENERATION STATUS: SUCCESS]