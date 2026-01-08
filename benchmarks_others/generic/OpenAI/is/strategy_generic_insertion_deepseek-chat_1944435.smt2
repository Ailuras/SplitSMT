(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun var_0xINPUT_101933 () String)
(assert (= T_1 (not (= "file:" var_0xINPUT_101933))))
(assert T_1)

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

(declare-fun scheme () String)
(declare-fun rest_after_colon () String)

(assert (>= (str.len var_0xINPUT_101933) (str.len "file:")))
(assert (>= (num_splits var_0xINPUT_101933 ":") 2))
(assert (= scheme (split_at var_0xINPUT_101933 ":" 0)))
(assert (= rest_after_colon (split_rest var_0xINPUT_101933 ":" 1)))
(assert (= var_0xINPUT_101933 (str.++ scheme ":" rest_after_colon)))
(assert (not (= scheme "file")))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
