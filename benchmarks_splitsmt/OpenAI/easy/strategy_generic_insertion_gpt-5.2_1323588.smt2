(set-logic ALL)
(declare-fun T_1 () Int)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_392285 () String)
(assert (= T_1 (str.len var_0xINPUT_392285)))
(assert (= T_2 (= T_1 0)))
(assert T_2)

; --- START CONSTRAINT ---
; str_split interface function signatures

; splitting an empty string by any delimiter yields exactly one (empty) segment
(assert (= (str.num_splits var_0xINPUT_392285 ",") 1))
(assert (= (str.split_at var_0xINPUT_392285 "," 0) ""))
(assert (= (str.split_rest var_0xINPUT_392285 "," 0) ""))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
