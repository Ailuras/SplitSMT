; CSV Processing Scenario: Ensure correct field counts and detect empty fields using str_split interface
(set-logic ALL)

; Declare variables for CSV data and delimiter
(declare-const csv_data String)
(declare-const delimiter String)
(declare-const field_count Int)
(declare-const first_field String)
(declare-const last_field String)
(declare-const middle_field String)

; Declare uninterpreted functions for str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Assert delimiter is a comma
(assert (= delimiter ","))

; Constraint 1: CSV data must have at least 3 fields
(assert (>= (num_splits csv_data delimiter) 3))

; Constraint 2: First field is non-empty (length > 0)
(assert (= first_field (split_at csv_data delimiter 0)))
(assert (> (str.len first_field) 0))

; Constraint 3: Last field is non-empty
(assert (= last_field (split_at csv_data delimiter (- (num_splits csv_data delimiter) 1))))
(assert (> (str.len last_field) 0))

; Constraint 4: Middle field (index 1) is empty (length = 0) to detect missing data
(assert (= middle_field (split_at csv_data delimiter 1)))
(assert (= (str.len middle_field) 0))

; Constraint 5: Total field count is exactly 5
(assert (= field_count (num_splits csv_data delimiter)))
(assert (= field_count 5))

; Constraint 6: split_rest from index 2 must contain "data" substring
(assert (str.contains (split_rest csv_data delimiter 2) "data"))

; Additional constraints for diversity: ensure CSV data length is reasonable
(assert (>= (str.len csv_data) 10))
(assert (<= (str.len csv_data) 100))

; Check satisfiability
(check-sat)
(get-value (csv_data field_count first_field last_field middle_field))

; [GENERATION STATUS: SUCCESS]