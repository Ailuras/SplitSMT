(set-logic ALL)

; Uninterpreted interface operations for string splitting

; ------------------------------
; SAT instance: well-formed CSV with 4 fields, no empty fields
; ------------------------------
(declare-const csv_line_sat String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)
(declare-const rest1_sat String)
(declare-const rest2_sat String)
(declare-const rest3_sat String)

(assert (= csv_line_sat (str.++ f0_sat "," f1_sat "," f2_sat "," f3_sat)))
(assert (= (str.num_splits csv_line_sat ",") 4))
(assert (= f0_sat (str.split_at csv_line_sat "," 0)))
(assert (= f1_sat (str.split_at csv_line_sat "," 1)))
(assert (= f2_sat (str.split_at csv_line_sat "," 2)))
(assert (= f3_sat (str.split_at csv_line_sat "," 3)))
(assert (= rest1_sat (str.split_rest csv_line_sat "," 1)))
(assert (= rest2_sat (str.split_rest csv_line_sat "," 2)))
(assert (= rest3_sat (str.split_rest csv_line_sat "," 3)))
(assert (= rest1_sat (str.++ f1_sat "," f2_sat "," f3_sat)))
(assert (= rest2_sat (str.++ f2_sat "," f3_sat)))
(assert (= rest3_sat f3_sat))

; No empty fields
(assert (> (str.len f0_sat) 0))
(assert (> (str.len f1_sat) 0))
(assert (> (str.len f2_sat) 0))
(assert (> (str.len f3_sat) 0))

; Additional realistic constraints: disallow commas inside fields
(assert (not (str.contains f0_sat ",")))
(assert (not (str.contains f1_sat ",")))
(assert (not (str.contains f2_sat ",")))
(assert (not (str.contains f3_sat ",")))

; Force a simple shape: first field is an integer-like token, second is alphabetic-like
(assert (str.in_re f0_sat (re.+ (re.range "0" "9"))))
(assert (str.in_re f1_sat (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))))

; ------------------------------
; UNSAT instance: claims 4 fields but also enforces an empty middle field while requiring all fields non-empty
; ------------------------------
(declare-const csv_line_unsat String)
(declare-const u0 String)
(declare-const u1 String)
(declare-const u2 String)
(declare-const u3 String)

(assert (= csv_line_unsat (str.++ u0 "," u1 "," u2 "," u3)))
(assert (= (str.num_splits csv_line_unsat ",") 4))
(assert (= u0 (str.split_at csv_line_unsat "," 0)))
(assert (= u1 (str.split_at csv_line_unsat "," 1)))
(assert (= u2 (str.split_at csv_line_unsat "," 2)))
(assert (= u3 (str.split_at csv_line_unsat "," 3)))

; Detect an empty field (u1 is empty) but simultaneously require all fields non-empty
(assert (= u1 ""))
(assert (> (str.len u0) 0))
(assert (> (str.len u1) 0))
(assert (> (str.len u2) 0))
(assert (> (str.len u3) 0))

; ------------------------------
; Mixed constraints: another independent SAT subproblem about trailing commas and empty last field detection
; ------------------------------
(declare-const csv_line_trailing String)
(declare-const t0 String)
(declare-const t1 String)
(declare-const t2 String)

; A line with a trailing comma encodes an empty last field (3 segments: t0, t1, "")
(assert (= csv_line_trailing (str.++ t0 "," t1 "," t2)))
(assert (= t2 ""))
(assert (= (str.num_splits csv_line_trailing ",") 3))
(assert (= t0 (str.split_at csv_line_trailing "," 0)))
(assert (= t1 (str.split_at csv_line_trailing "," 1)))
(assert (= t2 (str.split_at csv_line_trailing "," 2)))

; Ensure first two fields are non-empty and do not contain commas
(assert (> (str.len t0) 0))
(assert (> (str.len t1) 0))
(assert (not (str.contains t0 ",")))
(assert (not (str.contains t1 ",")))

; Guard-style index validity constraints (natural indices)
(assert (>= (str.num_splits csv_line_sat ",") 0))
(assert (>= (str.num_splits csv_line_unsat ",") 0))
(assert (>= (str.num_splits csv_line_trailing ",") 0))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
