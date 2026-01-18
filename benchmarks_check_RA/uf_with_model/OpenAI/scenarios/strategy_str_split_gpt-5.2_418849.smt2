(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted interface for string split (CSV-like delimiter)

; ---------- Shared declarations ----------
(declare-const delim String)
(assert (= delim ","))

; ---------- SAT instance: valid CSV with exactly 4 fields and no empty fields ----------
(declare-const csv_line_ok String)
(declare-const f0_ok String)
(declare-const f1_ok String)
(declare-const f2_ok String)
(declare-const f3_ok String)

(assert (>= (num_splits csv_line_ok delim) 1))
(assert (= (num_splits csv_line_ok delim) 4))

(assert (= f0_ok (split_at csv_line_ok delim 0)))
(assert (= f1_ok (split_at csv_line_ok delim 1)))
(assert (= f2_ok (split_at csv_line_ok delim 2)))
(assert (= f3_ok (split_at csv_line_ok delim 3)))

; Detect empty fields: require all fields to be non-empty
(assert (> (str.len f0_ok) 0))
(assert (> (str.len f1_ok) 0))
(assert (> (str.len f2_ok) 0))
(assert (> (str.len f3_ok) 0))

; Simple format restriction: fields contain no commas
(assert (not (str.contains f0_ok delim)))
(assert (not (str.contains f1_ok delim)))
(assert (not (str.contains f2_ok delim)))
(assert (not (str.contains f3_ok delim)))

; Constrain one field to look like an integer (optional example)
(assert (str.in_re f2_ok (re.+ (re.range "0" "9"))))

; Reconstruct (partial) using split_rest: remainder after first field
(declare-const rest1_ok String)
(assert (= rest1_ok (split_rest csv_line_ok delim 1)))
(assert (str.contains rest1_ok delim))

(check-sat)
(get-model)
(exit)
