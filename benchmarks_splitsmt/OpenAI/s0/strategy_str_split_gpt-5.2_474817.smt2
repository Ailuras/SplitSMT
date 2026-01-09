(set-logic ALL)

; Uninterpreted interface operations for string splitting

; ---------------------------
; SAT instance: typical CSV processing with empty-field detection
; ---------------------------
(declare-const csv_line String)
(declare-const delim String)
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const field3 String)
(declare-const rest_after2 String)
(declare-const is_empty_field2 Bool)
(declare-const idx2 Int)

(assert (= delim ","))

; Bind fields via split interface
(assert (= field0 (str.split_at csv_line delim 0)))
(assert (= field1 (str.split_at csv_line delim 1)))
(assert (= field2 (str.split_at csv_line delim 2)))
(assert (= field3 (str.split_at csv_line delim 3)))
(assert (= rest_after2 (str.split_rest csv_line delim 2)))

; Require exactly 4 fields total (indices 0..3)
(assert (= (str.num_splits csv_line delim) 4))

; Natural index example
(assert (= idx2 2))
(assert (>= idx2 0))

; Detect empty field2 (allowed but must be recognized)
(assert (= is_empty_field2 (= field2 "")))
(assert is_empty_field2)

; Concrete witness CSV line: third field empty
(assert (= csv_line "alpha,bravo,,delta"))

; Additional consistency/shape constraints
(assert (not (= field0 "")))
(assert (not (= field1 "")))
(assert (not (= field3 "")))
(assert (not (str.contains field0 ",")))
(assert (not (str.contains field1 ",")))
(assert (not (str.contains field2 ",")))
(assert (not (str.contains field3 ",")))
(assert (>= (str.len rest_after2) (str.len field2)))

; ---------------------------
; UNSAT instance: contradictory constraints on field count and emptiness
; ---------------------------
(declare-const bad_csv String)
(declare-const bad_f0 String)
(declare-const bad_f1 String)
(declare-const bad_f2 String)
(declare-const bad_is_empty1 Bool)
(declare-const bad_k Int)

(assert (= bad_f0 (str.split_at bad_csv "," 0)))
(assert (= bad_f1 (str.split_at bad_csv "," 1)))
(assert (= bad_f2 (str.split_at bad_csv "," 2)))

; Force a 3-field CSV with a concrete line that has 3 segments
(assert (= bad_csv "x,,z"))
(assert (= (str.num_splits bad_csv ",") 3))

; Empty-field detection says field1 is empty
(assert (= bad_is_empty1 (= bad_f1 "")))
(assert bad_is_empty1)

; Contradiction: also force field1 non-empty
(assert (not (= bad_f1 "")))

; Also require an impossible field count for the same string
(assert (= bad_k 4))
(assert (>= bad_k 0))
(assert (= (str.num_splits bad_csv ",") bad_k))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
