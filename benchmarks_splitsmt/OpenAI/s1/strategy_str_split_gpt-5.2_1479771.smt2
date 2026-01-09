(set-logic ALL)

; CSV Processing: validate comma-separated fields, detect empties, and keep core non-empty input structure

; Original-style symbols preserved
(declare-fun T_1 () Int)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun var_0xINPUT_234006 () String)

; str_split interface (uninterpreted)

; Additional variables for CSV scenario
(declare-const csv String)
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const rest1 String)
(declare-const rest2 String)
(declare-const nfields Int)
(declare-const has_empty Bool)
(declare-const all_nonempty Bool)
(declare-const unsat_trigger Bool)

; Core structure from seed: input must be non-empty
(assert (= T_1 (str.len var_0xINPUT_234006)))
(assert (= T_2 (= T_1 0)))
(assert (= T_3 (not T_2)))
(assert T_3)

; Tie seed input to CSV string
(assert (= csv var_0xINPUT_234006))
(assert (= delim ","))

; Basic well-formedness and length constraints
(assert (>= (str.len csv) 1))
(assert (>= T_1 1))
(assert (>= (str.len delim) 1))

; Split-derived fields
(assert (= nfields (str.num_splits csv delim)))
(assert (>= nfields 1))

(assert (= f0 (str.split_at csv delim 0)))
(assert (= f1 (str.split_at csv delim 1)))
(assert (= f2 (str.split_at csv delim 2)))
(assert (= rest1 (str.split_rest csv delim 1)))
(assert (= rest2 (str.split_rest csv delim 2)))

; Enforce a typical 3-column CSV shape
(assert (= nfields 3))

; Ensure reconstruction-like constraints with rest segments (relaxation-friendly)
(assert (str.contains rest1 f1))
(assert (str.contains rest2 f2))
(assert (str.contains csv f0))

; Detect empty fields
(assert (= has_empty (or (= (str.len f0) 0) (= (str.len f1) 0) (= (str.len f2) 0))))
(assert (= all_nonempty (and (> (str.len f0) 0) (> (str.len f1) 0) (> (str.len f2) 0))))

; SAT-side requirement: there is at least one empty field (e.g., "a,,c")
(assert has_empty)

; UNSAT instance embedded via a switch fixed to true
(assert (= unsat_trigger true))
(assert (=> unsat_trigger all_nonempty))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
