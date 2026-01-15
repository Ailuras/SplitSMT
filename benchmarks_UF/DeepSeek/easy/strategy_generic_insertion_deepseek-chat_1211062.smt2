(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
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
(assert (>= (num_splits var_0xINPUT_528426 delimiter) 3))
(assert (= (split_at var_0xINPUT_528426 delimiter 0) "array"))
(assert (not (= (split_at var_0xINPUT_528426 delimiter 1) "")))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
