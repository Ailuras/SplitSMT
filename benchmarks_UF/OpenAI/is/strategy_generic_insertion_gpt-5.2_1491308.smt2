(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun var_0xINPUT_102192 () String)
(assert (= T_1 (= "-" var_0xINPUT_102192)))
(assert T_1)

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(assert (= (num_splits var_0xINPUT_102192 "-") 2))
(assert (= (split_at var_0xINPUT_102192 "-" 0) ""))
(assert (= (split_at var_0xINPUT_102192 "-" 1) ""))
(assert (= (split_rest var_0xINPUT_102192 "-" 1) ""))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]