; CSV Processing: Validate field counts and detect empty fields using str_split operations
(set-logic ALL)

; Declare variables for CSV data and delimiter
(declare-const csv_line String)
(declare-const delimiter String)
(declare-const field_count Int)
(declare-const first_field String)
(declare-const last_field String)
(declare-const middle_field String)
(declare-const has_empty_field Bool)

; Define str_split interface functions

; Set delimiter to comma for CSV
(assert (= delimiter ","))

; Constraint 1: CSV line must contain at least 3 fields
(assert (>= (str.num_splits csv_line delimiter) 3))

; Constraint 2: First field must be non-empty (length > 0)
(assert (= first_field (str.split_at csv_line delimiter 0)))
(assert (> (str.len first_field) 0))

; Constraint 3: Last field must be non-empty
(assert (= last_field (str.split_at csv_line delimiter (- (str.num_splits csv_line delimiter) 1))))
(assert (> (str.len last_field) 0))

; Constraint 4: Middle field (second field) must be "N/A" or empty
(assert (= middle_field (str.split_at csv_line delimiter 1)))
(assert (or (= middle_field "N/A") (= middle_field "")))

; Constraint 5: Check if any field is empty (excluding middle field which is allowed)
(declare-const temp_field String)
(assert (or 
    (and (= temp_field (str.split_at csv_line delimiter 2)) (= temp_field ""))
    (and (>= (str.num_splits csv_line delimiter) 4) (= temp_field (str.split_at csv_line delimiter 3)) (= temp_field ""))
))
(assert (= has_empty_field true))

; Constraint 6: Total field count must be between 3 and 5
(assert (= field_count (str.num_splits csv_line delimiter)))
(assert (and (>= field_count 3) (<= field_count 5)))

; Constraint 7: CSV line must not contain newline characters
(assert (not (str.contains csv_line "\n")))

; Constraint 8: Ensure split_rest consistency for validation
(assert (= (str.split_rest csv_line delimiter 2) (str.++ (str.split_at csv_line delimiter 2) delimiter (str.split_at csv_line delimiter 3))))

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
