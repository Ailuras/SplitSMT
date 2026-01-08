(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_323918 () String)
(assert (= T_1 (not (= "" var_0xINPUT_323918))))
(assert (= T_2 (not T_1)))
(assert T_2)

; --- START CONSTRAINT ---
; Declare interface functions for str_split
; Declare new variables for split operations
(declare-const delimiter String)
(declare-const first_segment String)
(declare-const total_segments Int)
(declare-const remaining String)
; Assert constraints using str_split operations
(assert (= delimiter ":"))
(assert (= first_segment (str.split_at var_0xINPUT_323918 delimiter 0)))
(assert (= total_segments (str.num_splits var_0xINPUT_323918 delimiter)))
(assert (>= total_segments 1))
(assert (= remaining (str.split_rest var_0xINPUT_323918 delimiter 1)))
(assert (not (= remaining "")))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
