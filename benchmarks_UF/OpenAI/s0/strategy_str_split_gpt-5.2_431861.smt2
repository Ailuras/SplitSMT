(set-logic ALL)

; Uninterpreted interface for string split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; === Scenario: CSV Processing ===
; We model two independent CSV lines: one intended SAT (well-formed with an empty field)
; and one intended UNSAT (conflicting constraints about emptiness).

; ---------- SAT instance: well-formed CSV with exactly 4 fields and one empty field ----------
(declare-const csv_ok String)
(declare-const f0_ok String)
(declare-const f1_ok String)
(declare-const f2_ok String)
(declare-const f3_ok String)
(declare-const rest1_ok String)
(declare-const rest2_ok String)
(declare-const rest3_ok String)

(assert (>= (str.len csv_ok) 0))

; Field count: exactly 4 segments when splitting by ","
(assert (= (num_splits csv_ok ",") 4))

; Extract fields
(assert (= f0_ok (split_at csv_ok "," 0)))
(assert (= f1_ok (split_at csv_ok "," 1)))
(assert (= f2_ok (split_at csv_ok "," 2)))
(assert (= f3_ok (split_at csv_ok "," 3)))

; Define rest concatenations (useful for validating structure)
(assert (= rest1_ok (split_rest csv_ok "," 1)))
(assert (= rest2_ok (split_rest csv_ok "," 2)))
(assert (= rest3_ok (split_rest csv_ok "," 3)))

; Ensure indices are natural and within the number of splits (interface-style bounds)
(assert (and (<= 0 0) (< 0 (num_splits csv_ok ","))))
(assert (and (<= 0 1) (< 1 (num_splits csv_ok ","))))
(assert (and (<= 0 2) (< 2 (num_splits csv_ok ","))))
(assert (and (<= 0 3) (< 3 (num_splits csv_ok ","))))

; Detect an empty field: second field is empty
(assert (= f1_ok ""))

; Other fields are non-empty and do not themselves contain commas
(assert (not (= f0_ok "")))
(assert (not (= f2_ok "")))
(assert (not (= f3_ok "")))
(assert (not (str.contains f0_ok ",")))
(assert (not (str.contains f2_ok ",")))
(assert (not (str.contains f3_ok ",")))

; For a concrete-feeling CSV line, constrain the first field to be "id" and last to be numeric-like
(assert (= f0_ok "id"))
(assert (str.in_re f3_ok (re.+ (re.range "0" "9"))))

; Basic structure sanity: there is at least one comma if there are multiple splits
(assert (=> (>= (num_splits csv_ok ",") 2) (str.contains csv_ok ",")))

; ---------- UNSAT instance: contradictory CSV constraints about empty fields ----------
(declare-const csv_bad String)
(declare-const f0_bad String)
(declare-const f1_bad String)
(declare-const f2_bad String)
(declare-const rest1_bad String)

(assert (>= (str.len csv_bad) 0))

; Exactly 3 fields
(assert (= (num_splits csv_bad ",") 3))

; Extract fields
(assert (= f0_bad (split_at csv_bad "," 0)))
(assert (= f1_bad (split_at csv_bad "," 1)))
(assert (= f2_bad (split_at csv_bad "," 2)))
(assert (= rest1_bad (split_rest csv_bad "," 1)))

; Index bounds
(assert (and (<= 0 0) (< 0 (num_splits csv_bad ","))))
(assert (and (<= 0 1) (< 1 (num_splits csv_bad ","))))
(assert (and (<= 0 2) (< 2 (num_splits csv_bad ","))))

; Contradiction: second field is asserted both empty and non-empty
(assert (= f1_bad ""))
(assert (not (= f1_bad "")))

; Additional typical CSV checks (won't matter due to contradiction)
(assert (not (str.contains f0_bad ",")))
(assert (not (str.contains f2_bad ",")))
(assert (not (= f0_bad "")))
(assert (not (= f2_bad "")))

(check-sat)


; [GENERATION STATUS: SUCCESS]