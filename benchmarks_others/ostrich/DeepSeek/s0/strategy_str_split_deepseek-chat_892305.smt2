; CSV Processing Scenario: Validate field counts and detect empty fields using str_split operations
(set-logic ALL)

; Declare variables
(declare-const csv_line String)
(declare-const field_count Int)
(declare-const first_field String)
(declare-const last_field String)
(declare-const middle_field String)
(declare-const has_empty_field Bool)

; Declare str_split interface functions
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; Constraint 1: CSV line must have at least 3 fields
(assert (>= (num_splits csv_line ",") 3))

; Constraint 2: First field must be non-empty (length > 0)
(assert (> (str.len (split_at csv_line "," 0)) 0))

; Constraint 3: Last field must be non-empty
(assert (> (str.len (split_at csv_line "," (- (num_splits csv_line ",") 1))) 0))

; Constraint 4: Middle field (second field) must be empty to create a UNSAT scenario
(assert (= (str.len (split_at csv_line "," 1)) 0))

; Constraint 5: Total field count equals number of splits
(assert (= field_count (num_splits csv_line ",")))

; Constraint 6: Define first_field, last_field, and middle_field
(assert (= first_field (split_at csv_line "," 0)))
(assert (= last_field (split_at csv_line "," (- field_count 1))))
(assert (= middle_field (split_at csv_line "," 1)))

; Constraint 7: Check if any field is empty (excluding first and last which are constrained non-empty)
(assert (= has_empty_field
    (exists ((i Int))
        (and
            (>= i 0)
            (< i field_count)
            (= (str.len (split_at csv_line "," i)) 0)
        )
    )
))

; Additional constraint to ensure CSV line has reasonable length
(assert (<= (str.len csv_line) 100))

; Check satisfiability
(check-sat)


; [GENERATION STATUS: SUCCESS]
(get-model)
