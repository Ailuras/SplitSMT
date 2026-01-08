; CSV Processing: Validate field counts and detect empty fields using str_split interface
(set-logic ALL)

; Declare string variables for CSV data and delimiter
(declare-const csv_data String)
(declare-const delimiter String)
(declare-const field_count Int)
(declare-const has_empty_fields Bool)

; Declare str_split interface functions
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Set delimiter to comma for CSV
(assert (= delimiter ","))

; Constraint 1: CSV data must contain at least 3 fields
(assert (>= (num_splits csv_data delimiter) 3))

; Constraint 2: First field must be non-empty
(assert (not (= (split_at csv_data delimiter 0) "")))

; Constraint 3: Third field must be numeric (contains only digits)
(assert (str.in_re (split_at csv_data delimiter 2) (re.+ (re.range "0" "9"))))

; Constraint 4: Check if any field is empty (excluding first and third)
(assert (= has_empty_fields
    (or 
        (= (split_at csv_data delimiter 1) "")
        (exists ((i Int))
            (and
                (>= i 3)
                (< i (num_splits csv_data delimiter))
                (= (split_at csv_data delimiter i) "")
            )
        )
    )
))

; Constraint 5: Total field count must be exactly 5
(assert (= field_count (num_splits csv_data delimiter)))
(assert (= field_count 5))

; Constraint 6: Last field must be "END"
(assert (= (split_at csv_data delimiter 4) "END"))

; Constraint 7: Concatenation of all fields with delimiter should reconstruct original data
(assert (= csv_data
    (str.++
        (split_at csv_data delimiter 0)
        delimiter
        (split_at csv_data delimiter 1)
        delimiter
        (split_at csv_data delimiter 2)
        delimiter
        (split_at csv_data delimiter 3)
        delimiter
        (split_at csv_data delimiter 4)
    )
))

; Additional constraint: Ensure delimiter appears exactly 4 times (for 5 fields)
(assert (= (- (str.len csv_data) (str.len (str.replace_all csv_data delimiter ""))) 4))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(get-model)