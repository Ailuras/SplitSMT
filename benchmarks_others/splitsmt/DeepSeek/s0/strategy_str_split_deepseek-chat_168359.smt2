; CSV Processing Scenario: Validate field counts and detect empty fields using str_split interface
(set-logic ALL)

; Declare variables
(declare-const csv_line String)
(declare-const field_count Int)
(declare-const first_field String)
(declare-const last_field String)
(declare-const middle_field String)
(declare-const has_empty_field Bool)

; Declare str_split interface functions

; CSV line must have at least 3 fields
(assert (>= (str.num_splits csv_line ",") 3))

; First field must be non-empty (length > 0)
(assert (> (str.len (str.split_at csv_line "," 0)) 0))

; Last field must be non-empty
(assert (> (str.len (str.split_at csv_line "," (- (str.num_splits csv_line ",") 1))) 0))

; Middle field (second field) must be empty to demonstrate detection
(assert (= (str.len (str.split_at csv_line "," 1)) 0))

; Define field_count as total number of splits
(assert (= field_count (str.num_splits csv_line ",")))

; Define first_field and last_field
(assert (= first_field (str.split_at csv_line "," 0)))
(assert (= last_field (str.split_at csv_line "," (- field_count 1))))

; Define middle_field as second field
(assert (= middle_field (str.split_at csv_line "," 1)))

; Define has_empty_field based on presence of any empty field
(assert (= has_empty_field
    (exists ((i Int))
        (and
            (>= i 0)
            (< i field_count)
            (= (str.len (str.split_at csv_line "," i)) 0)
        )
    )
))

; Additional constraint: CSV line must contain only alphanumeric characters and commas
(assert (str.in_re csv_line (re.++ (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re ","))) )))

; Ensure field_count is exactly 4 for this example
(assert (= field_count 4))

; Check satisfiability
(check-sat)


; [GENERATION STATUS: SUCCESS]
(get-model)
