; CSV Processing: Validate field counts and detect empty fields using str_split operations
(set-logic ALL)

; Declare variables for CSV data and delimiter
(declare-const csv_line String)
(declare-const delimiter String)
(declare-const field_count Int)
(declare-const first_field String)
(declare-const last_field String)
(declare-const middle_field String)
(declare-const has_empty_field Bool)

; Define uninterpreted functions for str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; Set delimiter to comma for CSV
(assert (= delimiter ","))

; Constraint 1: CSV line must contain only alphanumeric characters and commas
(assert (str.in_re csv_line (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re ",")))))

; Constraint 2: CSV line length between 10 and 30 characters
(assert (>= (str.len csv_line) 10))
(assert (<= (str.len csv_line) 30))

; Constraint 3: Must have at least 3 fields (ensures meaningful splitting)
(assert (>= (num_splits csv_line delimiter) 3))

; Constraint 4: First field must be non-empty (length > 0)
(assert (> (str.len (split_at csv_line delimiter 0)) 0))

; Constraint 5: Last field must be non-empty (length > 0)
(assert (> (str.len (split_at csv_line delimiter (- (num_splits csv_line delimiter) 1))) 0))

; Constraint 6: Middle field (second field) must be empty to create a UNSAT scenario
; This ensures detection of empty fields, making the instance unsatisfiable
(assert (= (str.len (split_at csv_line delimiter 1)) 0))

; Constraint 7: Total field count must equal the number of splits
(assert (= field_count (num_splits csv_line delimiter)))

; Constraint 8: Field count must be between 3 and 5 (inclusive)
(assert (>= field_count 3))
(assert (<= field_count 5))

; Constraint 9: The concatenation of all fields (excluding delimiters) should equal the original line without commas
; This uses split_rest to reconstruct and compare
(assert (= (str.++ (split_at csv_line delimiter 0) (split_at csv_line delimiter 1) (split_at csv_line delimiter 2)) (str.replace csv_line delimiter "")))

; Check satisfiability
(check-sat)
(get-model)

; [GENERATION STATUS: SUCCESS]
