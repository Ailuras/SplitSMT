(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun var_0xINPUT_49578 () String)
(assert (= T_1 (not (= "" var_0xINPUT_49578))))
(assert T_1)

; --- START CONSTRAINT ---

(declare-fun delim_49578 () String)
(declare-fun seg0_49578 () String)
(declare-fun seg1_49578 () String)

(assert (= delim_49578 ","))
(assert (>= (str.num_splits var_0xINPUT_49578 delim_49578) 2))
(assert (= seg0_49578 (str.split_at var_0xINPUT_49578 delim_49578 0)))
(assert (= seg1_49578 (str.split_at var_0xINPUT_49578 delim_49578 1)))
(assert (not (= seg0_49578 "")))
(assert (not (= seg1_49578 "")))
(assert (= (str.split_rest var_0xINPUT_49578 delim_49578 1)
           (str.++ seg1_49578 (str.split_rest var_0xINPUT_49578 delim_49578 2))))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
