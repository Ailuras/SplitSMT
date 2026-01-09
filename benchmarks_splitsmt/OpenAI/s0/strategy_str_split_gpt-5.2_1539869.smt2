(set-logic ALL)

; Uninterpreted interface for string split operations

; ==========================
; Scenario: Email Validation
; ==========================

; --- SAT instance: a plausible complex email ---
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const tld_sat String)
(declare-const sld_sat String)
(declare-const host_sat String)
(declare-const first_host_label_sat String)
(declare-const rest_host_labels_sat String)

; Split at '@': local and domain
(assert (= local_sat (str.split_at email_sat "@" 0)))
(assert (= domain_sat (str.split_at email_sat "@" 1)))
(assert (>= (str.num_splits email_sat "@") 2))
(assert (<= (str.num_splits email_sat "@") 2))

; Basic structural constraints
(assert (>= (str.len email_sat) 6))
(assert (>= (str.len local_sat) 1))
(assert (>= (str.len domain_sat) 3))
(assert (not (str.contains local_sat "@")))
(assert (not (str.contains domain_sat "@")))

; Local-part constraints: no spaces, must contain at least one '.' (complex local)
(assert (not (str.contains local_sat " ")))
(assert (str.contains local_sat "."))
(assert (not (= (str.at local_sat 0) ".")))
(assert (not (= (str.at local_sat (- (str.len local_sat) 1)) ".")))

; Domain constraints: at least 2 dot-separated segments, and has a non-empty TLD
(assert (>= (str.num_splits domain_sat ".") 2))
(assert (= tld_sat (str.split_at domain_sat "." (- (str.num_splits domain_sat ".") 1))))
(assert (>= (str.len tld_sat) 2))

; Enforce that domain ends with "." + tld (via split_rest from last index)
(assert (= (str.split_rest domain_sat "." (- (str.num_splits domain_sat ".") 1)) tld_sat))

; Model a domain of the form host.sld.tld (at least 3 segments)
(assert (>= (str.num_splits domain_sat ".") 3))
(assert (= host_sat (str.split_at domain_sat "." 0)))
(assert (= sld_sat (str.split_at domain_sat "." (- (str.num_splits domain_sat ".") 2))))
(assert (>= (str.len host_sat) 1))
(assert (>= (str.len sld_sat) 1))

; Host itself can have hyphenated/extra labels: enforce at least one label and optionally more via rest
(assert (= first_host_label_sat (str.split_at host_sat "-" 0)))
(assert (>= (str.num_splits host_sat "-") 1))
(assert (= rest_host_labels_sat (str.split_rest host_sat "-" 1)))
(assert (>= (str.len first_host_label_sat) 1))

; Concrete satisfying example (consistent with all constraints)
(assert (= email_sat "john.doe+tag@sub-mail.example.co"))


; --- UNSAT instance: contradictory domain structure requirements ---
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const tld_unsat String)

; Split at '@'
(assert (= local_unsat (str.split_at email_unsat "@" 0)))
(assert (= domain_unsat (str.split_at email_unsat "@" 1)))
(assert (= (str.num_splits email_unsat "@") 2))

; Contradiction: domain must have at least 2 dot segments but also exactly 1 segment
(assert (>= (str.num_splits domain_unsat ".") 2))
(assert (= (str.num_splits domain_unsat ".") 1))

; Additional typical constraints (won't rescue satisfiability)
(assert (>= (str.len local_unsat) 1))
(assert (>= (str.len domain_unsat) 1))
(assert (= tld_unsat (str.split_at domain_unsat "." 0)))
(assert (>= (str.len tld_unsat) 2))

; Concrete-looking email (still UNSAT due to above contradiction)
(assert (= email_unsat "a@b"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
