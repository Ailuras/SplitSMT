(set-logic ALL)

; Uninterpreted interface for str_split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; ------------------------------
; Scenario: CSV Processing
; Goal: enforce correct field counts and detect empty fields
; Includes both SAT and UNSAT sub-instances in one file.
; ------------------------------

; ---------- SAT instance ----------
(declare-const csv_line_sat String)
(declare-const d_comma String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)
(declare-const rest2_sat String)

(assert (= d_comma ","))

; Exactly 4 fields => num_splits = 4
(assert (= (num_splits csv_line_sat d_comma) 4))

; Bind fields using split_at
(assert (= f0_sat (split_at csv_line_sat d_comma 0)))
(assert (= f1_sat (split_at csv_line_sat d_comma 1)))
(assert (= f2_sat (split_at csv_line_sat d_comma 2)))
(assert (= f3_sat (split_at csv_line_sat d_comma 3)))

; A remainder view from index 2
(assert (= rest2_sat (split_rest csv_line_sat d_comma 2)))

; Detect an empty middle field (e.g., "A,,C,D")
(assert (= f1_sat ""))

; Ensure other fields are non-empty and do not contain commas
(assert (> (str.len f0_sat) 0))
(assert (> (str.len f2_sat) 0))
(assert (> (str.len f3_sat) 0))
(assert (not (str.contains f0_sat d_comma)))
(assert (not (str.contains f1_sat d_comma)))
(assert (not (str.contains f2_sat d_comma)))
(assert (not (str.contains f3_sat d_comma)))

; Constrain the overall CSV line to have comma separators (at least 3 commas for 4 fields)
; This is a lightweight structural constraint without fully defining split semantics.
(assert (str.contains csv_line_sat ",,"))
(assert (str.contains csv_line_sat ","))
(assert (>= (str.len csv_line_sat) 3))

; Some additional typical CSV sanity checks: no newline characters
(assert (not (str.contains csv_line_sat "\n")))
(assert (not (str.contains csv_line_sat "\r")))

; ---------- UNSAT instance ----------
(declare-const csv_line_unsat String)
(declare-const g0_unsat String)
(declare-const g1_unsat String)
(declare-const g2_unsat String)

; Require exactly 3 fields
(assert (= (num_splits csv_line_unsat d_comma) 3))

; Bind fields
(assert (= g0_unsat (split_at csv_line_unsat d_comma 0)))
(assert (= g1_unsat (split_at csv_line_unsat d_comma 1)))
(assert (= g2_unsat (split_at csv_line_unsat d_comma 2)))

; Contradiction: claim field 1 is empty and non-empty simultaneously
(assert (= g1_unsat ""))
(assert (> (str.len g1_unsat) 0))

; Additional contradictions related to empty-field detection
(assert (str.contains csv_line_unsat ",,"))
(assert (not (str.contains csv_line_unsat ",,")))

(check-sat)


; [GENERATION STATUS: SUCCESS]