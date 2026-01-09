(set-logic ALL)

; Uninterpreted string split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Seed-like booleans preserved/extended
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)

; Email input and derived segments
(declare-const email String)
(declare-const local_part String)
(declare-const domain_all String)
(declare-const domain_label0 String)
(declare-const domain_label1 String)
(declare-const tld String)

; Core non-emptiness seed structure
(assert (= T_1 (not (= "" email))))
(assert (= T_2 (not T_1)))

; Email validation structure using '@' and '.' delimiters
(assert (= local_part (split_at email "@" 0)))
(assert (= domain_all (split_at email "@" 1)))
(assert (= (num_splits email "@") 2))

; Local part constraints
(assert (not (= "" local_part)))
(assert (not (str.contains local_part "@")))
(assert (not (str.contains local_part " ")))

; Domain constraints (split by '.')
(assert (>= (num_splits domain_all ".") 2))
(assert (= domain_label0 (split_at domain_all "." 0)))
(assert (= domain_label1 (split_at domain_all "." 1)))
(assert (= tld (split_at domain_all "." (- (num_splits domain_all ".") 1))))

(assert (not (= "" domain_label0)))
(assert (not (= "" domain_label1)))
(assert (not (= "" tld)))

; No spaces in domain and no stray '@'
(assert (not (str.contains domain_all " ")))
(assert (not (str.contains domain_all "@")))

; Simple shape constraints on TLD
(assert (>= (str.len tld) 2))

; Additional boolean tying: T_3 is true iff domain has at least 3 labels
(assert (= T_3 (>= (num_splits domain_all ".") 3)))

; Deliberate contradiction to create an UNSAT instance while keeping structure: email must be empty and non-empty
(assert T_2)
(assert (= email "user.name@example.com"))

(check-sat)


; [GENERATION STATUS: SUCCESS]