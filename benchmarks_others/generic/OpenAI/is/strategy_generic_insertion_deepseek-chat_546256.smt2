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
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

(declare-fun first_segment () String)
(declare-fun rest_from_1 () String)

(assert (>= (str.len var_0xINPUT_4903) 0))
(assert (= first_segment (split_at var_0xINPUT_4903 "," 0)))
(assert (= rest_from_1 (split_rest var_0xINPUT_4903 "," 1)))
(assert (>= (num_splits var_0xINPUT_4903 ",") 1))
(assert (= (split_rest var_0xINPUT_4903 "," 0) var_0xINPUT_4903))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
