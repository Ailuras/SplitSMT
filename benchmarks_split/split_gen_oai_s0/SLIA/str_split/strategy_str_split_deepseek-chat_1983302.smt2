(set-logic ALL)

; Uninterpreted interface for string splitting
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; =====================
; Scenario: CSV Processing
; - Ensure correct field counts
; - Detect empty fields
; =====================

; ---------- SAT instance: a 4-field CSV line with a known empty field ----------
(declare-const csv_line_sat String)
(declare-const delim String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)
(declare-const rest2_sat String)

(assert (= delim ","))

; Enforce exactly 4 fields
(assert (= (num_splits csv_line_sat delim) 4))

; Project fields
(assert (= f0_sat (split_at csv_line_sat delim 0)))
(assert (= f1_sat (split_at csv_line_sat delim 1)))
(assert (= f2_sat (split_at csv_line_sat delim 2)))
(assert (= f3_sat (split_at csv_line_sat delim 3)))

; Rest from index 2
(assert (= rest2_sat (split_rest csv_line_sat delim 2)))

; Concrete shape: "alpha,,42,omega" (empty second field)
(assert (= f0_sat "alpha"))
(assert (= f1_sat ""))
(assert (= f2_sat "42"))
(assert (= f3_sat "omega"))

; Non-empty constraints on other fields
(assert (> (str.len f0_sat) 0))
(assert (> (str.len f2_sat) 0))
(assert (> (str.len f3_sat) 0))

; The remainder from 2 should include commas and end with last field
(assert (str.contains rest2_sat ","))
(assert (str.contains rest2_sat f3_sat))

; ---------- UNSAT instance: contradictory constraints about empty-field existence ----------
(declare-const csv_line_unsat String)
(declare-const f0_u String)
(declare-const f1_u String)
(declare-const f2_u String)
(declare-const has_empty_u Bool)

; Exactly 3 fields
(assert (= (num_splits csv_line_unsat delim) 3))

(assert (= f0_u (split_at csv_line_unsat delim 0)))
(assert (= f1_u (split_at csv_line_unsat delim 1)))
(assert (= f2_u (split_at csv_line_unsat delim 2)))

; Define a helper boolean capturing whether any field is empty
(assert (= has_empty_u (or (= f0_u "") (= f1_u "") (= f2_u ""))))

; Contradiction: require an empty field but also require all fields non-empty
(assert has_empty_u)
(assert (> (str.len f0_u) 0))
(assert (> (str.len f1_u) 0))
(assert (> (str.len f2_u) 0))

; ---------- Another SAT instance: 2-field CSV with no empty fields, plus simple content rules ----------
(declare-const csv_line_sat2 String)
(declare-const g0 String)
(declare-const g1 String)
(declare-const rest1 String)

(assert (= (num_splits csv_line_sat2 delim) 2))
(assert (= g0 (split_at csv_line_sat2 delim 0)))
(assert (= g1 (split_at csv_line_sat2 delim 1)))
(assert (= rest1 (split_rest csv_line_sat2 delim 1)))

; No empty fields
(assert (> (str.len g0) 0))
(assert (> (str.len g1) 0))

; Some simple content constraints
(assert (str.contains g0 "id"))
(assert (not (str.contains g1 ",")))
(assert (= rest1 g1))

(check-sat)


; [GENERATION STATUS: SUCCESS]