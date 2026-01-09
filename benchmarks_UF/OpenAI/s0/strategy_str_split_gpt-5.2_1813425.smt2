(set-logic ALL)

; Uninterpreted interface functions for string split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; =========================
; Scenario: CSV Processing
; =========================

; -------- SAT instance: well-formed CSV with 4 fields, no empty fields
(declare-const csv_line_sat String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)
(declare-const rest1_sat String)
(declare-const rest2_sat String)

(assert (= csv_line_sat (str.++ f0_sat "," f1_sat "," f2_sat "," f3_sat)))
(assert (= (num_splits csv_line_sat ",") 4))
(assert (= f0_sat (split_at csv_line_sat "," 0)))
(assert (= f1_sat (split_at csv_line_sat "," 1)))
(assert (= f2_sat (split_at csv_line_sat "," 2)))
(assert (= f3_sat (split_at csv_line_sat "," 3)))
(assert (= rest1_sat (split_rest csv_line_sat "," 1)))
(assert (= rest2_sat (split_rest csv_line_sat "," 2)))

; detect empty fields: enforce non-empty
(assert (> (str.len f0_sat) 0))
(assert (> (str.len f1_sat) 0))
(assert (> (str.len f2_sat) 0))
(assert (> (str.len f3_sat) 0))

; additional sanity constraints: no commas inside fields for this simplified CSV
(assert (not (str.contains f0_sat ",")))
(assert (not (str.contains f1_sat ",")))
(assert (not (str.contains f2_sat ",")))
(assert (not (str.contains f3_sat ",")))

; simple content patterns: first field is digits, second is letters, third can be empty? no, enforced non-empty
(assert (str.in_re f0_sat (re.+ (re.range "0" "9"))))
(assert (str.in_re f1_sat (re.+ (re.union (re.range "a" "z") (re.range "A" "Z")))))

; rest fields should reconstruct remaining CSV parts structurally
(assert (= rest1_sat (str.++ f1_sat "," f2_sat "," f3_sat)))
(assert (= rest2_sat (str.++ f2_sat "," f3_sat)))

; indices natural and within plausible bounds
(declare-const k_sat Int)
(assert (and (>= k_sat 0) (<= k_sat 3)))
(assert (= (split_at csv_line_sat "," k_sat)
           (ite (= k_sat 0) f0_sat (ite (= k_sat 1) f1_sat (ite (= k_sat 2) f2_sat f3_sat)))))

; -------- UNSAT instance: claims 3 fields but forces a structure with 4 segments and an empty field
(declare-const csv_line_unsat String)
(declare-const u0 String)
(declare-const u1 String)
(declare-const u2 String)
(declare-const u3 String)

; Explicitly build a line with 4 segments, including an empty segment u1
(assert (= u1 ""))
(assert (= csv_line_unsat (str.++ u0 "," u1 "," u2 "," u3)))

; Must detect empty fields (no empties allowed)
(assert (> (str.len (split_at csv_line_unsat "," 1)) 0))

; Contradictory field count requirement (claims 3 fields)
(assert (= (num_splits csv_line_unsat ",") 3))

; Tie split_at results to the constructed segments to strengthen the inconsistency
(assert (= (split_at csv_line_unsat "," 0) u0))
(assert (= (split_at csv_line_unsat "," 1) u1))
(assert (= (split_at csv_line_unsat "," 2) u2))
(assert (= (split_at csv_line_unsat "," 3) u3))

; Ensure commas exist (at least one), and use rest relation
(declare-const rest_unsat String)
(assert (= rest_unsat (split_rest csv_line_unsat "," 1)))
(assert (= rest_unsat (str.++ u1 "," u2 "," u3)))
(assert (str.contains csv_line_unsat ","))

(check-sat)


; [GENERATION STATUS: SUCCESS]