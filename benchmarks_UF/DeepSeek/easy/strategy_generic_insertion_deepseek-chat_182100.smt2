(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_479903 () String)
(assert (= T_1 (not (= "" var_0xINPUT_479903))))
(assert (= T_2 (not T_1)))
(assert T_2)

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter ";"))
(assert (>= (num_splits var_0xINPUT_479903 delimiter) 3))
(assert (= (split_at var_0xINPUT_479903 delimiter 0) "start"))
(assert (= (split_at var_0xINPUT_479903 delimiter 2) "end"))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
