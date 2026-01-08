(set-logic ALL)

; Email Validation using str_split: '@' separates local-part and domain, '.' separates domain labels

; --- Uninterpreted split interface ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; --- Shared helper constraints (conceptual email structure) ---
; We model constraints over segments and some direct string properties.

; =====================
; SAT instance: a plausible complex email
; =====================
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const tld_sat String)
(declare-const sld_sat String)
(declare-const sub_sat String)
(declare-const rest_after_at_sat String)

(assert (= email_sat "john.doe+tag@sub.example.co.uk"))

; Must have exactly one '@' => two segments
(assert (= (num_splits email_sat "@") 2))
(assert (= local_sat (split_at email_sat "@" 0)))
(assert (= domain_sat (split_at email_sat "@" 1)))
(assert (= rest_after_at_sat (split_rest email_sat "@" 1)))
(assert (= domain_sat rest_after_at_sat))

; Local-part sanity
(assert (> (str.len local_sat) 0))
(assert (not (str.contains local_sat "@")))

; Domain must contain at least one '.' and have >= 3 labels here (sub + example + co + uk => 4)
(assert (>= (num_splits domain_sat ".") 2))
(assert (= (num_splits domain_sat ".") 4))
(assert (= sub_sat (split_at domain_sat "." 0)))
(assert (= sld_sat (split_at domain_sat "." 1)))
(assert (= (split_at domain_sat "." 2) "co"))
(assert (= tld_sat (split_at domain_sat "." 3)))

; Each relevant label non-empty
(assert (> (str.len sub_sat) 0))
(assert (> (str.len sld_sat) 0))
(assert (> (str.len tld_sat) 0))

; Basic domain restrictions: no '@' inside domain
(assert (not (str.contains domain_sat "@")))

; TLD example constraint (uk)
(assert (= tld_sat "uk"))


; =====================
; UNSAT instance: contradictory domain structure constraints
; =====================
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const tld_unsat String)
(declare-const dot_count_unsat Int)

(assert (= email_unsat "alice@company.com"))

; Force exactly one '@'
(assert (= (num_splits email_unsat "@") 2))
(assert (= local_unsat (split_at email_unsat "@" 0)))
(assert (= domain_unsat (split_at email_unsat "@" 1)))
(assert (> (str.len local_unsat) 0))
(assert (> (str.len domain_unsat) 0))

; Contradiction: require exactly 1 dot-label in domain (no '.') but also require domain contains '.'
(assert (= dot_count_unsat (num_splits domain_unsat ".")))
(assert (= dot_count_unsat 1))
(assert (str.contains domain_unsat "."))

; Additional conflicting constraint on TLD extraction requiring at least 2 labels
(assert (>= (num_splits domain_unsat ".") 2))
(assert (= tld_unsat (split_at domain_unsat "." 1)))
(assert (= tld_unsat "com"))


; The combined file contains both a SAT-constrained email and an UNSAT-constrained email;
; overall result should be UNSAT due to the unsat block above.
(check-sat)


; [GENERATION STATUS: SUCCESS]
