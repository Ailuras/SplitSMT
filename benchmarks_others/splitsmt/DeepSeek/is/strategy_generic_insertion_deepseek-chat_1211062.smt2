(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_528426 () String)
(assert (= T_1 (not (= "" var_0xINPUT_528426))))
(assert T_1)
(assert (= T_2 (= var_0xINPUT_528426 "array")))
(assert T_2)

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter ","))
(assert (>= (str.num_splits var_0xINPUT_528426 delimiter) 3))
(assert (= (str.split_at var_0xINPUT_528426 delimiter 0) "array"))
(assert (not (= (str.split_at var_0xINPUT_528426 delimiter 1) "")))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
