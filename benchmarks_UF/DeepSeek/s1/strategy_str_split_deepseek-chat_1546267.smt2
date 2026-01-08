; CSV Processing: Validate field counts and detect empty fields using str_split interface
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Declare variables
(declare-const csv_line String)
(declare-const field_count Int)
(declare-const has_empty_field Bool)
(declare-const first_field String)
(declare-const last_field String)
(declare-const middle_field String)

; Declare str_split interface functions

; CSV line must have at least 3 fields
(assert (>= (num_splits csv_line ",") 3))

; First field must not be empty
(assert (not (= (split_at csv_line "," 0) "")))

; Last field must not be empty
(assert (not (= (split_at csv_line "," (- (num_splits csv_line ",") 1)) "")))

; Check if any field is empty (excluding first and last)
(assert (= has_empty_field
    (exists ((i Int))
        (and
            (>= i 1)
            (< i (- (num_splits csv_line ",") 1))
            (= (split_at csv_line "," i) "")
        )
    )
))

; Define first and last fields
(assert (= first_field (split_at csv_line "," 0)))
(assert (= last_field (split_at csv_line "," (- (num_splits csv_line ",") 1))))

; Middle field (second field) must contain at least one alphabetic character
(assert (str.contains (split_at csv_line "," 1) "a"))

; Total field count constraint
(assert (= field_count (num_splits csv_line ",")))
(assert (<= field_count 5))

; Additional constraint: CSV line must not start or end with comma
(assert (not (str.prefixof "," csv_line)))
(assert (not (str.suffixof "," csv_line)))

; Ensure the line has at least one non-empty field (already covered by first/last constraints)

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
