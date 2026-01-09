(set-logic ALL)

; Uninterpreted functions for str_split interface

; Scenario: CSV Processing
; We model a CSV line split by "," and add constraints to enforce field counts and detect empty fields.

; ----------------------------
; SAT instance: well-formed CSV with at least 4 fields and a detected empty field
; ----------------------------
(declare-const csv_line_sat String)
(declare-const sat_f0 String)
(declare-const sat_f1 String)
(declare-const sat_f2 String)
(declare-const sat_f3 String)
(declare-const sat_tail_from2 String)

(assert (= sat_f0 (str.split_at csv_line_sat "," 0)))
(assert (= sat_f1 (str.split_at csv_line_sat "," 1)))
(assert (= sat_f2 (str.split_at csv_line_sat "," 2)))
(assert (= sat_f3 (str.split_at csv_line_sat "," 3)))
(assert (= sat_tail_from2 (str.split_rest csv_line_sat "," 2)))

; Require at least 4 segments/fields
(assert (>= (str.num_splits csv_line_sat ",") 4))

; Detect an empty field: field 1 is empty
(assert (= sat_f1 ""))

; Basic sanity constraints to keep indices natural and within plausible bounds
(assert (>= (str.num_splits csv_line_sat ",") 1))

; Add content constraints: first field is an ID-like number, third field contains a dash
(assert (str.in_re sat_f0 (re.+ (re.range "0" "9"))))
(assert (str.contains sat_f2 "-"))

; Also relate tail: tail_from2 must include field2 and field3 separated by comma when there are exactly 4 fields
; We do not force exactness, but if exactly 4 splits, then tail_from2 is f2,f3
(assert (=> (= (str.num_splits csv_line_sat ",") 4)
            (= sat_tail_from2 (str.++ sat_f2 "," sat_f3))))

; Avoid trivial empty whole line
(assert (>= (str.len csv_line_sat) 1))

; ----------------------------
; UNSAT instance: contradictory constraints about emptiness and numeric-only field
; ----------------------------
(declare-const csv_line_unsat String)
(declare-const uns_f0 String)
(declare-const uns_f1 String)
(declare-const uns_f2 String)

(assert (= uns_f0 (str.split_at csv_line_unsat "," 0)))
(assert (= uns_f1 (str.split_at csv_line_unsat "," 1)))
(assert (= uns_f2 (str.split_at csv_line_unsat "," 2)))

; Require exactly 3 fields
(assert (= (str.num_splits csv_line_unsat ",") 3))

; State that field0 is numeric-only and non-empty
(assert (str.in_re uns_f0 (re.+ (re.range "0" "9"))))

; Contradiction: also state field0 is empty
(assert (= uns_f0 ""))

; Additional constraints about empty field detection (irrelevant to core contradiction but CSV-related)
(assert (or (= uns_f1 "") (= uns_f2 "")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
