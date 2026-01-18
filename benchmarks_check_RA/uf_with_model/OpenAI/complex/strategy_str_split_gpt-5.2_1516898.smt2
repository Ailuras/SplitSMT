(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Scenario: CSV Processing
; Goal: process comma-separated data fields to ensure correct field counts and detect empty fields

; Split interface (uninterpreted)

; Seed remnants (mutated/extended)
(declare-fun T_1 () Bool)
(declare-const var_0xINPUT_283257 String)

; Additional CSV-related variables
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)
(declare-const empty_field Bool)
(declare-const has_trailing_comma Bool)
(declare-const bad_header Bool)

(assert (= delim ","))

; Mutate the seed: still relate T_1 to a string equality, but now as a header check
(assert (= T_1 (= var_0xINPUT_283257 "Search")))

; CSV structure: require 4 fields (indices 0..3)
(assert (= (num_splits var_0xINPUT_283257 delim) 4))
(assert (>= (num_splits var_0xINPUT_283257 delim) 1))

; Bind fields via split_at
(assert (= f0 (split_at var_0xINPUT_283257 delim 0)))
(assert (= f1 (split_at var_0xINPUT_283257 delim 1)))
(assert (= f2 (split_at var_0xINPUT_283257 delim 2)))
(assert (= f3 (split_at var_0xINPUT_283257 delim 3)))

; Rest reconstruction constraint
(assert (= (split_rest var_0xINPUT_283257 delim 2) (str.++ f2 delim f3)))

; Detect empty fields: any field can be empty
(assert (= empty_field (or (= f0 "") (= f1 "") (= f2 "") (= f3 ""))))

; Trailing comma implies last field empty (a common CSV issue)
(assert (= has_trailing_comma (= f3 "")))

; Bad header: if first field equals "Search" while we expect a CSV header like "id"
(assert (= bad_header (= f0 "Search")))

; Mix SAT and UNSAT: keep main instance SAT, but include an UNSAT branch guarded by bad_header
; If bad_header holds, force contradictory properties.
(assert (=> bad_header (and (not empty_field) has_trailing_comma)))

; Core CSV sanity: require no empty fields in the main intended path
(assert (not empty_field))

; Also require the overall input not to be exactly "Search" to avoid degenerate single-token input
(assert (not T_1))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(get-model)
(exit)
