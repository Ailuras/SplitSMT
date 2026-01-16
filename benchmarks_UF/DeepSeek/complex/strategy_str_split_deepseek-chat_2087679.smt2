; CSV Processing Scenario: Validate field counts and detect empty fields using str_split operations
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Declare variables for CSV data and delimiter
(declare-const csv_line String)
(declare-const delimiter String)
(declare-const field_count Int)
(declare-const has_empty_field Bool)

; Declare uninterpreted functions for str_split interface

; Assert delimiter is a comma
(assert (= delimiter ","))

; Constraint 1: CSV line must have at least 3 fields (e.g., for ID, Name, Age)
(assert (>= (num_splits csv_line delimiter) 3))

; Constraint 2: The second field (index 1) must not be empty (non-zero length)
(assert (> (str.len (split_at csv_line delimiter 1)) 0))

; Constraint 3: The last field (index field_count-1) must be numeric (all digits)
(assert (let ((last_field (split_at csv_line delimiter (- (num_splits csv_line delimiter) 1))))
    (forall ((i Int))
        (=> (and (>= i 0) (< i (str.len last_field)))
            (and (>= (str.to_code (str.at last_field i)) 48) (<= (str.to_code (str.at last_field i)) 57))
        )
    )
))

; Constraint 4: Define field_count as the number of splits
(assert (= field_count (num_splits csv_line delimiter)))

; Constraint 5: Define has_empty_field based on existence of any empty segment
(assert (= has_empty_field
    (exists ((k Int))
        (and (>= k 0) (< k field_count)
             (= (str.len (split_at csv_line delimiter k)) 0)
        )
    )
))

; Additional constraint to ensure CSV line is not empty and has valid structure
(assert (> (str.len csv_line) 0))
(assert (str.contains csv_line delimiter))

; Check satisfiability


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
