; CSV Processing Scenario: Ensure correct field counts and detect empty fields using str_split interface
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
; Constraint 1: CSV line must have at least 4 fields (e.g., for a 4-column CSV)
(assert (>= (num_splits csv_line ",") 4))

; Constraint 2: Define field_count as the total number of segments
(assert (= field_count (num_splits csv_line ",")))

; Constraint 3: Extract first four fields using split_at
(assert (= field1 (split_at csv_line "," 0)))
(assert (= field2 (split_at csv_line "," 1)))
(assert (= field3 (split_at csv_line "," 2)))
(assert (= field4 (split_at csv_line "," 3)))

; Constraint 4: Ensure no empty fields among the first four (empty string length 0)
(assert (= empty_field_detected (or (= (str.len field1) 0) (= (str.len field2) 0) (= (str.len field3) 0) (= (str.len field4) 0))))

; Constraint 5: Add a specific condition to make it SAT (e.g., field1 is non-empty and field_count is exactly 4)
(assert (not (= (str.len field1) 0)))
(assert (= field_count 4))

; Constraint 6: Additional constraint to vary patterns: field2 must contain the substring "data"
(assert (str.contains field2 "data"))

; Check satisfiability
(check-sat)
(get-value (csv_line field_count field1 field2 field3 field4 empty_field_detected))

; [GENERATION STATUS: SUCCESS]
