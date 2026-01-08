(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun var_0xINPUT_49116 () String)
(assert (= T_1 (not (= "" var_0xINPUT_49116))))
(assert (= T_2 (not T_1)))
(assert T_2)
(assert (= T_3 (not (= "" var_0xINPUT_49116))))
(assert (= T_4 (not T_3)))
(assert T_4)

; --- START CONSTRAINT ---
; str_split interface declarations
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; Since var_0xINPUT_49116 is asserted to be empty in the context, constrain consistent split behavior
(assert (= (num_splits var_0xINPUT_49116 ",") 1))
(assert (= (split_at var_0xINPUT_49116 "," 0) ""))
(assert (= (split_rest var_0xINPUT_49116 "," 0) var_0xINPUT_49116))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
