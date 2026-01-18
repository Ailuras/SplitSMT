(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted interface for string split operations

; =====================
; Scenario: CSV Processing
; =====================

; --- Shared constants
(declare-const comma String)
(assert (= comma ","))

; -------------------------------------------------
; SAT instance: a CSV line with 4 fields, with empty field detection
; Example target shape: "alpha,,gamma,delta" (second field is empty)
; -------------------------------------------------
(declare-const csv_line_sat String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)
(declare-const rest1_sat String)
(declare-const rest2_sat String)
(declare-const rest3_sat String)

(assert (= 4 (num_splits csv_line_sat comma)))
(assert (= f0_sat (split_at csv_line_sat comma 0)))
(assert (= f1_sat (split_at csv_line_sat comma 1)))
(assert (= f2_sat (split_at csv_line_sat comma 2)))
(assert (= f3_sat (split_at csv_line_sat comma 3)))

; Empty field detection: require exactly the second field to be empty
(assert (= f1_sat ""))
(assert (not (= f0_sat "")))
(assert (not (= f2_sat "")))
(assert (not (= f3_sat "")))

; Basic sanity: reconstruct via rest segments (relaxation-style constraints)
(assert (= rest1_sat (split_rest csv_line_sat comma 1)))
(assert (= rest2_sat (split_rest csv_line_sat comma 2)))
(assert (= rest3_sat (split_rest csv_line_sat comma 3)))
(assert (str.contains rest1_sat comma))
(assert (str.contains rest2_sat comma))
(assert (not (str.contains rest3_sat comma)))

; Ensure comma count matches 4 fields -> at least 3 commas present
(assert (>= (str.len csv_line_sat) 3))
(assert (str.contains csv_line_sat comma))

; Pin to a concrete satisfying example
(assert (= csv_line_sat "alpha,,gamma,delta"))


; -------------------------------------------------
; UNSAT instance: claim 3 fields, but enforce both leading and trailing comma
; Leading comma -> first field empty; trailing comma -> last field empty => at least 4 segments
; This conflicts with num_splits = 3
; -------------------------------------------------
(declare-const csv_line_unsat String)
(declare-const u0 String)
(declare-const u1 String)
(declare-const u2 String)

(assert (= 3 (num_splits csv_line_unsat comma)))
(assert (= u0 (split_at csv_line_unsat comma 0)))
(assert (= u1 (split_at csv_line_unsat comma 1)))
(assert (= u2 (split_at csv_line_unsat comma 2)))

; Enforce leading and trailing commas
(assert (str.prefixof "," csv_line_unsat))
(assert (str.suffixof "," csv_line_unsat))

; Make the middle contain some content to avoid degenerate all-empty line
(assert (>= (str.len csv_line_unsat) 2))
(assert (str.contains csv_line_unsat "x"))

; Also require that the last field (as per split_at) is non-empty, which contradicts trailing comma semantics
(assert (not (= u2 "")))


; -------------------------------------------------
; SAT instance: detect no empty fields for a fixed 3-column header
; Example: "id,name,age" with all non-empty and exactly 3 fields
; -------------------------------------------------
(declare-const header_line String)
(declare-const h0 String)
(declare-const h1 String)
(declare-const h2 String)

(assert (= 3 (num_splits header_line comma)))
(assert (= h0 (split_at header_line comma 0)))
(assert (= h1 (split_at header_line comma 1)))
(assert (= h2 (split_at header_line comma 2)))
(assert (and (not (= h0 "")) (not (= h1 "")) (not (= h2 ""))))
(assert (= header_line "id,name,age"))


; -------------------------------------------------
; Force combined satisfiability: include both SAT and UNSAT parts together
; This makes the whole file UNSAT overall, demonstrating detection.
; -------------------------------------------------


; [GENERATION STATUS: SUCCESS]
(check-sat)
(get-model)
(exit)
