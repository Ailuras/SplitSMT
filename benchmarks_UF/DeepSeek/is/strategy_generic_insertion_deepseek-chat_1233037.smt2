(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun var_0xINPUT_102266 () String)
(assert (= T_1 (not (= "file:" var_0xINPUT_102266))))
(assert T_1)

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const protocol String)
(declare-const path String)
(assert (= protocol (split_at var_0xINPUT_102266 ":" 0)))
(assert (>= (num_splits var_0xINPUT_102266 ":") 2))
(assert (= path (split_rest var_0xINPUT_102266 ":" 1)))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]