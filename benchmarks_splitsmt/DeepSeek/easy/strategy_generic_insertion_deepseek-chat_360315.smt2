(set-logic ALL)
(declare-fun T_1 () Int)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun var_0xINPUT_252769 () String)
(assert (= T_1 (str.len var_0xINPUT_252769)))
(assert (= T_2 (= T_1 0)))
(assert (= T_3 (not T_2)))
(assert T_3)

; --- START CONSTRAINT ---
(declare-fun delimiter () String)
(declare-fun segment0 () String)
(declare-fun segment1 () String)
(declare-fun total_segments () Int)
(assert (>= (str.len delimiter) 1))
(assert (= segment0 (str.split_at var_0xINPUT_252769 delimiter 0)))
(assert (= total_segments (str.num_splits var_0xINPUT_252769 delimiter)))
(assert (>= total_segments 2))
(assert (= segment1 (str.split_at var_0xINPUT_252769 delimiter 1)))
(assert (>= (str.len segment0) 1))
(assert (>= (str.len segment1) 1))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
