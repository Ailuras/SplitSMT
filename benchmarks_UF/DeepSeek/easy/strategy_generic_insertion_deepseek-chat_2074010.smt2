(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_400878 () String)
(assert (= T_1 (= var_0xINPUT_400878 "Search")))
(assert (= T_2 (not T_1)))
(assert T_2)

; --- START CONSTRAINT ---
(declare-const segment0 String)
(declare-const segment1 String)
(declare-const num_segments Int)
(assert (= segment0 (split_at var_0xINPUT_400878 "," 0)))
(assert (= segment1 (split_at var_0xINPUT_400878 "," 1)))
(assert (= num_segments (num_splits var_0xINPUT_400878 ",")))
(assert (>= num_segments 2))
(assert (not (str.contains segment0 "Search")))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
