; CSV Processing Scenario: Ensure correct field counts and detect empty fields using str_split interface
(set-logic ALL)

; Declare variables for CSV data and delimiter
(declare-const csv_data String)
(declare-const delimiter String)
(declare-const field_count Int)
(declare-const first_field String)
(declare-const last_field String)
(declare-const middle_field String)

; Define uninterpreted functions for str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Assert that delimiter is a comma for CSV
(assert (= delimiter ","))

; Constraint 1: CSV data must have at least 3 fields
(assert (>= (num_splits csv_data delimiter) 3))

; Constraint 2: First field is non-empty (length > 0)
(assert (= first_field (split_at csv_data delimiter 0)))
(assert (> (str.len first_field) 0))

; Constraint 3: Last field is non-empty
(assert (= last_field (split_at csv_data delimiter (- (num_splits csv_data delimiter) 1))))
(assert (> (str.len last_field) 0))

; Constraint 4: Middle field (index 1) is empty to detect missing data
(assert (= middle_field (split_at csv_data delimiter 1)))
(assert (= (str.len middle_field) 0))

; Constraint 5: Total field count is exactly 4
(assert (= field_count (num_splits csv_data delimiter)))
(assert (= field_count 4))

; Constraint 6: split_rest from index 2 should concatenate to a specific string
(assert (= (split_rest csv_data delimiter 2) "field3,field4"))

; Additional constraint to ensure data consistency: first field starts with 'ID'
(assert (str.prefixof "ID" first_field))

; Check satisfiability
(check-sat)
(get-value (csv_data field_count first_field middle_field last_field))

; [GENERATION STATUS: SUCCESS]
