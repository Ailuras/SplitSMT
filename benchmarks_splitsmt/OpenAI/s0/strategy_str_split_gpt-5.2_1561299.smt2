(set-logic ALL)

; Uninterpreted interface operations for str_split

; -------------------------------
; Scenario: CSV Processing
; Goal: process comma-separated data fields to ensure correct field counts and detect empty fields.
; This file contains both SAT and UNSAT instances.
; -------------------------------

; -------- SAT instance --------
(declare-const csv_line_sat String)
(declare-const delim String)
(declare-const n_sat Int)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)
(declare-const rest2_sat String)
(declare-const rest3_sat String)
(declare-const has_empty_sat Bool)

(assert (= delim ","))

; Extract first 4 fields
(assert (= f0_sat (str.split_at csv_line_sat delim 0)))
(assert (= f1_sat (str.split_at csv_line_sat delim 1)))
(assert (= f2_sat (str.split_at csv_line_sat delim 2)))
(assert (= f3_sat (str.split_at csv_line_sat delim 3)))

; Remainders from index k onwards
(assert (= rest2_sat (str.split_rest csv_line_sat delim 2)))
(assert (= rest3_sat (str.split_rest csv_line_sat delim 3)))

; Field count constraints: exactly 4 segments
(assert (= n_sat (str.num_splits csv_line_sat delim)))
(assert (= n_sat 4))

; Indices natural (interface discipline)
(assert (and (<= 0 0) (<= 0 1) (<= 0 2) (<= 0 3)))

; Content constraints: two numeric fields, one empty field, and a final token "END"
(assert (str.in_re f0_sat (re.+ (re.range "0" "9"))))
(assert (= f1_sat ""))
(assert (str.in_re f2_sat (re.+ (re.range "0" "9"))))
(assert (= f3_sat "END"))

; Detect empty fields (at least one empty)
(assert (= has_empty_sat (or (= f0_sat "") (= f1_sat "") (= f2_sat "") (= f3_sat ""))))
(assert has_empty_sat)

; Ensure the original line contains at least one comma (implied by 4 splits, but explicit)
(assert (str.contains csv_line_sat ","))

; Additional consistency: if rest2 begins with f2, then it contains f2
(assert (str.contains rest2_sat f2_sat))
(assert (str.contains rest3_sat f3_sat))

; Optional pattern: line has digits, then two commas in a row somewhere due to empty field
(assert (str.contains csv_line_sat ",,"))

; -------- UNSAT instance --------
(declare-const csv_line_unsat String)
(declare-const n_unsat Int)
(declare-const g0 String)
(declare-const g1 String)
(declare-const g2 String)
(declare-const g3 String)
(declare-const all_nonempty Bool)
(declare-const some_empty Bool)

(assert (= g0 (str.split_at csv_line_unsat delim 0)))
(assert (= g1 (str.split_at csv_line_unsat delim 1)))
(assert (= g2 (str.split_at csv_line_unsat delim 2)))
(assert (= g3 (str.split_at csv_line_unsat delim 3)))

(assert (= n_unsat (str.num_splits csv_line_unsat delim)))

; Claim there are exactly 3 segments...
(assert (= n_unsat 3))
; ...but also assert a 4th segment exists and is non-empty, conflicting with the intended meaning
(assert (not (= g3 "")))

; Enforce all fields non-empty
(assert (= all_nonempty (and (not (= g0 "")) (not (= g1 "")) (not (= g2 "")) (not (= g3 "")))))
(assert all_nonempty)

; Simultaneously assert some field is empty -> contradiction
(assert (= some_empty (or (= g0 "") (= g1 "") (= g2 "") (= g3 ""))))
(assert some_empty)

; Extra CSV-like constraint: if exactly 3 segments, line must have at least 2 commas
(assert (=> (= n_unsat 3) (str.contains csv_line_unsat ",")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
