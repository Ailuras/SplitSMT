(set-logic ALL)

; Uninterpreted split interface for CSV processing

; =====================
; SAT instance: well-formed CSV with exactly 4 fields, no empty fields
; =====================
(declare-const csv_line_sat String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)

(assert (= csv_line_sat "alpha,beta,gamma,delta"))
(assert (= (str.num_splits csv_line_sat ",") 4))
(assert (= f0_sat (str.split_at csv_line_sat "," 0)))
(assert (= f1_sat (str.split_at csv_line_sat "," 1)))
(assert (= f2_sat (str.split_at csv_line_sat "," 2)))
(assert (= f3_sat (str.split_at csv_line_sat "," 3)))

; detect empty fields: enforce all non-empty
(assert (> (str.len f0_sat) 0))
(assert (> (str.len f1_sat) 0))
(assert (> (str.len f2_sat) 0))
(assert (> (str.len f3_sat) 0))

; additional sanity: no commas inside extracted fields
(assert (not (str.contains f0_sat ",")))
(assert (not (str.contains f1_sat ",")))
(assert (not (str.contains f2_sat ",")))
(assert (not (str.contains f3_sat ",")))

; tie split_rest to a consistency expectation (interface-level reasoning)
(declare-const tail1_sat String)
(assert (= tail1_sat (str.split_rest csv_line_sat "," 1)))
(assert (str.contains tail1_sat ","))

(check-sat)

; =====================
; UNSAT instance: empty-field detection contradiction
;   line has an empty 2nd field: "A,,C" (3 fields total), but we force it non-empty
; =====================
(declare-const csv_line_unsat String)
(declare-const u0 String)
(declare-const u1 String)
(declare-const u2 String)

(assert (= csv_line_unsat "A,,C"))
(assert (= (str.num_splits csv_line_unsat ",") 3))
(assert (= u0 (str.split_at csv_line_unsat "," 0)))
(assert (= u1 (str.split_at csv_line_unsat "," 1)))
(assert (= u2 (str.split_at csv_line_unsat "," 2)))

; expected empty middle field
(assert (= u1 ""))

; contradiction: also require all fields non-empty
(assert (> (str.len u0) 0))
(assert (> (str.len u1) 0))
(assert (> (str.len u2) 0))

(check-sat)
(exit)
