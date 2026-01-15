(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_237732 () String)
(assert (= T_1 (not (= "" var_0xINPUT_237732))))
(assert T_1)
(assert (= T_2 (= var_0xINPUT_237732 "array")))
(assert T_2)

; --- START CONSTRAINT ---
(declare-fun segment_0 () String)
(declare-fun segment_1 () String)
(assert (= segment_0 (str.split_at var_0xINPUT_237732 "," 0)))
(assert (= segment_1 (str.split_at var_0xINPUT_237732 "," 1)))
(assert (>= (str.num_splits var_0xINPUT_237732 ",") 2))
(assert (str.contains (str.split_rest var_0xINPUT_237732 "," 2) "array"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
