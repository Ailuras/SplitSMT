(set-logic ALL)

; Uninterpreted interface for str_split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; =========================
; SAT instance: CSV processing with correct field counts and empty-field detection
; =========================
(declare-const csv_line_sat String)
(declare-const delim String)
(declare-const sat_field0 String)
(declare-const sat_field1 String)
(declare-const sat_field2 String)
(declare-const sat_field3 String)
(declare-const sat_tail2 String)
(declare-const sat_tail3 String)

(assert (= delim ","))

; Exactly 4 fields: f0,f1,f2,f3
(assert (= (num_splits csv_line_sat delim) 4))
(assert (= sat_field0 (split_at csv_line_sat delim 0)))
(assert (= sat_field1 (split_at csv_line_sat delim 1)))
(assert (= sat_field2 (split_at csv_line_sat delim 2)))
(assert (= sat_field3 (split_at csv_line_sat delim 3)))

; Build a concrete CSV line with an empty second field
(assert (= sat_field0 "alpha"))
(assert (= sat_field1 ""))
(assert (= sat_field2 "gamma"))
(assert (= sat_field3 "delta"))
(assert (= csv_line_sat (str.++ sat_field0 delim sat_field1 delim sat_field2 delim sat_field3)))

; Detect empty fields: ensure field1 is empty and others are non-empty
(assert (= (str.len sat_field1) 0))
(assert (> (str.len sat_field0) 0))
(assert (> (str.len sat_field2) 0))
(assert (> (str.len sat_field3) 0))

; Tail constraints via split_rest (relaxation-style interface use)
(assert (= sat_tail2 (split_rest csv_line_sat delim 2)))
(assert (= sat_tail3 (split_rest csv_line_sat delim 3)))
(assert (= sat_tail2 (str.++ sat_field2 delim sat_field3)))
(assert (= sat_tail3 sat_field3))

; No field contains a comma (simple CSV restriction, no quoting)
(assert (not (str.contains sat_field0 delim)))
(assert (not (str.contains sat_field1 delim)))
(assert (not (str.contains sat_field2 delim)))
(assert (not (str.contains sat_field3 delim)))

(check-sat)

; =========================
; UNSAT instance: contradictory requirements about field counts and empty fields
; =========================
(declare-const csv_line_unsat String)
(declare-const unsat_field0 String)
(declare-const unsat_field1 String)
(declare-const unsat_field2 String)
(declare-const unsat_field3 String)
(declare-const unsat_tail0 String)

; Demand exactly 3 fields, but also constrain 4th field to exist and be non-empty
(assert (= (num_splits csv_line_unsat delim) 3))
(assert (= unsat_field0 (split_at csv_line_unsat delim 0)))
(assert (= unsat_field1 (split_at csv_line_unsat delim 1)))
(assert (= unsat_field2 (split_at csv_line_unsat delim 2)))
(assert (= unsat_field3 (split_at csv_line_unsat delim 3)))

; Tail from 0 should equal whole string
(assert (= unsat_tail0 (split_rest csv_line_unsat delim 0)))
(assert (= unsat_tail0 csv_line_unsat))

; Construct a CSV line with 4 fields explicitly
(assert (= unsat_field0 "a"))
(assert (= unsat_field1 "b"))
(assert (= unsat_field2 "c"))
(assert (= unsat_field3 "d"))
(assert (= csv_line_unsat (str.++ unsat_field0 delim unsat_field1 delim unsat_field2 delim unsat_field3)))

; Contradict empty-field detection for field1
(assert (= (str.len unsat_field1) 0))
(assert (> (str.len unsat_field1) 0))

(check-sat)



; [GENERATION STATUS: SUCCESS]