(set-logic ALL)

; Uninterpreted functions for str_split interface

; -----------------------------
; SAT instance: well-formed CSV row with 4 fields, no empty fields
; -----------------------------
(declare-const csv_line_sat String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)
(declare-const rest2_sat String)

(assert (= csv_line_sat "alice,42,NY,engineer"))
(assert (= (str.num_splits csv_line_sat ",") 4))

(assert (= f0_sat (str.split_at csv_line_sat "," 0)))
(assert (= f1_sat (str.split_at csv_line_sat "," 1)))
(assert (= f2_sat (str.split_at csv_line_sat "," 2)))
(assert (= f3_sat (str.split_at csv_line_sat "," 3)))

; Detect empty fields: all fields must be non-empty
(assert (> (str.len f0_sat) 0))
(assert (> (str.len f1_sat) 0))
(assert (> (str.len f2_sat) 0))
(assert (> (str.len f3_sat) 0))

; Basic content checks (mixing simple and slightly structured constraints)
(assert (= f0_sat "alice"))
(assert (= f1_sat "42"))
(assert (str.in_re f2_sat (str.to_re "NY")))
(assert (str.contains f3_sat "engine"))

; Rest-from-index constraints
(assert (= rest2_sat (str.split_rest csv_line_sat "," 2)))
(assert (= rest2_sat "NY,engineer"))

(check-sat)

; -----------------------------
; UNSAT instance: enforce 3 fields but also require detection of an empty field in a 3-field line
; -----------------------------
(declare-const csv_line_unsat String)
(declare-const u0 String)
(declare-const u1 String)
(declare-const u2 String)

; Concrete CSV with an empty middle field
(assert (= csv_line_unsat "A,,C"))

; Field count as 3 is fine
(assert (= (str.num_splits csv_line_unsat ",") 3))
(assert (= u0 (str.split_at csv_line_unsat "," 0)))
(assert (= u1 (str.split_at csv_line_unsat "," 1)))
(assert (= u2 (str.split_at csv_line_unsat "," 2)))

; Detect empty fields, but (incorrectly) assert none are empty -> contradiction with the intended empty field
(assert (> (str.len u0) 0))
(assert (> (str.len u1) 0))
(assert (> (str.len u2) 0))

; Additionally, state the middle field is empty (forces direct clash)
(assert (= u1 ""))

(check-sat)
(exit)
