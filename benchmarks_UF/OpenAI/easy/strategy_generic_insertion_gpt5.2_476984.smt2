(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_238509 () String)
(assert (= T_1 (= var_0xINPUT_238509 "Type")))
(assert (= T_2 (not T_1)))
(assert T_2)

; --- START CONSTRAINT ---

(declare-fun input_prefix () String)
(declare-fun input_suffix () String)
(declare-fun input_num_parts () Int)

(assert (= input_num_parts (num_splits var_0xINPUT_238509 "y")))
(assert (>= input_num_parts 2))
(assert (= input_prefix (split_at var_0xINPUT_238509 "y" 0)))
(assert (= input_suffix (split_rest var_0xINPUT_238509 "y" 1)))
(assert (= input_prefix "T"))
(assert (= input_suffix "pe"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
