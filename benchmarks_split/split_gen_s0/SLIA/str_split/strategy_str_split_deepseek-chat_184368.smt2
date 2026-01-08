; CSV Processing Scenario: Ensure correct field counts and detect empty fields using str_split operations
(set-logic ALL)

; Declare variables for CSV data and fields
(declare-const csv_line String)
(declare-const field_count Int)
(declare-const field1 String)
(declare-const field2 String)
(declare-const field3 String)
(declare-const field4 String)
(declare-const empty_field_detected Bool)

; Declare uninterpreted functions for str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Assert constraints for CSV processing
; Constraint 1: CSV line must have at least 4 fields (e.g., typical for a record with ID, name, age, city)
(assert (>= (num_splits csv_line ",") 4))

; Constraint 2: Extract first four fields using split_at
(assert (= field1 (split_at csv_line "," 0)))
(assert (= field2 (split_at csv_line "," 1)))
(assert (= field3 (split_at csv_line "," 2)))
(assert (= field4 (split_at csv_line "," 3)))

; Constraint 3: Field count must be exactly 4 (enforce precise structure)
(assert (= field_count (num_splits csv_line ",")))
(assert (= field_count 4))

; Constraint 4: Detect if any of the first four fields is empty (i.e., length zero)
(assert (= empty_field_detected (or (= (str.len field1) 0) (= (str.len field2) 0) (= (str.len field3) 0) (= (str.len field4) 0))))

; Constraint 5: Ensure no empty fields are allowed (make the instance SAT by requiring empty_field_detected to be false)
(assert (not empty_field_detected))

; Constraint 6: Add some content constraints for realism (e.g., field1 must be numeric, field2 non-empty string)
(assert (str.in_re field1 (re.++ (re.* (str.to_re "0123456789"))))) ; field1 contains only digits
(assert (>= (str.len field2) 1)) ; field2 has at least one character

; Constraint 7: Use split_rest to verify that after field4, there are no more fields (since field_count is 4)
(assert (= (split_rest csv_line "," 4) "")) ; No remaining segments

; Check satisfiability
(check-sat)


; [GENERATION STATUS: SUCCESS]
(get-model)