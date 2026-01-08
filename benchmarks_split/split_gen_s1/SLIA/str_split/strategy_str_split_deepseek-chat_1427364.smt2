; CSV Processing scenario: Ensure correct field counts and detect empty fields using str_split operations
(set-logic ALL)

; Declare variables for CSV data and delimiter
(declare-const csv_line String)
(declare-const delimiter String)
(declare-const field_count Int)
(declare-const first_field String)
(declare-const last_field String)
(declare-const middle_field String)

; Set delimiter to comma for CSV
(assert (= delimiter ","))

; Define str_split interface operations
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Constraint 1: CSV line must contain at least 3 fields
(assert (>= (num_splits csv_line delimiter) 3))

; Constraint 2: First field must be non-empty (length > 0)
(assert (> (str.len (split_at csv_line delimiter 0)) 0))

; Constraint 3: Last field must be non-empty (length > 0)
(assert (> (str.len (split_at csv_line delimiter (- (num_splits csv_line delimiter) 1))) 0))

; Constraint 4: Middle field (second field) must be empty (length = 0) to simulate missing data
(assert (= (str.len (split_at csv_line delimiter 1)) 0))

; Constraint 5: The concatenation of all fields from index 2 onwards must contain the substring "data"
(assert (str.contains (split_rest csv_line delimiter 2) "data"))

; Constraint 6: CSV line must end with a digit (0-9) to ensure proper formatting
(assert (str.in_re csv_line (re.++ (re.* re.allchar) (re.range "0" "9"))))

; Constraint 7: CSV line must not contain spaces to avoid formatting issues
(assert (not (str.contains csv_line " ")))

; Additional constraint: Ensure total length of CSV line is at least 10 characters
(assert (>= (str.len csv_line) 10))

; Check satisfiability
(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)