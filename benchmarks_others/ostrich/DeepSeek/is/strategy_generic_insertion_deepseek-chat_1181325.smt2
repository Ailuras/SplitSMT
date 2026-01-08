(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun var_0xINPUT_101541 () String)
(assert (= T_1 (not (= "file:" var_0xINPUT_101541))))
(assert T_1)

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))
(declare-const protocol String)
(declare-const host String)
(assert (= protocol (split_at var_0xINPUT_101541 "://" 0)))
(assert (= host (split_at var_0xINPUT_101541 "://" 1)))
(assert (>= (num_splits var_0xINPUT_101541 "://") 2))
(assert (not (= protocol "file:")))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
