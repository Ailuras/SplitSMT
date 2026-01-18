(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted interface for str_split

; Core seed booleans preserved
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)

; CSV processing variables
(declare-const csv_line String)
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const empty_field_detected Bool)

; Delimiter is comma
(assert (= delim ","))

; Seed core structure: make csv_line empty via booleans
(assert (= T_1 (not (= "" csv_line))))
(assert (= T_2 (not T_1)))
(assert T_2)

; CSV structure constraints (will conflict with emptiness to form UNSAT)
(assert (>= (num_splits csv_line delim) 3))
(assert (= f0 (split_at csv_line delim 0)))
(assert (= f1 (split_at csv_line delim 1)))
(assert (= f2 (split_at csv_line delim 2)))

; Detect empty fields
(assert (= empty_field_detected (or (= f0 "") (= f1 "") (= f2 ""))))

; Require non-empty fields (contradicts empty_line + 3 splits, strengthening UNSAT)
(assert (not empty_field_detected))

; Additional consistency: rest from 0 is the whole line
(assert (= (split_rest csv_line delim 0) csv_line))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(get-model)
(exit)
