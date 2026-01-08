(set-logic ALL)

; Uninterpreted interface for str_split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; =========================
; Scenario: CSV Processing
; =========================

; --- SAT instance: a CSV line with 4 fields, including one empty field ---
(declare-const csv_line_sat String)
(declare-const delim String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)
(declare-const tail2_sat String)

(assert (= delim ","))

; Force a concrete but non-trivial CSV line with an empty field in the middle
(assert (= csv_line_sat "alpha,,gamma,delta"))

; Ensure field count is 4
(assert (= (num_splits csv_line_sat delim) 4))

; Extract fields
(assert (= f0_sat (split_at csv_line_sat delim 0)))
(assert (= f1_sat (split_at csv_line_sat delim 1)))
(assert (= f2_sat (split_at csv_line_sat delim 2)))
(assert (= f3_sat (split_at csv_line_sat delim 3)))

; Detect empty field at index 1
(assert (= f1_sat ""))

; Non-empty constraints for other fields
(assert (and (> (str.len f0_sat) 0)
             (> (str.len f2_sat) 0)
             (> (str.len f3_sat) 0)))

; Tail from index 2 onwards should begin with field2 (a basic sanity constraint)
(assert (= tail2_sat (split_rest csv_line_sat delim 2)))
(assert (str.prefixof (str.++ f2_sat delim) tail2_sat))

; Ensure no stray spaces in any field (simple CSV hygiene)
(assert (not (str.contains f0_sat " ")))
(assert (not (str.contains f1_sat " ")))
(assert (not (str.contains f2_sat " ")))
(assert (not (str.contains f3_sat " ")))


; --- UNSAT instance: contradictory requirements about field count and emptiness ---
(declare-const csv_line_unsat String)
(declare-const u0 String)
(declare-const u1 String)
(declare-const u2 String)

; A specific 2-field CSV
(assert (= csv_line_unsat "x,y"))

; But require 3 fields (contradiction w.r.t. this fixed string)
(assert (= (num_splits csv_line_unsat delim) 3))

; Also constrain extracted fields in a way that would correspond to 3 segments
(assert (= u0 (split_at csv_line_unsat delim 0)))
(assert (= u1 (split_at csv_line_unsat delim 1)))
(assert (= u2 (split_at csv_line_unsat delim 2)))

; Require the last field to be empty and also non-empty (direct contradiction)
(assert (= u2 ""))
(assert (> (str.len u2) 0))

(check-sat)


; [GENERATION STATUS: SUCCESS]