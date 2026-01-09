(set-logic ALL)

; --- Boolean skeleton preserved/mutated from seed ---
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_6 () Bool)
(declare-fun T_7 () Bool)

; --- CSV Processing scenario variables ---
(declare-const var_0xINPUT_80938 String)
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const rest1 String)
(declare-const rest2 String)
(declare-const expected_fields Int)

; --- str_split interface functions (uninterpreted per spec) ---

; Delimiter is a comma for CSV
(assert (= delim ","))

; Extract first three fields and the remainder
(assert (= f0 (str.split_at var_0xINPUT_80938 delim 0)))
(assert (= f1 (str.split_at var_0xINPUT_80938 delim 1)))
(assert (= f2 (str.split_at var_0xINPUT_80938 delim 2)))
(assert (= rest1 (str.split_rest var_0xINPUT_80938 delim 1)))
(assert (= rest2 (str.split_rest var_0xINPUT_80938 delim 2)))

; Expect exactly 3 fields in this record
(assert (= expected_fields 3))
(assert (= (str.num_splits var_0xINPUT_80938 delim) expected_fields))

; Core CSV well-formedness: non-empty record and contains delimiter if multiple fields
(assert (not (= var_0xINPUT_80938 "")))
(assert (str.contains var_0xINPUT_80938 delim))

; Detect empty field: require that at least one of the 3 fields is empty
(assert (or (= f0 "") (= f1 "") (= f2 "")))

; Simple structural constraints to tie together prefix/suffix intuition
(assert (>= (str.len f0) 0))
(assert (>= (str.len f1) 0))
(assert (>= (str.len f2) 0))
(assert (>= (str.len rest1) 0))
(assert (>= (str.len rest2) 0))

; --- Mutated boolean structure from seed, now referencing CSV constraints ---
; T_1: record is not the exact literal (kept from seed)
(assert (= T_1 (not (= "AA1ND6MEXd" var_0xINPUT_80938))))
; T_2: negation, forcing equality with the literal
(assert (= T_2 (not T_1)))
(assert T_2)

; T_3: record is not empty
(assert (= T_3 (not (= "" var_0xINPUT_80938))))
(assert T_3)

; T_4/T_5: record should not be "Example:" (kept from seed)
(assert (= T_4 (= var_0xINPUT_80938 "Example:")))
(assert (= T_5 (not T_4)))
(assert T_5)

; T_6/T_7: mirrored constraint forcing record equal to the literal again
(assert (= T_6 (not (= var_0xINPUT_80938 "AA1ND6MEXd"))))
(assert (= T_7 (not T_6)))
(assert T_7)

; Additional CSV-specific sanity: if exactly 3 fields, field2 is the last segment
(assert (= (str.split_rest var_0xINPUT_80938 delim 2) f2))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
