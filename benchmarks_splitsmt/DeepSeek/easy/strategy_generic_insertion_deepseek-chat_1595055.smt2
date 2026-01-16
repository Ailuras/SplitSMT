(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_237732 () String)
(assert (= T_1 (not (= "" var_0xINPUT_237732))))
(assert T_1)
(assert (= T_2 (= var_0xINPUT_237732 "array")))
(assert T_2)

; --- START CONSTRAINT ---
; Declare interface functions for str_split
; Declare new variables for split results
(declare-const segment0 String)
(declare-const segment1 String)
(declare-const num_segments Int)
; Assert constraints using str_split operations
(assert (= segment0 (str.split_at var_0xINPUT_237732 "," 0)))
(assert (= segment1 (str.split_at var_0xINPUT_237732 "," 1)))
(assert (= num_segments (str.num_splits var_0xINPUT_237732 ",")))
(assert (>= num_segments 2))
(assert (not (= segment0 "")))
(assert (not (= segment1 "")))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
