; CSV Processing: Validate comma-separated data fields with str_split operations
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Declare string variables for CSV data and delimiter
(declare-const csv_line String)
(declare-const delimiter String)
(declare-const field_count Int)
(declare-const first_field String)
(declare-const last_field String)
(declare-const middle_fields String)

; Set delimiter to comma for CSV
(assert (= delimiter ","))

; Constraint 1: CSV line must contain at least 3 fields
(assert (>= (num_splits csv_line delimiter) 3))

; Constraint 2: First field must be non-empty (length > 0)
(assert (= first_field (split_at csv_line delimiter 0)))
(assert (> (str.len first_field) 0))

; Constraint 3: Last field must not contain spaces
(assert (= last_field (split_at csv_line delimiter (- (num_splits csv_line delimiter) 1))))
(assert (not (str.contains last_field " ")))

; Constraint 4: Middle fields (from index 1 to second-last) concatenated must have length at least 10
(assert (= middle_fields (split_rest csv_line delimiter 1)))
(assert (>= (str.len middle_fields) 10))

; Constraint 5: Total field count must be exactly 5
(assert (= field_count (num_splits csv_line delimiter)))
(assert (= field_count 5))

; Constraint 6: CSV line must not contain the delimiter followed immediately by another delimiter (no empty fields)
(assert (not (str.contains csv_line ",,")))

; Constraint 7: CSV line length must be between 20 and 100 characters
(assert (>= (str.len csv_line) 20))
(assert (<= (str.len csv_line) 100))

; Constraint 8: CSV line must start with an alphabetic character
(assert (str.in_re csv_line (re.++ (re.range "A" "Z") re.all)))

; Check satisfiability
(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
