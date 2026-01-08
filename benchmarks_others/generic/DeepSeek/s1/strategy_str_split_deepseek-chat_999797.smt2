; CSV Processing: Validate comma-separated data fields with str_split operations
(set-logic ALL)

; Declare variables for CSV data and delimiter
(declare-const csv_line String)
(declare-const delimiter String)
(declare-const field_count Int)
(declare-const first_field String)
(declare-const second_field String)
(declare-const last_field String)
(declare-const concatenated_rest String)

; Declare str_split interface functions
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Set delimiter to comma for CSV
(assert (= delimiter ","))

; Constraint 1: CSV line must contain at least 3 fields (minimum for meaningful processing)
(assert (>= (num_splits csv_line delimiter) 3))

; Constraint 2: First field must be non-empty (no leading empty field)
(assert (> (str.len (split_at csv_line delimiter 0)) 0))

; Constraint 3: Second field must be exactly "data" (specific field validation)
(assert (= (split_at csv_line delimiter 1) "data"))

; Constraint 4: Last field (index = total splits - 1) must not be "empty"
(assert (not (= (split_at csv_line delimiter (- (num_splits csv_line delimiter) 1)) "empty")))

; Constraint 5: Concatenation of fields from index 2 onwards must contain "value"
(assert (str.contains (split_rest csv_line delimiter 2) "value"))

; Constraint 6: Total field count must be between 3 and 5 inclusive
(assert (and (>= field_count 3) (<= field_count 5)))
(assert (= field_count (num_splits csv_line delimiter)))

; Constraint 7: CSV line must match a pattern: alphanumeric fields separated by commas
(assert (str.in_re csv_line (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re ",")))))

; Constraint 8: No two consecutive commas (to prevent empty fields in middle)
(assert (not (str.contains csv_line ",,")))

; Constraint 9: Define helper variables for specific fields
(assert (= first_field (split_at csv_line delimiter 0)))
(assert (= second_field (split_at csv_line delimiter 1)))
(assert (= last_field (split_at csv_line delimiter (- field_count 1))))
(assert (= concatenated_rest (split_rest csv_line delimiter 2)))

; Constraint 10: Ensure the line ends with a non-comma character (valid termination)
(assert (not (= (str.at csv_line (- (str.len csv_line) 1)) ",")))

; Check satisfiability
(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
