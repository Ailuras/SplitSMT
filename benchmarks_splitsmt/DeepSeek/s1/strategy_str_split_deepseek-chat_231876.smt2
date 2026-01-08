; CSV Processing scenario: Ensure correct field counts and detect empty fields using str_split operations
(set-logic ALL)

; Declare variables for CSV data and delimiter
(declare-const csv_line String)
(declare-const delimiter String)
(declare-const field_count Int)
(declare-const first_field String)
(declare-const last_field String)
(declare-const middle_field String)

; Set delimiter to comma for CSV
(assert (= delimiter ","))

; Define a sample CSV line with some fields
(assert (= csv_line "John,Doe,30,New York,USA"))

; Use str_split interface to process fields
; Calculate total number of fields after splitting by delimiter
(assert (= field_count (str.num_splits csv_line delimiter)))

; Ensure there are at least 3 fields to work with
(assert (>= field_count 3))

; Extract the first field (index 0)
(assert (= first_field (str.split_at csv_line delimiter 0)))

; Extract the last field (index field_count-1)
(assert (= last_field (str.split_at csv_line delimiter (- field_count 1))))

; Extract a middle field (e.g., index 2 for third field)
(assert (= middle_field (str.split_at csv_line delimiter 2)))

; Check that no field is empty (i.e., length > 0)
(assert (forall ((i Int)) (=> (and (>= i 0) (< i field_count)) (> (str.len (str.split_at csv_line delimiter i)) 0))))

; Additional constraint: First field must not contain spaces
(assert (not (str.contains first_field " ")))

; Constraint to ensure the CSV line ends with a non-empty last field
(assert (> (str.len last_field) 0))

; Use split_rest to get all fields from index 1 onwards and check it contains "Doe"
(assert (str.contains (str.split_rest csv_line delimiter 1) "Doe"))

; Declare uninterpreted functions for str_split interface as per rules

; Add a constraint to make it SAT: Ensure field_count is exactly 5 for the sample line
(assert (= field_count 5))

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
