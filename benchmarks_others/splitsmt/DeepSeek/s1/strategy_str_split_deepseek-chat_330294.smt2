; CSV Processing: Validate field counts and detect empty fields using str_split operations
(set-logic ALL)

; Declare variables
(declare-const csv_line String)
(declare-const field_count Int)
(declare-const first_field String)
(declare-const last_field String)
(declare-const has_empty_field Bool)
(declare-const is_valid Bool)

; Declare str_split interface functions

; CSV line example: "name,age,city,,"
(assert (= csv_line "John,25,New York,,"))

; Calculate number of fields when splitting by comma
(assert (= field_count (str.num_splits csv_line ",")))

; Extract first field
(assert (= first_field (str.split_at csv_line "," 0)))

; Extract last field (index field_count-1)
(assert (= last_field (str.split_at csv_line "," (- field_count 1))))

; Check if any field is empty by examining each segment
; We'll check if first or last field is empty as a proxy for simplicity
(assert (= has_empty_field (or (= (str.len first_field) 0) (= (str.len last_field) 0))))

; Define validity: must have at least 3 fields and no empty fields
(assert (= is_valid (and (>= field_count 3) (not has_empty_field))))

; Add contradictory constraint to make it UNSAT: require valid but force empty last field
(assert is_valid)
(assert (= (str.len last_field) 0))

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
