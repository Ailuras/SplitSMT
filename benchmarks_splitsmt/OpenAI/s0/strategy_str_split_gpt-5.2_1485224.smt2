(set-logic ALL)

; Uninterpreted functions for string split interface

; =============================
; Scenario: CSV Processing
; =============================

; -----------------------------
; SAT instance: well-formed CSV row with 4 fields and an empty field in the middle
; Example shape: "Alice,30,,NY"
; -----------------------------
(declare-const csv_row_sat String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)
(declare-const rest1_sat String)
(declare-const rest2_sat String)
(declare-const rest3_sat String)

(assert (= (str.num_splits csv_row_sat ",") 4))
(assert (= f0_sat (str.split_at csv_row_sat "," 0)))
(assert (= f1_sat (str.split_at csv_row_sat "," 1)))
(assert (= f2_sat (str.split_at csv_row_sat "," 2)))
(assert (= f3_sat (str.split_at csv_row_sat "," 3)))

(assert (= rest1_sat (str.split_rest csv_row_sat "," 1)))
(assert (= rest2_sat (str.split_rest csv_row_sat "," 2)))
(assert (= rest3_sat (str.split_rest csv_row_sat "," 3)))

; enforce some content properties
(assert (= f0_sat "Alice"))
(assert (= f1_sat "30"))
(assert (= f2_sat ""))
(assert (= f3_sat "NY"))

; detect empty field and ensure row contains commas
(assert (str.contains csv_row_sat ","))
(assert (= (str.len f2_sat) 0))

; delimiter should not appear inside each extracted field (typical CSV without quoting)
(assert (not (str.contains f0_sat ",")))
(assert (not (str.contains f1_sat ",")))
(assert (not (str.contains f2_sat ",")))
(assert (not (str.contains f3_sat ",")))

; additional consistency: reconstruct a canonical row from the fields
(assert (= csv_row_sat (str.++ f0_sat "," f1_sat "," f2_sat "," f3_sat)))

; numeric check on an integer-like field length ("30" -> 2)
(assert (= (str.len f1_sat) 2))

; sanity constraints on split indices (natural)
(assert (and (<= 0 0) (<= 0 1) (<= 0 2) (<= 0 3)))

(check-sat)

; -----------------------------
; UNSAT instance: contradictory requirements about empty fields and field count
; -----------------------------
(declare-const csv_row_unsat String)
(declare-const u0 String)
(declare-const u1 String)
(declare-const u2 String)
(declare-const u3 String)
(declare-const u4 String)

; require 5 fields
(assert (= (str.num_splits csv_row_unsat ",") 5))
(assert (= u0 (str.split_at csv_row_unsat "," 0)))
(assert (= u1 (str.split_at csv_row_unsat "," 1)))
(assert (= u2 (str.split_at csv_row_unsat "," 2)))
(assert (= u3 (str.split_at csv_row_unsat "," 3)))
(assert (= u4 (str.split_at csv_row_unsat "," 4)))

; force a row that has no commas but still claims 5 splits (contradiction via contains)
(assert (not (str.contains csv_row_unsat ",")))

; additionally force each field to be non-empty
(assert (> (str.len u0) 0))
(assert (> (str.len u1) 0))
(assert (> (str.len u2) 0))
(assert (> (str.len u3) 0))
(assert (> (str.len u4) 0))

; but also force u2 to be empty (direct contradiction)
(assert (= u2 ""))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
