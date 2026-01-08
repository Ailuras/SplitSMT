; CSV Processing Scenario: Ensure correct field counts and detect empty fields using str_split interface
(set-logic ALL)

; Declare variables
(declare-const csv_line String)
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const total_fields Int)
(declare-const has_empty_field Bool)

; Declare str_split interface functions
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Assert constraints for CSV processing
; Constraint 1: CSV line must have at least 3 fields
(assert (>= (num_splits csv_line ",") 3))

; Constraint 2: Extract first three fields
(assert (= field0 (split_at csv_line "," 0)))
(assert (= field1 (split_at csv_line "," 1)))
(assert (= field2 (split_at csv_line "," 2)))

; Constraint 3: Total fields count
(assert (= total_fields (num_splits csv_line ",")))

; Constraint 4: Detect if any of the first three fields is empty (length 0)
(assert (= has_empty_field (or (= (str.len field0) 0) (= (str.len field1) 0) (= (str.len field2) 0))))

; Constraint 5: Ensure CSV line is non-empty and contains commas
(assert (> (str.len csv_line) 0))
(assert (str.contains csv_line ","))

; Constraint 6: Additional constraint to create a SAT instance: field0 must not be empty if total_fields is exactly 3
(assert (=> (= total_fields 3) (> (str.len field0) 0)))

; Check satisfiability
(check-sat)
(get-value (csv_line field0 field1 field2 total_fields has_empty_field))

; [GENERATION STATUS: SUCCESS]