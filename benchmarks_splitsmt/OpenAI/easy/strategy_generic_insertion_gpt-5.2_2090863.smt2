(set-logic ALL)
(declare-fun T1_3 () String)
(declare-fun T2_3 () String)
(declare-fun T_1 () String)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_96358 () String)
(assert (= T_1 (str.++ T1_3 T2_3)))
(assert (= T2_3 var_0xINPUT_96358))
(assert (= T1_3 ""))
(assert (= T_2 (= "-" T_1)))
(assert T_2)

; --- START CONSTRAINT ---

(declare-fun seg0 () String)
(declare-fun seg1 () String)
(declare-fun rest1 () String)

(assert (>= (str.num_splits var_0xINPUT_96358 "-") 2))
(assert (= seg0 (str.split_at var_0xINPUT_96358 "-" 0)))
(assert (= seg1 (str.split_at var_0xINPUT_96358 "-" 1)))
(assert (= rest1 (str.split_rest var_0xINPUT_96358 "-" 1)))
(assert (= seg0 ""))
(assert (= seg1 ""))
(assert (= rest1 ""))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
