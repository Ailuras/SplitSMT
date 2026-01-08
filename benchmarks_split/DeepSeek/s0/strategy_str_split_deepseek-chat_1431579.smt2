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
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Assert CSV line has at least 3 fields (comma-separated)
(assert (>= (num_splits csv_line ",") 3))

; Define field_count as total number of segments
(assert (= field_count (num_splits csv_line ",")))

; Extract first field (index 0)
(assert (= first_field (split_at csv_line "," 0)))

; Extract last field (index field_count-1)
(assert (= last_field (split_at csv_line "," (- field_count 1))))

; Extract middle field (index 1) for validation
(assert (= middle_field (split_at csv_line "," 1)))

; Constraint: first field must not be empty
(assert (not (= first_field "")))

; Constraint: last field must contain at least one character
(assert (>= (str.len last_field) 1))

; Detect if any field is empty by checking middle field as example
(assert (= has_empty_field (= middle_field "")))

; Additional constraint: total line length is reasonable (e.g., less than 100 chars)
(assert (< (str.len csv_line) 100))

; Ensure field_count is positive
(assert (> field_count 0))

; Check satisfiability
(check-sat)


; [GENERATION STATUS: SUCCESS]
(get-model)