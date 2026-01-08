(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_102366 () String)
(assert (= T_1 (not (= "file:" var_0xINPUT_102366))))
(assert (= T_2 (not T_1)))
(assert T_2)

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-fun scheme () String)
(declare-fun after_colon () String)
(assert (= scheme (split_at var_0xINPUT_102366 ":" 0)))
(assert (= after_colon (split_rest var_0xINPUT_102366 ":" 1)))
(assert (>= (num_splits var_0xINPUT_102366 ":") 2))
(assert (= scheme "file"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
