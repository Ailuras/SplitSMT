(set-logic ALL)

; Uninterpreted interface for string split constraints
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; === Scenario: CSV Processing ===
; We model comma-separated rows, validate field counts, and detect empty fields.

; ---------- SAT instance: well-formed CSV row with 4 fields, one empty ----------
(declare-const row_sat String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)
(declare-const rest2_sat String)

(assert (= row_sat (str.++ f0_sat "," f1_sat "," f2_sat "," f3_sat)))
(assert (= f0_sat (split_at row_sat "," 0)))
(assert (= f1_sat (split_at row_sat "," 1)))
(assert (= f2_sat (split_at row_sat "," 2)))
(assert (= f3_sat (split_at row_sat "," 3)))
(assert (= rest2_sat (split_rest row_sat "," 2)))

; Exactly 4 segments/fields
(assert (= (num_splits row_sat ",") 4))

; Detect an empty field (e.g., missing middle value)
(assert (= f2_sat ""))

; Additional plausibility constraints
(assert (not (= f0_sat "")))
(assert (not (= f3_sat "")))
; No commas inside a field (simple CSV, no quoting)
(assert (not (str.contains f0_sat ",")))
(assert (not (str.contains f1_sat ",")))
(assert (not (str.contains f2_sat ",")))
(assert (not (str.contains f3_sat ",")))

; rest2_sat should begin with f2_sat and comma when there are at least 4 fields
(assert (= rest2_sat (str.++ f2_sat "," f3_sat)))

; ---------- UNSAT instance: contradictory requirements on empty fields ----------
(declare-const row_unsat String)
(declare-const u0 String)
(declare-const u1 String)
(declare-const u2 String)

(assert (= row_unsat (str.++ u0 "," u1 "," u2)))
(assert (= (num_splits row_unsat ",") 3))
(assert (= u1 (split_at row_unsat "," 1)))

; Require u1 to be empty but also non-empty (contradiction)
(assert (= u1 ""))
(assert (>= (str.len u1) 1))

; ---------- SAT instance: detect trailing empty field (ends with comma) ----------
(declare-const row_trailing String)
(declare-const t0 String)
(declare-const t1 String)
(declare-const t2 String)

; A trailing comma means last field is empty in simple split semantics
(assert (= row_trailing (str.++ t0 "," t1 "," t2)))
(assert (= t2 ""))
(assert (= (num_splits row_trailing ",") 3))
(assert (= t2 (split_at row_trailing "," 2)))
(assert (not (= t0 "")))

; ---------- UNSAT instance: inconsistent field count vs construction ----------
(declare-const row_count_bad String)
(declare-const c0 String)
(declare-const c1 String)

(assert (= row_count_bad (str.++ c0 "," c1)))
; If constructed as two fields, demanding three fields is inconsistent under intended semantics
(assert (= (num_splits row_count_bad ",") 3))
(assert (= c0 (split_at row_count_bad "," 0)))
(assert (= c1 (split_at row_count_bad "," 1)))

(check-sat)


; [GENERATION STATUS: SUCCESS]