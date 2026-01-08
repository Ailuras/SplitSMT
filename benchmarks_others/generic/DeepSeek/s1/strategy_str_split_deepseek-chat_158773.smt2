; CSV Processing scenario: Ensure correct field counts and detect empty fields using str_split operations
(set-logic ALL)

; Declare variables for CSV data and fields
(declare-const csv_line String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const field3 String)
(declare-const field4 String)
(declare-const total_fields Int)
(declare-const empty_field_index Int)

; Define str_split interface operations
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Constraint 1: CSV line must contain at least 4 fields when split by comma
(assert (>= (num_splits csv_line ",") 4))
(set-info :total_fields (num_splits csv_line ","))

; Constraint 2: Extract first four fields using split_at
(assert (= field1 (split_at csv_line "," 0)))
(assert (= field2 (split_at csv_line "," 1)))
(assert (= field3 (split_at csv_line "," 2)))
(assert (= field4 (split_at csv_line "," 3)))

; Constraint 3: No field should be empty (i.e., length > 0)
(assert (> (str.len field1) 0))
(assert (> (str.len field2) 0))
(assert (> (str.len field3) 0))
(assert (> (str.len field4) 0))

; Constraint 4: Field1 must start with 'ID' and have at least 3 characters
(assert (str.prefixof "ID" field1))
(assert (>= (str.len field1) 3))

; Constraint 5: Field2 must be a numeric string (all digits)
(assert (str.in_re field2 (re.+ (re.range "0" "9"))))

; Constraint 6: Field3 must contain only letters (A-Z or a-z)
(assert (str.in_re field3 (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))))

; Constraint 7: Field4 must be either "ACTIVE" or "INACTIVE"
(assert (or (= field4 "ACTIVE") (= field4 "INACTIVE")))

; Constraint 8: Detect if any field beyond the fourth is empty by checking split_rest
(declare-const rest_fields String)
(assert (= rest_fields (split_rest csv_line "," 4)))
; If rest_fields is not empty, ensure it contains no empty segments by checking it does not start or end with comma and has no consecutive commas
(assert (not (str.prefixof "," rest_fields)))
(assert (not (str.suffixof "," rest_fields)))
(assert (not (str.contains rest_fields ",,")))

; Constraint 9: Total length of CSV line must be between 30 and 100 characters
(assert (>= (str.len csv_line) 30))
(assert (<= (str.len csv_line) 100))

; Constraint 10: CSV line must not contain special characters like quotes or semicolons to avoid injection issues
(assert (not (str.contains csv_line "\"")))
(assert (not (str.contains csv_line ";")))

; Additional constraint to ensure variability: field1 and field3 are different
(assert (not (= field1 field3)))

; Set a goal: find a satisfying assignment (SAT instance)
(check-sat)
(get-model)

; [GENERATION STATUS: SUCCESS]
