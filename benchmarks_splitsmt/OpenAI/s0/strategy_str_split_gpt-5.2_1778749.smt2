(set-logic ALL)

; Uninterpreted interface for str_split

; Scenario: CSV Processing
; We model two CSV lines: one intended to be well-formed (SAT) and one contradictory (UNSAT).

; ---------- SAT instance: well-formed CSV with 4 fields ----------
(declare-const csv_ok String)
(declare-const f0_ok String)
(declare-const f1_ok String)
(declare-const f2_ok String)
(declare-const f3_ok String)

(assert (= "," ","))
(assert (= f0_ok (str.split_at csv_ok "," 0)))
(assert (= f1_ok (str.split_at csv_ok "," 1)))
(assert (= f2_ok (str.split_at csv_ok "," 2)))
(assert (= f3_ok (str.split_at csv_ok "," 3)))
(assert (= 4 (str.num_splits csv_ok ",")))

; Require the CSV string to be exactly the concatenation of fields with commas
(assert (= csv_ok (str.++ f0_ok "," f1_ok "," f2_ok "," f3_ok)))

; Detect empty fields: force one empty middle field and ensure others non-empty
(assert (= f2_ok ""))
(assert (> (str.len f0_ok) 0))
(assert (> (str.len f1_ok) 0))
(assert (> (str.len f3_ok) 0))

; Simple content constraints (avoid commas within fields, typical for unquoted CSV)
(assert (not (str.contains f0_ok ",")))
(assert (not (str.contains f1_ok ",")))
(assert (not (str.contains f2_ok ",")))
(assert (not (str.contains f3_ok ",")))

; Additional check using split_rest: from index 1 onwards should match tail concatenation
(assert (= (str.split_rest csv_ok "," 1) (str.++ f1_ok "," f2_ok "," f3_ok)))

; ---------- UNSAT instance: contradictory requirements about empty fields and segment count ----------
(declare-const csv_bad String)
(declare-const b0 String)
(declare-const b1 String)
(declare-const b2 String)

(assert (= b0 (str.split_at csv_bad "," 0)))
(assert (= b1 (str.split_at csv_bad "," 1)))
(assert (= b2 (str.split_at csv_bad "," 2)))

; Claim exactly 3 fields
(assert (= 3 (str.num_splits csv_bad ",")))
(assert (= csv_bad (str.++ b0 "," b1 "," b2)))

; Contradiction: enforce b1 is empty, but also enforce all fields are non-empty
(assert (= b1 ""))
(assert (> (str.len b0) 0))
(assert (> (str.len b1) 0))
(assert (> (str.len b2) 0))

; Another contradiction: if there are 3 fields, rest from index 2 should be b2
(assert (= (str.split_rest csv_bad "," 2) b2))
; but also assert it equals b0 (impossible unless b0=b2 and b1 empty and csv structure aligns, yet b1 non-empty already contradicts)
(assert (= (str.split_rest csv_bad "," 2) b0))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
