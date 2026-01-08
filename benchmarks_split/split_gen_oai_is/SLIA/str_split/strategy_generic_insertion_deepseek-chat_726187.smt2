(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun var_0xINPUT_78999 () String)
(assert (= T_1 (not (= "" var_0xINPUT_78999))))
(assert (= T_2 (not T_1)))
(assert T_2)
(assert (= T_3 (not (= "" var_0xINPUT_78999))))
(assert T_3)

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

(declare-fun input_first_segment () String)
(declare-fun input_rest_from_1 () String)
(declare-fun input_num_segments () Int)

(assert (= input_first_segment (split_at var_0xINPUT_78999 "" 0)))
(assert (= input_rest_from_1 (split_rest var_0xINPUT_78999 "" 1)))
(assert (= input_num_segments (num_splits var_0xINPUT_78999 "")))

(assert (>= input_num_segments 1))
(assert (= var_0xINPUT_78999 (str.++ input_first_segment input_rest_from_1)))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]