(set-logic ALL)

; --- Uninterpreted interface operations (str_split) ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; --- SAT instance: a plausible complex email format ---
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const tld_sat String)
(declare-const domain_first_label_sat String)
(declare-const domain_rest_labels_sat String)
(declare-const dot_segments_sat Int)

(assert (= local_sat (split_at email_sat "@" 0)))
(assert (= domain_sat (split_at email_sat "@" 1)))
(assert (>= (num_splits email_sat "@") 2))
(assert (= (num_splits email_sat "@") 2))

; local-part constraints
(assert (>= (str.len local_sat) 1))
(assert (not (str.contains local_sat "@")))
(assert (not (str.contains local_sat " ")))
(assert (not (str.contains local_sat "..")))

; domain constraints via '.' splitting
(assert (= dot_segments_sat (num_splits domain_sat ".")))
(assert (>= dot_segments_sat 2))
(assert (= domain_first_label_sat (split_at domain_sat "." 0)))
(assert (= tld_sat (split_at domain_sat "." (- dot_segments_sat 1))))
(assert (>= (str.len domain_first_label_sat) 1))
(assert (>= (str.len tld_sat) 2))
(assert (<= (str.len tld_sat) 24))
(assert (not (str.contains domain_sat "..")))
(assert (not (str.contains domain_sat "@")))
(assert (not (str.contains domain_sat " ")))

; remaining labels after first domain label
(assert (= domain_rest_labels_sat (split_rest domain_sat "." 1)))
(assert (>= (str.len domain_rest_labels_sat) 1))

; enforce that the email has some extra complexity (e.g., subdomain)
(assert (>= dot_segments_sat 3))

; concrete witness making it SAT
(assert (= email_sat "john.doe+tag@sub.mail.example.com"))


; --- UNSAT instance: contradictory requirements about domain dots ---
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const dot_segments_unsat Int)

(assert (= local_unsat (split_at email_unsat "@" 0)))
(assert (= domain_unsat (split_at email_unsat "@" 1)))
(assert (= (num_splits email_unsat "@") 2))

(assert (= dot_segments_unsat (num_splits domain_unsat ".")))

; require at least one dot in the domain
(assert (>= dot_segments_unsat 2))

; but also (contradictorily) require the domain to have no dot segments beyond one
(assert (= dot_segments_unsat 1))

; add some well-formedness constraints (won't rescue satisfiability)
(assert (>= (str.len local_unsat) 1))
(assert (>= (str.len domain_unsat) 1))
(assert (not (str.contains email_unsat " ")))

(check-sat)


; [GENERATION STATUS: SUCCESS]