(set-logic ALL)

; Uninterpreted interface for string split operations

; Scenario: CSV Processing (comma-separated fields)
(declare-const csv_line String)
(declare-const delim String)
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const field3 String)
(declare-const rest_from_2 String)
(declare-const rest_from_4 String)
(declare-const empty_exists Bool)

; Delimiter is a comma
(assert (= delim ","))

; Basic split constraints
(assert (= field0 (str.split_at csv_line delim 0)))
(assert (= field1 (str.split_at csv_line delim 1)))
(assert (= field2 (str.split_at csv_line delim 2)))
(assert (= field3 (str.split_at csv_line delim 3)))
(assert (= rest_from_2 (str.split_rest csv_line delim 2)))
(assert (= rest_from_4 (str.split_rest csv_line delim 4)))

; Index constraints (natural indices)
(assert (and (>= 0 0) (>= 1 0) (>= 2 0) (>= 3 0) (>= 4 0)))

; Non-empty line overall
(assert (> (str.len csv_line) 0))

; Require at least 4 fields (i.e., 4 segments)
(assert (>= (str.num_splits csv_line delim) 4))

; Detect presence of an empty field among the first four
(assert (= empty_exists (or (= field0 "") (= field1 "") (= field2 "") (= field3 ""))))

; SAT part: enforce a concrete well-formed CSV with an empty middle field
; Example: "A,,C,D" => field0="A", field1="", field2="C", field3="D"
(assert (= csv_line (str.++ field0 "," field1 "," field2 "," field3)))
(assert (= field0 "A"))
(assert (= field2 "C"))
(assert (= field3 "D"))
(assert (= field1 ""))
(assert empty_exists)

; Additional sanity: if there are exactly 4 fields, rest_from_4 should be empty
(assert (=> (= (str.num_splits csv_line delim) 4) (= rest_from_4 "")))

; UNSAT instance (separate, intentionally contradictory) encoded via a flag
(declare-const make_unsat Bool)

; When make_unsat is true, demand exactly 4 fields and simultaneously require a comma inside field2.
; This conflicts with typical split semantics where fields cannot contain the delimiter.
; Since split_* are uninterpreted, we also add a consistency axiom tying split_at to split_rest for k=2.
(declare-const axiom_ok Bool)
(assert (= axiom_ok true))

; Consistency axiom (lightweight): if there are at least 3 splits, rest_from_2 starts with field2
(assert (=> (and axiom_ok (>= (str.num_splits csv_line delim) 3))
            (= rest_from_2 (str.++ field2 (str.++ delim (str.split_rest csv_line delim 3))))))

; Turn on UNSAT mode and assert contradiction under a strong delimiter-exclusion rule for field2
(assert make_unsat)
(assert (= (str.num_splits csv_line delim) 4))
(assert (str.contains field2 ","))
(assert (not (str.contains field2 delim)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
