; CSV Processing: Ensure correct field counts and detect empty fields using str_split interface
(set-logic ALL)

; Declare variables
(declare-const csv_line String)
(declare-const field_count Int)
(declare-const first_field String)
(declare-const last_field String)
(declare-const middle_field String)

; Declare str_split interface functions
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Assert constraints for CSV processing
; Constraint 1: CSV line must have exactly 5 fields (comma-separated)
(assert (= (num_splits csv_line ",") 5))

; Constraint 2: First field must be non-empty (length > 0)
(assert (= first_field (split_at csv_line "," 0)))
(assert (> (str.len first_field) 0))

; Constraint 3: Last field must be non-empty
(assert (= last_field (split_at csv_line "," 4)))
(assert (> (str.len last_field) 0))

; Constraint 4: Third field (index 2) must be empty (detect empty field)
(assert (= middle_field (split_at csv_line "," 2)))
(assert (= (str.len middle_field) 0))

; Constraint 5: The concatenation of all fields after the first should equal the original line without first field
(assert (= (split_rest csv_line "," 1) (str.substr csv_line (+ (str.len first_field) 1) (- (str.len csv_line) (+ (str.len first_field) 1)))))

; Additional constraint: Ensure field count variable matches actual splits
(assert (= field_count (num_splits csv_line ",")))

; Check satisfiability
(check-sat)


; [GENERATION STATUS: SUCCESS]
(get-model)
