(set-logic ALL)

; Scenario: CSV Processing (comma-separated fields)

; Uninterpreted interface for splitting

; CSV input and some extracted fields
(declare-const csv String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const tail1 String)

; Basic CSV shape assumptions
(assert (>= (str.len csv) 0))
(assert (>= (str.num_splits csv ",") 1))

; Extract fields using str_split interface
(assert (= f0 (str.split_at csv "," 0)))
(assert (= f1 (str.split_at csv "," 1)))
(assert (= f2 (str.split_at csv "," 2)))
(assert (= tail1 (str.split_rest csv "," 1)))

; Expect exactly 3 fields
(assert (= (str.num_splits csv ",") 3))

; Detect empty fields: enforce field 1 is empty
(assert (= f1 ""))

; Field 0 must be non-empty and all digits
(assert (> (str.len f0) 0))
(assert (str.in_re f0 (re.+ (re.range "0" "9"))))

; Field 2 must be a signed integer with optional leading '+' or '-'
(assert (str.in_re f2 (re.++ (re.opt (re.union (str.to_re "+") (str.to_re "-"))) (re.+ (re.range "0" "9")))))

; Make sure there isn't a hidden extra comma in the rest after the first comma
(assert (not (str.contains tail1 ",")))

; Contradiction: with exactly 3 fields, tail1 is fields 1..end and must contain a comma between f1 and f2.
; This makes the instance UNSAT while preserving CSV-processing structure.
(assert (str.contains tail1 ","))

; Mutated seed-style constraint: forbid a numeric line ending with newline (\u{a}) in the whole CSV
(assert (not (str.in_re csv (re.++ (re.* (re.range "0" "9")) (re.opt (str.to_re ".")) (re.+ (re.range "0" "9")) (str.to_re "\u{a}")))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
