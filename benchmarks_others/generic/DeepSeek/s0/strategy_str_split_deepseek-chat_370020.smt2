; CSV Processing Scenario: Validate field counts and detect empty fields using str_split interface
(set-logic ALL)

; Declare variables for CSV data and delimiter
(declare-const csv_line String)
(declare-const delimiter String)
(declare-const field_count Int)
(declare-const field_3 String)
(declare-const has_empty_field Bool)

; Declare uninterpreted functions for str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Define constraints for CSV processing
; Constraint 1: Delimiter is a comma
(assert (= delimiter ","))

; Constraint 2: CSV line has at least 4 fields
(assert (>= (num_splits csv_line delimiter) 4))

; Constraint 3: Field count equals number of splits
(assert (= field_count (num_splits csv_line delimiter)))

; Constraint 4: Third field (index 2) is "empty"
(assert (= field_3 (split_at csv_line delimiter 2)))
(assert (= field_3 ""))

; Constraint 5: Check if any field is empty by verifying at least one split segment is empty string
(assert (= has_empty_field (or (= (split_at csv_line delimiter 0) "") (= (split_at csv_line delimiter 1) "") (= (split_at csv_line delimiter 2) "") (= (split_at csv_line delimiter 3) ""))))

; Constraint 6: Ensure CSV line is non-empty and contains delimiter
(assert (>= (str.len csv_line) 1))
(assert (str.contains csv_line delimiter))

; Additional constraint for diversity: Field count is exactly 5 (SAT instance)
(assert (= field_count 5))

; Check satisfiability
(check-sat)
(get-value (csv_line field_count field_3 has_empty_field))

; [GENERATION STATUS: SUCCESS]
