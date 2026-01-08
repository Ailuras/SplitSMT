(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_6 () Bool)
(declare-fun var_0xINPUT_114521 () String)
(assert (= T_1 (not (= "" var_0xINPUT_114521))))
(assert T_1)
(assert (= T_2 (not (= "" var_0xINPUT_114521))))
(assert T_2)
(assert (= T_3 (= var_0xINPUT_114521 "Example:")))
(assert (= T_4 (not T_3)))
(assert T_4)
(assert (= T_5 (not (= var_0xINPUT_114521 "o7E1eVAEe3"))))
(assert (= T_6 (not T_5)))
(assert T_6)

; --- START CONSTRAINT ---
; str_split interface declarations

; New constraints using str_split on existing input
(assert (>= (num_splits var_0xINPUT_114521 "E") 1))
(assert (= (split_at var_0xINPUT_114521 "E" 0) "o7"))
(assert (= (split_at var_0xINPUT_114521 "E" 1) "1eVA"))
(assert (= (split_at var_0xINPUT_114521 "E" 2) "e3"))
(assert (= (split_rest var_0xINPUT_114521 "E" 0) var_0xINPUT_114521))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
