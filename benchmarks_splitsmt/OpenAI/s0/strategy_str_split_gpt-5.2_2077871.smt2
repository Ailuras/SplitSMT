(set-logic ALL)

; Email Validation scenario using str_split abstraction and native string constraints

; --- Uninterpreted split interface ---

; --- Common declarations ---
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const tld_sat String)
(declare-const domain_core_sat String)
(declare-const left_label_sat String)
(declare-const right_label_sat String)
(declare-const reconstructed_sat String)

(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const tld_unsat String)
(declare-const domain_core_unsat String)

; ------------------------------
; SAT instance: a well-structured email
; local part: split_at(email,"@",0)
; domain part: split_at(email,"@",1)
; domain must contain at least one '.' and a TLD length constraint
; ------------------------------
(assert (= local_sat (str.split_at email_sat "@" 0)))
(assert (= domain_sat (str.split_at email_sat "@" 1)))
(assert (>= (str.num_splits email_sat "@") 2))
(assert (= (str.num_splits email_sat "@") 2))

; Basic non-emptiness and no spaces
(assert (> (str.len local_sat) 0))
(assert (> (str.len domain_sat) 0))
(assert (not (str.contains email_sat " ")))
(assert (not (str.contains local_sat "@")))
(assert (not (str.contains domain_sat "@")))

; Domain must be dot-separated: at least two segments (core + tld)
(assert (>= (str.num_splits domain_sat ".") 2))
(assert (= domain_core_sat (str.split_at domain_sat "." 0)))
(assert (= tld_sat (str.split_rest domain_sat "." 1)))
(assert (> (str.len domain_core_sat) 0))
(assert (> (str.len tld_sat) 1))
(assert (<= (str.len tld_sat) 24))

; Ensure the TLD has no dots (since it is the rest from index 1, constrain to a single label via num_splits)
(assert (= (str.num_splits tld_sat ".") 1))

; Additional domain structure: core must contain at least one dot label split (e.g., sub.domain)
(assert (>= (str.num_splits domain_core_sat ".") 1))

; Constrain domain_sat to have no empty labels like "a..b" by forcing the first two labels non-empty
(assert (= left_label_sat (str.split_at domain_sat "." 0)))
(assert (= right_label_sat (str.split_at domain_sat "." 1)))
(assert (> (str.len left_label_sat) 0))
(assert (> (str.len right_label_sat) 0))

; Reconstruct the email via concatenation and split_rest agreement
(assert (= reconstructed_sat (str.++ local_sat "@" domain_sat)))
(assert (= email_sat reconstructed_sat))

; Provide a concrete satisfying shape
(assert (= email_sat "alice.smith@sub.example.com"))

; ------------------------------
; UNSAT instance: contradictory constraints about domain/TLD structure
; ------------------------------
(assert (= local_unsat (str.split_at email_unsat "@" 0)))
(assert (= domain_unsat (str.split_at email_unsat "@" 1)))
(assert (= (str.num_splits email_unsat "@") 2))
(assert (> (str.len local_unsat) 0))
(assert (> (str.len domain_unsat) 0))

; Force domain to have a dot and define TLD as rest after first dot
(assert (>= (str.num_splits domain_unsat ".") 2))
(assert (= domain_core_unsat (str.split_at domain_unsat "." 0)))
(assert (= tld_unsat (str.split_rest domain_unsat "." 1)))
(assert (> (str.len tld_unsat) 0))

; Contradiction: say TLD must contain no dots (single segment) AND also must have at least one dot
(assert (= (str.num_splits tld_unsat ".") 1))
(assert (>= (str.num_splits tld_unsat ".") 2))

; Additionally pin a plausible email to avoid vacuity
(assert (= email_unsat "bob@company.org"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
