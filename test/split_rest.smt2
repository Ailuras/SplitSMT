(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)
; --- LLM Generated Split Constraints ---
; Multi-level splitting with cross-dependencies
(declare-const input_str String)
(declare-const part2 String)
(assert (= part2 (str.split_at (str.split_rest input_str "|" 1) "|" 0)))

(check-sat)
(exit)
