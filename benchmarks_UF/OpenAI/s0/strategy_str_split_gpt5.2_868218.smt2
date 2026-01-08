(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; --- Uninterpreted interface for string split ---

; --- Scenario: CSV Processing ---
; We model comma-separated values, validate field counts, and detect empty fields.

(declare-const csv_line String)
(declare-const delim String)
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const rest_from1 String)
(declare-const rest_from2 String)
(declare-const nfields Int)

; Delimiter is a comma
(assert (= delim ","))

; Link fields to the split interface
(assert (= nfields (num_splits csv_line delim)))
(assert (= field0 (split_at csv_line delim 0)))
(assert (= field1 (split_at csv_line delim 1)))
(assert (= field2 (split_at csv_line delim 2)))
(assert (= rest_from1 (split_rest csv_line delim 1)))
(assert (= rest_from2 (split_rest csv_line delim 2)))

; Indices are natural (interface requirement)
(assert (and (<= 0 0) (<= 0 1) (<= 0 2)))

; ------------------------
; SAT instance: a valid 3-field CSV with an empty middle field
; Example: "alpha,,omega"  => field1 is empty
; ------------------------
(assert (>= nfields 3))
(assert (= csv_line (str.++ field0 "," field1 "," field2)))
(assert (not (= field0 "")))
(assert (= field1 ""))
(assert (not (= field2 "")))

; Basic sanity: no commas inside individual fields (simple CSV constraint)
(assert (not (str.contains field0 delim)))
(assert (not (str.contains field1 delim)))
(assert (not (str.contains field2 delim)))

; Rest strings consistent with the intended CSV structure
(assert (= rest_from1 (str.++ field1 "," field2)))
(assert (= rest_from2 field2))

; Nontrivial content constraints
(assert (>= (str.len field0) 1))
(assert (>= (str.len field2) 1))
(assert (str.contains csv_line ",,"))

; ------------------------
; UNSAT instance: claim no empty fields while forcing an empty field
; This block intentionally makes the overall formula UNSAT.
; ------------------------
(declare-const enforce_no_empty Bool)
(assert (= enforce_no_empty true))
(assert (=> enforce_no_empty (and (not (= field0 "")) (not (= field1 "")) (not (= field2 "")))))

; Additionally, require exactly 3 fields while also forcing a trailing comma (would imply empty last field in typical CSV)
(declare-const trailing_comma_required Bool)
(assert (= trailing_comma_required true))
(assert (=> trailing_comma_required (str.suffixof "," csv_line)))
(assert (= nfields 3))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
