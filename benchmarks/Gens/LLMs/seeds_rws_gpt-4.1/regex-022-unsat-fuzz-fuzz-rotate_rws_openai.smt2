(set-logic QF_SLIA)

; ; CSV/TSV/PSV line processing example using split constraints
; Delimiters: ',', '\t', ';', '|'
; Focus: field count, escape handling, empty fields

; Declare a string variable representing a TSV (tab-separated) line
(declare-const tsv_line String)

; Assert that the line contains at least 2 fields (i.e., at least one tab)
(assert (>= (str.num_splits tsv_line "\t") 2))

; ; Extract the first three fields (0-based indexing)
(declare-const tsv_field0 String)
(declare-const tsv_field1 String)
(declare-const tsv_field2 String)
(assert (= tsv_field0 (str.split_at tsv_line "\t" 0)))
(assert (= tsv_field1 (str.split_at tsv_line "\t" 1)))
(assert (= tsv_field2 (str.split_at tsv_line "\t" 2)))

; Ensure the first field is empty (simulate a leading tab)
(assert (= tsv_field0 ""))

; Ensure the second field contains no tab or pipe character (simulate validation)
(assert (not (str.contains tsv_field1 "\t")))
(assert (not (str.contains tsv_field1 "|")))

; Ensure the third field is non-empty
(assert (> (str.len tsv_field2) 0))

; Now, add a constraint that makes this unsatisfiable: third field must be empty
(assert (= tsv_field2 ""))

(check-sat)
(exit)