; CSV Processing Scenario: Validate field counts and detect empty fields using str_split operations
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Declare variables for CSV data and delimiter
(declare-const csv_data String)
(declare-const delimiter String)
(declare-const field_count Int)
(declare-const field2 String)
(declare-const field4 String)
(declare-const has_empty_field Bool)

; Declare uninterpreted functions for str_split interface

; Define constraints for CSV processing
; Constraint 1: Delimiter is a comma
(assert (= delimiter ","))

; Constraint 2: CSV data has at least 5 fields
(assert (>= (num_splits csv_data delimiter) 5))

; Constraint 3: Field count equals number of splits
(assert (= field_count (num_splits csv_data delimiter)))

; Constraint 4: Second field (index 1) is non-empty
(assert (= field2 (split_at csv_data delimiter 1)))
(assert (not (= field2 "")))

; Constraint 5: Fourth field (index 3) is empty
(assert (= field4 (split_at csv_data delimiter 3)))
(assert (= field4 ""))

; Constraint 6: Check if any field is empty by examining split_rest
(assert (= has_empty_field (str.contains (split_rest csv_data delimiter 0) ",,")))
(assert has_empty_field)

; Additional constraints to ensure diversity and realistic data
; Constraint 7: CSV data length is between 10 and 100 characters
(assert (>= (str.len csv_data) 10))
(assert (<= (str.len csv_data) 100))

; Constraint 8: Field count is exactly 6 to create a SAT instance
(assert (= field_count 6))

; Check satisfiability


; [GENERATION STATUS: SUCCESS]
(check-sat)
(get-model)
(exit)
