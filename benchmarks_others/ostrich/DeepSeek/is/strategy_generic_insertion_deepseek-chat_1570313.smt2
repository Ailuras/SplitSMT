(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_135296 () String)
(assert (= T_1 (not (= "A9jaaDKZbG" var_0xINPUT_135296))))
(assert (= T_2 (not T_1)))
(assert T_2)

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))
(declare-const delimiter String)
(assert (= delimiter ";"))
(assert (>= (num_splits var_0xINPUT_135296 delimiter) 3))
(assert (= (split_at var_0xINPUT_135296 delimiter 0) "A9jaaDKZbG"))
(assert (str.contains (split_rest var_0xINPUT_135296 delimiter 1) "example"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
