(set-logic ALL)

; Uninterpreted interface functions for str_split

; =========================
; Scenario: CSV Processing
; Goal: Ensure correct field counts and detect empty fields.
; We include both SAT and UNSAT instances by splitting into separate cases.
; =========================

; ---------- SAT instance: a CSV line with 4 fields, one empty field (double comma)
(declare-const csv_line_sat String)
(declare-const delim String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)
(declare-const rest1_sat String)
(declare-const rest2_sat String)
(declare-const rest3_sat String)

(assert (= delim ","))

; Concrete CSV example: field2 is empty
(assert (= csv_line_sat "alice,42,,NY"))

; Must have exactly 4 fields
(assert (= (str.num_splits csv_line_sat delim) 4))

; Extract fields via split_at
(assert (= f0_sat (str.split_at csv_line_sat delim 0)))
(assert (= f1_sat (str.split_at csv_line_sat delim 1)))
(assert (= f2_sat (str.split_at csv_line_sat delim 2)))
(assert (= f3_sat (str.split_at csv_line_sat delim 3)))

; Expected values
(assert (= f0_sat "alice"))
(assert (= f1_sat "42"))
(assert (= f2_sat ""))
(assert (= f3_sat "NY"))

; Detect empty field (at least one empty)
(assert (or (= f0_sat "") (= f1_sat "") (= f2_sat "") (= f3_sat "")))

; Additional rest constraints to exercise split_rest
(assert (= rest1_sat (str.split_rest csv_line_sat delim 1)))
(assert (= rest2_sat (str.split_rest csv_line_sat delim 2)))
(assert (= rest3_sat (str.split_rest csv_line_sat delim 3)))

; Reasonable index bounds as per interface guidelines
(assert (and (<= 0 1) (< 1 (str.num_splits csv_line_sat delim))))
(assert (and (<= 0 2) (< 2 (str.num_splits csv_line_sat delim))))
(assert (and (<= 0 3) (< 3 (str.num_splits csv_line_sat delim))))

; ---------- UNSAT instance: contradictory requirements for a fixed CSV line
(declare-const csv_line_unsat String)
(declare-const g0_unsat String)
(declare-const g1_unsat String)
(declare-const g2_unsat String)

; Fixed CSV line with an empty middle field, thus 3 fields total
(assert (= csv_line_unsat "a,,b"))

; Contradiction 1: claim it has 2 fields
(assert (= (str.num_splits csv_line_unsat delim) 2))

; Also extract three fields and require the third to exist as a non-empty value
(assert (= g0_unsat (str.split_at csv_line_unsat delim 0)))
(assert (= g1_unsat (str.split_at csv_line_unsat delim 1)))
(assert (= g2_unsat (str.split_at csv_line_unsat delim 2)))

; Contradiction 2: require 3rd segment index to be in-range given the above field count
(assert (and (<= 0 2) (< 2 (str.num_splits csv_line_unsat delim))))

; Contradiction 3: for "a,,b" the middle should be empty, but force it non-empty
(assert (not (= g1_unsat "")))

; Some additional CSV-like sanity constraints
(assert (>= (str.len csv_line_sat) 1))
(assert (>= (str.len csv_line_unsat) 1))
(assert (str.contains csv_line_sat delim))
(assert (str.contains csv_line_unsat delim))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
