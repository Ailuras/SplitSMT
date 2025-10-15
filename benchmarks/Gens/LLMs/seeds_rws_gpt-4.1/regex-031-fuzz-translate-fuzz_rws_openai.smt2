(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)
(set-info :category "industrial")
(set-info :status unknown)

; ; Example: TSV line processing (tab-separated)
(declare-const tsv_line String)

; The line must have exactly 5 fields (4 tabs = 5 segments)
(assert (= (str.num_splits tsv_line "\t") 5))

; Declare variables for each field
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

; ; Constraint: The second field must be empty (testing empty field handling)
(assert (= tsv_field1 ""))

; ; Constraint: The third field must NOT be empty
(assert (> (str.len tsv_field2) 0))

; ; Constraint: No field is allowed to contain the tab delimiter itself
(assert (not (str.contains tsv_field0 "\t")))
(assert (not (str.contains tsv_field1 "\t")))
(assert (not (str.contains tsv_field2 "\t")))
(assert (not (str.contains tsv_field3 "\t")))
(assert (not (str.contains tsv_field4 "\t")))

; ; Constraint: The fifth field may contain a semicolon, but not a pipe
(assert (not (str.contains tsv_field4 "|")))

; ; Unsatisfiable constraint: The first field is both empty and not empty
(assert (not (= tsv_field0 "")))
(assert (= tsv_field0 ""))

(check-sat)
(exit)