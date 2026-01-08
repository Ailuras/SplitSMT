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
(declare-const empty_field_detected Bool)

; Declare uninterpreted functions for str_split interface

; Assert that the CSV line has exactly 4 fields (comma-separated)
(assert (= field_count (num_splits csv_line ",")))
(assert (= field_count 4))

; Extract each field using split_at
(assert (= field1 (split_at csv_line "," 0)))
(assert (= field2 (split_at csv_line "," 1)))
(assert (= field3 (split_at csv_line "," 2)))
(assert (= field4 (split_at csv_line "," 3)))

; Ensure no field is empty (i.e., length > 0)
(assert (not (= (str.len field1) 0)))
(assert (not (= (str.len field2) 0)))
(assert (not (= (str.len field3) 0)))
(assert (not (= (str.len field4) 0)))

; Additional constraint: At least one field contains the substring "data"
(assert (or (str.contains field1 "data") (str.contains field2 "data") (str.contains field3 "data") (str.contains field4 "data")))

; Define empty_field_detected based on any field being empty (should be false due to above constraints)
(assert (= empty_field_detected (or (= (str.len field1) 0) (= (str.len field2) 0) (= (str.len field3) 0) (= (str.len field4) 0))))
(assert (not empty_field_detected))

; Add a complex pattern: The CSV line must start with "ID:" and end with a digit
(assert (str.prefixof "ID:" csv_line))
(assert (str.suffixof "0" csv_line))

; Check satisfiability
(check-sat)
(get-value (csv_line field_count field1 field2 field3 field4 empty_field_detected))

; [GENERATION STATUS: SUCCESS]
(exit)
