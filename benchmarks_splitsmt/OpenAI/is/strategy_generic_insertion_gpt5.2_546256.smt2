(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun var_0xINPUT_4903 () String)
(assert (= T_1 (not (= "" var_0xINPUT_4903))))
(assert (= T_2 (not T_1)))
(assert T_2)
(assert (= T_3 (not (= "" var_0xINPUT_4903))))
(assert T_3)

; --- START CONSTRAINT ---

(declare-fun first_segment () String)
(declare-fun rest_from_1 () String)

(assert (>= (str.len var_0xINPUT_4903) 0))
(assert (= first_segment (str.split_at var_0xINPUT_4903 "," 0)))
(assert (= rest_from_1 (str.split_rest var_0xINPUT_4903 "," 1)))
(assert (>= (str.num_splits var_0xINPUT_4903 ",") 1))
(assert (= (str.split_rest var_0xINPUT_4903 "," 0) var_0xINPUT_4903))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
