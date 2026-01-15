(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_208734 () String)
(assert (= T_1 (not (= "" var_0xINPUT_208734))))
(assert T_1)
(assert (= T_2 (= var_0xINPUT_208734 "array")))
(assert T_2)

; --- START CONSTRAINT ---
(declare-const segment_0 String)
(declare-const segment_1 String)
(declare-const num_segments Int)
(assert (= segment_0 (str.split_at var_0xINPUT_208734 "," 0)))
(assert (= segment_1 (str.split_at var_0xINPUT_208734 "," 1)))
(assert (= num_segments (str.num_splits var_0xINPUT_208734 ",")))
(assert (>= num_segments 2))
(assert (not (= segment_0 "")))
(assert (not (= segment_1 "")))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
