(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_155219 () String)
(assert (= T_1 (not (= "file:" var_0xINPUT_155219))))
(assert (= T_2 (not T_1)))
(assert T_2)

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

(declare-fun prefix_part () String)
(declare-fun rest_part () String)

(assert (>= (num_splits var_0xINPUT_155219 ":") 2))
(assert (= prefix_part (split_at var_0xINPUT_155219 ":" 0)))
(assert (= rest_part (split_rest var_0xINPUT_155219 ":" 1)))
(assert (= prefix_part "file"))
(assert (= (str.++ prefix_part ":" rest_part) var_0xINPUT_155219))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
