(set-logic ALL)

; Uninterpreted interface functions for CSV-like splitting

; Scenario: CSV Processing
; We model comma-separated rows, enforce expected field counts, and detect empty fields.

; -------------------------
; SAT instance: well-formed CSV row with an empty field
; -------------------------
(declare-const csv_row_sat String)
(declare-const sat_f0 String)
(declare-const sat_f1 String)
(declare-const sat_f2 String)
(declare-const sat_f3 String)
(declare-const sat_tail_from2 String)
(declare-const sat_num_fields Int)
(declare-const sat_has_empty Bool)

; Concrete row: 4 fields, with an empty 3rd field: "Alice,42,,NY"
(assert (= csv_row_sat "Alice,42,,NY"))

; Splitting by comma yields 4 segments
(assert (= sat_num_fields (str.num_splits csv_row_sat ",")))
(assert (= sat_num_fields 4))

; Access individual fields
(assert (= sat_f0 (str.split_at csv_row_sat "," 0)))
(assert (= sat_f1 (str.split_at csv_row_sat "," 1)))
(assert (= sat_f2 (str.split_at csv_row_sat "," 2)))
(assert (= sat_f3 (str.split_at csv_row_sat "," 3)))

; Index well-formedness (natural indices and within bounds)
(assert (and (<= 0 0) (< 0 sat_num_fields)))
(assert (and (<= 0 1) (< 1 sat_num_fields)))
(assert (and (<= 0 2) (< 2 sat_num_fields)))
(assert (and (<= 0 3) (< 3 sat_num_fields)))

; Tail from field 2 is the remaining CSV substring of fields 2..end
(assert (= sat_tail_from2 (str.split_rest csv_row_sat "," 2)))

; Basic field expectations
(assert (= sat_f0 "Alice"))
(assert (= sat_f1 "42"))
(assert (= sat_f2 ""))
(assert (= sat_f3 "NY"))

; Empty field detection: at least one field is empty
(assert (= sat_has_empty (or (= sat_f0 "") (= sat_f1 "") (= sat_f2 "") (= sat_f3 ""))))
(assert sat_has_empty)

; Extra sanity checks: row contains commas and tail begins with empty field then comma then last
(assert (str.contains csv_row_sat ","))
(assert (= sat_tail_from2 ",NY"))

(check-sat)

; -------------------------
; UNSAT instance: contradictory field count / emptiness constraints
; -------------------------
(declare-const csv_row_unsat String)
(declare-const unsat_f0 String)
(declare-const unsat_f1 String)
(declare-const unsat_f2 String)
(declare-const unsat_num_fields Int)
(declare-const unsat_no_empty Bool)

; Concrete row has an empty middle field and 3 segments: "x,,y"
(assert (= csv_row_unsat "x,,y"))

; num_splits is constrained inconsistently
(assert (= unsat_num_fields (str.num_splits csv_row_unsat ",")))
(assert (= unsat_num_fields 2))

; Still refer to three fields by index (intended 0..2) with bounds constraints
(assert (= unsat_f0 (str.split_at csv_row_unsat "," 0)))
(assert (= unsat_f1 (str.split_at csv_row_unsat "," 1)))
(assert (= unsat_f2 (str.split_at csv_row_unsat "," 2)))

; Index bounds force 2 < unsat_num_fields, contradicting unsat_num_fields = 2
(assert (and (<= 0 2) (< 2 unsat_num_fields)))

; Additionally, enforce that no field is empty, contradicting the concrete empty field
(assert (= unsat_no_empty (and (not (= unsat_f0 "")) (not (= unsat_f1 "")) (not (= unsat_f2 "")))))
(assert unsat_no_empty)

; Concrete expectations for fields
(assert (= unsat_f0 "x"))
(assert (= unsat_f1 ""))
(assert (= unsat_f2 "y"))

(check-sat)



; [GENERATION STATUS: SUCCESS]
(exit)
