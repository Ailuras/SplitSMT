(set-logic ALL)

; Uninterpreted interface operations for str_split

; -----------------------------
; Scenario: CSV Processing
; -----------------------------

; SAT instance: A CSV line with exactly 4 fields, one empty field in the middle, and no trailing commas
(declare-const csv_line_sat String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)
(declare-const rest2_sat String)
(declare-const rest3_sat String)

(assert (= f0_sat (str.split_at csv_line_sat "," 0)))
(assert (= f1_sat (str.split_at csv_line_sat "," 1)))
(assert (= f2_sat (str.split_at csv_line_sat "," 2)))
(assert (= f3_sat (str.split_at csv_line_sat "," 3)))

; exactly 4 fields
(assert (= (str.num_splits csv_line_sat ",") 4))

; include an empty field at index 1
(assert (= f1_sat ""))

; basic non-empty constraints for other fields
(assert (>= (str.len f0_sat) 1))
(assert (>= (str.len f2_sat) 1))
(assert (>= (str.len f3_sat) 1))

; no commas inside any single field (simple CSV, no quoting)
(assert (not (str.contains f0_sat ",")))
(assert (not (str.contains f1_sat ",")))
(assert (not (str.contains f2_sat ",")))
(assert (not (str.contains f3_sat ",")))

; relate line structure using split_rest (soft structural consistency constraints)
(assert (= rest2_sat (str.split_rest csv_line_sat "," 2)))
(assert (= rest3_sat (str.split_rest csv_line_sat "," 3)))
(assert (= rest2_sat (str.++ f2_sat "," f3_sat)))
(assert (= rest3_sat f3_sat))

; ensure there are commas in the original line for 4 fields
(assert (str.contains csv_line_sat ","))


; UNSAT instance: Force contradictory properties about empty fields / trailing comma
(declare-const csv_line_unsat String)
(declare-const u0 String)
(declare-const u1 String)
(declare-const u2 String)

(assert (= u0 (str.split_at csv_line_unsat "," 0)))
(assert (= u1 (str.split_at csv_line_unsat "," 1)))
(assert (= u2 (str.split_at csv_line_unsat "," 2)))

; exactly 3 fields
(assert (= (str.num_splits csv_line_unsat ",") 3))

; claim there is a trailing comma, which would create an empty last field in typical split semantics
(assert (str.contains csv_line_unsat ","))
(assert (= (str.at csv_line_unsat (- (str.len csv_line_unsat) 1)) ","))

; but also force the last field to be non-empty -> intended contradiction under split constraints
(assert (>= (str.len u2) 1))

; additionally, force all fields to be non-empty, contradicting empty-last-field expectation
(assert (>= (str.len u0) 1))
(assert (>= (str.len u1) 1))




; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
