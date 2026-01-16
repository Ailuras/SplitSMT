(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Email Validation using str_split-like interface

; Uninterpreted split interface

; -------------------------
; SAT instance: a valid-looking email with structural constraints
; -------------------------
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_full_sat String)
(declare-const domain_head_sat String)
(declare-const tld_sat String)
(declare-const domain_rest_from1_sat String)
(declare-const domain_dots_sat Int)

; Ensure exactly one '@' => two segments when splitting by '@'
(assert (= (num_splits email_sat "@") 2))
(assert (= local_sat (split_at email_sat "@" 0)))
(assert (= domain_full_sat (split_at email_sat "@" 1)))

; Local part constraints: non-empty, no '@'
(assert (> (str.len local_sat) 0))
(assert (not (str.contains local_sat "@")))

; Domain must contain at least one '.' => at least two segments when splitting by '.'
(assert (>= (num_splits domain_full_sat ".") 2))
(assert (= domain_head_sat (split_at domain_full_sat "." 0)))
(assert (= tld_sat (split_at domain_full_sat "." (- (num_splits domain_full_sat ".") 1))))
(assert (= domain_rest_from1_sat (split_rest domain_full_sat "." 1)))

; Head label constraints: non-empty and no '.'
(assert (> (str.len domain_head_sat) 0))
(assert (not (str.contains domain_head_sat ".")))

; TLD constraints: length 2..10, no '.'
(assert (>= (str.len tld_sat) 2))
(assert (<= (str.len tld_sat) 10))
(assert (not (str.contains tld_sat ".")))

; Domain tail (everything after first dot) should be non-empty and contain no '@'
(assert (> (str.len domain_rest_from1_sat) 0))
(assert (not (str.contains domain_full_sat "@")))

; Provide a concrete witness to ensure satisfiable
(assert (= email_sat "alice.smith@sub.example.co"))

; Add a small arithmetic constraint connected to structure (kept consistent)
(assert (= domain_dots_sat (- (num_splits domain_full_sat ".") 1)))
(assert (>= domain_dots_sat 1))

; -------------------------
; UNSAT instance: contradictory email requirements
; -------------------------
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_full_unsat String)
(declare-const tld_unsat String)

; Exactly one '@'
(assert (= (num_splits email_unsat "@") 2))
(assert (= local_unsat (split_at email_unsat "@" 0)))
(assert (= domain_full_unsat (split_at email_unsat "@" 1)))

; Require a domain with at least one '.'
(assert (>= (num_splits domain_full_unsat ".") 2))
(assert (= tld_unsat (split_at domain_full_unsat "." (- (num_splits domain_full_unsat ".") 1))))

; Contradiction: force domain to contain no '.' while also requiring dot-splitting into >=2 parts
(assert (not (str.contains domain_full_unsat ".")))

; Additional constraints (still consistent alone): local must be non-empty
(assert (> (str.len local_unsat) 0))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
