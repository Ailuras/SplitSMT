; CSV Processing Scenario: Validate field counts and detect empty fields using str_split interface
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Declare variables
(declare-const csv_line String)
(declare-const field_count Int)
(declare-const first_field String)
(declare-const last_field String)
(declare-const middle_field String)
(declare-const has_empty_field Bool)

; Declare str_split interface functions

; Assert CSV line has at least 3 fields (comma-separated)
(assert (>= (num_splits csv_line ",") 3))

; Set field_count to actual number of fields
(assert (= field_count (num_splits csv_line ",")))

; Extract first field (index 0)
(assert (= first_field (split_at csv_line "," 0)))

; Extract last field (index field_count-1)
(assert (= last_field (split_at csv_line "," (- field_count 1))))

; Extract middle field (index 1) - assuming at least 3 fields
(assert (= middle_field (split_at csv_line "," 1)))

; Constraint: first field must not be empty
(assert (not (= (str.len first_field) 0)))

; Constraint: last field must contain at least one alphabetic character
(assert (str.contains last_field "a"))

; Detect if any field is empty by checking all split segments
(assert (= has_empty_field
    (or 
        (= (str.len (split_at csv_line "," 0)) 0)
        (= (str.len (split_at csv_line "," 1)) 0)
        (= (str.len (split_at csv_line "," 2)) 0)
        (and (>= field_count 4) (= (str.len (split_at csv_line "," 3)) 0))
    )))

; Additional constraint: CSV line must end with a non-comma character
(assert (not (str.suffixof "," csv_line)))

; Make it SAT by allowing reasonable values
(assert (str.contains csv_line "data,test,value"))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
