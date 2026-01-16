(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_42194 () String)
(assert (= T_1 (= var_0xINPUT_42194 "")))
(assert (= T_2 (not T_1)))
(assert T_2)

; --- START CONSTRAINT ---
(declare-const part1 String)
(declare-const part2 String)
(assert (= part1 (str.split_at var_0xINPUT_42194 "," 0)))
(assert (= part2 (str.split_at var_0xINPUT_42194 "," 1)))
(assert (>= (str.num_splits var_0xINPUT_42194 ",") 2))
(assert (not (= part1 "")))
(assert (not (= part2 "")))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
