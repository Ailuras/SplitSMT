(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun T_1 () Bool)
(declare-fun var_0xINPUT_14843 () String)
(assert (= T_1 (= "-" var_0xINPUT_14843)))
(assert T_1)

; --- START CONSTRAINT ---
; Declare interface functions for str_split
; Declare new variables for split operations
(declare-const delimiter String)
(declare-const segment0 String)
(declare-const segment1 String)
(declare-const total_segments Int)
; Assert constraints using str_split operations
(assert (= delimiter ","))
(assert (= segment0 (split_at var_0xINPUT_14843 delimiter 0)))
(assert (= segment1 (split_at var_0xINPUT_14843 delimiter 1)))
(assert (= total_segments (num_splits var_0xINPUT_14843 delimiter)))
(assert (>= total_segments 2))
(assert (not (= segment0 segment1)))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
