(set-logic ALL)

; Uninterpreted interface for string split constraints (CSV-like)

; ----------------------------
; SAT instance: a well-formed CSV row with 4 fields, no empty fields
; ----------------------------
(declare-const csv_row_ok String)
(declare-const ok_f0 String)
(declare-const ok_f1 String)
(declare-const ok_f2 String)
(declare-const ok_f3 String)

(assert (= csv_row_ok "alpha,beta,gamma,delta"))
(assert (= ok_f0 (str.split_at csv_row_ok "," 0)))
(assert (= ok_f1 (str.split_at csv_row_ok "," 1)))
(assert (= ok_f2 (str.split_at csv_row_ok "," 2)))
(assert (= ok_f3 (str.split_at csv_row_ok "," 3)))
(assert (= (str.num_splits csv_row_ok ",") 4))

; Ensure no empty fields (detect empty fields)
(assert (> (str.len ok_f0) 0))
(assert (> (str.len ok_f1) 0))
(assert (> (str.len ok_f2) 0))
(assert (> (str.len ok_f3) 0))

; Basic sanity: first character of each field is not a comma
(assert (not (= (str.at ok_f0 0) ",")))
(assert (not (= (str.at ok_f1 0) ",")))
(assert (not (= (str.at ok_f2 0) ",")))
(assert (not (= (str.at ok_f3 0) ",")))

; A consistency-style constraint: the rest from index 2 should contain f2
(assert (str.contains (str.split_rest csv_row_ok "," 2) ok_f2))

(check-sat)

; ----------------------------
; UNSAT instance: claims no empty fields but row has an empty middle field
; ----------------------------
(declare-const csv_row_bad String)
(declare-const bad_f0 String)
(declare-const bad_f1 String)
(declare-const bad_f2 String)

(assert (= csv_row_bad "a,,c"))
(assert (= (str.num_splits csv_row_bad ",") 3))
(assert (= bad_f0 (str.split_at csv_row_bad "," 0)))
(assert (= bad_f1 (str.split_at csv_row_bad "," 1)))
(assert (= bad_f2 (str.split_at csv_row_bad "," 2)))

; Requires all fields to be non-empty
(assert (> (str.len bad_f0) 0))
(assert (> (str.len bad_f1) 0))
(assert (> (str.len bad_f2) 0))

; But we also explicitly detect that the middle field is empty
(assert (= bad_f1 ""))

(check-sat)
(exit)
