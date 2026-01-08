(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun var_0xINPUT_4701 () String)
(assert (= T_1 (not (= "file:" var_0xINPUT_4701))))
(assert T_1)

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

(declare-const scheme String)
(declare-const after_colon String)

(assert (= scheme (split_at var_0xINPUT_4701 ":" 0)))
(assert (>= (num_splits var_0xINPUT_4701 ":") 2))
(assert (= after_colon (split_rest var_0xINPUT_4701 ":" 1)))
(assert (= var_0xINPUT_4701 (str.++ scheme ":" after_colon)))
(assert (not (= scheme "file")))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]