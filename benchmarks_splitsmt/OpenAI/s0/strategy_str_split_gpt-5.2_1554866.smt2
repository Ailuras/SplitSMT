(set-logic ALL)

; Uninterpreted interface operations for str_split

; =========================
; Scenario: CSV Processing
; =========================

; ---------
; SAT case: a 4-field CSV row, with an empty field in the middle
; ---------
(declare-const csv_row_sat String)
(declare-const delim String)
(declare-const sat_f0 String)
(declare-const sat_f1 String)
(declare-const sat_f2 String)
(declare-const sat_f3 String)
(declare-const sat_tail1 String)
(declare-const sat_tail2 String)
(declare-const sat_idx Int)

(assert (= delim ","))

; Enforce total field count = 4
(assert (= (str.num_splits csv_row_sat delim) 4))

; Extract fields by index
(assert (= sat_f0 (str.split_at csv_row_sat delim 0)))
(assert (= sat_f1 (str.split_at csv_row_sat delim 1)))
(assert (= sat_f2 (str.split_at csv_row_sat delim 2)))
(assert (= sat_f3 (str.split_at csv_row_sat delim 3)))

; Indices are natural and within range
(assert (>= sat_idx 0))
(assert (< sat_idx (str.num_splits csv_row_sat delim)))

; Remainders/tails after splitting
(assert (= sat_tail1 (str.split_rest csv_row_sat delim 1)))
(assert (= sat_tail2 (str.split_rest csv_row_sat delim 2)))

; Detect an empty field: field 2 is empty
(assert (= sat_f2 ""))

; Non-empty constraints for other fields (typical CSV sanity)
(assert (> (str.len sat_f0) 0))
(assert (> (str.len sat_f1) 0))
(assert (> (str.len sat_f3) 0))

; Fields should not themselves contain the delimiter
(assert (not (str.contains sat_f0 delim)))
(assert (not (str.contains sat_f1 delim)))
(assert (not (str.contains sat_f2 delim)))
(assert (not (str.contains sat_f3 delim)))

; Constrain the row to a simple concrete shape: A,B,,D
(assert (= csv_row_sat (str.++ sat_f0 delim sat_f1 delim sat_f2 delim sat_f3)))

; Give concrete candidates (still SAT)
(assert (= sat_f0 "A"))
(assert (= sat_f1 "B"))
(assert (= sat_f3 "D"))

; Some additional consistency constraints involving tails
(assert (= sat_tail1 (str.++ sat_f1 delim sat_f2 delim sat_f3)))
(assert (= sat_tail2 (str.++ sat_f2 delim sat_f3)))


; ---------
; UNSAT case: contradictions about empty-field detection and field count
; ---------
(declare-const csv_row_unsat String)
(declare-const uns_f0 String)
(declare-const uns_f1 String)
(declare-const uns_f2 String)
(declare-const uns_f3 String)
(declare-const uns_f4 String)
(declare-const uns_bad_empty String)
(declare-const uns_k Int)

; Force 5 fields
(assert (= (str.num_splits csv_row_unsat delim) 5))

; Extract fields 0..4
(assert (= uns_f0 (str.split_at csv_row_unsat delim 0)))
(assert (= uns_f1 (str.split_at csv_row_unsat delim 1)))
(assert (= uns_f2 (str.split_at csv_row_unsat delim 2)))
(assert (= uns_f3 (str.split_at csv_row_unsat delim 3)))
(assert (= uns_f4 (str.split_at csv_row_unsat delim 4)))

; Constrain row as a 5-field CSV
(assert (= csv_row_unsat (str.++ uns_f0 delim uns_f1 delim uns_f2 delim uns_f3 delim uns_f4)))

; Natural index constraint
(assert (>= uns_k 0))
(assert (< uns_k (str.num_splits csv_row_unsat delim)))

; Model "detect empty" using a selected field (uns_bad_empty), but contradict it
; First, require field 3 is empty
(assert (= uns_f3 ""))
; Then define the detected-empty field to be field 3
(assert (= uns_bad_empty uns_f3))
; Contradiction: detected-empty must be non-empty
(assert (> (str.len uns_bad_empty) 0))

; Additional contradiction about count: also assert it is 4
(assert (= (str.num_splits csv_row_unsat delim) 4))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
