(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun var_0xINPUT_49072 () String)
(assert (= T_1 (not (= "" var_0xINPUT_49072))))
(assert (= T_2 (not T_1)))
(assert T_2)
(assert (= T_3 (not (= "" var_0xINPUT_49072))))
(assert (= T_4 (not T_3)))
(assert T_4)

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter ","))
(assert (>= (str.num_splits var_0xINPUT_49072 delimiter) 3))
(assert (= (str.split_at var_0xINPUT_49072 delimiter 0) "start"))
(assert (= (str.split_rest var_0xINPUT_49072 delimiter 2) "end"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
