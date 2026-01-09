(set-logic ALL)

; Uninterpreted interface functions for string splitting

; =========================
; Scenario: CSV Processing
; =========================

; ---------- SAT instance: well-formed 4-column CSV row with some empty fields ----------
(declare-const csv_row_sat String)
(declare-const delim String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)
(declare-const tail2_sat String)

(assert (= delim ","))

; Exactly 4 fields (segments) after splitting by comma
(assert (= (str.num_splits csv_row_sat delim) 4))

; Bind fields via split_at
(assert (= f0_sat (str.split_at csv_row_sat delim 0)))
(assert (= f1_sat (str.split_at csv_row_sat delim 1)))
(assert (= f2_sat (str.split_at csv_row_sat delim 2)))
(assert (= f3_sat (str.split_at csv_row_sat delim 3)))

; Bind the rest from index 2 onwards
(assert (= tail2_sat (str.split_rest csv_row_sat delim 2)))

; Reconstruct one concrete pattern: 4 fields with two empty in the middle
(assert (= csv_row_sat (str.++ "alpha" delim "" delim "" delim "omega")))

; Empty-field detection: field 1 and 2 must be empty
(assert (= f1_sat ""))
(assert (= f2_sat ""))

; Non-empty checks for first/last
(assert (> (str.len f0_sat) 0))
(assert (> (str.len f3_sat) 0))

; Basic sanity: empty fields often appear when there are consecutive delimiters
(assert (str.contains csv_row_sat (str.++ delim delim)))

; Tail from index 2 should start with field2 followed by delimiter then field3 (field2 is empty)
(assert (= tail2_sat (str.++ f2_sat delim f3_sat)))

; ---------- UNSAT instance: contradictory expectations about empty fields ----------
(declare-const csv_row_unsat String)
(declare-const u0 String)
(declare-const u1 String)
(declare-const u2 String)
(declare-const u3 String)

; Constrain to 4 fields
(assert (= (str.num_splits csv_row_unsat ",") 4))

; Bind fields
(assert (= u0 (str.split_at csv_row_unsat "," 0)))
(assert (= u1 (str.split_at csv_row_unsat "," 1)))
(assert (= u2 (str.split_at csv_row_unsat "," 2)))
(assert (= u3 (str.split_at csv_row_unsat "," 3)))

; Force a concrete row where field1 is empty because of consecutive commas
(assert (= csv_row_unsat (str.++ "a" "," "" "," "c" "," "d")))

; Detect empty field (this is consistent)
(assert (= u1 ""))

; Contradiction: also require u1 to be non-empty
(assert (> (str.len u1) 0))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
