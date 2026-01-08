(set-logic ALL)

; Uninterpreted interface functions for string split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; =====================
; CSV Processing Scenario
; =====================

; A single CSV line and its delimiter
(declare-const csv_line String)
(declare-const delim String)
(assert (= delim ","))

; Extract some fields by index
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const rest_from3 String)

(assert (= field0 (split_at csv_line delim 0)))
(assert (= field1 (split_at csv_line delim 1)))
(assert (= field2 (split_at csv_line delim 2)))
(assert (= rest_from3 (split_rest csv_line delim 3)))

; Index domain constraints (natural indices)
(assert (and (>= 0 0) (>= 1 0) (>= 2 0) (>= 3 0)))

; ---------------------
; SAT instance: ensure correct field count and detect empty fields
; ---------------------

; Require exactly 4 fields (indices 0..3 exist)
(declare-const nfields Int)
(assert (= nfields (num_splits csv_line delim)))
(assert (= nfields 4))

; Constrain content patterns: IDs and numeric-like fields
; - field0: exactly 2 uppercase letters
; - field1: non-empty
; - field2: digits only (possibly empty allowed later, but here force non-empty)
(declare-const re_upper2 RegLan)
(declare-const re_digitplus RegLan)

(assert (= re_upper2 (re.++ (re.range "A" "Z") (re.range "A" "Z"))))
(assert (= re_digitplus (re.++ (re.+ (re.range "0" "9")) (re.* (re.range "0" "9")))))

(assert (str.in_re field0 re_upper2))
(assert (not (= field1 "")))
(assert (and (not (= field2 "")) (str.in_re field2 (re.+ (re.range "0" "9")))))

; Empty-field detection: enforce that the 4th field (index 3) is empty
(declare-const field3 String)
(assert (= field3 (split_at csv_line delim 3)))
(assert (= field3 ""))

; Ensure we actually have consecutive delimiters or trailing delimiter causing emptiness.
; Two common ways: ",," creates an empty middle field; trailing "," creates empty last field.
; Here we require last field empty, which implies the line ends with a comma in typical CSV.
; We approximate this by requiring csv_line ends with a comma.
(assert (str.suffixof "," csv_line))

; Also constrain earlier fields to avoid commas
(assert (not (str.contains field0 ",")))
(assert (not (str.contains field1 ",")))
(assert (not (str.contains field2 ",")))
(assert (not (str.contains field3 ",")))

; Provide one concrete witness to keep SAT grounded
(assert (= csv_line "AB,hello,123,"))

(check-sat)

; ---------------------
; UNSAT instance: contradictory requirements about empty fields / field count
; ---------------------

(push 1)

; Force still 4 fields, but also require last field to be non-empty while csv_line ends with comma
(assert (= (num_splits csv_line delim) 4))
(assert (str.suffixof "," csv_line))
(assert (not (= (split_at csv_line delim 3) "")))

(check-sat)

(pop 1)

; ---------------------
; SAT instance 2: detect an empty middle field via consecutive commas
; ---------------------

(push 1)

(declare-const csv_line2 String)
(declare-const f0_2 String)
(declare-const f1_2 String)
(declare-const f2_2 String)
(declare-const f3_2 String)

(assert (= f0_2 (split_at csv_line2 delim 0)))
(assert (= f1_2 (split_at csv_line2 delim 1)))
(assert (= f2_2 (split_at csv_line2 delim 2)))
(assert (= f3_2 (split_at csv_line2 delim 3)))

(assert (= (num_splits csv_line2 delim) 4))

; Empty middle field at index 1, others non-empty
(assert (not (= f0_2 "")))
(assert (= f1_2 ""))
(assert (not (= f2_2 "")))
(assert (not (= f3_2 "")))

; Approximate consecutive commas existence
(assert (str.contains csv_line2 ",,"))

; Concrete satisfying example
(assert (= csv_line2 "x,,y,z"))

(check-sat)

(pop 1)



; [GENERATION STATUS: SUCCESS]
(check-sat)
