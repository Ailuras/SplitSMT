(set-logic ALL)

; Uninterpreted interface operations for str_split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Seed-like boolean structure
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)

; Inputs / derived segments
(declare-const email String)
(declare-const local_part String)
(declare-const domain String)
(declare-const domain_first String)
(declare-const domain_tld String)
(declare-const domain_rest String)
(declare-const at_count Int)
(declare-const dot_count Int)
(declare-const local_len Int)
(declare-const domain_len Int)

; Core structure: non-empty check and its negation
(assert (= T_1 (not (= "" email))))
(assert (= T_2 (not T_1)))

; Split by '@' and check counts
(assert (= at_count (num_splits email "@")))
(assert (= local_part (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))

; Split domain by '.' and check structure
(assert (= dot_count (num_splits domain ".")))
(assert (= domain_first (split_at domain "." 0)))
(assert (= domain_tld (split_at domain "." (- dot_count 1))))
(assert (= domain_rest (split_rest domain "." 1)))

; Length bookkeeping
(assert (= local_len (str.len local_part)))
(assert (= domain_len (str.len domain)))

; Email validation constraints (intentionally inconsistent to yield UNSAT)
(assert (>= at_count 2))
(assert (= at_count 2))
(assert (>= dot_count 2))
(assert (= dot_count 1))

; Require that local/domain are non-empty (valid email expectation)
(assert (> local_len 0))
(assert (> domain_len 0))
(assert (not (= "" domain_tld)))
(assert (not (= "" domain_first)))

; Derived booleans tied into the seed-like structure
(assert (= T_3 (and (= at_count 2) (> local_len 0) (> domain_len 0))))
(assert (= T_4 (and (>= dot_count 2) (not (str.contains domain "..")))))

; Final condition: preserve core structure by asserting T_2, making instance UNSAT because T_1 must hold for any valid-looking email constraints
(assert T_2)

(check-sat)


; [GENERATION STATUS: SUCCESS]