(set-logic ALL)

; Uninterpreted interface functions for str_split

; Seed-style booleans preserved and repurposed
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)

; Email validation variables
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const domain_first String)
(declare-const domain_rest String)
(declare-const tld String)

; Core split structure: local@domain
(assert (= local (str.split_at email "@" 0)))
(assert (= domain (str.split_at email "@" 1)))
(assert (>= (str.num_splits email "@") 2))

; Disallow multiple '@' (exactly 2 segments)
(assert (= (str.num_splits email "@") 2))

; Domain structure: at least one dot in domain
(assert (>= (str.num_splits domain ".") 2))
(assert (= domain_first (str.split_at domain "." 0)))
(assert (= domain_rest (str.split_rest domain "." 1)))

; TLD is last segment after splitting domain by '.'
(assert (= tld (str.split_at domain "." (- (str.num_splits domain ".") 1))))

; Basic non-emptiness constraints
(assert (>= (str.len local) 1))
(assert (>= (str.len domain_first) 1))
(assert (>= (str.len tld) 2))

; Local part and domain should not begin with '.' or '@'
(assert (not (= (str.at local 0) ".")))
(assert (not (= (str.at domain 0) ".")))

; No spaces
(assert (not (str.contains email " ")))

; Couple T_1/T_2 to email property (mutated from seed)
(assert (= T_1 (not (= "ywUN4ZIDAC" email))))
(assert (= T_2 (not T_1)))

; Make it a negative test (UNSAT): require both T_2 and T_1
(assert T_2)
(assert T_1)

; Additional domain constraints (still consistent with email structure, but irrelevant due to UNSAT core)
(assert (not (str.contains domain "..")))
(assert (not (= (str.at domain (- (str.len domain) 1)) ".")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
