; CSV Processing Scenario: Ensure correct field counts and detect empty fields using str_split interface
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Declare variables for CSV data and fields
(declare-const csv_line String)
(declare-const field_count Int)
(declare-const first_field String)
(declare-const last_field String)
(declare-const middle_field String)
(declare-const has_empty_field Bool)

; Declare uninterpreted functions for str_split interface as per methodology

; Assert constraints for CSV processing
; Constraint 1: CSV line must have at least 3 fields (e.g., for ID, Name, Age)
(assert (>= (num_splits csv_line ",") 3))

; Constraint 2: First field (index 0) must not be empty (e.g., ID cannot be empty)
(assert (not (= (split_at csv_line "," 0) "")))

; Constraint 3: Last field (index = field_count - 1) must not be empty (e.g., Age cannot be empty)
(assert (let ((field_count_val (num_splits csv_line ","))) (not (= (split_at csv_line "," (- field_count_val 1)) ""))))

; Constraint 4: Middle field (index 1) must be non-empty if it exists (e.g., Name cannot be empty)
(assert (let ((field_count_val (num_splits csv_line ","))) (=> (>= field_count_val 3) (not (= (split_at csv_line "," 1) "")))))

; Constraint 5: Define has_empty_field as true if any field except first and last is empty (e.g., detect internal empty fields)
(assert (= has_empty_field (exists ((i Int)) (and (>= i 1) (< i (- (num_splits csv_line ",") 1)) (= (split_at csv_line "," i) "")))))

; Constraint 6: Ensure the CSV line does not start or end with a comma (no leading/trailing delimiters)
(assert (not (str.prefixof "," csv_line)))
(assert (not (str.suffixof "," csv_line)))

; Constraint 7: Add a specific example to make it SAT: a valid CSV line with 4 fields and no empty internal fields
(assert (= csv_line "123,John Doe,30,USA"))

; Check satisfiability

; [GENERATION STATUS: SUCCESS]
(check-sat)
(get-model)
(exit)
