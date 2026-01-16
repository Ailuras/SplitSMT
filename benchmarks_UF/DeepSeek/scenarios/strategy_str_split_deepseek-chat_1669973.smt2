; CSV Processing: Validate field counts and detect empty fields using str_split operations
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
(declare-const all_fields_nonempty Bool)

; Declare str_split interface functions

; Core CSV constraints
; Constraint 1: CSV line must contain at least 3 fields
(assert (>= (num_splits csv_line ",") 3))

; Constraint 2: First field must be non-empty
(assert (not (= (split_at csv_line "," 0) "")))

; Constraint 3: Last field must be non-empty
(assert (not (= (split_at csv_line "," (- (num_splits csv_line ",") 1)) "")))

; Constraint 4: Middle field (second field) must contain the substring "ID"
(assert (str.contains (split_at csv_line "," 1) "ID"))

; Constraint 5: Check if any field is empty (excluding first and last which are already constrained)
(assert (= has_empty_field
    (exists ((i Int))
        (and
            (>= i 2)
            (< i (- (num_splits csv_line ",") 1))
            (= (split_at csv_line "," i) "")
        )
    )
))

; Constraint 6: All fields must be non-empty (contradicts Constraint 5 to create UNSAT potential)
(assert (= all_fields_nonempty
    (forall ((j Int))
        (=>
            (and (>= j 0) (< j (num_splits csv_line ",")))
            (not (= (split_at csv_line "," j) ""))
        )
    )
))

; Constraint 7: Total field count must be exactly 5
(assert (= (num_splits csv_line ",") 5))

; Constraint 8: The concatenation of all fields (excluding delimiters) must equal the original line
; This is a tautology by definition of split_at, but included for completeness
(assert (= csv_line
    (str.++
        (split_at csv_line "," 0)
        ","
        (split_at csv_line "," 1)
        ","
        (split_at csv_line "," 2)
        ","
        (split_at csv_line "," 3)
        ","
        (split_at csv_line "," 4)
    )
))

; Constraint 9: The third field must be numeric (only digits)
(assert (str.in_re (split_at csv_line "," 2) (re.* (re.range "0" "9"))))

; Constraint 10: The line must not start or end with a comma
(assert (not (str.prefixof "," csv_line)))
(assert (not (str.suffixof "," csv_line)))

; Final check


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
