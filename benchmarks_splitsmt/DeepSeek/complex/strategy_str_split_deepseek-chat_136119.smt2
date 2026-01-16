; CSV Processing Scenario: Validate field counts and detect empty fields using str_split operations
(set-logic ALL)

; Declare variables for CSV data and delimiter
(declare-const csv_line String)
(declare-const delimiter String)
(declare-const field_count Int)
(declare-const empty_field_index Int)

; Define uninterpreted functions for str_split interface

; Assert that delimiter is a comma for CSV
(assert (= delimiter ","))

; Constraint 1: CSV line must have at least 3 fields
(assert (>= (str.num_splits csv_line delimiter) 3))

; Constraint 2: The second field (index 1) must be non-empty
(assert (> (str.len (str.split_at csv_line delimiter 1)) 0))

; Constraint 3: There exists an empty field at some index
(assert (exists ((i Int)) (and (>= i 0) (< i (str.num_splits csv_line delimiter)) (= (str.len (str.split_at csv_line delimiter i)) 0))))

; Constraint 4: The last field (index = field_count - 1) must not be empty
(assert (let ((last_index (- (str.num_splits csv_line delimiter) 1))) (> (str.len (str.split_at csv_line delimiter last_index)) 0)))

; Constraint 5: The total number of fields is exactly 5
(assert (= (str.num_splits csv_line delimiter) 5))

; Additional constraint to make it SAT: Provide a concrete example CSV line
(assert (= csv_line "apple,banana,,cherry,date"))

; Check satisfiability


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
