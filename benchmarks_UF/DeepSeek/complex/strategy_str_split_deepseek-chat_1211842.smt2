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

; Extract middle field (index 1) - second field
(assert (= middle_field (split_at csv_line "," 1)))

; Check if any field is empty (zero length)
(assert (= has_empty_field
    (or 
        (= (str.len first_field) 0)
        (= (str.len middle_field) 0)
        (= (str.len last_field) 0)
        ; Check remaining fields using split_rest
        (str.contains (split_rest csv_line "," 2) ",,")
    )))

; Additional constraints for diversity
; Ensure first field is not "ID" (example constraint)
(assert (not (= first_field "ID")))

; Ensure last field contains only digits
(assert (str.in_re last_field (re.+ (re.range "0" "9"))))

; Ensure middle field has at least 3 characters
(assert (>= (str.len middle_field) 3))

; Final check for satisfiability
(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
