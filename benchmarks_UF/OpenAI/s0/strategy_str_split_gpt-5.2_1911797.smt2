(set-logic ALL)

; Uninterpreted interface functions for str_split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; =====================
; SAT instance: plausible complex email address
; =====================
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const domain_first_sat String)
(declare-const tld_sat String)
(declare-const dom_rest_sat String)

; Split at '@' into local and domain
(assert (= local_sat (split_at email_sat "@" 0)))
(assert (= domain_sat (split_at email_sat "@" 1)))
(assert (>= (num_splits email_sat "@") 2))
(assert (< (num_splits email_sat "@") 3))

; Basic non-empty constraints
(assert (> (str.len local_sat) 0))
(assert (> (str.len domain_sat) 0))

; No additional '@' inside local or domain (under-specified but useful)
(assert (< (num_splits local_sat "@") 2))
(assert (< (num_splits domain_sat "@") 2))

; Domain must have at least one '.' and a non-empty TLD
(assert (>= (num_splits domain_sat ".") 2))
(assert (= domain_first_sat (split_at domain_sat "." 0)))
(assert (= tld_sat (split_at domain_sat "." (- (num_splits domain_sat ".") 1))))
(assert (> (str.len domain_first_sat) 0))
(assert (> (str.len tld_sat) 1))

; Domain remainder (from first dot onward) must contain a dot (ensures at least one dot exists)
(assert (= dom_rest_sat (split_rest domain_sat "." 1)))
(assert (str.contains dom_rest_sat "."))

; Character-level sanity: local cannot start/end with '.'
(assert (not (= (str.at local_sat 0) ".")))
(assert (not (= (str.at local_sat (- (str.len local_sat) 1)) ".")))

; Local contains no spaces
(assert (not (str.contains local_sat " ")))

; Constrain SAT email to a concrete example that meets constraints
(assert (= email_sat "john.doe+tag@example.co.uk"))


; =====================
; UNSAT instance: contradictory requirements for email structure
; =====================
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const tld_unsat String)

(assert (= local_unsat (split_at email_unsat "@" 0)))
(assert (= domain_unsat (split_at email_unsat "@" 1)))

; Require exactly one '@'
(assert (>= (num_splits email_unsat "@") 2))
(assert (< (num_splits email_unsat "@") 3))

; Require domain to have at least one '.'
(assert (>= (num_splits domain_unsat ".") 2))
(assert (= tld_unsat (split_at domain_unsat "." (- (num_splits domain_unsat ".") 1))))
(assert (> (str.len tld_unsat) 0))

; Contradiction: also require domain to have no '.'
(assert (< (num_splits domain_unsat ".") 2))

; Provide a concrete email that would otherwise be fine
(assert (= email_unsat "alice@example.com"))

(check-sat)


; [GENERATION STATUS: SUCCESS]