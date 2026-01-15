; CSV Processing: Ensure correct field counts and detect empty fields using str_split operations
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
(declare-const rest_fields String)

; Define uninterpreted functions for str_split interface

; Set delimiter to comma for CSV
(assert (= delimiter ","))

; Constraint 1: CSV line must contain at least 3 fields (e.g., for ID, Name, Age)
(assert (>= (num_splits csv_line delimiter) 3))

; Constraint 2: First field (e.g., ID) must be non-empty and not contain spaces
(assert (= first_field (split_at csv_line delimiter 0)))
(assert (not (= (str.len first_field) 0)))
(assert (not (str.contains first_field " ")))

; Constraint 3: Last field (e.g., Age) must be numeric (digits only)
(assert (= last_field (split_at csv_line delimiter (- (num_splits csv_line delimiter) 1))))
(assert (str.in_re last_field (re.+ (re.range "0" "9"))))

; Constraint 4: Middle field (e.g., Name) must be at least 2 characters long
(assert (= middle_field (split_at csv_line delimiter 1)))
(assert (>= (str.len middle_field) 2))

; Constraint 5: Rest of fields after the first must not be empty when concatenated
(assert (= rest_fields (split_rest csv_line delimiter 1)))
(assert (not (= (str.len rest_fields) 0)))

; Constraint 6: Ensure no empty fields in the entire CSV line by checking each split
(assert (forall ((i Int)) (=> (and (>= i 0) (< i (num_splits csv_line delimiter))) (not (= (str.len (split_at csv_line delimiter i)) 0)))))

; Constraint 7: CSV line must not contain the delimiter repeated consecutively (e.g., ",,")
(assert (not (str.contains csv_line (str.++ delimiter delimiter))))

; Constraint 8: Total length of CSV line must be less than 100 characters to avoid overflow
(assert (< (str.len csv_line) 100))

; Additional constraint: CSV line must start with a letter (A-Z or a-z) for first field
(assert (str.in_re (str.at first_field 0) (re.union (re.range "A" "Z") (re.range "a" "z"))))

; Check satisfiability
(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
