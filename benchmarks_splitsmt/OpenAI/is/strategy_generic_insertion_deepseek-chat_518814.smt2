(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_21095 () String)
(assert (= T_1 (not (= "" var_0xINPUT_21095))))
(assert T_1)
(assert (= T_2 (not (= "" var_0xINPUT_21095))))
(assert T_2)

; --- START CONSTRAINT ---

(declare-fun delim_21095 () String)
(declare-fun seg0_21095 () String)
(declare-fun rest_21095 () String)

(assert (= delim_21095 ":"))
(assert (>= (str.len var_0xINPUT_21095) 1))
(assert (>= (str.num_splits var_0xINPUT_21095 delim_21095) 1))
(assert (= seg0_21095 (str.split_at var_0xINPUT_21095 delim_21095 0)))
(assert (= rest_21095 (str.split_rest var_0xINPUT_21095 delim_21095 0)))
(assert (= rest_21095 var_0xINPUT_21095))
(assert (not (= "" seg0_21095)))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
