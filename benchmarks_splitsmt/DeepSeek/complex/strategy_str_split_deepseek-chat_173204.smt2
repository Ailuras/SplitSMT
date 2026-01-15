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

; Assert CSV line has at least 3 fields (comma-separated)
(assert (>= (str.num_splits csv_line ",") 3))

; Define field_count as total number of splits
(assert (= field_count (str.num_splits csv_line ",")))

; Extract first field (index 0)
(assert (= first_field (str.split_at csv_line "," 0)))

; Extract last field (index field_count-1)
(assert (= last_field (str.split_at csv_line "," (- field_count 1))))

; Extract middle field (index 1) for checking
(assert (= middle_field (str.split_at csv_line "," 1)))

; Check if any field is empty (zero length)
(assert (= has_empty_field
    (or (= (str.len first_field) 0)
        (= (str.len middle_field) 0)
        (= (str.len last_field) 0)
        (exists ((i Int))
            (and (>= i 2) (< i (- field_count 1))
                 (= (str.len (str.split_at csv_line "," i)) 0))))))

; Additional constraints for meaningful CSV processing
(assert (not (= csv_line ""))) ; CSV line cannot be empty
(assert (>= (str.len csv_line) 5)) ; Minimum reasonable length
(assert (str.contains csv_line ",")) ; Must contain at least one comma

; Constraint to make it SAT: ensure first field is non-empty
(assert (not (= (str.len first_field) 0)))

; Constraint to potentially make UNSAT: conflicting empty field requirements
; (assert (and has_empty_field (not has_empty_field))) ; Uncomment for UNSAT version

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
