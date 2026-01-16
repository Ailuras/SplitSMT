(set-logic ALL)

; CSV Processing scenario: ensure correct field counts and detect empty fields

(declare-fun T_1 () Int)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun T_5 () Bool)

(declare-fun var_0xINPUT_399334 () String)
(declare-fun delim () String)
(declare-fun f0 () String)
(declare-fun f1 () String)
(declare-fun f2 () String)
(declare-fun f3 () String)
(declare-fun rest1 () String)
(declare-fun rest2 () String)

; str_split interface

; Preserve seed core structure: non-empty input
(assert (= T_1 (str.len var_0xINPUT_399334)))
(assert (= T_2 (= T_1 0)))
(assert (= T_3 (not T_2)))
(assert T_3)

; Delimiter is comma
(assert (= delim ","))

; Basic CSV well-formedness: no leading/trailing comma
(assert (not (str.prefixof delim var_0xINPUT_399334)))
(assert (not (str.suffixof delim var_0xINPUT_399334)))

; Split into exactly 4 fields
(assert (>= (str.num_splits var_0xINPUT_399334 delim) 4))
(assert (<= (str.num_splits var_0xINPUT_399334 delim) 4))

; Bind fields and rests
(assert (= f0 (str.split_at var_0xINPUT_399334 delim 0)))
(assert (= f1 (str.split_at var_0xINPUT_399334 delim 1)))
(assert (= f2 (str.split_at var_0xINPUT_399334 delim 2)))
(assert (= f3 (str.split_at var_0xINPUT_399334 delim 3)))
(assert (= rest1 (str.split_rest var_0xINPUT_399334 delim 1)))
(assert (= rest2 (str.split_rest var_0xINPUT_399334 delim 2)))

; Reconstructive structure constraints for a 4-field CSV
(assert (= var_0xINPUT_399334 (str.++ f0 delim f1 delim f2 delim f3)))
(assert (= rest1 (str.++ f1 delim f2 delim f3)))
(assert (= rest2 (str.++ f2 delim f3)))

; Field constraints: fields must not contain delimiter
(assert (not (str.contains f0 delim)))
(assert (not (str.contains f1 delim)))
(assert (not (str.contains f2 delim)))
(assert (not (str.contains f3 delim)))

; Detect empty fields: at least one field is empty
(assert (= T_4 (or (= (str.len f0) 0)
                  (= (str.len f1) 0)
                  (= (str.len f2) 0)
                  (= (str.len f3) 0))))
(assert T_4)

; Additionally: require at least one non-empty field to avoid all-empty degenerate case
(assert (= T_5 (or (> (str.len f0) 0)
                  (> (str.len f1) 0)
                  (> (str.len f2) 0)
                  (> (str.len f3) 0))))
(assert T_5)



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
