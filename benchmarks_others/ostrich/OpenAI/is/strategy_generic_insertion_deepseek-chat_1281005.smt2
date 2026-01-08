(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun var_0xINPUT_137609 () String)
(assert (= T_1 (= var_0xINPUT_137609 "gaMUIKcECR")))
(assert T_1)

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

(declare-fun seg0 () String)
(declare-fun seg1 () String)
(declare-fun seg2 () String)
(declare-fun rest1 () String)

(assert (= (num_splits var_0xINPUT_137609 "UI") 2))
(assert (= seg0 (split_at var_0xINPUT_137609 "UI" 0)))
(assert (= seg1 (split_at var_0xINPUT_137609 "UI" 1)))
(assert (= rest1 (split_rest var_0xINPUT_137609 "UI" 1)))
(assert (= rest1 seg1))

(assert (= (num_splits seg0 "M") 2))
(assert (= seg2 (split_at seg0 "M" 0)))
(assert (= seg2 "ga"))
(assert (= (split_at seg0 "M" 1) ""))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
