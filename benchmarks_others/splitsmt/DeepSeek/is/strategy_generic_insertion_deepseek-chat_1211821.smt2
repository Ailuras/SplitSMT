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
(declare-fun segment_0 () String)
(declare-fun segment_1 () String)
(declare-fun num_segments () Int)
(assert (= segment_0 (str.split_at var_0xINPUT_78999 "," 0)))
(assert (= segment_1 (str.split_at var_0xINPUT_78999 "," 1)))
(assert (= num_segments (str.num_splits var_0xINPUT_78999 ",")))
(assert (>= num_segments 2))
(assert (not (= segment_0 "")))
(assert (not (= segment_1 "")))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
