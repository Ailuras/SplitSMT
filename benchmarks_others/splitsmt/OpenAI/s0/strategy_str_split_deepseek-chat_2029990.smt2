(set-logic ALL)

; Uninterpreted interface operations for string splitting (CSV processing)

; -----------------------------
; SAT instance: well-formed CSV with 4 fields and one empty field in the middle
; -----------------------------
(declare-const csv_line_sat String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)
(declare-const rest1_sat String)
(declare-const rest2_sat String)
(declare-const rest3_sat String)

; Concrete CSV line example: "alice,,42,NY"
(assert (= csv_line_sat (str.++ "alice" "," "" "," "42" "," "NY")))

; Split by comma
(assert (= f0_sat (str.split_at csv_line_sat "," 0)))
(assert (= f1_sat (str.split_at csv_line_sat "," 1)))
(assert (= f2_sat (str.split_at csv_line_sat "," 2)))
(assert (= f3_sat (str.split_at csv_line_sat "," 3)))

; Total segments should be exactly 4
(assert (= (str.num_splits csv_line_sat ",") 4))

; Empty-field detection: second field is empty
(assert (= f1_sat ""))

; Non-empty constraints on other fields
(assert (> (str.len f0_sat) 0))
(assert (> (str.len f2_sat) 0))
(assert (> (str.len f3_sat) 0))

; Numeric-like field constraint on f2: allow optional leading '-' then digits
(assert (str.in_re f2_sat (re.++ (re.union (str.to_re "") (str.to_re "-")) (re.+ (re.range "0" "9")))))

; Use split_rest to relate suffixes (index bounds are natural)
(assert (= rest1_sat (str.split_rest csv_line_sat "," 1)))
(assert (= rest2_sat (str.split_rest csv_line_sat "," 2)))
(assert (= rest3_sat (str.split_rest csv_line_sat "," 3)))
(assert (= rest1_sat (str.++ f1_sat "," f2_sat "," f3_sat)))
(assert (= rest2_sat (str.++ f2_sat "," f3_sat)))
(assert (= rest3_sat f3_sat))

; Additional sanity: no commas inside individual fields (common CSV restriction without quoting)
(assert (not (str.contains f0_sat ",")))
(assert (not (str.contains f1_sat ",")))
(assert (not (str.contains f2_sat ",")))
(assert (not (str.contains f3_sat ",")))

; -----------------------------
; UNSAT instance: contradicting field count and empty-field expectations
; -----------------------------
(declare-const csv_line_unsat String)
(declare-const u0 String)
(declare-const u1 String)
(declare-const u2 String)
(declare-const u3 String)

; Concrete CSV line example with 3 segments: "A,,B" (fields: "A", "", "B")
(assert (= csv_line_unsat (str.++ "A" "," "" "," "B")))

(assert (= u0 (str.split_at csv_line_unsat "," 0)))
(assert (= u1 (str.split_at csv_line_unsat "," 1)))
(assert (= u2 (str.split_at csv_line_unsat "," 2)))
(assert (= u3 (str.split_at csv_line_unsat "," 3)))

; True segment count for "A,,B" is 3, but we force it to 4 -> contradiction
(assert (= (str.num_splits csv_line_unsat ",") 4))

; Also require that the allegedly-4th field is non-empty, which conflicts with missing segment behavior
(assert (> (str.len u3) 0))

; And require the middle field to be empty (consistent with the concrete string, but doesn't fix the count contradiction)
(assert (= u1 ""))

(check-sat)


; [GENERATION STATUS: SUCCESS]
