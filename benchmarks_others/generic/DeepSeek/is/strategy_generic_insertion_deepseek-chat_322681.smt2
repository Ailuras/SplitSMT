(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun var_0xINPUT_49007 () String)
(assert (= T_1 (= "-" var_0xINPUT_49007)))
(assert (= T_2 (not T_1)))
(assert T_2)
(assert (= T_3 (= "" var_0xINPUT_49007)))
(assert (= T_4 (not T_3)))
(assert T_4)

; --- START CONSTRAINT ---
; Declare interface functions for str_split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
; Declare new variables for split results
(declare-fun segment_0 () String)
(declare-fun segment_1 () String)
(declare-fun total_segments () Int)
; Assert constraints using str_split operations
(assert (= segment_0 (split_at var_0xINPUT_49007 "," 0)))
(assert (= segment_1 (split_at var_0xINPUT_49007 "," 1)))
(assert (= total_segments (num_splits var_0xINPUT_49007 ",")))
(assert (>= total_segments 2))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
