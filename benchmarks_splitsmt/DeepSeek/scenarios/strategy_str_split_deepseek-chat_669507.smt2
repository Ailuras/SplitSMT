; CSV Processing: Validate field counts and detect empty fields using str_split operations
(set-logic ALL)

; Declare variables for CSV data and delimiter
(declare-const csv_line String)
(declare-const delimiter String)
(declare-const field_count Int)
(declare-const first_field String)
(declare-const last_field String)
(declare-const middle_field String)

; Define delimiter as comma
(assert (= delimiter ","))

; Constraint 1: CSV line must contain at least 3 fields
(assert (>= (str.num_splits csv_line delimiter) 3))

; Constraint 2: First field must be non-empty
(assert (not (= (str.split_at csv_line delimiter 0) "")))

; Constraint 3: Last field must be non-empty
(assert (not (= (str.split_at csv_line delimiter (- (str.num_splits csv_line delimiter) 1)) "")))

; Constraint 4: Middle field (second field) must be empty to detect missing data
(assert (= (str.split_at csv_line delimiter 1) ""))

; Constraint 5: Total field count must be exactly 5
(assert (= (str.num_splits csv_line delimiter) 5))

; Constraint 6: Concatenation of all fields after the first should match a specific pattern
(assert (str.contains (str.split_rest csv_line delimiter 1) "data"))

; Constraint 7: Ensure the CSV line does not start or end with the delimiter
(assert (not (str.prefixof delimiter csv_line)))
(assert (not (str.suffixof delimiter csv_line)))

; Additional constraint: Field lengths must be within reasonable bounds
(assert (<= (str.len (str.split_at csv_line delimiter 0)) 10))
(assert (<= (str.len (str.split_at csv_line delimiter 2)) 15))


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
