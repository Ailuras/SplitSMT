(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun T_1 () Bool)
(declare-fun var_0xINPUT_109017 () String)
(assert (= T_1 (= "-" var_0xINPUT_109017)))
(assert T_1)

; --- START CONSTRAINT ---
(declare-const segment_0 String)
(declare-const segment_1 String)
(declare-const num_parts Int)
(assert (= segment_0 (split_at var_0xINPUT_109017 "-" 0)))
(assert (= segment_1 (split_at var_0xINPUT_109017 "-" 1)))
(assert (= num_parts (num_splits var_0xINPUT_109017 "-")))
(assert (>= num_parts 2))
(assert (str.contains segment_0 "example"))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
