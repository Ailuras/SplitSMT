(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_6 () Bool)
(declare-fun T_7 () Bool)
(declare-fun var_0xINPUT_172195 () String)
(assert (= T_1 (not (= "" var_0xINPUT_172195))))
(assert T_1)
(assert (= T_2 (not (= "" var_0xINPUT_172195))))
(assert T_2)
(assert (= T_3 (not (= "" var_0xINPUT_172195))))
(assert T_3)
(assert (= T_4 (not (= var_0xINPUT_172195 ""))))
(assert T_4)
(assert (= T_5 (= var_0xINPUT_172195 "")))
(assert (= T_6 (not T_5)))
(assert T_6)
(assert (= T_7 (not (= var_0xINPUT_172195 ""))))
(assert T_7)

; --- START CONSTRAINT ---
; Declare interface functions for str_split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
; Declare new variables for split operations
(declare-fun delimiter () String)
(declare-fun segment0 () String)
(declare-fun segment1 () String)
(declare-fun total_segments () Int)
; Assert constraints using str_split operations
(assert (= delimiter ";"))
(assert (= segment0 (split_at var_0xINPUT_172195 delimiter 0)))
(assert (= segment1 (split_at var_0xINPUT_172195 delimiter 1)))
(assert (= total_segments (num_splits var_0xINPUT_172195 delimiter)))
(assert (>= total_segments 2))
(assert (not (= segment0 "")))
(assert (not (= segment1 "")))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
