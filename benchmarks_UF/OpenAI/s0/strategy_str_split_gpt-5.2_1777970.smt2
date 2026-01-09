(set-logic ALL)

; Uninterpreted interface functions for str_split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; =====================
; SAT instance: CSV processing with empty field detection
; =====================
(declare-const csv_line String)
(declare-const comma String)
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const rest_after_1 String)
(declare-const rest_after_2 String)
(declare-const n_fields Int)

(assert (= comma ","))

; Concrete CSV line exhibiting an empty middle field: "A,,C"
(assert (= csv_line "A,,C"))

; Field count and access
(assert (= n_fields (num_splits csv_line comma)))
(assert (= n_fields 3))
(assert (= field0 (split_at csv_line comma 0)))
(assert (= field1 (split_at csv_line comma 1)))
(assert (= field2 (split_at csv_line comma 2)))

; Rest-of-line views
(assert (= rest_after_1 (split_rest csv_line comma 1)))
(assert (= rest_after_2 (split_rest csv_line comma 2)))

; Indices are natural and in-range for this scenario
(assert (and (>= 0 0) (< 0 n_fields)))
(assert (and (>= 1 0) (< 1 n_fields)))
(assert (and (>= 2 0) (< 2 n_fields)))

; Empty field detection: field1 must be empty
(assert (= field0 "A"))
(assert (= field1 ""))
(assert (= field2 "C"))

; Additional sanity checks using generic string constraints
(assert (not (str.contains field0 comma)))
(assert (not (str.contains field1 comma)))
(assert (not (str.contains field2 comma)))
(assert (>= (str.len field0) 1))
(assert (= (str.len field1) 0))
(assert (>= (str.len field2) 1))

; Rest strings should be consistent with expected suffixes for this concrete line
(assert (= rest_after_1 ",C"))
(assert (= rest_after_2 "C"))

; =====================
; UNSAT instance: contradictory expectations on the same CSV line
; (kept in the same file by forcing both sets of constraints simultaneously)
; =====================
(declare-const csv_line_u String)
(declare-const u_field0 String)
(declare-const u_field1 String)
(declare-const u_field2 String)
(declare-const u_n_fields Int)

(assert (= csv_line_u "A,,C"))
(assert (= u_n_fields (num_splits csv_line_u comma)))
(assert (= u_n_fields 3))
(assert (= u_field0 (split_at csv_line_u comma 0)))
(assert (= u_field1 (split_at csv_line_u comma 1)))
(assert (= u_field2 (split_at csv_line_u comma 2)))

; Contradiction: the middle field is required to be both empty and non-empty
(assert (= u_field1 ""))
(assert (> (str.len u_field1) 0))

(check-sat)


; [GENERATION STATUS: SUCCESS]