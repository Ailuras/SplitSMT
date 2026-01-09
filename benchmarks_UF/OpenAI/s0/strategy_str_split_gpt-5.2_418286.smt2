(set-logic ALL)

; Uninterpreted functions for string split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; =====================
; SAT instance: CSV processing with correct field count and empty-field detection
; =====================
(declare-const csv_line_sat String)
(declare-const delim String)
(declare-const sat_field0 String)
(declare-const sat_field1 String)
(declare-const sat_field2 String)
(declare-const sat_field3 String)
(declare-const sat_has_empty Bool)

(assert (= delim ","))

; Exactly 4 fields
(assert (= (num_splits csv_line_sat delim) 4))

; Bind individual fields
(assert (= sat_field0 (split_at csv_line_sat delim 0)))
(assert (= sat_field1 (split_at csv_line_sat delim 1)))
(assert (= sat_field2 (split_at csv_line_sat delim 2)))
(assert (= sat_field3 (split_at csv_line_sat delim 3)))

; Reconstruct a canonical CSV line from fields (no quoting modeled)
(assert (= csv_line_sat (str.++ sat_field0 delim sat_field1 delim sat_field2 delim sat_field3)))

; Ensure at least one empty field (detect empty segments)
(assert (= sat_has_empty (or (= sat_field0 "") (= sat_field1 "") (= sat_field2 "") (= sat_field3 ""))))
(assert sat_has_empty)

; Additional realistic constraints: fields should not contain delimiter
(assert (not (str.contains sat_field0 delim)))
(assert (not (str.contains sat_field1 delim)))
(assert (not (str.contains sat_field2 delim)))
(assert (not (str.contains sat_field3 delim)))

; Some non-empty content as well
(assert (>= (str.len sat_field0) 1))
(assert (>= (str.len sat_field3) 1))

; Use split_rest as a consistency check: rest from 2 is field2,delim,field3
(assert (= (split_rest csv_line_sat delim 2) (str.++ sat_field2 delim sat_field3)))

(check-sat)

; =====================
; UNSAT instance: contradictory requirements about empty fields
; =====================
(push 1)
(declare-const csv_line_unsat String)
(declare-const u_field0 String)
(declare-const u_field1 String)
(declare-const u_field2 String)

; Exactly 3 fields
(assert (= (num_splits csv_line_unsat delim) 3))
(assert (= u_field0 (split_at csv_line_unsat delim 0)))
(assert (= u_field1 (split_at csv_line_unsat delim 1)))
(assert (= u_field2 (split_at csv_line_unsat delim 2)))

; Reconstruct
(assert (= csv_line_unsat (str.++ u_field0 delim u_field1 delim u_field2)))

; Claim there exists an empty field
(assert (or (= u_field0 "") (= u_field1 "") (= u_field2 "")))

; Contradiction: all fields forced non-empty
(assert (> (str.len u_field0) 0))
(assert (> (str.len u_field1) 0))
(assert (> (str.len u_field2) 0))

(check-sat)
(pop 1)



; [GENERATION STATUS: SUCCESS]
(check-sat)