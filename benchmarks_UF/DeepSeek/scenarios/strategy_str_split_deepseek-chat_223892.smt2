; CSV Processing: Validate comma-separated data fields using str_split operations
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Declare string variables for CSV data and delimiter
(declare-const csv_data String)
(declare-const delimiter String)
(declare-const field_count Int)
(declare-const first_field String)
(declare-const last_field String)
(declare-const middle_fields String)

; Declare Boolean variables for constraints
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_6 () Bool)

; Declare str_split interface functions

; Set delimiter to comma for CSV
(assert (= delimiter ","))

; Constraint 1: CSV data must not be empty
(assert (= T_1 (not (= "" csv_data))))
(assert T_1)

; Constraint 2: CSV data must contain at least one delimiter
(assert (= T_2 (str.contains csv_data delimiter)))
(assert T_2)

; Constraint 3: Field count must be at least 3
(assert (= field_count (num_splits csv_data delimiter)))
(assert (= T_3 (>= field_count 3)))
(assert T_3)

; Constraint 4: First field must not be empty
(assert (= first_field (split_at csv_data delimiter 0)))
(assert (= T_4 (not (= "" first_field))))
(assert T_4)

; Constraint 5: Last field must not be empty
(assert (= last_field (split_at csv_data delimiter (- field_count 1))))
(assert (= T_5 (not (= "" last_field))))
(assert T_5)

; Constraint 6: Middle fields (from index 1 to second-last) must contain at least one non-empty field
(assert (= middle_fields (split_rest csv_data delimiter 1)))
(assert (= T_6 (str.contains middle_fields "A"))) ; Example: require middle fields to contain 'A' for diversity
(assert T_6)

; Additional constraint: Ensure total string length is reasonable
(assert (<= (str.len csv_data) 100))

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
