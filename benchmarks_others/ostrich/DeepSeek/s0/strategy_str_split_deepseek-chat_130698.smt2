; CSV Processing Scenario: Ensure correct field counts and detect empty fields using str_split interface
(set-logic ALL)

; Declare variables for CSV data and delimiter
(declare-const csv_data String)
(declare-const delimiter String)
(declare-const field_count Int)
(declare-const field2 String)
(declare-const field4 String)
(declare-const has_empty_field Bool)

; Declare uninterpreted functions for str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; Define constraints for CSV processing
; Constraint 1: Delimiter is a comma
(assert (= delimiter ","))

; Constraint 2: CSV data must have at least 5 fields
(assert (>= (num_splits csv_data delimiter) 5))

; Constraint 3: Field count equals number of splits
(assert (= field_count (num_splits csv_data delimiter)))

; Constraint 4: Second field (index 1) is non-empty
(assert (= field2 (split_at csv_data delimiter 1)))
(assert (not (= field2 "")))

; Constraint 5: Fourth field (index 3) is empty
(assert (= field4 (split_at csv_data delimiter 3)))
(assert (= field4 ""))

; Constraint 6: Check if any field is empty beyond specific ones
(declare-fun check_empty (String String) Bool)
(assert (= has_empty_field (check_empty csv_data delimiter)))
; Helper assertion: has_empty_field is true if any field is empty
(assert (=> (>= field_count 1) (or has_empty_field (forall ((i Int)) (=> (and (>= i 0) (< i field_count)) (not (= (split_at csv_data delimiter i) "")))))))

; Additional constraints for diversity
; Constraint 7: CSV data length is at least 10 characters
(assert (>= (str.len csv_data) 10))

; Constraint 8: CSV data does not start or end with delimiter
(assert (not (str.prefixof delimiter csv_data)))
(assert (not (str.suffixof delimiter csv_data)))

; Constraint 9: Ensure split_rest consistency for fields after index 2
(assert (= (split_rest csv_data delimiter 2) (str.++ (split_at csv_data delimiter 2) delimiter (split_rest csv_data delimiter 3))))

; Final check for satisfiability
(check-sat)
(get-value (csv_data field_count field2 field4 has_empty_field))

; [GENERATION STATUS: SUCCESS]
