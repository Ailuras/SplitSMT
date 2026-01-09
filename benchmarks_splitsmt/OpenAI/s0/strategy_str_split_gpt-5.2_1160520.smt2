(set-logic ALL)

; Uninterpreted interface for string split (CSV-like)

; -------------------------
; SAT instance: well-formed 4-field CSV with one empty field and fixed header
; -------------------------
(declare-const csv_line_sat String)
(declare-const delim String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)
(declare-const rest2_sat String)
(declare-const rest3_sat String)

(assert (= delim ","))

; Require exactly 4 fields (segments) after splitting by comma
(assert (= (str.num_splits csv_line_sat delim) 4))

; Bind fields using split_at
(assert (= f0_sat (str.split_at csv_line_sat delim 0)))
(assert (= f1_sat (str.split_at csv_line_sat delim 1)))
(assert (= f2_sat (str.split_at csv_line_sat delim 2)))
(assert (= f3_sat (str.split_at csv_line_sat delim 3)))

; Detect empty field: third field is empty
(assert (= f2_sat ""))

; Constrain non-empty fields and a simple numeric pattern for last field
(assert (not (= f0_sat "")))
(assert (not (= f1_sat "")))
(assert (not (= f3_sat "")))
(assert (str.in_re f3_sat (re.+ (re.range "0" "9"))))

; Header-like constraint: first field equals "id", second equals "name"
(assert (= f0_sat "id"))
(assert (= f1_sat "name"))

; Rest constraints using split_rest (structural consistency)
(assert (= rest2_sat (str.split_rest csv_line_sat delim 2)))
(assert (= rest3_sat (str.split_rest csv_line_sat delim 3)))

; If we start from field 2, result should start with empty then comma then last field,
; i.e., ",<digits>" given f2 is empty.
(assert (= rest2_sat (str.++ f2_sat delim f3_sat)))
(assert (= rest3_sat f3_sat))

; Strengthen by constructing an explicit witness line
(assert (= csv_line_sat (str.++ f0_sat delim f1_sat delim f2_sat delim f3_sat)))

(check-sat)

; -------------------------
; UNSAT instance: contradictions about empty fields and field count
; -------------------------
(declare-const csv_line_unsat String)
(declare-const g0_unsat String)
(declare-const g1_unsat String)
(declare-const g2_unsat String)

; Claim there are exactly 3 fields
(assert (= (str.num_splits csv_line_unsat delim) 3))

; Bind the three fields
(assert (= g0_unsat (str.split_at csv_line_unsat delim 0)))
(assert (= g1_unsat (str.split_at csv_line_unsat delim 1)))
(assert (= g2_unsat (str.split_at csv_line_unsat delim 2)))

; Contradiction: g1 is both empty and non-empty
(assert (= g1_unsat ""))
(assert (not (= g1_unsat "")))

(check-sat)
(exit)
