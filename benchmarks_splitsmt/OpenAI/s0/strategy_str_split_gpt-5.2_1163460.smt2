(set-logic ALL)

; Uninterpreted interface for string split operations

; ========== SAT instance: well-formed CSV line with possible empty fields ========== 
(declare-const csv_line_sat String)
(declare-const delim String)
(declare-const sat_field0 String)
(declare-const sat_field1 String)
(declare-const sat_field2 String)
(declare-const sat_field3 String)
(declare-const sat_field4 String)
(declare-const sat_tail2 String)
(declare-const sat_tail3 String)
(declare-const sat_hasEmpty Bool)

(assert (= delim ","))

; Require 5 fields total => 5 segments after split
(assert (= (str.num_splits csv_line_sat delim) 5))

; Extract each field
(assert (= sat_field0 (str.split_at csv_line_sat delim 0)))
(assert (= sat_field1 (str.split_at csv_line_sat delim 1)))
(assert (= sat_field2 (str.split_at csv_line_sat delim 2)))
(assert (= sat_field3 (str.split_at csv_line_sat delim 3)))
(assert (= sat_field4 (str.split_at csv_line_sat delim 4)))

; Use split_rest to relate suffixes (structural sanity constraints)
(assert (= sat_tail2 (str.split_rest csv_line_sat delim 2)))
(assert (= sat_tail3 (str.split_rest csv_line_sat delim 3)))

; Constrain indices to be natural and within range implied by num_splits
(assert (and (<= 0 0) (<= 0 1) (<= 0 2) (<= 0 3) (<= 0 4)))

; A CSV processor usually expects no delimiter inside fields (simple approximation)
(assert (not (str.contains sat_field0 delim)))
(assert (not (str.contains sat_field1 delim)))
(assert (not (str.contains sat_field2 delim)))
(assert (not (str.contains sat_field3 delim)))
(assert (not (str.contains sat_field4 delim)))

; Detect empty fields: sat_hasEmpty is true iff any field is empty
(assert (= sat_hasEmpty (or (= sat_field0 "") (= sat_field1 "") (= sat_field2 "") (= sat_field3 "") (= sat_field4 ""))))

; Require at least one empty field to be detected
(assert sat_hasEmpty)

; Additional realistic constraints: header-like first field and numeric 4th field
(assert (str.in_re sat_field0 (re.++ (str.to_re "ID") (re.* (str.to_re "")))))
(assert (>= (str.len sat_field0) 2))

; Make one specific field empty and another non-empty
(assert (= sat_field2 ""))
(assert (> (str.len sat_field1) 0))
(assert (> (str.len sat_field4) 0))

; Shape tails: tail from 3 contains field3,",",field4 (approx via contains)
(assert (str.contains sat_tail3 sat_field3))
(assert (str.contains sat_tail3 sat_field4))

; Make the whole line concrete enough to avoid degenerate models
(assert (= csv_line_sat (str.++ sat_field0 "," sat_field1 "," sat_field2 "," sat_field3 "," sat_field4)))

; ========== UNSAT instance: contradictory constraints on field count / emptiness ========== 
(declare-const csv_line_unsat String)
(declare-const unsat_field0 String)
(declare-const unsat_field1 String)
(declare-const unsat_field2 String)
(declare-const unsat_field3 String)
(declare-const unsat_hasEmpty Bool)

; Claim 4 fields, but also enforce a 5-field construction: contradiction via num_splits
(assert (= (str.num_splits csv_line_unsat delim) 4))

(assert (= unsat_field0 (str.split_at csv_line_unsat delim 0)))
(assert (= unsat_field1 (str.split_at csv_line_unsat delim 1)))
(assert (= unsat_field2 (str.split_at csv_line_unsat delim 2)))
(assert (= unsat_field3 (str.split_at csv_line_unsat delim 3)))

; Define emptiness detector
(assert (= unsat_hasEmpty (or (= unsat_field0 "") (= unsat_field1 "") (= unsat_field2 "") (= unsat_field3 ""))))

; Require no empty fields
(assert (not unsat_hasEmpty))

; Yet force a specific field to be empty: contradiction
(assert (= unsat_field1 ""))

; Additionally, construct a 5-field CSV string explicitly, which should imply 5 splits
(declare-const unsat_extra_field4 String)
(assert (> (str.len unsat_extra_field4) 0))
(assert (= csv_line_unsat (str.++ unsat_field0 "," unsat_field1 "," unsat_field2 "," unsat_field3 "," unsat_extra_field4)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
