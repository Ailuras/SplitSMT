(set-logic ALL)

; Uninterpreted interface for string split operations

; ========== SAT instance: well-formed CSV line with an empty field ==========
(declare-const csv_line_sat String)
(declare-const delim String)
(declare-const sat_f0 String)
(declare-const sat_f1 String)
(declare-const sat_f2 String)
(declare-const sat_f3 String)
(declare-const sat_tail2 String)

(assert (= delim ","))

; Require exactly 4 fields (segments) after splitting by comma
(assert (= (str.num_splits csv_line_sat delim) 4))

; Bind fields via split_at
(assert (= sat_f0 (str.split_at csv_line_sat delim 0)))
(assert (= sat_f1 (str.split_at csv_line_sat delim 1)))
(assert (= sat_f2 (str.split_at csv_line_sat delim 2)))
(assert (= sat_f3 (str.split_at csv_line_sat delim 3)))

; Bind remainder from index 2 onwards
(assert (= sat_tail2 (str.split_rest csv_line_sat delim 2)))

; Detect/ensure an empty middle field (e.g., "alpha,,gamma,42")
(assert (= sat_f1 ""))

; Additional sanity: non-empty surrounding fields and a numeric last field
(assert (not (= sat_f0 "")))
(assert (not (= sat_f2 "")))
(assert (str.in_re sat_f3 (re.+ (re.range "0" "9"))))

; Ensure comma delimiter appears and there is at least one empty-field pattern ",,"
(assert (str.contains csv_line_sat delim))
(assert (str.contains csv_line_sat ",,"))

; Simple consistency between tail and known fields (tail must contain the later fields)
(assert (str.contains sat_tail2 sat_f2))
(assert (str.contains sat_tail2 sat_f3))


; ========== UNSAT instance: contradictory empty/non-empty requirements ==========
(declare-const csv_line_unsat String)
(declare-const uns_f0 String)
(declare-const uns_f1 String)
(declare-const uns_f2 String)

; Exactly 3 fields
(assert (= (str.num_splits csv_line_unsat delim) 3))
(assert (= uns_f0 (str.split_at csv_line_unsat delim 0)))
(assert (= uns_f1 (str.split_at csv_line_unsat delim 1)))
(assert (= uns_f2 (str.split_at csv_line_unsat delim 2)))

; Contradiction: the same field must be empty and non-empty
(assert (= uns_f1 ""))
(assert (not (= uns_f1 "")))


; ========== UNSAT instance: conflicting field count constraints ==========
(declare-const csv_line_unsat2 String)
(assert (= (str.num_splits csv_line_unsat2 delim) 2))
(assert (= (str.num_splits csv_line_unsat2 delim) 5))


(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
