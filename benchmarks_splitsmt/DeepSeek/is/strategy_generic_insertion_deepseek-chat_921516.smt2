(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun var_0xINPUT_137609 () String)
(assert (= T_1 (= var_0xINPUT_137609 "gaMUIKcECR")))
(assert T_1)

; --- START CONSTRAINT ---
(declare-const segment0 String)
(declare-const segment1 String)
(declare-const delimiter String)
(assert (= delimiter ":"))
(assert (= segment0 (str.split_at var_0xINPUT_137609 delimiter 0)))
(assert (= segment1 (str.split_at var_0xINPUT_137609 delimiter 1)))
(assert (>= (str.num_splits var_0xINPUT_137609 delimiter) 2))
(assert (str.contains (str.split_rest var_0xINPUT_137609 delimiter 2) "ECR"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
