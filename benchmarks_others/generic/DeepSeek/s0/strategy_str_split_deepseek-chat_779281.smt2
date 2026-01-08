; CSV Processing Scenario: Validate field counts and detect empty fields using str_split interface
(set-logic ALL)

; Declare variables
(declare-const csv_line String)
(declare-const field_count Int)
(declare-const first_field String)
(declare-const last_field String)
(declare-const middle_field String)
(declare-const has_empty_field Bool)

; Declare str_split interface functions
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Assert CSV line has at least 3 fields
(assert (>= (num_splits csv_line ",") 3))

; Set field_count to actual number of fields
(assert (= field_count (num_splits csv_line ",")))

; Extract first field (index 0)
(assert (= first_field (split_at csv_line "," 0)))

; Extract last field (index field_count-1)
(assert (= last_field (split_at csv_line "," (- field_count 1))))

; Extract middle field (index 1) if exists
(assert (=> (>= field_count 2) (= middle_field (split_at csv_line "," 1))))

; Check if any field is empty (zero length)
(declare-const temp_field String)
(assert (or 
    (= (str.len first_field) 0)
    (and (>= field_count 2) (= (str.len middle_field) 0))
    (= (str.len last_field) 0)
    (exists ((i Int)) 
        (and 
            (>= i 2)
            (< i (- field_count 1))
            (= (str.len (split_at csv_line "," i)) 0)
        )
    )
))
(assert (= has_empty_field true))

; Additional constraint: first field must not be "ID"
(assert (not (= first_field "ID")))

; Constraint: last field must contain only digits
(assert (str.in_re last_field (re.+ (re.range "0" "9"))))

; Constraint: total length of CSV line less than 50 characters
(assert (< (str.len csv_line) 50))

; Make it SAT by allowing a valid example
(assert (str.contains csv_line ","))

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
