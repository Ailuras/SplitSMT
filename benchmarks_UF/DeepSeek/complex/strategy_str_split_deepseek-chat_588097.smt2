; CSV Processing Scenario: Ensure correct field counts and detect empty fields using str_split interface
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Declare variables for CSV data and delimiter
(declare-const csv_data String)
(declare-const delimiter String)
(declare-const field_count Int)
(declare-const first_field String)
(declare-const last_field String)
(declare-const empty_field_index Int)

; Define uninterpreted functions for str_split interface

; Assert that delimiter is a comma for CSV
(assert (= delimiter ","))

; Constraint 1: CSV data must have at least 3 fields
(assert (>= (num_splits csv_data delimiter) 3))

; Constraint 2: First field is non-empty (length > 0)
(assert (> (str.len (split_at csv_data delimiter 0)) 0))

; Constraint 3: Last field is non-empty
(assert (let ((last_idx (- (num_splits csv_data delimiter) 1)))
          (> (str.len (split_at csv_data delimiter last_idx)) 0)))

; Constraint 4: There exists at least one empty field (length = 0) at some index between 1 and second-to-last
(assert (and (>= empty_field_index 1)
             (<= empty_field_index (- (num_splits csv_data delimiter) 2))
             (= (str.len (split_at csv_data delimiter empty_field_index)) 0)))

; Constraint 5: Total field count equals the number of splits
(assert (= field_count (num_splits csv_data delimiter)))

; Constraint 6: The concatenation of all fields from index 1 onwards equals the rest after first field
(assert (= (split_rest csv_data delimiter 1) (str.substr csv_data (+ (str.len (split_at csv_data delimiter 0)) (str.len delimiter)) (str.len csv_data))))

; Additional constraint to ensure data consistency: CSV data does not start or end with delimiter
(assert (not (str.prefixof delimiter csv_data)))
(assert (not (str.suffixof delimiter csv_data)))

; Check satisfiability

; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
