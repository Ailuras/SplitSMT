(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted interface for string split

; =========================
; Scenario: CSV Processing
; =========================

; ---------- SAT instance: basic validation, field count, empty-field detection ----------
(declare-const csv_line_sat String)
(declare-const delim String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)
(declare-const rest1_sat String)
(declare-const empty_count_sat Int)

(assert (= delim ","))

; Require exactly 4 fields (segments) separated by commas
(assert (= (num_splits csv_line_sat delim) 4))

; Extract fields
(assert (= f0_sat (split_at csv_line_sat delim 0)))
(assert (= f1_sat (split_at csv_line_sat delim 1)))
(assert (= f2_sat (split_at csv_line_sat delim 2)))
(assert (= f3_sat (split_at csv_line_sat delim 3)))

; Rest from index 1 onward
(assert (= rest1_sat (split_rest csv_line_sat delim 1)))

; Concrete shape example with an empty middle field: "alpha,,gamma,delta"
(assert (= csv_line_sat (str.++ "alpha" delim "" delim "gamma" delim "delta")))

; Basic content constraints: no commas inside fields (approximation using contains)
(assert (not (str.contains f0_sat delim)))
(assert (not (str.contains f1_sat delim)))
(assert (not (str.contains f2_sat delim)))
(assert (not (str.contains f3_sat delim)))

; Detect empties: count how many fields have length 0
(assert (= empty_count_sat
  (+ (ite (= (str.len f0_sat) 0) 1 0)
     (ite (= (str.len f1_sat) 0) 1 0)
     (ite (= (str.len f2_sat) 0) 1 0)
     (ite (= (str.len f3_sat) 0) 1 0))))

; Ensure exactly one empty field
(assert (= empty_count_sat 1))

; Additional sanity: first field non-empty, last field non-empty
(assert (> (str.len f0_sat) 0))
(assert (> (str.len f3_sat) 0))

; Ensure rest1 starts with the second field (weak check: if f1 is non-empty, it occurs in rest1)
(assert (=> (> (str.len f1_sat) 0) (str.contains rest1_sat f1_sat)))

; ---------- UNSAT instance: contradictory requirements on emptiness vs concrete string ----------
(declare-const csv_line_unsat String)
(declare-const g0_unsat String)
(declare-const g1_unsat String)
(declare-const g2_unsat String)
(declare-const g3_unsat String)
(declare-const empty_count_unsat Int)

(assert (= (num_splits csv_line_unsat delim) 4))
(assert (= g0_unsat (split_at csv_line_unsat delim 0)))
(assert (= g1_unsat (split_at csv_line_unsat delim 1)))
(assert (= g2_unsat (split_at csv_line_unsat delim 2)))
(assert (= g3_unsat (split_at csv_line_unsat delim 3)))

; Concrete CSV with no empty fields: "a,b,c,d"
(assert (= csv_line_unsat (str.++ "a" delim "b" delim "c" delim "d")))

(assert (= empty_count_unsat
  (+ (ite (= (str.len g0_unsat) 0) 1 0)
     (ite (= (str.len g1_unsat) 0) 1 0)
     (ite (= (str.len g2_unsat) 0) 1 0)
     (ite (= (str.len g3_unsat) 0) 1 0))))

; Contradiction: demand at least one empty field
(assert (>= empty_count_unsat 1))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(get-model)
(exit)
