(set-logic ALL)

; Uninterpreted interface for str_split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; ========== SAT instance: plausible email validation constraints ==========
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const tld_sat String)
(declare-const domain_label0_sat String)
(declare-const domain_tail_sat String)
(declare-const at_count_sat Int)
(declare-const dot_count_sat Int)

; Basic split by '@'
(assert (= at_count_sat (num_splits email_sat "@")))
(assert (= at_count_sat 2))
(assert (= local_sat (split_at email_sat "@" 0)))
(assert (= domain_sat (split_at email_sat "@" 1)))

; Local part non-empty and not containing '@'
(assert (> (str.len local_sat) 0))
(assert (not (str.contains local_sat "@")))

; Domain must include at least one '.' and be split into >= 2 labels
(assert (= dot_count_sat (num_splits domain_sat ".")))
(assert (>= dot_count_sat 2))
(assert (= domain_label0_sat (split_at domain_sat "." 0)))
(assert (= domain_tail_sat (split_rest domain_sat "." 1)))
(assert (> (str.len domain_label0_sat) 0))
(assert (> (str.len domain_tail_sat) 0))

; TLD is the last label (approximated by constraining split_at at the last index)
(assert (= tld_sat (split_at domain_sat "." (- dot_count_sat 1))))
(assert (>= (str.len tld_sat) 2))

; Sanity: email itself contains '@' and domain contains '.' (over strings)
(assert (str.contains email_sat "@"))
(assert (str.contains domain_sat "."))

; Provide a concrete witness to ensure SAT
(assert (= email_sat "alice.smith+tag@sub.example.co"))

; ========== UNSAT instance: contradictory email/domain structure ==========
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const at_count_unsat Int)
(declare-const dot_count_unsat Int)
(declare-const tld_unsat String)

; Force single '@' split (2 segments)
(assert (= at_count_unsat (num_splits email_unsat "@")))
(assert (= at_count_unsat 2))
(assert (= local_unsat (split_at email_unsat "@" 0)))
(assert (= domain_unsat (split_at email_unsat "@" 1)))
(assert (> (str.len local_unsat) 0))

; Contradiction: domain required to have at least one '.', but also forced to have exactly 1 segment when split by '.'
(assert (= dot_count_unsat (num_splits domain_unsat ".")))
(assert (>= dot_count_unsat 2))
(assert (= dot_count_unsat 1))

; Additionally constrain tld based on dot_count_unsat (still consistent syntactically)
(assert (= tld_unsat (split_at domain_unsat "." (- dot_count_unsat 1))))
(assert (>= (str.len tld_unsat) 2))

; Concrete witness that still cannot satisfy the contradictory dot_count constraints
(assert (= email_unsat "bob@nodotdomain"))

(check-sat)


; [GENERATION STATUS: SUCCESS]