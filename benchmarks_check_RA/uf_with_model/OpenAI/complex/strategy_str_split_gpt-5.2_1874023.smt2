(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted interface functions for str_split

; Seed variables (preserved core structure)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_479903 () String)

; Additional variables for email validation scenario
(declare-const local_part String)
(declare-const domain_part String)
(declare-const tld String)
(declare-const domain_label0 String)
(declare-const domain_rest String)
(declare-const domain_with_dot String)
(declare-const dot String)
(declare-const at String)

(assert (= dot "."))
(assert (= at "@"))

; Core seed structure
(assert (= T_1 (not (= "" var_0xINPUT_479903))))
(assert (= T_2 (not T_1)))

; Email split constraints
(assert (= local_part (split_at var_0xINPUT_479903 at 0)))
(assert (= domain_part (split_at var_0xINPUT_479903 at 1)))
(assert (= (num_splits var_0xINPUT_479903 at) 2))

; local-part sanity (non-empty, no nested @)
(assert (not (= local_part "")))
(assert (= (num_splits local_part at) 1))

; domain structure: must contain at least one '.'
(assert (>= (num_splits domain_part dot) 2))
(assert (= domain_label0 (split_at domain_part dot 0)))
(assert (= tld (split_at domain_part dot (- (num_splits domain_part dot) 1))))
(assert (= domain_rest (split_rest domain_part dot 1)))

; domain labels non-empty
(assert (not (= domain_label0 "")))
(assert (not (= tld "")))

; domain_part should be reconstructible as label0 + '.' + rest (rest includes at least one segment)
(assert (= domain_with_dot (str.++ domain_label0 dot domain_rest)))
(assert (= domain_with_dot domain_part))

; Additional email-like character constraints (approximate with contains restrictions)
(assert (not (str.contains local_part " ")))
(assert (not (str.contains domain_part " ")))
(assert (not (str.contains domain_part "..")))

; Force UNSAT by requiring empty input while also requiring email splits and non-empty local/domain
(assert T_2)
(assert (= var_0xINPUT_479903 ""))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(get-model)
(exit)
