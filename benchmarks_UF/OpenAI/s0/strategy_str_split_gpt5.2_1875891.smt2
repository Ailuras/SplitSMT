(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; --- Uninterpreted interface: str_split ---

; --- Scenario: CSV Processing ---
; We model a CSV line split by "," and constrain field counts and empties.

; ===== SAT instance: 4 fields, with an intentionally empty field =====
(declare-const csv_line_sat String)
(declare-const delim String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)
(declare-const rest2_sat String)

(assert (= delim ","))

; Exactly 4 segments/fields
(assert (= (num_splits csv_line_sat delim) 4))

; Bind each field via split_at
(assert (= f0_sat (split_at csv_line_sat delim 0)))
(assert (= f1_sat (split_at csv_line_sat delim 1)))
(assert (= f2_sat (split_at csv_line_sat delim 2)))
(assert (= f3_sat (split_at csv_line_sat delim 3)))

; Index bounds (natural and within [0, num_splits-1])
(assert (and (<= 0 0) (< 0 (num_splits csv_line_sat delim))))
(assert (and (<= 0 1) (< 1 (num_splits csv_line_sat delim))))
(assert (and (<= 0 2) (< 2 (num_splits csv_line_sat delim))))
(assert (and (<= 0 3) (< 3 (num_splits csv_line_sat delim))))

; Detect an empty field (e.g., consecutive commas create empty string)
(assert (= f2_sat ""))

; No newline characters inside fields (simple sanitation)
(assert (not (str.contains f0_sat "\n")))
(assert (not (str.contains f1_sat "\n")))
(assert (not (str.contains f2_sat "\n")))
(assert (not (str.contains f3_sat "\n")))

; Rest-of-line from index 2 is concatenation of f2,f3 with delimiter between (relaxed via split_rest)
(assert (= rest2_sat (split_rest csv_line_sat delim 2)))
(assert (>= (str.len rest2_sat) (str.len f2_sat)))

; Additional plausibility constraints
(assert (>= (str.len f0_sat) 1))
(assert (>= (str.len f1_sat) 1))
(assert (>= (str.len f3_sat) 1))

; ===== UNSAT instance: contradictions about empty detection and field count =====
(declare-const csv_line_unsat String)
(declare-const g0_unsat String)
(declare-const g1_unsat String)
(declare-const g2_unsat String)

; Claim there are exactly 3 fields
(assert (= (num_splits csv_line_unsat delim) 3))

; Bind fields
(assert (= g0_unsat (split_at csv_line_unsat delim 0)))
(assert (= g1_unsat (split_at csv_line_unsat delim 1)))
(assert (= g2_unsat (split_at csv_line_unsat delim 2)))

; Index bounds for 0..2
(assert (and (<= 0 0) (< 0 (num_splits csv_line_unsat delim))))
(assert (and (<= 0 1) (< 1 (num_splits csv_line_unsat delim))))
(assert (and (<= 0 2) (< 2 (num_splits csv_line_unsat delim))))

; Contradiction: field is both empty and non-empty
(assert (= g1_unsat ""))
(assert (>= (str.len g1_unsat) 1))

; Another contradiction: require at least 4 fields
(assert (>= (num_splits csv_line_unsat delim) 4))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
