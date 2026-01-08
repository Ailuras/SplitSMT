(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_76237 () String)
(assert (= T_1 (= var_0xINPUT_76237 "")))
(assert (= T_2 (not T_1)))
(assert T_2)

; --- START CONSTRAINT ---

(declare-const delim_76237 String)

(assert (= delim_76237 ","))
(assert (>= (str.num_splits var_0xINPUT_76237 delim_76237) 1))
(assert (= (str.split_at var_0xINPUT_76237 delim_76237 0) var_0xINPUT_76237))
(assert (= (str.split_rest var_0xINPUT_76237 delim_76237 0) var_0xINPUT_76237))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
