(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)

; Declare a variable for a TSV line (tab-separated values)
(declare-const tsv_line String)

; Ensure the line uses tab as delimiter and has exactly 5 fields
(assert (= (str.num_splits tsv_line "\t") 5))

; ; Extract all five fields for further constraints
(declare-const tsv_f0 String)
(declare-const tsv_f1 String)
(declare-const tsv_f2 String)
(declare-const tsv_f3 String)
(declare-const tsv_f4 String)
(assert (= tsv_f0 (str.split_at tsv_line "\t" 0)))
(assert (= tsv_f1 (str.split_at tsv_line "\t" 1)))
(assert (= tsv_f2 (str.split_at tsv_line "\t" 2)))
(assert (= tsv_f3 (str.split_at tsv_line "\t" 3)))
(assert (= tsv_f4 (str.split_at tsv_line "\t" 4)))

; ; Constraint: the third field must be empty
(assert (= tsv_f2 ""))

; ; Constraint: no field contains the delimiter (tab character)
(assert (not (str.contains tsv_f0 "\t")))
(assert (not (str.contains tsv_f1 "\t")))
(assert (not (str.contains tsv_f2 "\t")))
(assert (not (str.contains tsv_f3 "\t")))
(assert (not (str.contains tsv_f4 "\t")))

; ; Constraint: the first and last fields must not be empty
(assert (> (str.len tsv_f0) 0))
(assert (> (str.len tsv_f4) 0))

(assert (str.contains tsv_f3 "|"))

; ; UNSAT constraint: the first and last fields must be identical and also different
(assert (= tsv_f0 tsv_f4))
(assert (not (= tsv_f0 tsv_f4)))

(check-sat)
(exit)