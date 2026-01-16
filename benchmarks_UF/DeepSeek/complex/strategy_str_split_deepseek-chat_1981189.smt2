; CSV Processing Scenario: Validate field counts and detect empty fields using str_split interface
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Declare variables
(declare-const csv_line String)
(declare-const field_count Int)
(declare-const first_field String)
(declare-const last_field String)
(declare-const has_empty_field Bool)

; Declare str_split interface functions

; Constraint 1: CSV line must have at least 3 fields
(assert (>= (num_splits csv_line ",") 3))

; Constraint 2: First field must be non-empty
(assert (not (= (split_at csv_line "," 0) "")))

; Constraint 3: Last field must be non-empty
(assert (not (= (split_at csv_line "," (- (num_splits csv_line ",") 1)) "")))

; Constraint 4: Define field_count as total number of splits
(assert (= field_count (num_splits csv_line ",")))

; Constraint 5: Define first_field
(assert (= first_field (split_at csv_line "," 0)))

; Constraint 6: Define last_field
(assert (= last_field (split_at csv_line "," (- field_count 1))))

; Constraint 7: Check if any field is empty (excluding first and last which are already constrained)
(assert (= has_empty_field
    (exists ((i Int))
        (and
            (>= i 1)
            (< i (- field_count 1))
            (= (split_at csv_line "," i) "")
        )
    )
))

; Constraint 8: CSV line must contain at least one comma
(assert (str.contains csv_line ","))

; Constraint 9: Ensure split indices are within bounds (implicitly handled by interface constraints)
; Additional constraint for diversity: total length of CSV line must be at least field_count + 1
(assert (>= (str.len csv_line) (+ field_count 1)))

; Check satisfiability


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
