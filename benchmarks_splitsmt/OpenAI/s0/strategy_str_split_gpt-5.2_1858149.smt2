(set-logic ALL)

; CSV Processing: comma-separated fields, field counts, empty-field detection.
; Mix of SAT and UNSAT instances using str_split interface functions.


; -----------------------------
; SAT instance: a valid CSV row with exactly 4 fields,
; ensuring at least one empty field is present (e.g., trailing comma).
; -----------------------------
(declare-const csv_sat String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)
(declare-const rest2_sat String)

(assert (= (str.num_splits csv_sat ",") 4))
(assert (>= (str.num_splits csv_sat ",") 1))

(assert (= f0_sat (str.split_at csv_sat "," 0)))
(assert (= f1_sat (str.split_at csv_sat "," 1)))
(assert (= f2_sat (str.split_at csv_sat "," 2)))
(assert (= f3_sat (str.split_at csv_sat "," 3)))
(assert (= rest2_sat (str.split_rest csv_sat "," 2)))

; Require an empty field exists (detect missing data)
(assert (or (= f0_sat "") (= f1_sat "") (= f2_sat "") (= f3_sat "")))

; Constrain fields to not contain commas (typical raw CSV without quoting)
(assert (not (str.contains f0_sat ",")))
(assert (not (str.contains f1_sat ",")))
(assert (not (str.contains f2_sat ",")))
(assert (not (str.contains f3_sat ",")))

; Make the SAT row concrete: "A,B,,D" (an empty third field)
(assert (= csv_sat (str.++ "A" "," "B" "," "" "," "D")))

; Sanity constraints on indices (natural)
(assert (>= 0 0))
(assert (>= 1 0))
(assert (>= 2 0))
(assert (>= 3 0))

; -----------------------------
; UNSAT instance: contradictory requirements about empty fields.
; Exactly 3 fields, but also requires (i) at least one empty field and
; (ii) all fields non-empty.
; -----------------------------
(declare-const csv_unsat String)
(declare-const u0 String)
(declare-const u1 String)
(declare-const u2 String)

(assert (= (str.num_splits csv_unsat ",") 3))

(assert (= u0 (str.split_at csv_unsat "," 0)))
(assert (= u1 (str.split_at csv_unsat "," 1)))
(assert (= u2 (str.split_at csv_unsat "," 2)))

; Require at least one empty field
(assert (or (= u0 "") (= u1 "") (= u2 "")))

; Contradiction: require all fields non-empty
(assert (and (not (= u0 "")) (not (= u1 "")) (not (= u2 ""))))

; Additional plausible CSV constraints
(assert (not (str.contains u0 ",")))
(assert (not (str.contains u1 ",")))
(assert (not (str.contains u2 ",")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
