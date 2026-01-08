; CSV Processing: Validate field counts and detect empty fields using str_split operations
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

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
(assert (>= (num_splits csv_line delimiter) 3))

; Constraint 2: First field must be non-empty
(assert (not (= (split_at csv_line delimiter 0) "")))

; Constraint 3: Last field must be non-empty
(assert (not (= (split_at csv_line delimiter (- (num_splits csv_line delimiter) 1)) "")))

; Constraint 4: Middle field (second field) must be empty to detect missing data
(assert (= (split_at csv_line delimiter 1) ""))

; Constraint 5: Total field count must be exactly 5
(assert (= (num_splits csv_line delimiter) 5))

; Constraint 6: Concatenation of all fields after the first should match a specific pattern
(assert (str.contains (split_rest csv_line delimiter 1) "data"))

; Constraint 7: Ensure the CSV line does not start or end with the delimiter
(assert (not (str.prefixof delimiter csv_line)))
(assert (not (str.suffixof delimiter csv_line)))

; Additional constraint: Field lengths must be within reasonable bounds
(assert (<= (str.len (split_at csv_line delimiter 0)) 10))
(assert (<= (str.len (split_at csv_line delimiter 2)) 15))

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
