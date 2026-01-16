; CSV Processing: Ensure correct field counts and detect empty fields using str_split interface
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
; Declare variables for CSV data and delimiter
(declare-const csv_line String)
(declare-const delimiter String)
(declare-const field_count Int)
(declare-const field1 String)
(declare-const field2 String)
(declare-const field3 String)
; Declare uninterpreted functions for str_split interface
; Set delimiter to comma for CSV
(assert (= delimiter ","))
; Constraint: CSV line must have at least 3 fields
(assert (>= (num_splits csv_line delimiter) 3))
; Extract first three fields using split_at
(assert (= field1 (split_at csv_line delimiter 0)))
(assert (= field2 (split_at csv_line delimiter 1)))
(assert (= field3 (split_at csv_line delimiter 2)))
; Constraint: No field should be empty (i.e., length > 0)
(assert (> (str.len field1) 0))
(assert (> (str.len field2) 0))
(assert (> (str.len field3) 0))
; Additional constraint: The total number of fields is exactly 5
(assert (= (num_splits csv_line delimiter) 5))
; Constraint: The fourth field (index 3) contains the substring "data"
(assert (str.contains (split_at csv_line delimiter 3) "data"))
; Constraint: The rest of the fields after the third (indices 3 and 4) concatenated should have length at least 10
(assert (>= (str.len (split_rest csv_line delimiter 3)) 10))
; Ensure indices are within bounds for split operations
(assert (>= 0 0))
(assert (< 0 (num_splits csv_line delimiter)))
(assert (>= 1 0))
(assert (< 1 (num_splits csv_line delimiter)))
(assert (>= 2 0))
(assert (< 2 (num_splits csv_line delimiter)))
(assert (>= 3 0))
(assert (< 3 (num_splits csv_line delimiter)))
; Add a constraint to make the problem SAT: CSV line starts with "id,"
(assert (str.prefixof "id," csv_line))

; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
