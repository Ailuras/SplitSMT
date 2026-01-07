(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)

(set-info :license "https://creativecommons.org/licenses/by/4.0/")
(set-info :category "industrial")
(set-info :status unknown)



(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_89339 () String)
(assert (= T_1 (not (= "" var_0xINPUT_89339))))
(assert T_1)
(assert (= T_2 (not (= var_0xINPUT_89339 ""))))
(assert T_2)

; --- LLM Generated Split Constraints ---
; Basic split operations on input string
(declare-fun split_part_0 () String)
(declare-fun split_part_1 () String)
(assert (= split_part_0 (str.split_at var_0xINPUT_89339 " " 0))) ; First segment
(assert (= split_part_1 (str.split_at var_0xINPUT_89339 " " 1))) ; Second segment
; ; Validate split operation produced non-empty parts
(assert (not (= split_part_0 "")))
(assert (not (= split_part_1 "")))
; ; Check number of segments when splitting by space
(assert (>= (str.num_splits var_0xINPUT_89339 " ") 2))
; Get remaining segments after first split
(declare-fun remaining_segments () String)
(assert (= remaining_segments (str.split_rest var_0xINPUT_89339 " " 1)))
(assert (not (= remaining_segments "")))
; --- End LLM Generated Constraints ---

(check-sat)

(exit)
