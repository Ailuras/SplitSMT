(set-logic ALL)
(declare-fun T_1 () Int)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun var_0xINPUT_474185 () String)
(assert (= T_1 (str.len var_0xINPUT_474185)))
(assert (= T_2 (= T_1 0)))
(assert (= T_3 (not T_2)))
(assert T_3)

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

(declare-fun seg0 () String)
(declare-fun seg1 () String)
(declare-fun segRestFrom1 () String)
(declare-fun nSegs () Int)

(assert (= nSegs (num_splits var_0xINPUT_474185 ",")))
(assert (>= nSegs 1))
(assert (= seg0 (split_at var_0xINPUT_474185 "," 0)))
(assert (= seg1 (split_at var_0xINPUT_474185 "," 1)))
(assert (= segRestFrom1 (split_rest var_0xINPUT_474185 "," 1)))
(assert (or (= nSegs 1) (> (str.len segRestFrom1) 0)))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
