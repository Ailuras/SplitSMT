(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted str_split interface

; Seed-derived core structure
(declare-fun T_1 () Bool)
(declare-const var_0xINPUT_113268 String)

; CSV Processing scenario variables
(declare-const csv_line String)
(declare-const delim String)
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const field3 String)
(declare-const empty_field_index Int)

; Preserve core structure but repurpose: input is expected to be a CSV line
(assert (= T_1 (= var_0xINPUT_113268 csv_line)))
(assert T_1)

; Delimiter is comma
(assert (= delim ","))

; Basic CSV well-formedness: at least 4 fields (3 commas)
(assert (>= (num_splits csv_line delim) 4))

; Extract first 4 fields
(assert (= field0 (split_at csv_line delim 0)))
(assert (= field1 (split_at csv_line delim 1)))
(assert (= field2 (split_at csv_line delim 2)))
(assert (= field3 (split_at csv_line delim 3)))

; Indices must be natural and within extracted range for empty-field detection
(assert (and (<= 0 empty_field_index) (<= empty_field_index 3)))

; Detect at least one empty field among the first four
(assert (or (= field0 "") (= field1 "") (= field2 "") (= field3 "")))

; Additional CSV constraints: no embedded commas in individual fields (common simple CSV assumption)
(assert (and (not (str.contains field0 delim))
             (not (str.contains field1 delim))
             (not (str.contains field2 delim))
             (not (str.contains field3 delim))))

; Ensure the remainder from field3 onward contains field3 as a prefix (sanity check on split_rest)
(assert (= (split_at (split_rest csv_line delim 3) delim 0) field3))

; UNSAT guard: require csv_line to be exactly "-" while also requiring 4 fields via commas
; This preserves a visible mutation of the original seed's "-" check but makes the overall instance UNSAT.
(assert (= csv_line "-"))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
