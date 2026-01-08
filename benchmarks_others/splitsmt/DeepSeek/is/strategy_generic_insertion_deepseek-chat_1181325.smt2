(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun var_0xINPUT_101541 () String)
(assert (= T_1 (not (= "file:" var_0xINPUT_101541))))
(assert T_1)

; --- START CONSTRAINT ---
(declare-const protocol String)
(declare-const host String)
(assert (= protocol (str.split_at var_0xINPUT_101541 "://" 0)))
(assert (= host (str.split_at var_0xINPUT_101541 "://" 1)))
(assert (>= (str.num_splits var_0xINPUT_101541 "://") 2))
(assert (not (= protocol "file:")))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
