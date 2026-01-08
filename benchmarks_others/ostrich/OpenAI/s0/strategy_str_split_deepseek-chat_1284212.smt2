(set-logic ALL)

; Uninterpreted interface for string split operations
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; Scenario: CSV Processing (comma-separated fields)
; We model parsing a CSV line, enforce field counts, and detect empty fields.

; --------------------
; SAT instance: well-formed CSV with 4 fields, some constraints on content
; --------------------
(declare-const csv_line_sat String)
(declare-const delim_comma String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)
(declare-const rest1_sat String)
(declare-const rest2_sat String)
(declare-const rest3_sat String)

(assert (= delim_comma ","))

; field extraction
(assert (= f0_sat (split_at csv_line_sat delim_comma 0)))
(assert (= f1_sat (split_at csv_line_sat delim_comma 1)))
(assert (= f2_sat (split_at csv_line_sat delim_comma 2)))
(assert (= f3_sat (split_at csv_line_sat delim_comma 3)))

; rest reconstruction checks
(assert (= rest1_sat (split_rest csv_line_sat delim_comma 1)))
(assert (= rest2_sat (split_rest csv_line_sat delim_comma 2)))
(assert (= rest3_sat (split_rest csv_line_sat delim_comma 3)))
(assert (= rest1_sat (str.++ f1_sat delim_comma rest2_sat)))
(assert (= rest2_sat (str.++ f2_sat delim_comma rest3_sat)))

; exactly 4 fields (segments)
(assert (= (num_splits csv_line_sat delim_comma) 4))

; CSV should have at least 3 commas if it has 4 fields
(assert (>= (str.len csv_line_sat) 3))

; detect empty fields: enforce one empty field at index 2
(assert (= f2_sat ""))

; other fields non-empty
(assert (> (str.len f0_sat) 0))
(assert (> (str.len f1_sat) 0))
(assert (> (str.len f3_sat) 0))

; additional sanity: no commas inside fields (approximation via contains)
(assert (not (str.contains f0_sat delim_comma)))
(assert (not (str.contains f1_sat delim_comma)))
(assert (not (str.contains f2_sat delim_comma)))
(assert (not (str.contains f3_sat delim_comma)))

; constrain some content patterns using basic properties
(assert (= (str.at f0_sat 0) "A"))
(assert (= (str.at f3_sat 0) "Z"))

; indices are natural where used
(assert (>= 0 0))
(assert (>= 1 0))
(assert (>= 2 0))
(assert (>= 3 0))

(check-sat)

; --------------------
; UNSAT instance: conflicting requirements about field counts and emptiness
; --------------------
(declare-const csv_line_unsat String)
(declare-const g0_unsat String)
(declare-const g1_unsat String)
(declare-const g2_unsat String)

(assert (= g0_unsat (split_at csv_line_unsat delim_comma 0)))
(assert (= g1_unsat (split_at csv_line_unsat delim_comma 1)))
(assert (= g2_unsat (split_at csv_line_unsat delim_comma 2)))

; claim it has 3 fields
(assert (= (num_splits csv_line_unsat delim_comma) 3))

; also (incorrectly) require a 4th field to exist and be non-empty
(declare-const g3_unsat String)
(assert (= g3_unsat (split_at csv_line_unsat delim_comma 3)))
(assert (> (str.len g3_unsat) 0))

; but force the remainder from index 3 to be empty (i.e., no field content)
(declare-const rest3_unsat String)
(assert (= rest3_unsat (split_rest csv_line_unsat delim_comma 3)))
(assert (= rest3_unsat ""))

; additionally, require the 2nd field to be empty and non-empty simultaneously
(assert (= g1_unsat ""))
(assert (> (str.len g1_unsat) 0))

(check-sat)



; [GENERATION STATUS: SUCCESS]
