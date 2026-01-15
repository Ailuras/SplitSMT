; CSV Processing: Validate field counts and detect empty fields using str_split operations
(set-logic ALL)

; Declare variables for CSV data and delimiter
(declare-fun csv_data () String)
(declare-fun delimiter () String)
(declare-fun field_count () Int)
(declare-fun first_field () String)
(declare-fun last_field () String)
(declare-fun middle_field () String)
(declare-fun empty_field_check () Bool)

; Declare str_split interface functions

; Set delimiter to comma for CSV
(assert (= delimiter ","))

; Define CSV data with some fields and potential empty ones
(assert (= csv_data "name,age,,city,country"))

; Constraint 1: Total number of fields must be exactly 5
(assert (= (str.num_splits csv_data delimiter) 5))

; Constraint 2: First field (index 0) must be "name"
(assert (= (str.split_at csv_data delimiter 0) "name"))

; Constraint 3: Last field (index 4) must be "country"
(assert (= (str.split_at csv_data delimiter 4) "country"))

; Constraint 4: Middle field (index 2) must be empty (detect empty field)
(assert (= (str.len (str.split_at csv_data delimiter 2)) 0))

; Constraint 5: Field count variable matches actual splits
(assert (= field_count (str.num_splits csv_data delimiter)))

; Constraint 6: Ensure there are no trailing delimiters by checking split_rest
(assert (not (= (str.len (str.split_rest csv_data delimiter 5)) 0)))

; Constraint 7: All fields combined via split_rest from start should equal original data minus delimiters? Not directly, but we can check consistency
(assert (= (str.++ (str.split_at csv_data delimiter 0) delimiter (str.split_at csv_data delimiter 1) delimiter (str.split_at csv_data delimiter 2) delimiter (str.split_at csv_data delimiter 3) delimiter (str.split_at csv_data delimiter 4)) csv_data))

; Additional constraint: Field count must be at least 3
(assert (>= field_count 3))

; Check satisfiability
(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
