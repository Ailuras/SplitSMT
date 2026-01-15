(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun var_0xINPUT_464210 () String)
(assert (= T_1 (not (= "" var_0xINPUT_464210))))
(assert T_1)
(assert (= T_2 (not (= "" var_0xINPUT_464210))))
(assert T_2)
(assert (= T_3 (not (= "VEECEXk2pV" var_0xINPUT_464210))))
(assert (= T_4 (not T_3)))
(assert T_4)

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter ";"))
(assert (>= (str.num_splits var_0xINPUT_464210 delimiter) 3))
(assert (not (= (str.split_at var_0xINPUT_464210 delimiter 0) "")))
(assert (not (= (str.split_at var_0xINPUT_464210 delimiter 1) "")))
(assert (not (= (str.split_at var_0xINPUT_464210 delimiter 2) "")))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
