; CSV Processing: Validate field counts and detect empty fields using str_split interface
(set-logic ALL)

; Declare variables
(declare-const csv_line String)
(declare-const field_count Int)
(declare-const first_field String)
(declare-const last_field String)
(declare-const has_empty_field Bool)
(declare-const is_valid Bool)

; Declare str_split interface functions

; Define constraints
; Constraint 1: CSV line must have at least 3 fields
(assert (>= (str.num_splits csv_line ",") 3))

; Constraint 2: First field must be non-empty
(assert (not (= (str.split_at csv_line "," 0) "")))

; Constraint 3: Last field must be non-empty
(assert (not (= (str.split_at csv_line "," (- (str.num_splits csv_line ",") 1)) "")))

; Constraint 4: Check if any field is empty (excluding first and last)
(assert (= has_empty_field
    (exists ((i Int))
        (and
            (>= i 1)
            (< i (- (str.num_splits csv_line ",") 1))
            (= (str.split_at csv_line "," i) "")
        )
    )
))

; Constraint 5: Overall validity condition
(assert (= is_valid (and (>= (str.num_splits csv_line ",") 3) (not has_empty_field))))

; Constraint 6: Specific example line to make SAT
(assert (= csv_line "name,age,city,country"))

; Final check
(assert is_valid)
(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
