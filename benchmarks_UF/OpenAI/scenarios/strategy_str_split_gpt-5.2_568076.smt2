(set-logic ALL)

; Uninterpreted interface for string splitting
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; -----------------------------
; SAT instance: well-formed CSV row with a fixed field count and some content rules
; -----------------------------
(declare-const csv_row String)
(declare-const delim String)
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const field3 String)
(declare-const rest_from2 String)

(assert (= delim ","))

; Exactly 4 fields (i.e., 4 segments after splitting by comma)
(assert (= (num_splits csv_row delim) 4))

; Bind fields by index
(assert (= field0 (split_at csv_row delim 0)))
(assert (= field1 (split_at csv_row delim 1)))
(assert (= field2 (split_at csv_row delim 2)))
(assert (= field3 (split_at csv_row delim 3)))

; Bind rest from index 2 onwards
(assert (= rest_from2 (split_rest csv_row delim 2)))

; Construct a concrete row satisfying constraints
(assert (= csv_row "alice,42,,NY"))

; Detect empty field: field2 is empty due to consecutive commas
(assert (= field2 ""))

; Some content checks
(assert (not (= field0 "")))
(assert (not (str.contains field0 delim)))
(assert (not (= field1 "")))
(assert (not (str.contains field1 delim)))
(assert (not (str.contains field3 delim)))

; Relationship check involving rest
(assert (str.prefixof field2 rest_from2))
(assert (str.contains rest_from2 field3))

(check-sat)

; -----------------------------
; UNSAT instance: contradicts empty-field detection on a concrete row
; -----------------------------
(declare-const csv_row_bad String)
(declare-const bad0 String)
(declare-const bad1 String)
(declare-const bad2 String)

(assert (= csv_row_bad "x,,z"))
(assert (= (num_splits csv_row_bad delim) 3))
(assert (= bad0 (split_at csv_row_bad delim 0)))
(assert (= bad1 (split_at csv_row_bad delim 1)))
(assert (= bad2 (split_at csv_row_bad delim 2)))

; In "x,,z", the middle field must be empty, so forcing it non-empty makes this UNSAT
(assert (not (= bad1 "")))

(check-sat)
(exit)
