; Email Validation Scenario: Validate complex email address formats using '@' and '.' as delimiters
; Core structure preserved with added constraints for segment counts and domain structure
(set-logic ALL)
; Declare string variables for email and its components
(declare-fun email () String)
(declare-fun local_part () String)
(declare-fun domain () String)
(declare-fun domain_part1 () String)
(declare-fun domain_part2 () String)
(declare-fun T0_5 () String)
(declare-fun T1_5 () String)
(declare-fun T2_5 () String)
(declare-fun T3_5 () String)
(declare-fun T4_5 () String)
(declare-fun T5_5 () String)
(declare-fun I0_5 () Int)
(declare-fun PCTEMP_LHS_1 () Int)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_6 () Bool)
(declare-fun T_SELECT_1 () Bool)
(declare-fun var_0xINPUT_35568 () String)
; Declare interface functions for str_split operations
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
; Assert that email is not empty and contains '@'
(assert (not (= email "")))
(assert (str.contains email "@"))
; Split email into local_part and domain using '@' delimiter
(assert (= local_part (split_at email "@" 0)))
(assert (= domain (split_rest email "@" 1)))
; Verify segment counts: at least 2 segments after splitting by '@'
(assert (>= (num_splits email "@") 2))
; Domain must contain at least one '.' and have at least 2 segments after splitting by '.'
(assert (str.contains domain "."))
(assert (>= (num_splits domain ".") 2))
; Extract first and second parts of domain for validation
(assert (= domain_part1 (split_at domain "." 0)))
(assert (= domain_part2 (split_at domain "." 1)))
; Constraints on domain parts: non-empty and alphanumeric characters
(assert (not (= domain_part1 "")))
(assert (not (= domain_part2 "")))
(assert (str.in_re domain_part1 (re.++ (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9"))) (re.opt (str.to_re "-")) (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9"))))))
(assert (str.in_re domain_part2 (re.++ (re.* (re.union (re.range "a" "z") (re.range "A" "Z"))) (re.opt (str.to_re ".")) (re.* (re.union (re.range "a" "z") (re.range "A" "Z"))))))
; Local part constraints: non-empty and can contain alphanumeric, dots, underscores, hyphens
(assert (not (= local_part "")))
(assert (str.in_re local_part (re.++ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9")) (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re ".") (str.to_re "_") (str.to_re "-"))) (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9")))))
; Preserve seed constraints with modifications for integration
(assert (= T_1 (= "-" var_0xINPUT_35568)))
(assert (= T_2 (not T_1)))
(assert T_2)
(assert (= T_3 (= "" var_0xINPUT_35568)))
(assert T_3)
(assert (= T_SELECT_1 (not (= PCTEMP_LHS_1 (- 1)))))
(assert (ite T_SELECT_1 (and (= PCTEMP_LHS_1 (+ I0_5 0)) (= var_0xINPUT_35568 (str.++ T0_5 T1_5)) (= I0_5 (str.len T4_5)) (= 0 (str.len T0_5)) (= T1_5 (str.++ T2_5 T3_5)) (= T2_5 (str.++ T4_5 T5_5)) (= T5_5 "__utma=16886264") (not (str.in_re T4_5 (re.++ (str.to_re "_") (str.to_re "_") (str.to_re "u") (str.to_re "t") (str.to_re "m") (str.to_re "a") (str.to_re "=") (str.to_re "1") (str.to_re "6") (str.to_re "8") (str.to_re "8") (str.to_re "6") (str.to_re "2") (str.to_re "6") (str.to_re "4"))))) (and (= PCTEMP_LHS_1 (- 1)) (= var_0xINPUT_35568 (str.++ T0_5 T1_5)) (= 0 (str.len T0_5)) (not (str.in_re T1_5 (re.++ (str.to_re "_") (str.to_re "_") (str.to_re "u") (str.to_re "t") (str.to_re "m") (str.to_re "a") (str.to_re "=") (str.to_re "1") (str.to_re "6") (str.to_re "8") (str.to_re "8") (str.to_re "6") (str.to_re "2") (str.to_re "6") (str.to_re "4"))))))
(assert (= T_5 (< (- 1) PCTEMP_LHS_1)))
(assert (= T_6 (not T_5)))
(assert T_6)
; Additional constraint to link email with seed variable for consistency
(assert (= email var_0xINPUT_35568))
(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)