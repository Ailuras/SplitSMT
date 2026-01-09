(set-logic ALL)

; Uninterpreted interface for string split constraints
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; ----------------------------
; SAT instance: valid CSV line with 4 fields, some empty detection checks
; ----------------------------
(declare-const csv_line_sat String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)
(declare-const comma String)

(assert (= comma ","))

; Require exactly 4 segments after splitting by comma
(assert (= (num_splits csv_line_sat comma) 4))

; Extract the 4 fields
(assert (= f0_sat (split_at csv_line_sat comma 0)))
(assert (= f1_sat (split_at csv_line_sat comma 1)))
(assert (= f2_sat (split_at csv_line_sat comma 2)))
(assert (= f3_sat (split_at csv_line_sat comma 3)))

; Rest from index 2 should contain f2,f3 joined by a comma when exactly 4 fields
(assert (= (split_rest csv_line_sat comma 2) (str.++ f2_sat comma f3_sat)))

; Constrain fields: non-empty in positions 0 and 2, allow optional empties elsewhere
(assert (> (str.len f0_sat) 0))
(assert (> (str.len f2_sat) 0))

; Detect at least one empty among f1 or f3
(assert (or (= f1_sat "") (= f3_sat "")))

; Basic CSV hygiene: no newlines in the line
(assert (not (str.contains csv_line_sat "\n")))
(assert (not (str.contains csv_line_sat "\r")))

; Ensure the line actually contains commas (since 4 segments)
(assert (str.contains csv_line_sat comma))

; Make it concrete enough to be solvable while still symbolic
(assert (= csv_line_sat (str.++ f0_sat comma f1_sat comma f2_sat comma f3_sat)))

; Additional consistency: no leading/trailing spaces in f0 and f2 (simple check)
(assert (not (= (str.at f0_sat 0) " ")))
(assert (not (= (str.at f2_sat 0) " ")))

; ----------------------------
; UNSAT instance: contradictions about empty fields and segment counts
; ----------------------------
(declare-const csv_line_unsat String)
(declare-const u0 String)
(declare-const u1 String)
(declare-const u2 String)

; Require exactly 3 segments
(assert (= (num_splits csv_line_unsat comma) 3))

(assert (= u0 (split_at csv_line_unsat comma 0)))
(assert (= u1 (split_at csv_line_unsat comma 1)))
(assert (= u2 (split_at csv_line_unsat comma 2)))

; Force a concrete shape
(assert (= csv_line_unsat (str.++ u0 comma u1 comma u2)))

; Contradiction: claim middle field is empty and non-empty simultaneously
(assert (= u1 ""))
(assert (> (str.len u1) 0))

; Additional contradiction: state there are 4 splits but also 3
(assert (= (num_splits csv_line_unsat comma) 4))

; ----------------------------
; SAT instance: detect empty field at start or end using split behavior
; ----------------------------
(declare-const csv_line_sat2 String)
(declare-const g0 String)
(declare-const g1 String)
(declare-const g2 String)

(assert (= (num_splits csv_line_sat2 comma) 3))
(assert (= g0 (split_at csv_line_sat2 comma 0)))
(assert (= g1 (split_at csv_line_sat2 comma 1)))
(assert (= g2 (split_at csv_line_sat2 comma 2)))

; Construct the line
(assert (= csv_line_sat2 (str.++ g0 comma g1 comma g2)))

; Ensure exactly one empty field, and it is either the first or the last
(assert (or (= g0 "") (= g2 "")))
(assert (not (and (= g0 "") (= g2 ""))))
(assert (> (str.len g1) 0))

; Avoid commas inside fields (simple constraint)
(assert (not (str.contains g0 comma)))
(assert (not (str.contains g1 comma)))
(assert (not (str.contains g2 comma)))

(check-sat)


; [GENERATION STATUS: SUCCESS]