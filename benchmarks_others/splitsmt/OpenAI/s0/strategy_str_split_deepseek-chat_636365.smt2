(set-logic ALL)

; Uninterpreted interface for string split operations

; =====================
; SAT instance: well-formed CSV line with 4 fields, no empty fields
; =====================
(declare-const csv_line_sat String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)
(declare-const rest2_sat String)

(assert (= f0_sat (str.split_at csv_line_sat "," 0)))
(assert (= f1_sat (str.split_at csv_line_sat "," 1)))
(assert (= f2_sat (str.split_at csv_line_sat "," 2)))
(assert (= f3_sat (str.split_at csv_line_sat "," 3)))
(assert (= rest2_sat (str.split_rest csv_line_sat "," 2)))

; exactly 4 fields
(assert (= (str.num_splits csv_line_sat ",") 4))

; no empty fields
(assert (> (str.len f0_sat) 0))
(assert (> (str.len f1_sat) 0))
(assert (> (str.len f2_sat) 0))
(assert (> (str.len f3_sat) 0))

; sanity: delimiter must actually be present, and the tail from field 2 onward contains a comma
(assert (str.contains csv_line_sat ","))
(assert (str.contains rest2_sat ","))

; add simple content constraints to diversify
(assert (str.in_re f0_sat (re.+ (re.range "0" "9"))))
(assert (str.in_re f1_sat (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))))
(assert (str.in_re f2_sat (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))))
(assert (str.in_re f3_sat (re.+ (re.range "0" "9"))))

; =====================
; UNSAT instance: claims 3 fields but forces an empty middle field while also requiring non-empty fields
; =====================
(declare-const csv_line_unsat String)
(declare-const u0 String)
(declare-const u1 String)
(declare-const u2 String)

(assert (= u0 (str.split_at csv_line_unsat "," 0)))
(assert (= u1 (str.split_at csv_line_unsat "," 1)))
(assert (= u2 (str.split_at csv_line_unsat "," 2)))

(assert (= (str.num_splits csv_line_unsat ",") 3))

; force empty middle field
(assert (= u1 ""))

; but also require no empty fields (inconsistent)
(assert (> (str.len u0) 0))
(assert (> (str.len u1) 0))
(assert (> (str.len u2) 0))

; also require that the CSV line does not start or end with a comma (still consistent with empty middle, but doesn't fix the contradiction)
(assert (not (str.prefixof "," csv_line_unsat)))
(assert (not (str.suffixof "," csv_line_unsat)))

; =====================
; Additional SAT instance: detect an empty field via pattern, while allowing it
; =====================
(declare-const csv_line_empty_ok String)
(declare-const e0 String)
(declare-const e1 String)
(declare-const e2 String)
(declare-const e_rest1 String)

(assert (= e0 (str.split_at csv_line_empty_ok "," 0)))
(assert (= e1 (str.split_at csv_line_empty_ok "," 1)))
(assert (= e2 (str.split_at csv_line_empty_ok "," 2)))
(assert (= e_rest1 (str.split_rest csv_line_empty_ok "," 1)))

(assert (= (str.num_splits csv_line_empty_ok ",") 3))

; allow an empty field but ensure at least one field is empty and others are non-empty
(assert (= e1 ""))
(assert (> (str.len e0) 0))
(assert (> (str.len e2) 0))

; ensure the input line contains ",," to indicate an empty middle field in raw text
(assert (str.contains csv_line_empty_ok ",,"))

; constrain other fields to be alphanumeric strings
(assert (str.in_re e0 (re.+ (re.union (re.range "0" "9") (re.range "A" "Z") (re.range "a" "z")))))
(assert (str.in_re e2 (re.+ (re.union (re.range "0" "9") (re.range "A" "Z") (re.range "a" "z")))))

; relate rest from index 1 onward to contain a comma (since it covers fields 1 and 2)
(assert (str.contains e_rest1 ","))

(check-sat)


; [GENERATION STATUS: SUCCESS]
