; CSV Processing: Validate field counts and detect empty fields using str_split interface
(set-logic ALL)

; Declare variables for CSV data and delimiter
(declare-const csv_line String)
(declare-const delimiter String)
(declare-const field_count Int)
(declare-const first_field String)
(declare-const last_field String)
(declare-const middle_field String)

; Define str_split interface functions
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; Set delimiter to comma for CSV
(assert (= delimiter ","))

; Constraint 1: CSV line must have at least 3 fields
(assert (>= (num_splits csv_line delimiter) 3))

; Constraint 2: First field must not be empty (length > 0)
(assert (= first_field (split_at csv_line delimiter 0)))
(assert (> (str.len first_field) 0))

; Constraint 3: Last field must not be empty
(assert (= last_field (split_at csv_line delimiter (- (num_splits csv_line delimiter) 1))))
(assert (> (str.len last_field) 0))

; Constraint 4: Middle field (second field) must contain only digits
(assert (= middle_field (split_at csv_line delimiter 1)))
(assert (str.in_re middle_field (re.+ (str.to_re "0123456789"))))

; Constraint 5: Total field count must be exactly 5 (SAT instance)
(assert (= (num_splits csv_line delimiter) 5))

; Constraint 6: The concatenation of all fields after the first should not contain the delimiter
(assert (not (str.contains (split_rest csv_line delimiter 1) delimiter)))

; Additional constraint: CSV line must not start or end with delimiter
(assert (not (str.prefixof delimiter csv_line)))
(assert (not (str.suffixof delimiter csv_line)))

(check-sat)
(get-model)

; [GENERATION STATUS: SUCCESS]
