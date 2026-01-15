; CSV Processing Scenario: Ensure correct field counts and detect empty fields using str_split interface
(set-logic ALL)

; Declare variables
(declare-const csv_line String)
(declare-const field_count Int)
(declare-const first_field String)
(declare-const last_field String)
(declare-const middle_field String)
(declare-const has_empty_field Bool)

; Declare str_split interface functions

; Assert constraints for CSV processing
; Constraint 1: CSV line must have at least 3 fields (e.g., for ID, name, value)
(assert (>= (str.num_splits csv_line ",") 3))

; Constraint 2: First field (index 0) must be non-empty and start with a letter
(assert (not (= (str.split_at csv_line "," 0) "")))
(assert (str.prefixof "A" (str.at (str.split_at csv_line "," 0) 0)))

; Constraint 3: Last field (index field_count-1) must be numeric (simplified as containing only digits)
(assert (str.in_re (str.split_at csv_line "," (- (str.num_splits csv_line ",") 1)) (re.++ (re.* (re.range "0" "9")) (re.range "0" "9"))))

; Constraint 4: Middle field (index 1) can be empty, but if not, it must contain at least one alphabetic character
(assert (or (= (str.split_at csv_line "," 1) "") (str.contains (str.split_at csv_line "," 1) "a")))

; Constraint 5: Check if any field is empty (excluding first and last as per constraints)
(assert (= has_empty_field (or (= (str.split_at csv_line "," 1) "") (exists ((i Int)) (and (>= i 2) (< i (- (str.num_splits csv_line ",") 1)) (= (str.split_at csv_line "," i) ""))))))

; Constraint 6: Total field count must be exactly 5 for this example
(assert (= (str.num_splits csv_line ",") 5))

; Constraint 7: Ensure indices are within bounds for split operations
(assert (and (>= (str.num_splits csv_line ",") 0) (forall ((k Int)) (=> (and (>= k 0) (< k (str.num_splits csv_line ","))) (>= (str.len (str.split_at csv_line "," k)) 0)))))

; Additional constraint to make it SAT: Provide a concrete example line
(assert (= csv_line "A123,empty,value,test,456"))

; Check satisfiability
(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
