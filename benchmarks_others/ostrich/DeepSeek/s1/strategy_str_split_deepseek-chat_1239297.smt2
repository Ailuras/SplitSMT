; CSV Processing: Validate comma-separated data fields with str_split operations
(set-logic ALL)

; Declare string variables for CSV data and delimiter
(declare-const csv_data String)
(declare-const delimiter String)
(declare-const field_count Int)
(declare-const first_field String)
(declare-const last_field String)
(declare-const middle_fields String)

; Declare str_split interface functions
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; Set delimiter to comma
(assert (= delimiter ","))

; Constraint 1: CSV data must contain at least 3 fields
(assert (>= (num_splits csv_data delimiter) 3))

; Constraint 2: First field must be non-empty (length > 0)
(assert (= first_field (split_at csv_data delimiter 0)))
(assert (> (str.len first_field) 0))

; Constraint 3: Last field must be non-empty
(assert (= last_field (split_at csv_data delimiter (- (num_splits csv_data delimiter) 1))))
(assert (> (str.len last_field) 0))

; Constraint 4: Middle fields (from index 1 to second-to-last) concatenated must not contain two consecutive commas (detect empty middle fields)
(assert (= middle_fields (split_rest csv_data delimiter 1)))
(assert (not (str.contains middle_fields ",,")))

; Constraint 5: Total field count must be exactly 5 (enforce specific structure)
(assert (= field_count (num_splits csv_data delimiter)))
(assert (= field_count 5))

; Constraint 6: Third field must contain only alphanumeric characters (simple regex check)
(declare-const third_field String)
(assert (= third_field (split_at csv_data delimiter 2)))
(assert (str.in_re third_field (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9")))))

; Constraint 7: CSV data must end with a non-comma character (prevent trailing delimiter)
(assert (not (= (str.at csv_data (- (str.len csv_data) 1)) ",")))

; Additional constraint to create UNSAT scenario: First and last fields must be identical but different strings
(assert (= first_field last_field))
(assert (not (= (str.len first_field) (str.len last_field))))

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
