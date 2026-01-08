; CSV Processing Scenario: Ensure correct field counts and detect empty fields using str_split interface
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Declare variables for CSV data and fields
(declare-const csv_line String)
(declare-const field_count Int)
(declare-const field1 String)
(declare-const field2 String)
(declare-const field3 String)
(declare-const field4 String)
(declare-const empty_field_index Int)

; Declare str_split interface functions

; Assert constraints for CSV processing
; Constraint 1: CSV line must have exactly 4 fields (comma-separated)
(assert (= field_count (num_splits csv_line ",")))
(assert (= field_count 4))

; Constraint 2: Extract each field using split_at
(assert (= field1 (split_at csv_line "," 0)))
(assert (= field2 (split_at csv_line "," 1)))
(assert (= field3 (split_at csv_line "," 2)))
(assert (= field4 (split_at csv_line "," 3)))

; Constraint 3: At least one field must be non-empty (i.e., length > 0)
(assert (or (> (str.len field1) 0) (> (str.len field2) 0) (> (str.len field3) 0) (> (str.len field4) 0)))

; Constraint 4: Detect an empty field by checking if any field has length 0
(assert (or (= (str.len field1) 0) (= (str.len field2) 0) (= (str.len field3) 0) (= (str.len field4) 0)))

; Constraint 5: Set empty_field_index to the index of the first empty field (0-based), or -1 if none (but we know at least one exists from Constraint 4)
(assert (ite (= (str.len field1) 0) (= empty_field_index 0) 
    (ite (= (str.len field2) 0) (= empty_field_index 1) 
        (ite (= (str.len field3) 0) (= empty_field_index 2) 
            (ite (= (str.len field4) 0) (= empty_field_index 3) (= empty_field_index -1))))))

; Constraint 6: Ensure the CSV line does not start or end with a comma to avoid extra empty fields
(assert (not (str.prefixof "," csv_line)))
(assert (not (str.suffixof "," csv_line)))

; Constraint 7: Add a complex pattern: field1 must contain only alphanumeric characters (simplified as not containing commas or spaces)
(assert (not (str.contains field1 ",")))
(assert (not (str.contains field1 " ")))

; Check satisfiability
(check-sat)
(get-value (csv_line field_count field1 field2 field3 field4 empty_field_index))

; [GENERATION STATUS: SUCCESS]
(exit)
