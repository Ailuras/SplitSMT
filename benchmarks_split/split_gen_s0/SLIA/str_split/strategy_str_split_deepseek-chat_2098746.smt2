; CSV Processing Scenario: Validate field counts and detect empty fields using str_split interface
(set-logic ALL)

; Declare variables for CSV data and delimiter
(declare-const csv_data String)
(declare-const delimiter String)
(declare-const field_count Int)
(declare-const first_field String)
(declare-const last_field String)
(declare-const middle_fields String)

; Define uninterpreted functions for str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Assert delimiter is a comma
(assert (= delimiter ","))

; Constraint 1: CSV data must have at least 3 fields
(assert (>= (num_splits csv_data delimiter) 3))

; Constraint 2: First field is non-empty (length > 0)
(assert (= first_field (split_at csv_data delimiter 0)))
(assert (> (str.len first_field) 0))

; Constraint 3: Last field is non-empty
(assert (= last_field (split_at csv_data delimiter (- (num_splits csv_data delimiter) 1))))
(assert (> (str.len last_field) 0))

; Constraint 4: Middle fields (from index 1 to second-last) concatenated must contain at least one non-comma character
(assert (= middle_fields (split_rest csv_data delimiter 1)))
(assert (str.contains middle_fields "A")) ; Example: ensure some content by requiring a specific character

; Constraint 5: Total field count is exactly 5 (for SAT instance) or 2 (for UNSAT instance)
; Uncomment one of the following lines to switch between SAT and UNSAT:
(assert (= (num_splits csv_data delimiter) 5)) ; SAT instance: field count is 5
; (assert (= (num_splits csv_data delimiter) 2)) ; UNSAT instance: field count is 2 (contradicts >=3 constraint)

; Additional constraint: CSV data does not start or end with delimiter to avoid empty fields at edges
(assert (not (str.prefixof delimiter csv_data)))
(assert (not (str.suffixof delimiter csv_data)))

; Check satisfiability
(check-sat)
(get-model)

; [GENERATION STATUS: SUCCESS]