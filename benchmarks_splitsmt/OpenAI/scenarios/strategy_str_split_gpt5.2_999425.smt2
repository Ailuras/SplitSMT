(set-logic ALL)

; Uninterpreted interface functions for str_split

; -----------------------------
; SAT instance: plausible complex email
; -----------------------------
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const tld_sat String)
(declare-const domain_before_tld_sat String)
(declare-const sub0_sat String)
(declare-const sub1_sat String)
(declare-const domain_rest1_sat String)
(declare-const local_first_token_sat String)

; Basic structure: one '@' yielding local and domain
(assert (>= (str.num_splits email_sat "@") 2))
(assert (= local_sat (str.split_at email_sat "@" 0)))
(assert (= domain_sat (str.split_at email_sat "@" 1)))

; Local-part constraints: non-empty, no spaces, has at least one segment when split by '.'
(assert (> (str.len local_sat) 0))
(assert (not (str.contains local_sat " ")))
(assert (>= (str.num_splits local_sat ".") 1))
(assert (= local_first_token_sat (str.split_at local_sat "." 0)))
(assert (> (str.len local_first_token_sat) 0))

; Domain constraints: must have at least 2 dot-separated labels (e.g., example.com)
(assert (>= (str.num_splits domain_sat ".") 2))
(assert (= domain_before_tld_sat (str.split_at domain_sat "." 0)))
(assert (= domain_rest1_sat (str.split_rest domain_sat "." 1)))
(assert (= sub0_sat (str.split_at domain_sat "." 0)))
(assert (= sub1_sat (str.split_at domain_sat "." 1)))
(assert (> (str.len sub0_sat) 0))
(assert (> (str.len sub1_sat) 0))

; TLD is last segment (approximate via requiring that after skipping one label, the rest is a single label)
(assert (= tld_sat domain_rest1_sat))
(assert (>= (str.len tld_sat) 2))
(assert (not (str.contains tld_sat ".")))

; For a complex format, force at least 3 domain labels: a.b.cc (subdomain + domain + tld)
(assert (>= (str.num_splits domain_sat ".") 3))

; Provide a concrete satisfying witness
(assert (= email_sat "john.doe+tag@sub.example.com"))

; -----------------------------
; UNSAT instance: contradictory requirements
; -----------------------------
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const tld_unsat String)

; Require standard email split
(assert (>= (str.num_splits email_unsat "@") 2))
(assert (= local_unsat (str.split_at email_unsat "@" 0)))
(assert (= domain_unsat (str.split_at email_unsat "@" 1)))

; Require domain to have at least 2 labels
(assert (>= (str.num_splits domain_unsat ".") 2))
(assert (= tld_unsat (str.split_rest domain_unsat "." 1)))

; Contradiction: also require domain to have no dots at all
(assert (not (str.contains domain_unsat ".")))

; Also tie to a concrete email-like string (still contradicts dot constraints)
(assert (= email_unsat "alice@nodots"))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
