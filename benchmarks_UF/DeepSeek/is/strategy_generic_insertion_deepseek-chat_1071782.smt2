(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun var_0xINPUT_14893 () String)
(assert (= T_1 (= "-" var_0xINPUT_14893)))
(assert (= T_2 (not T_1)))
(assert T_2)
(assert (= T_3 (= "" var_0xINPUT_14893)))
(assert (= T_4 (not T_3)))
(assert T_4)

; --- START CONSTRAINT ---
; Declare interface function signatures for str_split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
; Declare new variables for split operations
(declare-const delimiter String)
(declare-const segment0 String)
(declare-const segment1 String)
(declare-const total_segments Int)
; Assert constraints using str_split operations
(assert (= delimiter ","))
(assert (= segment0 (split_at var_0xINPUT_14893 delimiter 0)))
(assert (= segment1 (split_at var_0xINPUT_14893 delimiter 1)))
(assert (= total_segments (num_splits var_0xINPUT_14893 delimiter)))
(assert (>= total_segments 2))
(assert (not (= segment0 "")))
(assert (not (= segment1 "")))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
