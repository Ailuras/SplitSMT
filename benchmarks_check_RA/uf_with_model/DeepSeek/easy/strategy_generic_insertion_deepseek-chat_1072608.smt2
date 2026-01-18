(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_155219 () String)
(assert (= T_1 (not (= "file:" var_0xINPUT_155219))))
(assert (= T_2 (not T_1)))
(assert T_2)

; --- START CONSTRAINT ---
(declare-const protocol String)
(declare-const host String)
(assert (= protocol (split_at var_0xINPUT_155219 "://" 0)))
(assert (= host (split_at var_0xINPUT_155219 "://" 1)))
(assert (>= (num_splits var_0xINPUT_155219 "://") 2))
(assert (not (= protocol "file:")))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(get-model)
(exit)
