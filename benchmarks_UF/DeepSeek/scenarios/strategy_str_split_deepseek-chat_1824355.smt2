; CSV Processing: Validate field counts and detect empty fields using str_split interface
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Declare variables for CSV data and delimiter
(declare-fun csv_data () String)
(declare-fun delimiter () String)
(declare-fun field_count () Int)
(declare-fun field2 () String)
(declare-fun field4 () String)
(declare-fun last_field () String)

; Define delimiter as comma
(assert (= delimiter ","))

; Constraint 1: CSV data must contain at least 5 fields
(assert (= field_count (num_splits csv_data delimiter)))
(assert (>= field_count 5))

; Constraint 2: Third field (index 2) must be non-empty
(assert (= field2 (split_at csv_data delimiter 2)))
(assert (not (= field2 "")))
(assert (>= (str.len field2) 1))

; Constraint 3: Fifth field (index 4) must be numeric (digits only)
(assert (= field4 (split_at csv_data delimiter 4)))
(assert (str.in_re field4 (re.+ (re.range "0" "9"))))

; Constraint 4: Last field must be "END"
(assert (= last_field (split_at csv_data delimiter (- field_count 1))))
(assert (= last_field "END"))

; Constraint 5: No two consecutive empty fields
(declare-fun i () Int)
(assert (>= i 0))
(assert (< i (- field_count 1)))
(assert (not (and (= (split_at csv_data delimiter i) "") (= (split_at csv_data delimiter (+ i 1)) ""))))

; Constraint 6: Total length of CSV data between 20 and 100 characters
(assert (>= (str.len csv_data) 20))
(assert (<= (str.len csv_data) 100))

; Constraint 7: CSV data must start with a letter and end with a digit
(assert (str.in_re (str.at csv_data 0) (re.union (re.range "A" "Z") (re.range "a" "z"))))
(assert (str.in_re (str.at csv_data (- (str.len csv_data) 1)) (re.range "0" "9")))

; Check satisfiability

; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
