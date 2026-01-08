(set-logic ALL)
(declare-fun T_1 () Int)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun var_0xINPUT_259474 () String)
(assert (= T_1 (str.len var_0xINPUT_259474)))
(assert (= T_2 (= T_1 0)))
(assert (= T_3 (not T_2)))
(assert T_3)

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

(declare-fun first_seg () String)
(declare-fun rest_from_1 () String)
(declare-fun nseg () Int)

(assert (= nseg (num_splits var_0xINPUT_259474 "-")))
(assert (>= nseg 1))
(assert (= first_seg (split_at var_0xINPUT_259474 "-" 0)))
(assert (= rest_from_1 (split_rest var_0xINPUT_259474 "-" 1)))
(assert (= var_0xINPUT_259474 (str.++ first_seg "-" rest_from_1)))
(assert (>= (str.len first_seg) 1))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
