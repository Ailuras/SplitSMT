(set-logic QF_SLIA)
; CSV/TSV field separation and validation using str.split_at, str.num_splits, str.split_rest
; Delimiters used: ',', '\t', ';', '|'

; Declare a string constant representing a CSV line with semicolon delimiter
(declare-const csv_line String)

; Declare a string constant representing a TSV line with tab delimiter
(declare-const tsv_line String)

; --- CSV SCENARIO with semicolon delimiter ---

; Assert that the CSV line has exactly 5 fields (i.e., 4 semicolons)
(assert (= (str.num_splits csv_line ";") 5))

; ; Extract the individual fields
(declare-const csv_f0 String)
(declare-const csv_f1 String)
(declare-const csv_f2 String)
(declare-const csv_f3 String)
(declare-const csv_f4 String)

(assert (= csv_f0 (str.split_at csv_line ";" 0)))
(assert (= csv_f1 (str.split_at csv_line ";" 1)))
(assert (= csv_f2 (str.split_at csv_line ";" 2)))
(assert (= csv_f3 (str.split_at csv_line ";" 3)))
(assert (= csv_f4 (str.split_at csv_line ";" 4)))

; The third field (index 2) must be empty
(assert (= csv_f2 ""))

; The fifth field (index 4) must not contain the delimiter ';'
(assert (not (str.contains csv_f4 ";")))

; The second field (index 1) must contain the substring "ID"
(assert (str.contains csv_f1 "ID"))

; The first field must have length at least 2
(assert (>= (str.len csv_f0) 2))

; The last two fields concatenated (with delimiter) must be equal to the rest from index 3
(declare-const csv_rest String)
(assert (= csv_rest (str.split_rest csv_line ";" 3)))
(assert (= csv_rest (str.++ csv_f3 ";" csv_f4)))

; --- TSV SCENARIO with tab delimiter ---

; Assert that the TSV line has at least 3 fields (i.e., at least 2 tabs)
(assert (>= (str.num_splits tsv_line "\t") 3))

; ; Extract first three fields
(declare-const tsv_f0 String)
(declare-const tsv_f1 String)
(declare-const tsv_f2 String)

(assert (= tsv_f0 (str.split_at tsv_line "\t" 0)))
(assert (= tsv_f1 (str.split_at tsv_line "\t" 1)))
(assert (= tsv_f2 (str.split_at tsv_line "\t" 2)))

; The first field must not be empty
(assert (not (= tsv_f0 "")))

; The second field (tsv_f1) must start with "user"
(assert (str.prefixof "user" tsv_f1))

; The third field must not contain any tab characters
(assert (not (str.contains tsv_f2 "\t")))

; The rest from index 2 must start with the third field
(declare-const tsv_rest String)
(assert (= tsv_rest (str.split_rest tsv_line "\t" 2)))
(assert (str.prefixof tsv_f2 tsv_rest))

; ; --- UNSAT EXAMPLE: conflicting constraint on CSV ---
; The third field (csv_f2) is required to be both empty and to contain "abc" (which is impossible)
(assert (str.contains csv_f2 "abc"))

(check-sat)
(exit)