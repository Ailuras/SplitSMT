(set-logic ALL)

; CSV Processing scenario: comma-separated data fields

; Interface operations for splitting
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Variables
(declare-const csv_line String)
(declare-const delim String)
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const rest2 String)
(declare-const ok_nonempty Int)

; Preserve seed core structure: convoluted non-emptiness check, adapted to csv_line
(assert (and
  (not (not (not (= (ite (not (= (str.len csv_line) 0)) 1 0) 0))))
  (not (not (= (ite (not (= (str.len csv_line) 0)) 1 0) 0)))))

; Delimiter is comma
(assert (= delim ","))

; Require exactly 3 fields (i.e., two commas -> 3 segments)
(assert (= (num_splits csv_line delim) 3))

; Bind fields via split_at
(assert (= field0 (split_at csv_line delim 0)))
(assert (= field1 (split_at csv_line delim 1)))
(assert (= field2 (split_at csv_line delim 2)))

; Also bind the tail from index 2 onwards
(assert (= rest2 (split_rest csv_line delim 2)))

; Detect empty fields: at least one field must be empty
(assert (or (= field0 "") (= field1 "") (= field2 "")))

; But disallow leading empty first field (e.g., ",a,b") to model a validation rule
(assert (not (= field0 "")))

; Enforce non-trailing comma by requiring last field non-empty
(assert (not (= field2 "")))

; Create an explicit numeric flag tied to non-emptiness of field1
(assert (= ok_nonempty (ite (not (= (str.len field1) 0)) 1 0)))
(assert (or (= ok_nonempty 0) (= ok_nonempty 1)))

; Consistency check connecting rest2 and field2 (reasonable property for split_rest)
; If there are exactly 3 fields, the rest from index 2 should equal the last field
(assert (= rest2 field2))

(check-sat)


; [GENERATION STATUS: SUCCESS]
