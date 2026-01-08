(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_58251 () String)
(assert (= T_1 (not (= "" var_0xINPUT_58251))))
(assert (= T_2 (not T_1)))
(assert T_2)

; --- START CONSTRAINT ---

(declare-fun delim () String)
(declare-fun first_seg () String)

(assert (= delim ","))
(assert (= first_seg (str.split_at var_0xINPUT_58251 delim 0)))
(assert (>= (str.num_splits var_0xINPUT_58251 delim) 1))
(assert (= (str.split_rest var_0xINPUT_58251 delim 0) var_0xINPUT_58251))
(assert (= first_seg ""))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
