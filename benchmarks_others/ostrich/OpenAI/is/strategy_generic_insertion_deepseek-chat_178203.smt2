(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun var_0xINPUT_100788 () String)
(assert (= T_1 (= "-" var_0xINPUT_100788)))
(assert T_1)

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

(assert (>= (num_splits var_0xINPUT_100788 "-") 1))
(assert (= (split_at var_0xINPUT_100788 "-" 0) ""))
(assert (= (split_at var_0xINPUT_100788 "-" 1) ""))
(assert (= (split_rest var_0xINPUT_100788 "-" 1) ""))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
