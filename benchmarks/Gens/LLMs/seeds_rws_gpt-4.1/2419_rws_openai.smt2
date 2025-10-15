(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)


; Declare a TSV (tab-separated) line variable
(declare-const tsv_line String)

; Ensure the TSV line has exactly 5 fields
(assert (= (str.num_splits tsv_line "\t") 5))

; ; Extract individual fields
(declare-const tsv_field0 String)
(declare-const tsv_field1 String)
(declare-const tsv_field2 String)
(declare-const tsv_field3 String)
(declare-const tsv_field4 String)

(assert (= tsv_field0 (str.split_at tsv_line "\t" 0)))
(assert (= tsv_field1 (str.split_at tsv_line "\t" 1)))
(assert (= tsv_field2 (str.split_at tsv_line "\t" 2)))
(assert (= tsv_field3 (str.split_at tsv_line "\t" 3)))
(assert (= tsv_field4 (str.split_at tsv_line "\t" 4)))

; Ensure the third field is not empty (e.g., a required column)
(assert (> (str.len tsv_field2) 0))

; Ensure the last field is allowed to be empty (e.g., trailing field optional)
; ; Satisfiable constraint: last field is empty
(assert (= tsv_field4 ""))

; Escape handling: no field contains a literal tab character (should only appear as delimiter)
(assert (not (str.contains tsv_field0 "\t")))
(assert (not (str.contains tsv_field1 "\t")))
(assert (not (str.contains tsv_field2 "\t")))
(assert (not (str.contains tsv_field3 "\t")))

; ; Validate that the second field contains a semicolon (testing embedded delimiters)
(assert (str.contains tsv_field1 ";"))

; Get all fields starting from field 2 (fields 2, 3, 4, with delimiters)
(declare-const tsv_fields2on String)
(assert (= tsv_fields2on (str.split_rest tsv_line "\t" 2)))

; Unsatisfiable: require that fields 2on is both empty and non-empty
(assert (not (= tsv_fields2on "")))
(assert (= tsv_fields2on ""))

(check-sat)
(exit)