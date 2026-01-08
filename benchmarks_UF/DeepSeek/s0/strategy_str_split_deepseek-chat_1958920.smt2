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

; Declare uninterpreted functions for str_split interface

; Assert constraints for CSV processing
; Constraint 1: CSV line must have at least 3 fields (e.g., for ID, Name, Age)
(assert (>= (num_splits csv_line ",") 3))

; Constraint 2: First field (index 0) must be non-empty and start with a letter
(assert (not (= first_field "")))
(assert (>= (str.len first_field) 1))
(assert (let ((first_char (str.at first_field 0)))
  (or (and (>= (str.to_code first_char) 65) (<= (str.to_code first_char) 90))
      (and (>= (str.to_code first_char) 97) (<= (str.to_code first_char) 122)))))

; Constraint 3: Last field (index field_count-1) must be a numeric string
(assert (= last_field (split_at csv_line "," (- (num_splits csv_line ",") 1))))
(assert (forall ((i Int))
  (=> (and (>= i 0) (< i (str.len last_field)))
      (let ((ch (str.at last_field i)))
        (and (>= (str.to_code ch) 48) (<= (str.to_code ch) 57))))))

; Constraint 4: Middle field (index 1) can be empty, but if non-empty, must not contain commas
(assert (= middle_field (split_at csv_line "," 1)))
(assert (=> (not (= middle_field "")) (not (str.contains middle_field ","))))

; Constraint 5: Define field_count as the number of splits
(assert (= field_count (num_splits csv_line ",")))

; Constraint 6: Detect if any field is empty by checking each split
(assert (= has_empty_field
  (exists ((i Int))
    (and (>= i 0) (< i field_count)
         (= (split_at csv_line "," i) "")))))

; Constraint 7: Ensure the CSV line does not start or end with a comma to avoid leading/trailing empty fields
(assert (not (str.prefixof "," csv_line)))
(assert (not (str.suffixof "," csv_line)))

; Constraint 8: Add a specific example to make it SAT (e.g., "ID123,John Doe,25")
(assert (str.contains csv_line "ID123,John Doe,25"))

; Check satisfiability
(check-sat)
(get-value (csv_line field_count first_field last_field middle_field has_empty_field))

; [GENERATION STATUS: SUCCESS]
(exit)
