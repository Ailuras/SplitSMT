(set-logic ALL)

; Uninterpreted interface for string split operations

; =========================
; Scenario: CSV Processing
; =========================

; --- SAT instance: a CSV row with 4 fields, with an empty 2nd field
(declare-const csv_sat String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)
(declare-const rest2_sat String)

(assert (= csv_sat (str.++ "Alice" "," "" "," "42" "," "NY")))
(assert (= (str.num_splits csv_sat ",") 4))
(assert (= f0_sat (str.split_at csv_sat "," 0)))
(assert (= f1_sat (str.split_at csv_sat "," 1)))
(assert (= f2_sat (str.split_at csv_sat "," 2)))
(assert (= f3_sat (str.split_at csv_sat "," 3)))
(assert (= rest2_sat (str.split_rest csv_sat "," 2)))

; Detect empty field (2nd field is empty)
(assert (= f0_sat "Alice"))
(assert (= f1_sat ""))
(assert (= f2_sat "42"))
(assert (= f3_sat "NY"))
(assert (= rest2_sat (str.++ "42" "," "NY")))

; Additional sanity: no commas inside individual fields for this example
(assert (not (str.contains f0_sat ",")))
(assert (not (str.contains f1_sat ",")))
(assert (not (str.contains f2_sat ",")))
(assert (not (str.contains f3_sat ",")))

; --- UNSAT instance: contradictory constraints about empty-field detection and field count
(declare-const csv_unsat String)
(declare-const u0 String)
(declare-const u1 String)
(declare-const u2 String)

; Force an explicit empty middle field with 3 total fields
(assert (= csv_unsat (str.++ "A" "," "" "," "C")))
(assert (= (str.num_splits csv_unsat ",") 3))
(assert (= u0 (str.split_at csv_unsat "," 0)))
(assert (= u1 (str.split_at csv_unsat "," 1)))
(assert (= u2 (str.split_at csv_unsat "," 2)))
(assert (= u0 "A"))
(assert (= u1 ""))
(assert (= u2 "C"))

; Contradiction 1: claim there are no empty fields
(assert (and (not (= u0 "")) (not (= u1 "")) (not (= u2 ""))))

; Contradiction 2: inconsistent field count claim
(assert (= (str.num_splits csv_unsat ",") 4))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
