(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun var_0xINPUT_49116 () String)
(assert (= T_1 (not (= "" var_0xINPUT_49116))))
(assert (= T_2 (not T_1)))
(assert T_2)
(assert (= T_3 (not (= "" var_0xINPUT_49116))))
(assert (= T_4 (not T_3)))
(assert T_4)

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter ";"))
(assert (>= (str.num_splits var_0xINPUT_49116 delimiter) 3))
(assert (not (= (str.split_at var_0xINPUT_49116 delimiter 1) "")))
(assert (str.contains (str.split_rest var_0xINPUT_49116 delimiter 2) "example"))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
