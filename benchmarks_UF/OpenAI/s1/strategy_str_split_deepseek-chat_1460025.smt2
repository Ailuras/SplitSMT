(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted interface for string split operations

; Seed variables retained / extended
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-const var_0xINPUT_14483 String)

; Additional email-validation variables
(declare-const local_part String)
(declare-const domain_part String)
(declare-const domain_label0 String)
(declare-const domain_label1 String)
(declare-const tld String)
(declare-const at_count Int)
(declare-const dot_count Int)
(declare-const domain_dot_count Int)

; Seed core structure (mutated but preserved)
(assert (= T_1 (= "-" var_0xINPUT_14483)))
(assert (= T_2 (not T_1)))
(assert T_2)
(assert (= T_3 (= "" var_0xINPUT_14483)))
(assert (= T_4 (not T_3)))
(assert T_4)

; Basic email shape: must contain exactly one '@' as a delimiter
(assert (= at_count (num_splits var_0xINPUT_14483 "@")))
(assert (= at_count 2))
(assert (= local_part (split_at var_0xINPUT_14483 "@" 0)))
(assert (= domain_part (split_at var_0xINPUT_14483 "@" 1)))

; Non-empty local and domain segments
(assert (> (str.len local_part) 0))
(assert (> (str.len domain_part) 0))

; Local part constraints: no '@' and no spaces
(assert (= (num_splits local_part "@") 1))
(assert (not (str.contains local_part " ")))

; Domain structure: must contain at least one '.' and have at least two labels
(assert (= domain_dot_count (num_splits domain_part ".")))
(assert (>= domain_dot_count 2))

(assert (= domain_label0 (split_at domain_part "." 0)))
(assert (= domain_label1 (split_at domain_part "." 1)))
(assert (= tld (split_at domain_part "." (- domain_dot_count 1))))

; Domain labels cannot be empty
(assert (> (str.len domain_label0) 0))
(assert (> (str.len tld) 1))

; Domain cannot have spaces and cannot contain '@'
(assert (not (str.contains domain_part " ")))
(assert (= (num_splits domain_part "@") 1))

; Whole string should not start or end with '@'
(assert (not (= (str.at var_0xINPUT_14483 0) "@")))
(assert (not (= (str.at var_0xINPUT_14483 (- (str.len var_0xINPUT_14483) 1)) "@")))

; Mix in a global '.' constraint (email must contain at least one '.')
(assert (= dot_count (num_splits var_0xINPUT_14483 ".")))
(assert (>= dot_count 2))

; Additional structural consistency via split_rest
(assert (= (split_rest var_0xINPUT_14483 "@" 1) domain_part))

; SAT branch: a plausible email example is allowed
(assert (or (= var_0xINPUT_14483 "alice.smith@example.com")
            (= var_0xINPUT_14483 "user+tag@sub.example.org")
            (= var_0xINPUT_14483 "bob@example.co")))

; UNSAT sub-constraints (guarded so file remains SAT overall)
; If the input were exactly "a@b", force contradictory domain dot requirements.
(assert (=> (= var_0xINPUT_14483 "a@b") (and (= at_count 2) (>= domain_dot_count 2) (= domain_part "b"))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
