(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)
(set-info :source |
CSV/TSV field separation and validation using split constraints.
; Scenario: Validate field count, check for empty fields, and enforce escape handling.
Delimiters used: ',', '\t', ';', '|'
|)

; Declare a variable representing a TSV line (tab-separated)
(declare-const tsv_line String)

; Ensure the line has exactly 5 fields
(assert (= (str.num_splits tsv_line "\t") 5))

; ; Extract all 5 fields by index
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

; Ensure the third field is empty (testing empty field handling)
(assert (= tsv_field2 ""))

; Escape handling: no field should contain a literal delimiter (tab)
(assert (not (str.contains tsv_field0 "\t")))
(assert (not (str.contains tsv_field1 "\t")))
(assert (not (str.contains tsv_field2 "\t")))
(assert (not (str.contains tsv_field3 "\t")))
(assert (not (str.contains tsv_field4 "\t")))

; The last field must start with a semicolon (testing delimiter confusion)
(assert (str.prefixof ";" tsv_field4))

; Unsatisfiable combination: the first field must be both empty and non-empty
(assert (not (= tsv_field0 "")))
(assert (= tsv_field0 ""))

(check-sat)
(exit)