(set-logic ALL)

; CSV Processing: comma-separated fields, field counts, and empty-field detection
; We model splitting using the provided str_split interface.

(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; -------------------------
; SAT instance: valid CSV row with an empty field
; -------------------------
(declare-const csv_row String)
(declare-const comma String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)
(declare-const rest1 String)
(declare-const rest2 String)
(declare-const has_empty_field Bool)

(assert (= comma ","))

; Construct a concrete row that includes an empty middle field: "alpha,,gamma,42"
(assert (= csv_row (str.++ "alpha" comma "" comma "gamma" comma "42")))

; Expect exactly 4 fields
(assert (= (num_splits csv_row comma) 4))

; Bind fields and rests
(assert (= f0 (split_at csv_row comma 0)))
(assert (= f1 (split_at csv_row comma 1)))
(assert (= f2 (split_at csv_row comma 2)))
(assert (= f3 (split_at csv_row comma 3)))
(assert (= rest1 (split_rest csv_row comma 1)))
(assert (= rest2 (split_rest csv_row comma 2)))

; Basic index/bounds constraints (natural indices, within valid segment range)
(assert (and (>= 0 0) (< 0 (num_splits csv_row comma))))
(assert (and (>= 1 0) (< 1 (num_splits csv_row comma))))
(assert (and (>= 2 0) (< 2 (num_splits csv_row comma))))
(assert (and (>= 3 0) (< 3 (num_splits csv_row comma))))

; Non-empty constraints for certain fields, allow empty for f1
(assert (and (> (str.len f0) 0) (> (str.len f2) 0) (> (str.len f3) 0)))

; Detect empty fields: at least one empty field exists
(assert (= has_empty_field (or (= f0 "") (= f1 "") (= f2 "") (= f3 ""))))
(assert has_empty_field)

; Some additional sanity constraints using split_rest (uninterpreted, but constrained for consistency)
(assert (str.contains rest1 comma))
(assert (str.contains rest2 comma))

(check-sat)

; -------------------------
; UNSAT instance: contradictory requirements about emptiness for the same constructed row
; -------------------------
(push 1)

(declare-const must_have_empty Bool)
(declare-const must_have_no_empty Bool)

(assert (= must_have_empty (or (= f0 "") (= f1 "") (= f2 "") (= f3 ""))))
(assert (= must_have_no_empty (and (not (= f0 "")) (not (= f1 "")) (not (= f2 "")) (not (= f3 "")))))

; Force both to be true simultaneously: impossible since f1 is concretely "" from construction
(assert must_have_no_empty)
(assert must_have_empty)

(check-sat)
(pop 1)

; -------------------------
; Additional UNSAT instance: impossible field count vs constructed row
; -------------------------
(push 1)
(assert (= (num_splits csv_row comma) 3))
(check-sat)
(pop 1)



; [GENERATION STATUS: SUCCESS]
(check-sat)