(set-logic ALL)

; Uninterpreted split interface for CSV processing

; -------------------------------
; SAT instance: CSV line with exactly 4 fields, detect empty field(s)
; -------------------------------
(declare-const csv_line_sat String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)
(declare-const rest1_sat String)
(declare-const rest2_sat String)
(declare-const rest3_sat String)

(assert (= csv_line_sat "Alice,,30,NY"))
(assert (= (str.num_splits csv_line_sat ",") 4))
(assert (= f0_sat (str.split_at csv_line_sat "," 0)))
(assert (= f1_sat (str.split_at csv_line_sat "," 1)))
(assert (= f2_sat (str.split_at csv_line_sat "," 2)))
(assert (= f3_sat (str.split_at csv_line_sat "," 3)))

; Indices are natural and within bounds implied by field count
(assert (and (>= 0 0) (< 0 (str.num_splits csv_line_sat ","))))
(assert (and (>= 1 0) (< 1 (str.num_splits csv_line_sat ","))))
(assert (and (>= 2 0) (< 2 (str.num_splits csv_line_sat ","))))
(assert (and (>= 3 0) (< 3 (str.num_splits csv_line_sat ","))))

; Empty-field detection: second field is empty
(assert (= f0_sat "Alice"))
(assert (= f1_sat ""))
(assert (= f2_sat "30"))
(assert (= f3_sat "NY"))

; Additional consistency checks using split_rest
(assert (= rest1_sat (str.split_rest csv_line_sat "," 1)))
(assert (= rest2_sat (str.split_rest csv_line_sat "," 2)))
(assert (= rest3_sat (str.split_rest csv_line_sat "," 3)))

(assert (str.contains rest1_sat ","))
(assert (str.contains rest2_sat ","))
(assert (not (str.contains rest3_sat ",")))

; Basic sanity: no newline characters in a single CSV line
(assert (not (str.contains csv_line_sat "\n")))
(assert (not (str.contains csv_line_sat "\r")))

(check-sat)

; -------------------------------
; UNSAT instance: contradictory requirements about empty fields and field count
; -------------------------------
(declare-const csv_line_unsat String)
(declare-const u0 String)
(declare-const u1 String)
(declare-const u2 String)

; A concrete CSV line with an empty middle field, thus 3 fields total
(assert (= csv_line_unsat "A,,B"))
(assert (= (str.num_splits csv_line_unsat ",") 3))
(assert (= u0 (str.split_at csv_line_unsat "," 0)))
(assert (= u1 (str.split_at csv_line_unsat "," 1)))
(assert (= u2 (str.split_at csv_line_unsat "," 2)))

; Contradiction 1: demand no empty fields, but the concrete line has an empty one
(assert (not (= u1 "")))

; Contradiction 2: also demand the wrong number of fields
(assert (= (str.num_splits csv_line_unsat ",") 4))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
