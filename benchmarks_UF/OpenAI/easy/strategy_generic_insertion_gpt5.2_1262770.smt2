(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun T_1 () Bool)
(declare-fun var_0xINPUT_4701 () String)
(assert (= T_1 (not (= "file:" var_0xINPUT_4701))))
(assert T_1)

; --- START CONSTRAINT ---

(declare-fun scheme_part () String)
(declare-fun after_colon () String)

(assert (>= (str.len var_0xINPUT_4701) 0))
(assert (>= (num_splits var_0xINPUT_4701 ":") 1))
(assert (= scheme_part (split_at var_0xINPUT_4701 ":" 0)))
(assert (= after_colon (split_rest var_0xINPUT_4701 ":" 1)))
(assert (= scheme_part "file"))
(assert (= var_0xINPUT_4701 (str.++ scheme_part ":" after_colon)))
(assert (= (num_splits var_0xINPUT_4701 ":") 1))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
