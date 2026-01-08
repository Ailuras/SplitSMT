; CSV Processing: Validate comma-separated data fields with str_split operations
(set-logic ALL)

; Declare string variables for CSV data and fields
(declare-fun csv_data () String)
(declare-fun field0 () String)
(declare-fun field1 () String)
(declare-fun field2 () String)
(declare-fun field3 () String)
(declare-fun field4 () String)
(declare-fun field5 () String)
(declare-fun field6 () String)
(declare-fun field7 () String)
(declare-fun field8 () String)
(declare-fun field9 () String)
(declare-fun total_fields () Int)
(declare-fun empty_field_count () Int)
(declare-fun has_empty_fields () Bool)
(declare-fun valid_field_count () Bool)
(declare-fun all_fields_nonempty () Bool)

; Declare str_split interface functions
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; CSV data constraints
(assert (= csv_data "name,age,city,,salary,department,phone,email,status,notes"))
(assert (>= (str.len csv_data) 10))

; Split CSV data by comma delimiter
(assert (= total_fields (num_splits csv_data ",")))
(assert (= field0 (split_at csv_data "," 0)))
(assert (= field1 (split_at csv_data "," 1)))
(assert (= field2 (split_at csv_data "," 2)))
(assert (= field3 (split_at csv_data "," 3)))
(assert (= field4 (split_at csv_data "," 4)))
(assert (= field5 (split_at csv_data "," 5)))
(assert (= field6 (split_at csv_data "," 6)))
(assert (= field7 (split_at csv_data "," 7)))
(assert (= field8 (split_at csv_data "," 8)))
(assert (= field9 (split_at csv_data "," 9)))

; Field count validation
(assert (= valid_field_count (and (>= total_fields 8) (<= total_fields 10))))
(assert valid_field_count)

; Detect empty fields
(assert (= has_empty_fields (or (= field0 "") (= field1 "") (= field2 "") (= field3 "") (= field4 "") (= field5 "") (= field6 "") (= field7 "") (= field8 "") (= field9 ""))))
(assert has_empty_fields)

; Count empty fields
(assert (= empty_field_count (+ (ite (= field0 "") 1 0) (ite (= field1 "") 1 0) (ite (= field2 "") 1 0) (ite (= field3 "") 1 0) (ite (= field4 "") 1 0) (ite (= field5 "") 1 0) (ite (= field6 "") 1 0) (ite (= field7 "") 1 0) (ite (= field8 "") 1 0) (ite (= field9 "") 1 0))))
(assert (>= empty_field_count 1))
(assert (<= empty_field_count 3))

; Check if all fields are non-empty (should be false due to constraints above)
(assert (= all_fields_nonempty (and (not (= field0 "")) (not (= field1 "")) (not (= field2 "")) (not (= field3 "")) (not (= field4 "")) (not (= field5 "")) (not (= field6 "")) (not (= field7 "")) (not (= field8 "")) (not (= field9 "")))))
(assert (not all_fields_nonempty))

; Additional constraints on specific fields
(assert (>= (str.len field0) 2))  ; name field should have at least 2 characters
(assert (str.contains field1 "25"))  ; age field should contain "25"
(assert (str.contains field2 "York"))  ; city field should contain "York"
(assert (>= (str.len field4) 4))  ; salary field should have at least 4 characters
(assert (str.contains field5 "IT"))  ; department field should contain "IT"
(assert (str.contains field6 "555"))  ; phone field should contain "555"
(assert (str.contains field7 "@"))  ; email field should contain "@"
(assert (or (= field8 "active") (= field8 "inactive")))  ; status field must be either "active" or "inactive"
(assert (<= (str.len field9) 50))  ; notes field should not exceed 50 characters

; Verify split_rest functionality
(assert (= (split_rest csv_data "," 5) (str.++ field5 "," field6 "," field7 "," field8 "," field9)))
(assert (= (split_rest csv_data "," 0) csv_data))

; Ensure field indices are within bounds
(assert (>= total_fields 1))
(assert (forall ((i Int)) (=> (and (>= i 0) (< i total_fields)) (>= (str.len (split_at csv_data "," i)) 0))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(get-model)
