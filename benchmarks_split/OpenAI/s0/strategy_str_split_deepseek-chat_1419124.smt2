(set-logic ALL)

; Email validation scenario using split constraints over '@' and '.' delimiters

; --- str_split interface (uninterpreted) ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; ----------------------
; SAT instance: complex but valid email
; ----------------------
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const domain_first_sat String)
(declare-const tld_sat String)
(declare-const rest_from_1_sat String)
(declare-const dot_count_sat Int)

(assert (= email_sat "john.doe+tag_123@sub.mail.example.co.uk"))

; exactly one '@' meaning 2 segments
(assert (= (num_splits email_sat "@") 2))
(assert (= local_sat (split_at email_sat "@" 0)))
(assert (= domain_sat (split_at email_sat "@" 1)))

; local-part basic structure constraints
(assert (>= (str.len local_sat) 1))
(assert (not (str.contains local_sat "@")))
(assert (not (str.contains local_sat " ")))
(assert (str.contains local_sat "."))

; domain structure: must have at least one dot and at least 2 labels
(assert (>= (num_splits domain_sat ".") 2))
(assert (= domain_first_sat (split_at domain_sat "." 0)))
(assert (>= (str.len domain_first_sat) 1))

; top-level domain (last label) length >= 2
(assert (= dot_count_sat (num_splits domain_sat ".")))
(assert (>= dot_count_sat 2))
(assert (= tld_sat (split_at domain_sat "." (- dot_count_sat 1))))
(assert (>= (str.len tld_sat) 2))

; split_rest sanity: from index 1 onward equals suffix after first label
(assert (= rest_from_1_sat (split_rest domain_sat "." 1)))
(assert (>= (str.len rest_from_1_sat) 1))

; extra: no consecutive dots in domain (approximate via excluding "..")
(assert (not (str.contains domain_sat "..")))

; ----------------------
; UNSAT instance: contradictory email requirements
; ----------------------
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const tld_unsat String)
(declare-const dot_count_unsat Int)

(assert (= email_unsat "alice@example.com"))

; force exactly one '@'
(assert (= (num_splits email_unsat "@") 2))
(assert (= local_unsat (split_at email_unsat "@" 0)))
(assert (= domain_unsat (split_at email_unsat "@" 1)))

; require domain to have at least one dot
(assert (>= (num_splits domain_unsat ".") 2))

; but also (contradiction) require domain to have no dots
(assert (not (str.contains domain_unsat ".")))

; additionally contradict tld length: must be >= 2 and = 1 simultaneously
(assert (= dot_count_unsat (num_splits domain_unsat ".")))
(assert (>= dot_count_unsat 2))
(assert (= tld_unsat (split_at domain_unsat "." (- dot_count_unsat 1))))
(assert (>= (str.len tld_unsat) 2))
(assert (= (str.len tld_unsat) 1))

(check-sat)


; [GENERATION STATUS: SUCCESS]