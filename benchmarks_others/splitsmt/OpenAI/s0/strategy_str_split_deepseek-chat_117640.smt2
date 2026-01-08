(set-logic ALL)

; CSV Processing scenario: comma-separated fields, field counts, and empty-field detection
; Uses uninterpreted str_split interface functions split_at / split_rest / num_splits.


; ----------------------------
; SAT instance: well-formed CSV with 4 fields, third field empty
; ----------------------------
(declare-const csv_sat String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)
(declare-const rest1_sat String)
(declare-const rest2_sat String)
(declare-const rest3_sat String)

(assert (= csv_sat (str.++ "Alice" "," "42" "," "" "," "NY")))

(assert (= (str.num_splits csv_sat ",") 4))
(assert (= f0_sat (str.split_at csv_sat "," 0)))
(assert (= f1_sat (str.split_at csv_sat "," 1)))
(assert (= f2_sat (str.split_at csv_sat "," 2)))
(assert (= f3_sat (str.split_at csv_sat "," 3)))

(assert (= rest1_sat (str.split_rest csv_sat "," 1)))
(assert (= rest2_sat (str.split_rest csv_sat "," 2)))
(assert (= rest3_sat (str.split_rest csv_sat "," 3)))

; Field content checks
(assert (= f0_sat "Alice"))
(assert (= f1_sat "42"))
(assert (= f2_sat ""))
(assert (= f3_sat "NY"))

; Detect empty field: at least one segment has length 0
(assert (or (= (str.len f0_sat) 0)
            (= (str.len f1_sat) 0)
            (= (str.len f2_sat) 0)
            (= (str.len f3_sat) 0)))

; Basic structural expectations about comma presence
(assert (str.contains csv_sat ","))
(assert (>= (str.len csv_sat) 0))

; Index constraints (natural indices)
(assert (and (>= 0 0) (>= 1 0) (>= 2 0) (>= 3 0)))

(check-sat)

; ----------------------------
; UNSAT instance: claim 3 fields but force 4 via concrete construction
; ----------------------------
(reset)
(set-logic ALL)


(declare-const csv_unsat String)
(declare-const u0 String)
(declare-const u1 String)
(declare-const u2 String)
(declare-const u3 String)

; Concrete CSV with 4 segments: "a,,b,c" -> segments ["a", "", "b", "c"]
(assert (= csv_unsat (str.++ "a" "," "" "," "b" "," "c")))

; Contradictory field-count requirement
(assert (= (str.num_splits csv_unsat ",") 3))

; Still reference segments to model intended processing
(assert (= u0 (str.split_at csv_unsat "," 0)))
(assert (= u1 (str.split_at csv_unsat "," 1)))
(assert (= u2 (str.split_at csv_unsat "," 2)))
(assert (= u3 (str.split_at csv_unsat "," 3)))

(assert (= u0 "a"))
(assert (= u1 ""))
(assert (= u2 "b"))
(assert (= u3 "c"))

; Natural index constraints
(assert (and (>= 0 0) (>= 1 0) (>= 2 0) (>= 3 0)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
