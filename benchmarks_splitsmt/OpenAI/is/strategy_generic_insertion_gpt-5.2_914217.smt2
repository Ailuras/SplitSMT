(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun var_0xINPUT_110061 () String)
(assert (= T_1 (= var_0xINPUT_110061 "Type")))
(assert T_1)

; --- START CONSTRAINT ---

(declare-fun seg0 () String)
(declare-fun seg1 () String)
(declare-fun rest1 () String)

(assert (= seg0 (str.split_at var_0xINPUT_110061 "y" 0)))
(assert (= seg1 (str.split_at var_0xINPUT_110061 "y" 1)))
(assert (= rest1 (str.split_rest var_0xINPUT_110061 "y" 1)))
(assert (= (str.num_splits var_0xINPUT_110061 "y") 2))
(assert (= seg0 "T"))
(assert (= seg1 "pe"))
(assert (= rest1 "pe"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
