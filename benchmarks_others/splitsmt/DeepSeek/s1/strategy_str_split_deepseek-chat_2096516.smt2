; CSV Processing: Validate field counts and detect empty fields using str_split interface
(set-logic ALL)
; Declare variables
(declare-const csv_line String)
(declare-const field_count Int)
(declare-const first_field String)
(declare-const last_field String)
(declare-const middle_field String)
; Declare str_split interface functions
; Constraint 1: CSV line must contain at least 3 fields
(assert (>= (str.num_splits csv_line ",") 3))
; Constraint 2: First field must be non-empty
(assert (> (str.len (str.split_at csv_line "," 0)) 0))
; Constraint 3: Last field must be non-empty
(assert (> (str.len (str.split_at csv_line "," (- (str.num_splits csv_line ",") 1))) 0))
; Constraint 4: Middle field (index 1) must be empty to detect missing data
(assert (= (str.len (str.split_at csv_line "," 1)) 0))
; Constraint 5: Total field count must be exactly 5
(assert (= (str.num_splits csv_line ",") 5))
; Constraint 6: The concatenation of all fields from index 2 onwards must contain "data"
(assert (str.contains (str.split_rest csv_line "," 2) "data"))
; Constraint 7: CSV line must start with "ID" and end with "END"
(assert (str.prefixof "ID" csv_line))
(assert (str.suffixof "END" csv_line))
; Constraint 8: Ensure no extra commas at start or end (trimming effect)
(assert (not (str.prefixof "," csv_line)))
(assert (not (str.suffixof "," csv_line)))
; Constraint 9: Field count must be between 3 and 10 (redundant with Constraint 5, but adds complexity)
(assert (and (>= field_count 3) (<= field_count 10)))
(assert (= field_count (str.num_splits csv_line ",")))
; Constraint 10: First and last fields must be different
(assert (not (= (str.split_at csv_line "," 0) (str.split_at csv_line "," (- (str.num_splits csv_line ",") 1)))))
(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
