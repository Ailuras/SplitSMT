(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)
(set-info :source |
CSV/TSV/SSV/PSV field separation and validation with various delimiters and constraints.
|)
(set-info :category "industrial")
(set-info :status unknown)

; Declare a string variable representing a line in a TSV (tab-separated) file
(declare-const tsv_line String)

; Ensure the line has exactly 5 fields (i.e., 4 tabs)
(assert (= (str.num_splits tsv_line "\t") 5))

; ; Extract the first, third, and fifth fields
(declare-const tsv_f1 String)
(declare-const tsv_f3 String)
(declare-const tsv_f5 String)
(assert (= tsv_f1 (str.split_at tsv_line "\t" 0)))
(assert (= tsv_f3 (str.split_at tsv_line "\t" 2)))
(assert (= tsv_f5 (str.split_at tsv_line "\t" 4)))

; The third field must be exactly "NA"
(assert (= tsv_f3 "NA"))

; The fifth field must be empty (empty field at end)
(assert (= tsv_f5 ""))

; ; The first field must not contain any semicolons (escape/field separator check)
(assert (not (str.contains tsv_f1 ";")))

; The first field must start with "user_"
(assert (str.prefixof "user_" tsv_f1))

; ; Extract the rest after the first two fields (should include all remaining tabs and fields)
(declare-const tsv_rest String)
(assert (= tsv_rest (str.split_rest tsv_line "\t" 2)))

; ; Unsatisfiable constraint: the first field equals the third field, but third is "NA" and first starts with "user_"
(assert (= tsv_f1 tsv_f3))

(check-sat)
(exit)