(set-logic ALL)

; Uninterpreted interface for string splitting
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Scenario: CSV Processing
; We model several CSV lines and enforce constraints about field counts and empties.

; ---------- SAT instance: well-formed CSV with 4 fields and some content constraints ----------
(declare-const csv_ok String)
(declare-const ok_f0 String)
(declare-const ok_f1 String)
(declare-const ok_f2 String)
(declare-const ok_f3 String)

(assert (= csv_ok "id,name,age,city"))
(assert (= (num_splits csv_ok ",") 4))
(assert (= ok_f0 (split_at csv_ok "," 0)))
(assert (= ok_f1 (split_at csv_ok "," 1)))
(assert (= ok_f2 (split_at csv_ok "," 2)))
(assert (= ok_f3 (split_at csv_ok "," 3)))
(assert (= ok_f0 "id"))
(assert (= ok_f1 "name"))
(assert (= ok_f2 "age"))
(assert (= ok_f3 "city"))
(assert (= (split_rest csv_ok "," 2) "age,city"))
(assert (and (>= (str.len ok_f0) 1)
             (>= (str.len ok_f1) 1)
             (>= (str.len ok_f2) 1)
             (>= (str.len ok_f3) 1)))

; ---------- SAT instance: detect empty fields (consecutive commas) ----------
(declare-const csv_empty_ok String)
(declare-const e_f0 String)
(declare-const e_f1 String)
(declare-const e_f2 String)

(assert (= csv_empty_ok "a,,c"))
(assert (= (num_splits csv_empty_ok ",") 3))
(assert (= e_f0 (split_at csv_empty_ok "," 0)))
(assert (= e_f1 (split_at csv_empty_ok "," 1)))
(assert (= e_f2 (split_at csv_empty_ok "," 2)))
(assert (= e_f0 "a"))
(assert (= e_f1 ""))
(assert (= e_f2 "c"))
(assert (= (split_rest csv_empty_ok "," 1) ",c"))

; ---------- UNSAT instance: conflicting requirements about emptiness ----------
(declare-const csv_bad_empty String)
(declare-const b_f0 String)
(declare-const b_f1 String)
(declare-const b_f2 String)

(assert (= csv_bad_empty "x,,z"))
(assert (= (num_splits csv_bad_empty ",") 3))
(assert (= b_f0 (split_at csv_bad_empty "," 0)))
(assert (= b_f1 (split_at csv_bad_empty "," 1)))
(assert (= b_f2 (split_at csv_bad_empty "," 2)))
; The middle field is empty due to consecutive commas, but we (incorrectly) require it non-empty.
(assert (= b_f1 ""))
(assert (>= (str.len b_f1) 1))

; ---------- Another UNSAT instance: contradictory field count constraints ----------
(declare-const csv_count_conflict String)

(assert (= csv_count_conflict "p,q,r"))
(assert (= (num_splits csv_count_conflict ",") 3))
(assert (= (num_splits csv_count_conflict ",") 4))

(check-sat)


; [GENERATION STATUS: SUCCESS]