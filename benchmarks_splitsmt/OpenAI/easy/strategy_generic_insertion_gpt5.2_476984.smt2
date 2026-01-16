(set-logic ALL)
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

(assert (= input_num_parts (str.num_splits var_0xINPUT_238509 "y")))
(assert (>= input_num_parts 2))
(assert (= input_prefix (str.split_at var_0xINPUT_238509 "y" 0)))
(assert (= input_suffix (str.split_rest var_0xINPUT_238509 "y" 1)))
(assert (= input_prefix "T"))
(assert (= input_suffix "pe"))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
