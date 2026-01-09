(set-logic ALL)

; Uninterpreted interface for string split

; -------------------------
; CSV Processing constraints
; -------------------------

; SAT instance: a CSV line with 4 fields, no empty fields, and a numeric 3rd field
(declare-const csv_line_sat String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)

(declare-const idx0_sat Int)
(declare-const idx1_sat Int)

(assert (= csv_line_sat (str.++ f0_sat "," f1_sat "," f2_sat "," f3_sat)))
(assert (= (str.num_splits csv_line_sat ",") 4))
(assert (= f0_sat (str.split_at csv_line_sat "," 0)))
(assert (= f1_sat (str.split_at csv_line_sat "," 1)))
(assert (= f2_sat (str.split_at csv_line_sat "," 2)))
(assert (= f3_sat (str.split_at csv_line_sat "," 3)))
(assert (= (str.split_rest csv_line_sat "," 2) (str.++ f2_sat "," f3_sat)))

; No empty fields in SAT instance
(assert (and (> (str.len f0_sat) 0)
             (> (str.len f1_sat) 0)
             (> (str.len f2_sat) 0)
             (> (str.len f3_sat) 0)))

; Ensure delimiter exists and position is consistent with concatenation
(assert (>= (str.len csv_line_sat) 3))
(assert (= (str.indexof csv_line_sat "," 0) idx0_sat))
(assert (>= idx0_sat 0))
(assert (< idx0_sat (str.len csv_line_sat)))

(assert (= (str.indexof csv_line_sat "," (+ idx0_sat 1)) idx1_sat))
(assert (>= idx1_sat 0))
(assert (< idx1_sat (str.len csv_line_sat)))
(assert (> idx1_sat idx0_sat))

; Numeric 3rd field: only digits, non-empty
(assert (str.in_re f2_sat (re.+ (re.range "0" "9"))))

; Mild content constraints for diversity
(assert (str.contains f0_sat "A"))
(assert (not (str.contains f1_sat ",")))
(assert (not (str.contains f2_sat ",")))
(assert (not (str.contains f3_sat ",")))

; -------------------------
; UNSAT instance: claims exactly 3 fields, but also asserts an empty middle field is forbidden
; and simultaneously forces a double-comma pattern that creates an empty field.
; -------------------------
(declare-const csv_line_unsat String)
(declare-const u0 String)
(declare-const u1 String)
(declare-const u2 String)
(declare-const i_unsat Int)

; Force a CSV with an empty field: "X,,Y" (empty middle segment)
(assert (= csv_line_unsat (str.++ u0 ",," u2)))
(assert (= u0 "X"))
(assert (= u2 "Y"))

; Split expectations
(assert (= (str.num_splits csv_line_unsat ",") 3))
(assert (= u0 (str.split_at csv_line_unsat "," 0)))
(assert (= u1 (str.split_at csv_line_unsat "," 1)))
(assert (= u2 (str.split_at csv_line_unsat "," 2)))

; Detect empty fields: here u1 must be empty due to ",,"
(assert (= u1 ""))

; But also assert there are no empty fields (contradiction => UNSAT)
(assert (> (str.len u1) 0))

; Additional index bound constraints per interface guidance
(assert (= (str.indexof csv_line_unsat ",," 0) i_unsat))
(assert (>= i_unsat 0))
(assert (< i_unsat (str.len csv_line_unsat)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
