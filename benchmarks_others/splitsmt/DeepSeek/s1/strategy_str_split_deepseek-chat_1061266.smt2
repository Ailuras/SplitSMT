; CSV Processing: Validate field counts and detect empty fields using str_split operations
(set-logic ALL)

; Declare variables for CSV data and delimiter
(declare-const csv_data String)
(declare-const delimiter String)
(declare-const field_count Int)
(declare-const first_field String)
(declare-const last_field String)
(declare-const middle_field String)
(declare-const has_empty_field Bool)

; Set delimiter to comma for CSV
(assert (= delimiter ","))

; Constraint 1: CSV data must contain at least 3 fields
(assert (>= (str.num_splits csv_data delimiter) 3))

; Constraint 2: First field must be non-empty (length > 0)
(assert (= first_field (str.split_at csv_data delimiter 0)))
(assert (> (str.len first_field) 0))

; Constraint 3: Last field must be non-empty
(assert (= last_field (str.split_at csv_data delimiter (- (str.num_splits csv_data delimiter) 1))))
(assert (> (str.len last_field) 0))

; Constraint 4: Middle field (second field) must be either empty or contain only digits
(assert (= middle_field (str.split_at csv_data delimiter 1)))
(assert (or 
    (= (str.len middle_field) 0) 
    (str.in_re middle_field (re.+ (re.range "0" "9")))
))

; Constraint 5: Detect if any field is empty (excluding first and last which are already constrained)
(declare-fun is_empty_field (String) Bool)
(assert (forall ((s String)) (= (is_empty_field s) (= (str.len s) 0))))
(assert (= has_empty_field (or 
    (is_empty_field (str.split_at csv_data delimiter 1))
    (exists ((i Int)) 
        (and 
            (>= i 2) 
            (< i (- (str.num_splits csv_data delimiter) 1)) 
            (is_empty_field (str.split_at csv_data delimiter i))
        )
    )
)))

; Constraint 6: Total field count must be between 3 and 10
(assert (= field_count (str.num_splits csv_data delimiter)))
(assert (and (>= field_count 3) (<= field_count 10)))

; Constraint 7: All fields must be alphanumeric (letters or digits) if non-empty
(assert (forall ((i Int)) 
    (=> 
        (and (>= i 0) (< i field_count))
        (let ((field (str.split_at csv_data delimiter i)))
            (=> 
                (> (str.len field) 0)
                (str.in_re field (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9"))))
            )
        )
    )
))

; Constraint 8: No consecutive empty fields
(assert (forall ((i Int)) 
    (=> 
        (and (>= i 0) (< i (- field_count 1)))
        (not (and 
            (= (str.len (str.split_at csv_data delimiter i)) 0)
            (= (str.len (str.split_at csv_data delimiter (+ i 1))) 0)
        ))
    )
))

; Constraint 9: The concatenation of all fields with delimiter should equal the original CSV data
(assert (= csv_data (str.++ 
    (str.split_at csv_data delimiter 0)
    (let loop ((i 1)) 
        (if (< i field_count)
            (str.++ delimiter (str.split_at csv_data delimiter i) (loop (+ i 1)))
            ""
        )
    )
)))

; Check satisfiability
(check-sat)


; [GENERATION STATUS: SUCCESS]
(get-model)
