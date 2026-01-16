(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted interface operations for string splitting

; =====================
; Scenario: CSV Processing
; Goal: process comma-separated fields, enforce field counts, and detect empty fields
; Includes both SAT and UNSAT instances in one file using push/pop
; =====================

(declare-const csv_line String)
(declare-const delim String)
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const field3 String)
(declare-const field4 String)
(declare-const rest2 String)
(declare-const rest3 String)
(declare-const nfields Int)
(declare-const idx_empty Int)

(assert (= delim ","))

; Basic well-formedness and derived bindings
(assert (= nfields (num_splits csv_line delim)))
(assert (>= nfields 1))

(assert (= field0 (split_at csv_line delim 0)))
(assert (= field1 (split_at csv_line delim 1)))
(assert (= field2 (split_at csv_line delim 2)))
(assert (= field3 (split_at csv_line delim 3)))
(assert (= field4 (split_at csv_line delim 4)))

(assert (= rest2 (split_rest csv_line delim 2)))
(assert (= rest3 (split_rest csv_line delim 3)))

; Index for an empty field witness
(assert (>= idx_empty 0))
(assert (< idx_empty nfields))

; ---------------------
; SAT instance: exactly 4 fields, detect at least one empty field, and enforce simple content constraints
; ---------------------

(assert (= nfields 4))

; Example-style CSV: name,age,city,country (but allow empties)
; Require first field non-empty and not containing comma
(assert (> (str.len field0) 0))
(assert (not (str.contains field0 delim)))

; Constrain second field to be digits or empty (using regex)
(assert (str.in_re field1 (re.union (str.to_re "") (re.+ (re.range "0" "9")))))

; Constrain third and fourth fields to be alphabetic or empty
(assert (str.in_re field2 (re.union (str.to_re "") (re.+ (re.union (re.range "a" "z") (re.range "A" "Z"))))))
(assert (str.in_re field3 (re.union (str.to_re "") (re.+ (re.union (re.range "a" "z") (re.range "A" "Z"))))))

; Detect existence of an empty field among the 4
(assert (or (and (= idx_empty 0) (= field0 ""))
            (and (= idx_empty 1) (= field1 ""))
            (and (= idx_empty 2) (= field2 ""))
            (and (= idx_empty 3) (= field3 ""))))

; Additional structural constraint: if field2 is empty, then rest2 starts with comma ("",field3)
(assert (=> (= field2 "") (str.prefixof "," rest2)))

(check-sat)
(exit)
