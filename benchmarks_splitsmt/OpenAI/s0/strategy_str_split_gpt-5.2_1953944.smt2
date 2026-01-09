(set-logic ALL)

; Uninterpreted interface functions for string split

; ========== Shared delimiter ==========
(declare-const comma String)
(assert (= comma ","))

; ========== SAT instance: well-formed CSV with possible empty middle fields ==========
(declare-const csv_line_sat String)
(declare-const sat_field0 String)
(declare-const sat_field1 String)
(declare-const sat_field2 String)
(declare-const sat_field3 String)
(declare-const sat_field4 String)
(declare-const sat_rest2 String)
(declare-const sat_rest4 String)

; Expect exactly 5 fields (4 commas)
(assert (= (str.num_splits csv_line_sat comma) 5))

; Bind fields via split_at
(assert (= sat_field0 (str.split_at csv_line_sat comma 0)))
(assert (= sat_field1 (str.split_at csv_line_sat comma 1)))
(assert (= sat_field2 (str.split_at csv_line_sat comma 2)))
(assert (= sat_field3 (str.split_at csv_line_sat comma 3)))
(assert (= sat_field4 (str.split_at csv_line_sat comma 4)))

; Rest bindings to constrain structure without defining split semantics
(assert (= sat_rest2 (str.split_rest csv_line_sat comma 2)))
(assert (= sat_rest4 (str.split_rest csv_line_sat comma 4)))

; Detect an empty field: field2 is empty
(assert (= sat_field2 ""))

; Basic non-emptiness requirements for some fields
(assert (> (str.len sat_field0) 0))
(assert (> (str.len sat_field4) 0))

; No leading/trailing spaces in selected fields (simple checks)
(assert (not (= (str.at sat_field0 0) " ")))
(assert (not (= (str.at sat_field4 0) " ")))

; A simple format requirement: field0 and field4 are numeric-like (digits only, at least 1 char)
(declare-const digit_re RegLan)
(assert (= digit_re (re.range "0" "9")))
(assert (str.in_re sat_field0 (re.+ digit_re)))
(assert (str.in_re sat_field4 (re.+ digit_re)))

; Ensure field1 contains a dash and is not empty
(assert (> (str.len sat_field1) 0))
(assert (str.contains sat_field1 "-"))

; Ensure the rest-from-4 equals field4 (common split_rest expectation for last index)
; This is a plausible interface constraint for many split APIs
(assert (= sat_rest4 sat_field4))

; Constrain rest-from-2 to contain field3 and comma and field4 in order (structural hint)
(assert (str.contains sat_rest2 (str.++ sat_field3 comma)))
(assert (str.contains sat_rest2 (str.++ comma sat_field4)))

; Provide a concrete witness to keep the instance clearly SAT
(assert (= csv_line_sat "123,aa-bb,,X,99"))


; ========== UNSAT instance: contradictory field count vs explicit structure ==========
(declare-const csv_line_unsat String)
(declare-const uns_field0 String)
(declare-const uns_field1 String)
(declare-const uns_field2 String)
(declare-const uns_field3 String)

; Force a specific line with three commas -> 4 fields
(assert (= csv_line_unsat "a,,b,c"))

; Contradict: claim it has only 3 fields
(assert (= (str.num_splits csv_line_unsat comma) 3))

; Also bind out-of-range field if only 3 fields existed (index 3 would be invalid), but we keep it as an additional constraint
(assert (= uns_field0 (str.split_at csv_line_unsat comma 0)))
(assert (= uns_field1 (str.split_at csv_line_unsat comma 1)))
(assert (= uns_field2 (str.split_at csv_line_unsat comma 2)))
(assert (= uns_field3 (str.split_at csv_line_unsat comma 3)))

; Impose expected empty field1 due to consecutive commas in the concrete string
(assert (= uns_field1 ""))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
