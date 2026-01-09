(set-logic ALL)

; Uninterpreted interface operations for str_split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; ------------------------------
; SAT instance: CSV row processing
; ------------------------------
(declare-const csv_row String)
(declare-const delim String)
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const field3 String)
(declare-const rest2 String)
(declare-const total_fields Int)
(declare-const empty_count Int)
(declare-const row_len Int)

(assert (= delim ","))
(assert (= total_fields (num_splits csv_row delim)))
(assert (= row_len (str.len csv_row)))
(assert (>= row_len 0))

; Expect exactly 4 CSV fields
(assert (= total_fields 4))

; Extract fields by index
(assert (= field0 (split_at csv_row delim 0)))
(assert (= field1 (split_at csv_row delim 1)))
(assert (= field2 (split_at csv_row delim 2)))
(assert (= field3 (split_at csv_row delim 3)))

; Remainder from index 2: should equal field2,comma,field3
(assert (= rest2 (split_rest csv_row delim 2)))
(assert (= rest2 (str.++ field2 delim field3)))

; Detect empty fields and count them (0..4)
(assert (>= empty_count 0))
(assert (<= empty_count 4))
(assert (= empty_count
  (+ (ite (= field0 "") 1 0)
     (ite (= field1 "") 1 0)
     (ite (= field2 "") 1 0)
     (ite (= field3 "") 1 0))))

; Require at least one empty field but not all fields empty
(assert (>= empty_count 1))
(assert (<= empty_count 3))

; Basic sanity: no field contains the delimiter character
(assert (not (str.contains field0 delim)))
(assert (not (str.contains field1 delim)))
(assert (not (str.contains field2 delim)))
(assert (not (str.contains field3 delim)))

; Construct a witness-like relationship for csv_row
(assert (= csv_row (str.++ field0 delim field1 delim field2 delim field3)))

; Additional diversity constraints
(assert (>= (str.len field0) 0))
(assert (>= (str.len field1) 0))
(assert (>= (str.len field2) 0))
(assert (>= (str.len field3) 0))

; Ensure at least one non-empty field has length >= 2
(assert (or (>= (str.len field0) 2)
            (>= (str.len field1) 2)
            (>= (str.len field2) 2)
            (>= (str.len field3) 2)))

(check-sat)

; ------------------------------
; UNSAT instance: contradictory CSV constraints
; Uses fresh variables to avoid interaction with the SAT instance.
; ------------------------------
(push 1)
(declare-const bad_row String)
(declare-const bad_delim String)
(declare-const bad_total Int)
(declare-const b0 String)
(declare-const b1 String)
(declare-const b2 String)
(declare-const b3 String)

(assert (= bad_delim ","))
(assert (= bad_total (num_splits bad_row bad_delim)))

; Contradiction: claim exactly 4 fields, but also require 5 fields
(assert (= bad_total 4))
(assert (= bad_total 5))

; Still provide some structural constraints (won't matter due to contradiction)
(assert (= b0 (split_at bad_row bad_delim 0)))
(assert (= b1 (split_at bad_row bad_delim 1)))
(assert (= b2 (split_at bad_row bad_delim 2)))
(assert (= b3 (split_at bad_row bad_delim 3)))
(assert (= bad_row (str.++ b0 bad_delim b1 bad_delim b2 bad_delim b3)))

(check-sat)
(pop 1)



; [GENERATION STATUS: SUCCESS]
(check-sat)