(set-logic ALL)

; Uninterpreted functions for str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Seed-style boolean guards
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_6 () Bool)

; Input email
(declare-fun var_0xINPUT_161005 () String)

; Basic non-triviality constraints (mutated from seed)
(assert (= T_1 (= "-" var_0xINPUT_161005)))
(assert (= T_2 (not T_1)))
(assert T_2)

(assert (= T_3 (= "" var_0xINPUT_161005)))
(assert (= T_4 (not T_3)))
(assert T_4)

; Email must contain exactly one '@' -> 2 segments when splitting by '@'
(assert (= T_5 (= (num_splits var_0xINPUT_161005 "@") 2)))
(assert T_5)

; Split into local and domain parts
(declare-const local_part String)
(declare-const domain_part String)
(assert (= local_part (split_at var_0xINPUT_161005 "@" 0)))
(assert (= domain_part (split_at var_0xINPUT_161005 "@" 1)))

; Local part constraints
(assert (> (str.len local_part) 0))
(assert (not (str.contains local_part "@")))
(assert (not (str.contains local_part " ")))
(assert (not (str.contains local_part "..")))
(assert (not (= (str.at local_part 0) ".")))
(assert (not (= (str.at local_part (- (str.len local_part) 1)) ".")))

; Domain part: must contain at least one '.' => at least 2 segments
(assert (>= (num_splits domain_part ".") 2))

; Domain labels cannot be empty and cannot start/end with '-'
(declare-const dom_label0 String)
(declare-const tld String)
(assert (= dom_label0 (split_at domain_part "." 0)))
(assert (= tld (split_at domain_part "." (- (num_splits domain_part ".") 1))))

(assert (> (str.len dom_label0) 0))
(assert (> (str.len tld) 1))

(assert (not (= (str.at dom_label0 0) "-")))
(assert (not (= (str.at dom_label0 (- (str.len dom_label0) 1)) "-")))

(assert (not (= (str.at tld 0) "-")))
(assert (not (= (str.at tld (- (str.len tld) 1)) "-")))

; Domain must not contain spaces, consecutive dots, or '@'
(assert (not (str.contains domain_part " ")))
(assert (not (str.contains domain_part "..")))
(assert (not (str.contains domain_part "@")))

; Ensure at least one dot occurs after '@' (using split_rest for core-structure diversity)
(declare-const after_first_dot String)
(assert (= after_first_dot (split_rest domain_part "." 1)))
(assert (> (str.len after_first_dot) 0))

; Additional consistency: recomposition constraints for split behavior (relaxed)
(assert (= (str.++ local_part "@" domain_part) var_0xINPUT_161005))

; SAT branch with a concrete witness
(assert (= T_6 (= var_0xINPUT_161005 "alice.smith@sub.example.com")))
(assert T_6)

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
