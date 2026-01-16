(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted interface for string splitting

; Boolean structure preserved from seed
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)

; Email-related variables
(declare-const var_0xINPUT_244266 String)
(declare-const local_part String)
(declare-const domain_part String)
(declare-const domain_label0 String)
(declare-const domain_label1 String)
(declare-const tld String)
(declare-const recomposed_domain String)

; Preserve seed-style core: force equality with the literal and non-empty
(assert (= T_1 (not (= "4PH2ujcENG" var_0xINPUT_244266))))
(assert (= T_2 (not T_1)))
(assert T_2)
(assert (= T_3 (not (= var_0xINPUT_244266 ""))))
(assert T_3)

; Extend to email validation structure using '@' and '.'
; Require exactly one '@' (i.e., two segments when splitting)
(assert (= (num_splits var_0xINPUT_244266 "@") 2))
(assert (= local_part (split_at var_0xINPUT_244266 "@" 0)))
(assert (= domain_part (split_at var_0xINPUT_244266 "@" 1)))

; Local part constraints: non-empty, no '@', and no leading/trailing '.'
(assert (> (str.len local_part) 0))
(assert (not (str.contains local_part "@")))
(assert (not (= (str.at local_part 0) ".")))
(assert (not (= (str.at local_part (- (str.len local_part) 1)) ".")))

; Domain constraints: at least one '.', and no empty labels
(assert (>= (num_splits domain_part ".") 2))
(assert (= domain_label0 (split_at domain_part "." 0)))
(assert (= domain_label1 (split_at domain_part "." 1)))
(assert (= tld (split_at domain_part "." (- (num_splits domain_part ".") 1))))
(assert (> (str.len domain_label0) 0))
(assert (> (str.len domain_label1) 0))
(assert (> (str.len tld) 1))

; Disallow consecutive dots in domain by ensuring the remainder after first label doesn't start with '.'
(assert (not (= (str.at (split_rest domain_part "." 1) 0) ".")))

; Recompose and require it matches domain_part (structural check)
(assert (= recomposed_domain (str.++ domain_label0 "." (split_rest domain_part "." 1))))
(assert (= recomposed_domain domain_part))

; Ensure only one '@' by disallowing '@' in domain as well
(assert (not (str.contains domain_part "@")))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
