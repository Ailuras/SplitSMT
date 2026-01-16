(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_223839 () String)
(assert (= T_1 (= var_0xINPUT_223839 "")))
(assert (= T_2 (not T_1)))
(assert T_2)

; --- START CONSTRAINT ---
; Declare interface functions for str_split
; Declare new variables for split operations
(declare-const delimiter String)
(declare-const first_segment String)
(declare-const total_segments Int)
; Assert constraints using str_split operations
(assert (= delimiter ":"))
(assert (= first_segment (split_at var_0xINPUT_223839 delimiter 0)))
(assert (= total_segments (num_splits var_0xINPUT_223839 delimiter)))
(assert (>= total_segments 1))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
