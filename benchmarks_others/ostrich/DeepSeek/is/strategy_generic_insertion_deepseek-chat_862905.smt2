(set-logic ALL)
(declare-fun T_1 () Int)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun var_0xINPUT_252769 () String)
(assert (= T_1 (str.len var_0xINPUT_252769)))
(assert (= T_2 (= T_1 0)))
(assert (= T_3 (not T_2)))
(assert T_3)

; --- START CONSTRAINT ---
; Declare interface operations for str_split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))
; Declare new variables for split operations
(declare-fun delimiter () String)
(declare-fun segment0 () String)
(declare-fun segment1 () String)
(declare-fun total_segments () Int)
; Assert constraints using str_split operations
(assert (= delimiter ":"))
(assert (= segment0 (split_at var_0xINPUT_252769 delimiter 0)))
(assert (= segment1 (split_at var_0xINPUT_252769 delimiter 1)))
(assert (= total_segments (num_splits var_0xINPUT_252769 delimiter)))
(assert (>= total_segments 2))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
