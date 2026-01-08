(set-logic ALL)

; CSV Processing scenario: validate comma-separated fields, count fields, and detect empty fields

; Seed variables preserved
(declare-fun T_1 () Int)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun var_0xINPUT_332530 () String)

; str_split interface (uninterpreted per specification)

; Additional variables for CSV reasoning
(declare-const comma String)
(declare-const nfields Int)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const rest1 String)
(declare-const rest2 String)
(declare-const has_empty0 Bool)
(declare-const has_empty1 Bool)
(declare-const has_empty2 Bool)
(declare-const any_empty Bool)

; Core seed structure retained
(assert (= T_1 (str.len var_0xINPUT_332530)))
(assert (= T_2 (= T_1 0)))
(assert (= T_3 (not T_2)))
(assert T_3)

; CSV delimiter
(assert (= comma ","))

; Relate field count to split operator
(assert (= nfields (str.num_splits var_0xINPUT_332530 comma)))

; Require exactly 3 fields (i.e., two commas), and non-empty overall string already ensured by T_3
(assert (= nfields 3))

; Extract fields and rests
(assert (= f0 (str.split_at var_0xINPUT_332530 comma 0)))
(assert (= f1 (str.split_at var_0xINPUT_332530 comma 1)))
(assert (= f2 (str.split_at var_0xINPUT_332530 comma 2)))
(assert (= rest1 (str.split_rest var_0xINPUT_332530 comma 1)))
(assert (= rest2 (str.split_rest var_0xINPUT_332530 comma 2)))

; Basic index validity constraints (natural indices in-range for 3 fields)
(assert (and (>= 0 0) (< 0 nfields)))
(assert (and (>= 1 0) (< 1 nfields)))
(assert (and (>= 2 0) (< 2 nfields)))

; Empty-field detection
(assert (= has_empty0 (= (str.len f0) 0)))
(assert (= has_empty1 (= (str.len f1) 0)))
(assert (= has_empty2 (= (str.len f2) 0)))
(assert (= any_empty (or has_empty0 has_empty1 has_empty2)))

; ---- SAT branch constraints: a well-formed CSV line with no empty fields ----
(assert (not any_empty))

; Extra CSV-like sanity: no field may contain a comma
(assert (not (str.contains f0 comma)))
(assert (not (str.contains f1 comma)))
(assert (not (str.contains f2 comma)))

; Ensure some minimal content in each field
(assert (>= (str.len f0) 1))
(assert (>= (str.len f1) 1))
(assert (>= (str.len f2) 1))

; ---- UNSAT sub-instance (guarded, but forced on) to ensure diversity ----
; Require an empty middle field AND no empty fields simultaneously
(declare-const force_unsat Bool)
(assert (= force_unsat true))
(assert (=> force_unsat (= (str.len f1) 0)))
(assert (=> force_unsat (not any_empty)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
