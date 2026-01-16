(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun T_1 () Bool)
(declare-fun var_0xINPUT_101935 () String)
(assert (= T_1 (not (= "" var_0xINPUT_101935))))
(assert T_1)

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter ";"))
(assert (>= (num_splits var_0xINPUT_101935 delimiter) 3))
(assert (not (= (split_at var_0xINPUT_101935 delimiter 0) "")))
(assert (not (= (split_at var_0xINPUT_101935 delimiter 1) "")))
(assert (not (= (split_at var_0xINPUT_101935 delimiter 2) "")))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
