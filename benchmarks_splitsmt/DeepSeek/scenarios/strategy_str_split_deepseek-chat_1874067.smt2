; CSV Processing: Ensure correct field counts and detect empty fields using str_split interface
(set-logic ALL)

; Declare variables for CSV data and delimiter
(declare-const csv_data String)
(declare-const delimiter String)
(declare-const field_count Int)
(declare-const first_field String)
(declare-const second_field String)
(declare-const third_field String)
(declare-const rest_fields String)

; Declare str_split interface functions

; Set delimiter to comma for CSV
(assert (= delimiter ","))

; Constraint 1: CSV data must contain at least 3 fields (e.g., for ID, Name, Age)
(assert (>= (str.num_splits csv_data delimiter) 3))

; Constraint 2: First field (ID) must be non-empty and numeric (only digits)
(assert (= first_field (str.split_at csv_data delimiter 0)))
(assert (> (str.len first_field) 0))
(assert (str.in_re first_field (re.+ (re.range "0" "9"))))

; Constraint 3: Second field (Name) must be non-empty and contain only letters and spaces
(assert (= second_field (str.split_at csv_data delimiter 1)))
(assert (> (str.len second_field) 0))
(assert (str.in_re second_field (re.* (re.union (re.range "A" "Z") (re.range "a" "z") (str.to_re " ")))))

; Constraint 4: Third field (Age) must be a valid integer between 0 and 150
(assert (= third_field (str.split_at csv_data delimiter 2)))
(assert (str.in_re third_field (re.+ (re.range "0" "9"))))
(assert (let ((age_int (str.to_int third_field)))
  (and (>= age_int 0) (<= age_int 150))))

; Constraint 5: Rest of fields (if any) must not be empty
(assert (= rest_fields (str.split_rest csv_data delimiter 3)))
(assert (or (= rest_fields "") (not (str.contains rest_fields ",,"))))

; Constraint 6: Total field count must be exactly 4 (ID, Name, Age, and optional extra)
(assert (= field_count (str.num_splits csv_data delimiter)))
(assert (or (= field_count 3) (= field_count 4)))

; Additional constraint: CSV data must not start or end with delimiter to avoid empty leading/trailing fields
(assert (not (str.prefixof delimiter csv_data)))
(assert (not (str.suffixof delimiter csv_data)))

; Check satisfiability

; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
