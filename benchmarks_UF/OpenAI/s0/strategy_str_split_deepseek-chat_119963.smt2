(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted functions for string split interface

; =====================
; SAT instance: well-formed CSV row with possible empty fields
; =====================
(declare-const csv_row String)
(declare-const delim String)
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const field3 String)
(declare-const field4 String)
(declare-const rest2 String)
(declare-const has_empty_field Bool)

(assert (= delim ","))

; Require exactly 5 fields (i.e., 5 segments when splitting by comma)
(assert (= (num_splits csv_row delim) 5))

; Extract fields
(assert (= field0 (split_at csv_row delim 0)))
(assert (= field1 (split_at csv_row delim 1)))
(assert (= field2 (split_at csv_row delim 2)))
(assert (= field3 (split_at csv_row delim 3)))
(assert (= field4 (split_at csv_row delim 4)))

; Rest of row from field 2 onward (sanity link)
(assert (= rest2 (split_rest csv_row delim 2)))

; Field constraints: non-empty header and last field, middle may be empty
(assert (> (str.len field0) 0))
(assert (> (str.len field4) 0))
(assert (>= (str.len field1) 0))
(assert (>= (str.len field2) 0))
(assert (>= (str.len field3) 0))

; Detect empty fields
(assert (= has_empty_field (or (= field1 "") (= field2 "") (= field3 ""))))

; Ensure there is at least one empty field to test detection logic
(assert has_empty_field)

; Additional lightweight content checks
(assert (not (str.contains field0 ",")))
(assert (not (str.contains field4 ",")))
(assert (not (str.contains rest2 ",,")))

(check-sat)

; =====================
; UNSAT instance: contradictory constraints about empty fields and composition
; =====================
(declare-const csv_row_u String)
(declare-const f0_u String)
(declare-const f1_u String)
(declare-const f2_u String)
(declare-const f3_u String)
(declare-const f4_u String)
(declare-const has_empty_u Bool)
(declare-const reconstructed_u String)

(assert (= (num_splits csv_row_u ",") 5))
(assert (= f0_u (split_at csv_row_u "," 0)))
(assert (= f1_u (split_at csv_row_u "," 1)))
(assert (= f2_u (split_at csv_row_u "," 2)))
(assert (= f3_u (split_at csv_row_u "," 3)))
(assert (= f4_u (split_at csv_row_u "," 4)))

; Define emptiness detector and contradict it
(assert (= has_empty_u (or (= f0_u "") (= f1_u "") (= f2_u "") (= f3_u "") (= f4_u ""))))
(assert has_empty_u)
(assert (and (> (str.len f0_u) 0) (> (str.len f1_u) 0) (> (str.len f2_u) 0) (> (str.len f3_u) 0) (> (str.len f4_u) 0)))

; Reconstruction with explicit commas
(assert (= reconstructed_u (str.++ f0_u "," f1_u "," f2_u "," f3_u "," f4_u)))

; Force a shape that cannot have 5 segments: no commas at all
(assert (not (str.contains reconstructed_u ",")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
