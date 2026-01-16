; CSV Processing: Validate comma-separated data fields with str_split operations
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
(declare-const middle_field String)

; Define str_split interface functions

; Set delimiter to comma for CSV
(assert (= delimiter ","))

; Constraint 1: CSV data must contain at least 4 fields
(assert (>= (num_splits csv_data delimiter) 4))

; Constraint 2: First field must be non-empty (length > 0)
(assert (= first_field (split_at csv_data delimiter 0)))
(assert (> (str.len first_field) 0))

; Constraint 3: Last field must be non-empty
(assert (= last_field (split_at csv_data delimiter (- (num_splits csv_data delimiter) 1))))
(assert (> (str.len last_field) 0))

; Constraint 4: Third field (index 2) must be "ID123"
(assert (= (split_at csv_data delimiter 2) "ID123"))

; Constraint 5: Middle field (index 1) must contain only digits
(assert (= middle_field (split_at csv_data delimiter 1)))
(assert (str.in_re middle_field (re.+ (re.range "0" "9"))))

; Constraint 6: The concatenation of all fields from index 2 onwards must contain "XYZ"
(assert (str.contains (split_rest csv_data delimiter 2) "XYZ"))

; Constraint 7: Total field count must be even
(assert (= field_count (num_splits csv_data delimiter)))
(assert (= (mod field_count 2) 0))

; Additional constraint: CSV data must not start or end with delimiter
(assert (not (str.prefixof delimiter csv_data)))
(assert (not (str.suffixof delimiter csv_data)))

; Check satisfiability


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
