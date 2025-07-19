(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)
(set-info :source |
; SMT-LIB2 example: CSV/TSV field separation and validation
 Scenario: Field count, escape handling, empty fields
|)
(set-info :license "https://creativecommons.org/licenses/by/4.0/")
(set-info :category "industrial")
(set-info :status unknown)

; Declare a TSV line to process
(declare-const tsv_line String)

; Use tab as the delimiter
(define-fun delim () String "\t")

; The TSV line must have exactly 4 fields
(assert (= (str.num_splits tsv_line delim) 4))

; ; Extract all four fields
(declare-const tsv_field0 String)
(declare-const tsv_field1 String)
(declare-const tsv_field2 String)
(declare-const tsv_field3 String)

(assert (= tsv_field0 (str.split_at tsv_line delim 0)))
(assert (= tsv_field1 (str.split_at tsv_line delim 1)))
(assert (= tsv_field2 (str.split_at tsv_line delim 2)))
(assert (= tsv_field3 (str.split_at tsv_line delim 3)))

; At least one field must be empty (testing empty field handling)
(assert (or (= tsv_field0 "") (= tsv_field1 "") (= tsv_field2 "") (= tsv_field3 "")))

; No field may contain the delimiter itself (testing escape handling)
(assert (not (str.contains tsv_field0 delim)))
(assert (not (str.contains tsv_field1 delim)))
(assert (not (str.contains tsv_field2 delim)))
(assert (not (str.contains tsv_field3 delim)))

; For demonstration: an UNSAT constraint - two different fields must be equal and not empty, but also required to be empty
(assert (= tsv_field1 tsv_field2))
(assert (not (= tsv_field1 "")))
(assert (= tsv_field2 ""))

(check-sat)
(exit)