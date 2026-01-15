(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_154702 () String)
(assert (= T_1 (= "EEjrUKAeVI" var_0xINPUT_154702)))
(assert (= T_2 (not T_1)))
(assert T_2)

; --- START CONSTRAINT ---
(declare-fun segment_0 () String)
(declare-fun segment_1 () String)
(declare-fun delimiter () String)
(assert (= delimiter ":"))
(assert (= segment_0 (str.split_at var_0xINPUT_154702 delimiter 0)))
(assert (= segment_1 (str.split_at var_0xINPUT_154702 delimiter 1)))
(assert (>= (str.num_splits var_0xINPUT_154702 delimiter) 2))
(assert (not (= segment_0 segment_1)))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
