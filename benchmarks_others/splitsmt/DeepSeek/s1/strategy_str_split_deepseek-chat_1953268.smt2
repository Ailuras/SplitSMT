; CSV Processing: Validate field counts and detect empty fields using str_split interface
(set-logic ALL)

; Declare variables for CSV data and delimiter
(declare-fun csv_data () String)
(declare-fun delimiter () String)
(declare-fun field_count () Int)
(declare-fun first_field () String)
(declare-fun last_field () String)
(declare-fun middle_fields () String)

; Define str_split interface functions

; Set delimiter to comma for CSV
(assert (= delimiter ","))

; Constraint 1: CSV data must contain at least 3 fields
(assert (>= (str.num_splits csv_data delimiter) 3))

; Constraint 2: First field must not be empty
(assert (> (str.len (str.split_at csv_data delimiter 0)) 0))

; Constraint 3: Last field must not be empty
(assert (> (str.len (str.split_at csv_data delimiter (- (str.num_splits csv_data delimiter) 1))) 0))

; Constraint 4: At least one middle field (field index 1) must be empty to detect missing data
(assert (= (str.len (str.split_at csv_data delimiter 1)) 0))

; Constraint 5: Total field count must be exactly 5
(assert (= (str.num_splits csv_data delimiter) 5))

; Constraint 6: Concatenation of all fields (excluding delimiters) should reconstruct original data without extra commas
(assert (= csv_data (str.++ (str.split_at csv_data delimiter 0) delimiter (str.split_at csv_data delimiter 1) delimiter (str.split_at csv_data delimiter 2) delimiter (str.split_at csv_data delimiter 3) delimiter (str.split_at csv_data delimiter 4))))

; Constraint 7: Ensure no trailing delimiter
(assert (not (str.suffixof delimiter csv_data)))

; Constraint 8: Ensure no leading delimiter
(assert (not (str.prefixof delimiter csv_data)))

; Additional constraint: Field 3 must contain the substring "ID"
(assert (str.contains (str.split_at csv_data delimiter 2) "ID"))

; Check satisfiability
(check-sat)
(get-model)

; [GENERATION STATUS: SUCCESS]
