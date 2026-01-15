(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted interface for string split

; -----------------------------
; Scenario: CSV Processing
; Processing comma-separated data fields to ensure correct field counts and detect empty fields.
; Mix of SAT and UNSAT instances in one file via a case split.
; -----------------------------

(declare-const csv_line String)
(declare-const delim String)

(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const field3 String)
(declare-const rest2 String)

(declare-const nfields Int)
(declare-const k0 Int)
(declare-const k1 Int)
(declare-const k2 Int)

; Delimiter is a comma
(assert (= delim ","))

; Index bounds / natural indices (interface requirement)
(assert (>= k0 0))
(assert (>= k1 0))
(assert (>= k2 0))
(assert (= k0 0))
(assert (= k1 1))
(assert (= k2 2))

; Relate nfields to split operator
(assert (= nfields (num_splits csv_line delim)))
(assert (>= nfields 1))

; Define extracted fields and rest
(assert (= field0 (split_at csv_line delim k0)))
(assert (= field1 (split_at csv_line delim k1)))
(assert (= field2 (split_at csv_line delim k2)))
(assert (= rest2 (split_rest csv_line delim k2)))

; CSV sanity constraints: no newlines, at least one comma in the string for multi-field records
(assert (not (str.contains csv_line "\n")))
(assert (not (str.contains csv_line "\r")))
(assert (=> (>= nfields 2) (str.contains csv_line delim)))

; A useful reconstruction-style constraint (relaxation-friendly): if at least 3 fields, then rest2 is non-empty
(assert (=> (>= nfields 3) (> (str.len rest2) 0)))

; Case split: one branch SAT (valid record with an empty field), other branch UNSAT (contradictory empty/non-empty requirement)
(declare-const choose_sat Bool)

; -----------------------------
; SAT branch: exactly 4 fields, second field empty, others non-empty
; Example: "alice,,42,NY"
; -----------------------------
(assert (=> choose_sat
  (and
    (= nfields 4)
    (>= nfields 4)
    (= field0 "alice")
    (= field1 "")
    (= field2 "42")
    (= field3 (split_at csv_line delim 3))
    (= field3 "NY")

    ; detect empty field explicitly
    (= (str.len field1) 0)
    (> (str.len field0) 0)
    (> (str.len field2) 0)
    (> (str.len field3) 0)

    ; minimal well-formedness: no spaces in fields for this simplified CSV
    (not (str.contains field0 " "))
    (not (str.contains field1 " "))
    (not (str.contains field2 " "))
    (not (str.contains field3 " "))

    ; strengthen: ensure comma appears and record length is plausible
    (str.contains csv_line ",,")
    (>= (str.len csv_line) 5)
  )))

; -----------------------------
; UNSAT branch: claim exactly 3 fields, but also require field1 empty and non-empty simultaneously
; -----------------------------
(assert (=> (not choose_sat)
  (and
    (= nfields 3)
    (>= nfields 3)

    ; bind fields to something (still via split)
    (= field0 (split_at csv_line delim 0))
    (= field1 (split_at csv_line delim 1))
    (= field2 (split_at csv_line delim 2))

    ; contradictory empty-field detection requirements
    (= field1 "")
    (> (str.len field1) 0)
  )))

; Ensure both branches are possible as separate instances by allowing either value.
; The solver will decide satisfiable overall by setting choose_sat = true.

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
