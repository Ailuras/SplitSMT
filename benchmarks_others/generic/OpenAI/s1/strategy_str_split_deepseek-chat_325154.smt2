; Scenario: CSV Processing (mutated/extended seed)
(set-logic ALL)

; --- str_split interface ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; --- Variables ---
(declare-const value2 String)
(declare-const key2 String)

(declare-const csv_line String)
(declare-const delim String)
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const rest2 String)
(declare-const field_count Int)

; --- Basic scenario wiring ---
(assert (= delim ","))
(assert (= csv_line value2))
(assert (= field_count (num_splits csv_line delim)))
(assert (= field0 (split_at csv_line delim 0)))
(assert (= field1 (split_at csv_line delim 1)))
(assert (= field2 (split_at csv_line delim 2)))
(assert (= rest2 (split_rest csv_line delim 2)))

; --- Core CSV constraints: ensure correct field counts, detect empty fields ---
; Require at least 3 fields
(assert (>= field_count 3))

; Detect empty field: at least one of first three fields is empty
(assert (or (= (str.len field0) 0)
            (= (str.len field1) 0)
            (= (str.len field2) 0)))

; Commas must exist if we have multiple segments
(assert (=> (>= field_count 2) (str.contains csv_line ",")))

; Simple structural: if field_count is 3, then there are no commas in rest2
(assert (=> (= field_count 3) (not (str.contains rest2 ","))))

; If there are more than 3 fields, rest2 must contain a comma
(assert (=> (> field_count 3) (str.contains rest2 ",")))

; Some restrictions to avoid degenerate solutions
(assert (not (= (str.len csv_line) 0)))

; Key constraint: interpret this as processing a CSV header "cache-control"
(assert (= key2 "cache-control"))

; --- Mutated remnants (lightweight) inspired by the seed ---
; Ensure the line includes an '=' somewhere (like a key=value cell)
(assert (not (= (str.indexof csv_line "=" 0) (- 1))))

; Constrain that 'A' appears and it occurs before '=' (typical token pattern)
(assert (not (= (str.indexof csv_line "A" 0) (- 1))))
(assert (< (str.indexof csv_line "A" 0) (str.indexof csv_line "=" 0)))

; Avoid leading/trailing space
(assert (not (= (str.at csv_line 0) " ")))
(assert (not (= (str.at csv_line (- (str.len csv_line) 1)) " ")))

; --- Mix SAT and UNSAT instances: create one UNSAT branch guarded by a flag ---
(declare-const make_unsat Bool)

; If make_unsat, require all first three fields non-empty AND at least one empty: contradiction.
(assert (=> make_unsat (and (> (str.len field0) 0)
                            (> (str.len field1) 0)
                            (> (str.len field2) 0)
                            (or (= (str.len field0) 0)
                                (= (str.len field1) 0)
                                (= (str.len field2) 0)))))

; If not make_unsat, enforce a satisfiable concrete pattern: empty middle field
(assert (=> (not make_unsat)
            (and (= field1 "")
                 (>= field_count 3))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
