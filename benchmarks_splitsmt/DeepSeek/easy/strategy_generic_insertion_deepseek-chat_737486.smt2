(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun var_0xINPUT_112560 () String)
(assert (= T_1 (= "-" var_0xINPUT_112560)))
(assert (= T_2 (not T_1)))
(assert T_2)
(assert (= T_3 (= "" var_0xINPUT_112560)))
(assert (= T_4 (not T_3)))
(assert T_4)

; --- START CONSTRAINT ---
; Declare interface functions for str_split
; Declare new variables for split operations
(declare-const delimiter String)
(declare-const segment0 String)
(declare-const segment1 String)
(declare-const total_segments Int)
; Assert constraints using str_split operations
(assert (= delimiter ","))
(assert (= segment0 (str.split_at var_0xINPUT_112560 delimiter 0)))
(assert (= segment1 (str.split_at var_0xINPUT_112560 delimiter 1)))
(assert (= total_segments (str.num_splits var_0xINPUT_112560 delimiter)))
(assert (>= total_segments 2))
(assert (not (= segment0 "")))
(assert (not (= segment1 "")))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
