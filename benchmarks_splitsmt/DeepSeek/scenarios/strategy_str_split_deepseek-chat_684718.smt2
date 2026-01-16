; CSV Processing: Ensure correct field counts and detect empty fields using str_split operations
(set-logic ALL)

; Declare variables for CSV data and delimiter
(declare-const csv_line String)
(declare-const delimiter String)
(declare-const field_count Int)
(declare-const first_field String)
(declare-const last_field String)
(declare-const middle_field String)
(declare-const has_empty_field Bool)

; Set delimiter to comma for CSV
(assert (= delimiter ","))

; Constraint 1: CSV line must contain at least 3 fields
(assert (>= (str.num_splits csv_line delimiter) 3))

; Constraint 2: First field is non-empty (e.g., cannot be empty string)
(assert (not (= (str.split_at csv_line delimiter 0) "")))

; Constraint 3: Last field is non-empty
(assert (not (= (str.split_at csv_line delimiter (- (str.num_splits csv_line delimiter) 1)) "")))

; Constraint 4: Middle field (second field) must be numeric (digits only) and non-empty
(assert (str.in_re (str.split_at csv_line delimiter 1) (re.+ (re.range "0" "9"))))

; Constraint 5: Detect if any field is empty (excluding first and last as they are already constrained)
(assert (= has_empty_field
    (exists ((i Int))
        (and
            (>= i 2)
            (< i (- (str.num_splits csv_line delimiter) 1))
            (= (str.split_at csv_line delimiter i) "")
        )
    )
))

; Constraint 6: Total field count is exactly 5
(assert (= (str.num_splits csv_line delimiter) 5))

; Constraint 7: All fields concatenated with delimiter should reconstruct the original line (consistency check)
(assert (= csv_line
    (str.++
        (str.split_at csv_line delimiter 0)
        delimiter
        (str.split_at csv_line delimiter 1)
        delimiter
        (str.split_at csv_line delimiter 2)
        delimiter
        (str.split_at csv_line delimiter 3)
        delimiter
        (str.split_at csv_line delimiter 4)
    )
))

; Constraint 8: Ensure no extra delimiters at start or end (first and last fields are not empty)
(assert (not (str.prefixof delimiter csv_line)))
(assert (not (str.suffixof delimiter csv_line)))

; Check satisfiability

; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
