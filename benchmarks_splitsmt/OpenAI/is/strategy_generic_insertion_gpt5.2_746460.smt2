(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_42194 () String)
(assert (= T_1 (= var_0xINPUT_42194 "")))
(assert (= T_2 (not T_1)))
(assert T_2)

; --- START CONSTRAINT ---

(declare-fun delim_42194 () String)
(declare-fun seg0_42194 () String)
(declare-fun seg1_42194 () String)
(declare-fun rest1_42194 () String)

(assert (= delim_42194 "|"))
(assert (>= (str.num_splits var_0xINPUT_42194 delim_42194) 1))
(assert (= seg0_42194 (str.split_at var_0xINPUT_42194 delim_42194 0)))
(assert (= seg1_42194 (str.split_at var_0xINPUT_42194 delim_42194 1)))
(assert (= rest1_42194 (str.split_rest var_0xINPUT_42194 delim_42194 1)))

(assert (= seg0_42194 "abc"))
(assert (>= (str.num_splits var_0xINPUT_42194 delim_42194) 2))
(assert (str.contains rest1_42194 "def"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
