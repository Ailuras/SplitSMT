(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun T_5 () Bool)
(declare-fun var_0xINPUT_127551 () String)
(assert (= T_1 (not (= "4PH2ujcENG" var_0xINPUT_127551))))
(assert T_1)
(assert (= T_2 (not (= "" var_0xINPUT_127551))))
(assert T_2)
(assert (= T_3 (= var_0xINPUT_127551 "Example:")))
(assert (= T_4 (not T_3)))
(assert T_4)
(assert (= T_5 (not (= var_0xINPUT_127551 "ywUN4ZIDAC"))))
(assert T_5)

; --- START CONSTRAINT ---
; Interface function signatures
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; New variables
(declare-fun delim_colon () String)
(declare-fun seg0 () String)
(declare-fun seg1 () String)
(declare-fun rest1 () String)

; Constraints using str_split interface
(assert (= delim_colon ":"))
(assert (>= (num_splits var_0xINPUT_127551 delim_colon) 1))
(assert (= seg0 (split_at var_0xINPUT_127551 delim_colon 0)))
(assert (= seg1 (split_at var_0xINPUT_127551 delim_colon 1)))
(assert (= rest1 (split_rest var_0xINPUT_127551 delim_colon 1)))
(assert (= seg0 "Example"))
(assert (= seg1 ""))
(assert (= (num_splits var_0xINPUT_127551 delim_colon) 2))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]