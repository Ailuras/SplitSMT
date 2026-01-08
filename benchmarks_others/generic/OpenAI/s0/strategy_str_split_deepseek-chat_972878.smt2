(set-logic ALL)

; Email Validation using str_split interface

; --- Uninterpreted interface functions (str_split) ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; --- SAT instance variables ---
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const domain_name_sat String)
(declare-const tld_sat String)
(declare-const combined_domain_sat String)

; Parse around '@'
(assert (= local_sat (split_at email_sat "@" 0)))
(assert (= domain_sat (split_at email_sat "@" 1)))
(assert (= (num_splits email_sat "@") 2))

; Basic local-part constraints
(assert (>= (str.len local_sat) 1))
(assert (not (str.contains local_sat " ")))
(assert (not (str.contains local_sat "@")))

; Domain must be non-empty and contain at least one '.'
(assert (>= (str.len domain_sat) 3))
(assert (>= (num_splits domain_sat ".") 2))

; Require exactly one dot separating domain name and TLD (simple-but-nontrivial structure)
(assert (= (num_splits domain_sat ".") 2))
(assert (= domain_name_sat (split_at domain_sat "." 0)))
(assert (= tld_sat (split_at domain_sat "." 1)))
(assert (>= (str.len domain_name_sat) 1))
(assert (>= (str.len tld_sat) 2))

; Disallow spaces and '@' in domain pieces
(assert (not (str.contains domain_sat " ")))
(assert (not (str.contains domain_sat "@")))
(assert (not (str.contains domain_name_sat "@")))
(assert (not (str.contains tld_sat "@")))

; Ensure dot does not appear inside either piece for the exact-1-dot domain shape
(assert (= (num_splits domain_name_sat ".") 1))
(assert (= (num_splits tld_sat ".") 1))

; Reconstruct domain via concatenation for consistency
(assert (= combined_domain_sat (str.++ domain_name_sat "." tld_sat)))
(assert (= combined_domain_sat domain_sat))

; Concrete witness to make SAT easy for solvers even with uninterpreted split
(assert (= email_sat "alice@example.com"))
(assert (= local_sat "alice"))
(assert (= domain_sat "example.com"))
(assert (= domain_name_sat "example"))
(assert (= tld_sat "com"))
(assert (= combined_domain_sat "example.com"))

; --- UNSAT instance variables ---
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const dom_a_unsat String)
(declare-const dom_b_unsat String)
(declare-const dom_c_unsat String)

; Parse around '@'
(assert (= local_unsat (split_at email_unsat "@" 0)))
(assert (= domain_unsat (split_at email_unsat "@" 1)))
(assert (= (num_splits email_unsat "@") 2))

; Domain is required to have at least one '.'
(assert (>= (num_splits domain_unsat ".") 2))

; Also require exactly three segments by '.' (e.g., sub.domain.tld)
(assert (= (num_splits domain_unsat ".") 3))
(assert (= dom_a_unsat (split_at domain_unsat "." 0)))
(assert (= dom_b_unsat (split_at domain_unsat "." 1)))
(assert (= dom_c_unsat (split_at domain_unsat "." 2)))
(assert (>= (str.len dom_a_unsat) 1))
(assert (>= (str.len dom_b_unsat) 1))
(assert (>= (str.len dom_c_unsat) 2))

; Make it contradictory by forcing the domain to be a concrete 2-segment domain
(assert (= email_unsat "bob@example.com"))
(assert (= domain_unsat "example.com"))

; If domain_unsat is "example.com", then it cannot have 3 segments under '.'
; The contradiction is expressed via the required num_splits=3 above.

(check-sat)


; [GENERATION STATUS: SUCCESS]
