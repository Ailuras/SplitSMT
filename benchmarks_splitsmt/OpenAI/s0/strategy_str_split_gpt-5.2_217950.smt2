(set-logic ALL)

; Uninterpreted interface for string split methodology

; =====================
; Scenario: CSV Processing
; =====================

; -------- SAT instance: a well-formed CSV line with exactly 4 fields, no empty fields --------
(declare-const csv_line_ok String)
(declare-const f0_ok String)
(declare-const f1_ok String)
(declare-const f2_ok String)
(declare-const f3_ok String)

(assert (= csv_line_ok "alpha,beta,gamma,delta"))
(assert (= (str.num_splits csv_line_ok ",") 4))
(assert (= f0_ok (str.split_at csv_line_ok "," 0)))
(assert (= f1_ok (str.split_at csv_line_ok "," 1)))
(assert (= f2_ok (str.split_at csv_line_ok "," 2)))
(assert (= f3_ok (str.split_at csv_line_ok "," 3)))

; Detect and forbid empty fields
(assert (> (str.len f0_ok) 0))
(assert (> (str.len f1_ok) 0))
(assert (> (str.len f2_ok) 0))
(assert (> (str.len f3_ok) 0))

; Additional sanity: rest from 2 should contain a comma separating field2 and field3
(declare-const rest_from_2_ok String)
(assert (= rest_from_2_ok (str.split_rest csv_line_ok "," 2)))
(assert (str.contains rest_from_2_ok ","))

; -------- SAT instance: CSV line with an empty middle field (should be detectable) --------
(declare-const csv_line_has_empty String)
(declare-const e0 String)
(declare-const e1 String)
(declare-const e2 String)
(declare-const e3 String)

(assert (= csv_line_has_empty "a,,c,d"))
(assert (= (str.num_splits csv_line_has_empty ",") 4))
(assert (= e0 (str.split_at csv_line_has_empty "," 0)))
(assert (= e1 (str.split_at csv_line_has_empty "," 1)))
(assert (= e2 (str.split_at csv_line_has_empty "," 2)))
(assert (= e3 (str.split_at csv_line_has_empty "," 3)))

; Empty field detection: at least one field is empty (here, field1)
(assert (= e1 ""))
(assert (> (str.len e0) 0))
(assert (> (str.len e2) 0))
(assert (> (str.len e3) 0))

; -------- UNSAT instance: conflicting requirements on field count --------
(declare-const csv_line_bad_count String)
(declare-const b0 String)
(declare-const b1 String)
(declare-const b2 String)

(assert (= csv_line_bad_count "x,y,z"))
(assert (= (str.num_splits csv_line_bad_count ",") 3))
(assert (= b0 (str.split_at csv_line_bad_count "," 0)))
(assert (= b1 (str.split_at csv_line_bad_count "," 1)))
(assert (= b2 (str.split_at csv_line_bad_count "," 2)))

; Contradiction: demand 4 fields while also fixing the line to have 3 segments
(assert (= (str.num_splits csv_line_bad_count ",") 4))

; -------- UNSAT instance: claim an empty field where the concrete CSV has no empty fields --------
(declare-const csv_line_no_empty String)
(declare-const n0 String)
(declare-const n1 String)
(declare-const n2 String)

(assert (= csv_line_no_empty "p,q,r"))
(assert (= (str.num_splits csv_line_no_empty ",") 3))
(assert (= n0 (str.split_at csv_line_no_empty "," 0)))
(assert (= n1 (str.split_at csv_line_no_empty "," 1)))
(assert (= n2 (str.split_at csv_line_no_empty "," 2)))

; Contradiction: force an empty middle field even though "p,q,r" has no empty segment
(assert (= n1 ""))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
