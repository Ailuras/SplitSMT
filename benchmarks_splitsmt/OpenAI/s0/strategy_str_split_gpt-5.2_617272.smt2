(set-logic ALL)

; Uninterpreted functions for str_split interface

; =========================
; SAT instance: CSV line with exactly 4 fields, no empty fields
; =========================
(declare-const csv_line_ok String)
(declare-const delim String)
(declare-const f0_ok String)
(declare-const f1_ok String)
(declare-const f2_ok String)
(declare-const f3_ok String)

(assert (= delim ","))

; Must have exactly 4 fields
(assert (= (str.num_splits csv_line_ok delim) 4))

; Extract fields
(assert (= f0_ok (str.split_at csv_line_ok delim 0)))
(assert (= f1_ok (str.split_at csv_line_ok delim 1)))
(assert (= f2_ok (str.split_at csv_line_ok delim 2)))
(assert (= f3_ok (str.split_at csv_line_ok delim 3)))

; Indices are natural and within bounds (for the intended interface discipline)
(assert (and (>= 0 0) (< 0 (str.num_splits csv_line_ok delim))))
(assert (and (>= 1 0) (< 1 (str.num_splits csv_line_ok delim))))
(assert (and (>= 2 0) (< 2 (str.num_splits csv_line_ok delim))))
(assert (and (>= 3 0) (< 3 (str.num_splits csv_line_ok delim))))

; Detect and forbid empty fields
(assert (> (str.len f0_ok) 0))
(assert (> (str.len f1_ok) 0))
(assert (> (str.len f2_ok) 0))
(assert (> (str.len f3_ok) 0))

; Additional typical CSV sanity: line contains at least 3 delimiters
(assert (str.contains csv_line_ok delim))
(assert (str.contains (str.split_rest csv_line_ok delim 1) delim))
(assert (str.contains (str.split_rest csv_line_ok delim 2) delim))

; Example-oriented content constraints to keep it nontrivial
(assert (str.in_re f0_ok (re.+ (str.to_re "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"))))
(assert (str.in_re f1_ok (re.+ (re.union (str.to_re "0123456789") (str.to_re "-")))))
(assert (not (str.contains f2_ok ",")))
(assert (not (str.contains f3_ok ",")))

; =========================
; UNSAT instance: exactly 3 fields but middle field is forced both empty and non-empty
; =========================
(declare-const csv_line_bad String)
(declare-const g0 String)
(declare-const g1 String)
(declare-const g2 String)

(assert (= (str.num_splits csv_line_bad delim) 3))
(assert (= g0 (str.split_at csv_line_bad delim 0)))
(assert (= g1 (str.split_at csv_line_bad delim 1)))
(assert (= g2 (str.split_at csv_line_bad delim 2)))

; Force empty middle field
(assert (= g1 ""))

; Simultaneously require all fields to be non-empty (contradiction)
(assert (> (str.len g0) 0))
(assert (> (str.len g1) 0))
(assert (> (str.len g2) 0))

; Another CSV check: with 3 fields, splitting rest from 2 should be the last field (sanity-style)
(assert (= (str.split_rest csv_line_bad delim 2) g2))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
