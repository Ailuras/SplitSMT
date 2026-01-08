; CSV Processing: Validate comma-separated data fields with str_split operations
(set-logic ALL)

; Declare variables for CSV data and delimiter
(declare-const csv_line String)
(declare-const delimiter String)
(declare-const field_count Int)
(declare-const first_field String)
(declare-const last_field String)
(declare-const middle_fields String)

; Define str_split interface functions
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Set delimiter to comma for CSV
(assert (= delimiter ","))

; Constraint 1: CSV line must contain at least 3 fields
(assert (>= (num_splits csv_line delimiter) 3))

; Constraint 2: First field must be non-empty (length > 0)
(assert (= first_field (split_at csv_line delimiter 0)))
(assert (> (str.len first_field) 0))

; Constraint 3: Last field must be numeric (convertible to integer)
(assert (= last_field (split_at csv_line delimiter (- (num_splits csv_line delimiter) 1))))
(assert (str.is_digit last_field))

; Constraint 4: Middle fields (from index 1 to second-last) concatenated must not contain the delimiter
(assert (= middle_fields (split_rest csv_line delimiter 1)))
(assert (not (str.contains middle_fields delimiter)))

; Constraint 5: Total field count must be odd (ensuring specific structure)
(assert (= field_count (num_splits csv_line delimiter)))
(assert (= (mod field_count 2) 1))

; Constraint 6: CSV line must match a pattern: starts with letter, ends with digit
(assert (str.in_re csv_line (re.++ (re.range "A" "Z") (re.* re.allchar) (re.range "0" "9"))))

; Constraint 7: Ensure no empty fields except possibly middle ones (handled by split_rest)
(assert (forall ((i Int)) (=> (and (>= i 0) (< i field_count)) (=> (or (= i 0) (= i (- field_count 1))) (> (str.len (split_at csv_line delimiter i)) 0)))))

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)