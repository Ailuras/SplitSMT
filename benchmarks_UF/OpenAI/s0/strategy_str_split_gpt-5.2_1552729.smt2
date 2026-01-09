(set-logic ALL)

; Uninterpreted interface for string split operations (CSV delimiter is comma)
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; --- SAT instance: validate a CSV record with expected field count and non-empty required fields ---
(declare-const csv_line String)
(declare-const delim String)
(declare-const expected_fields Int)
(declare-const actual_fields Int)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)
(declare-const rest_from_2 String)

(assert (= delim ","))
(assert (= expected_fields 4))
(assert (= actual_fields (num_splits csv_line delim)))
(assert (= actual_fields expected_fields))

; Fields by index
(assert (= f0 (split_at csv_line delim 0)))
(assert (= f1 (split_at csv_line delim 1)))
(assert (= f2 (split_at csv_line delim 2)))
(assert (= f3 (split_at csv_line delim 3)))
(assert (= rest_from_2 (split_rest csv_line delim 2)))

; Index validity for the split API
(assert (and (>= 0 0) (< 0 actual_fields)))
(assert (and (>= 1 0) (< 1 actual_fields)))
(assert (and (>= 2 0) (< 2 actual_fields)))
(assert (and (>= 3 0) (< 3 actual_fields)))

; Concrete example CSV and constraints to detect empty fields
(assert (= csv_line "alice,42,,NY"))
(assert (= f0 "alice"))
(assert (= f1 "42"))
(assert (= f2 ""))
(assert (= f3 "NY"))

; Detect at least one empty field among non-key columns (here field 2 may be empty)
(assert (or (= f1 "") (= f2 "") (= f3 "")))

; Ensure key field (field 0) must be non-empty
(assert (> (str.len f0) 0))

; Some extra sanity properties typical in CSV processing
; Field 0 should not contain comma
(assert (not (str.contains f0 delim)))
; Field 3 is a two-letter state code
(assert (= (str.len f3) 2))

; Ensure split_rest agrees with known suffix for this concrete line
(assert (= rest_from_2 ",NY"))

; --- UNSAT instance: contradictory requirements about empty field existence ---
(declare-const csv_line_u String)
(declare-const fields_u Int)
(declare-const u0 String)
(declare-const u1 String)
(declare-const u2 String)

(assert (= fields_u (num_splits csv_line_u delim)))
(assert (= fields_u 3))
(assert (= u0 (split_at csv_line_u delim 0)))
(assert (= u1 (split_at csv_line_u delim 1)))
(assert (= u2 (split_at csv_line_u delim 2)))

; Index validity
(assert (and (>= 0 0) (< 0 fields_u)))
(assert (and (>= 1 0) (< 1 fields_u)))
(assert (and (>= 2 0) (< 2 fields_u)))

; Concrete line with no empty fields
(assert (= csv_line_u "x,y,z"))
(assert (> (str.len u0) 0))
(assert (> (str.len u1) 0))
(assert (> (str.len u2) 0))

; Contradiction: require an empty field as well
(assert (or (= u0 "") (= u1 "") (= u2 "")))

(check-sat)


; [GENERATION STATUS: SUCCESS]