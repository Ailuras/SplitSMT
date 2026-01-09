(set-logic ALL)

; Uninterpreted interface for CSV-style splitting
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Original seed symbols (kept, with extended structure)
(declare-const T_1 Int)
(declare-const T_2 Bool)
(declare-const T_3 Bool)
(declare-const var_0xINPUT_234006 String)

; Additional symbols for CSV processing
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const rest1 String)
(declare-const rest2 String)
(declare-const has_empty Bool)
(declare-const well_formed Bool)

; Seed core: input must be non-empty
(assert (= T_1 (str.len var_0xINPUT_234006)))
(assert (= T_2 (= T_1 0)))
(assert (= T_3 (not T_2)))
(assert T_3)

; CSV delimiter
(assert (= delim ","))

; Structural split constraints: 3 fields expected => 3 segments
(assert (= (num_splits var_0xINPUT_234006 delim) 3))
(assert (= f0 (split_at var_0xINPUT_234006 delim 0)))
(assert (= f1 (split_at var_0xINPUT_234006 delim 1)))
(assert (= f2 (split_at var_0xINPUT_234006 delim 2)))
(assert (= rest1 (split_rest var_0xINPUT_234006 delim 1)))
(assert (= rest2 (split_rest var_0xINPUT_234006 delim 2)))

; Basic bounds / sanity
(assert (>= T_1 3))

; Detect empty fields
(assert (= has_empty (or (= (str.len f0) 0)
                         (= (str.len f1) 0)
                         (= (str.len f2) 0))))

; Additional CSV constraints: no commas inside fields (simple CSV, no quoting)
(assert (not (str.contains f0 delim)))
(assert (not (str.contains f1 delim)))
(assert (not (str.contains f2 delim)))

; A derived well-formedness predicate: exactly 3 fields, input non-empty, no empty fields
(assert (= well_formed (and T_3
                            (= (num_splits var_0xINPUT_234006 delim) 3)
                            (not has_empty))))

; SAT branch: enforce well-formed CSV and some content patterns
(assert well_formed)
(assert (>= (str.len f0) 1))
(assert (>= (str.len f1) 1))
(assert (>= (str.len f2) 1))
(assert (str.contains var_0xINPUT_234006 delim))

; UNSAT branch (intentionally contradictory): require an empty field while also well_formed
; This creates an UNSAT instance while preserving the CSV core structure.
(assert has_empty)

(check-sat)


; [GENERATION STATUS: SUCCESS]