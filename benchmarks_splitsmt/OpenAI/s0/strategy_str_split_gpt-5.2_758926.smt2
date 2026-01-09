(set-logic ALL)

; Uninterpreted interface for string split

; Scenario: CSV Processing
; We model comma-separated values (CSV) rows, ensure correct field counts, and detect empty fields.

; ------------------------
; SAT instance: well-formed CSV row with exactly 4 fields, third field empty
; ------------------------
(declare-const csv_row_sat String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)

(assert (= csv_row_sat "alpha,42,,z"))
(assert (= (str.num_splits csv_row_sat ",") 4))

(assert (= f0_sat (str.split_at csv_row_sat "," 0)))
(assert (= f1_sat (str.split_at csv_row_sat "," 1)))
(assert (= f2_sat (str.split_at csv_row_sat "," 2)))
(assert (= f3_sat (str.split_at csv_row_sat "," 3)))

; Basic content checks
(assert (= f0_sat "alpha"))
(assert (= f1_sat "42"))
(assert (= f2_sat ""))
(assert (= f3_sat "z"))

; Empty field detection
(assert (= (str.len f2_sat) 0))
(assert (> (str.len f0_sat) 0))
(assert (> (str.len f1_sat) 0))
(assert (> (str.len f3_sat) 0))

; Rest-of-fields concatenation check from index 2
(assert (= (str.split_rest csv_row_sat "," 2) ",z"))

; Ensure no spaces in any field (simple hygiene constraint)
(assert (not (str.contains f0_sat " ")))
(assert (not (str.contains f1_sat " ")))
(assert (not (str.contains f2_sat " ")))
(assert (not (str.contains f3_sat " ")))

; ------------------------
; UNSAT instance: contradictory requirements about empty fields and field counts
; ------------------------
(declare-const csv_row_unsat String)
(declare-const g0_unsat String)
(declare-const g1_unsat String)
(declare-const g2_unsat String)

; A concrete 3-field CSV row
(assert (= csv_row_unsat "a,,c"))
(assert (= (str.num_splits csv_row_unsat ",") 3))

(assert (= g0_unsat (str.split_at csv_row_unsat "," 0)))
(assert (= g1_unsat (str.split_at csv_row_unsat "," 1)))
(assert (= g2_unsat (str.split_at csv_row_unsat "," 2)))

; Force middle field to be empty (matches the row)
(assert (= g1_unsat ""))
(assert (= (str.len g1_unsat) 0))

; Contradiction: also require it to be non-empty
(assert (> (str.len g1_unsat) 0))

; Additional contradiction: claim there are 4 fields
(assert (= (str.num_splits csv_row_unsat ",") 4))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
