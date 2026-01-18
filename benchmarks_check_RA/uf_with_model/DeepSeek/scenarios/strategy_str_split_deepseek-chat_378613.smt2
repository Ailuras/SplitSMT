; CSV Processing: Ensure correct field counts and detect empty fields using str_split interface
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Declare variables for CSV data and fields
(declare-const csv_data String)
(declare-const field_count Int)
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const field3 String)
(declare-const has_empty Bool)
(declare-const all_nonempty Bool)

; Declare str_split interface functions

; Define CSV data with comma delimiter
(assert (= csv_data "John,Doe,30,New York"))

; Compute number of fields after splitting by comma
(assert (= field_count (num_splits csv_data ",")))

; Ensure there are exactly 4 fields
(assert (= field_count 4))

; Extract each field using split_at
(assert (= field0 (split_at csv_data "," 0)))
(assert (= field1 (split_at csv_data "," 1)))
(assert (= field2 (split_at csv_data "," 2)))
(assert (= field3 (split_at csv_data "," 3)))

; Check for empty fields: define has_empty as true if any field is empty
(assert (= has_empty (or (= field0 "") (= field1 "") (= field2 "") (= field3 ""))))

; Assert that no fields are empty (all_nonempty is true)
(assert (= all_nonempty (not has_empty)))
(assert all_nonempty)

; Additional constraint: field2 must be a numeric string (digits only)
(assert (str.in_re field2 (re.+ (str.to_re "0123456789"))))

; Constraint: field0 and field1 must not be equal
(assert (not (= field0 field1)))

; Constraint: total length of all fields concatenated without commas equals length of csv_data minus 3 commas
(assert (= (str.len csv_data) (+ (str.len field0) (str.len field1) (str.len field2) (str.len field3) 3)))

; Check satisfiability

; [GENERATION STATUS: SUCCESS]
(check-sat)
(get-model)
(exit)
