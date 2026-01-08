(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_135296 () String)
(assert (= T_1 (not (= "A9jaaDKZbG" var_0xINPUT_135296))))
(assert (= T_2 (not T_1)))
(assert T_2)

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter ";"))
(assert (>= (str.num_splits var_0xINPUT_135296 delimiter) 3))
(assert (= (str.split_at var_0xINPUT_135296 delimiter 0) "A9jaaDKZbG"))
(assert (str.contains (str.split_rest var_0xINPUT_135296 delimiter 1) "example"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
