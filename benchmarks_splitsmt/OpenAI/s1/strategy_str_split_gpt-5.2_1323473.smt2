(set-logic ALL)

; CSV Processing scenario: comma-separated fields, field count checks, and empty-field detection

; --- str_split interface (uninterpreted) ---

; --- Inputs ---
(declare-const csv_line String)
(declare-const delim String)

; --- Derived fields ---
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)
(declare-const rest1 String)
(declare-const rest2 String)

; --- Core structure adapted from seed: keep a regex constraint but repurpose it to CSV ---
; Constraint: csv_line must be composed of characters from a limited alphabet (digits, letters, commas, spaces)
(assert (str.in_re csv_line (re.* (re.union (re.range "0" "9") (re.range "a" "z") (re.range "A" "Z") (str.to_re ",") (str.to_re " ")))))

; Delimiter is comma
(assert (= delim ","))

; Minimum of 4 fields (i.e., at least 3 commas); allow more fields but we will reason about first 4
(assert (>= (str.num_splits csv_line delim) 4))

; Link fields via split_at/split_rest
(assert (= f0 (str.split_at csv_line delim 0)))
(assert (= f1 (str.split_at csv_line delim 1)))
(assert (= f2 (str.split_at csv_line delim 2)))
(assert (= f3 (str.split_at csv_line delim 3)))
(assert (= rest1 (str.split_rest csv_line delim 1)))
(assert (= rest2 (str.split_rest csv_line delim 2)))

; Detect empty fields: enforce at least one empty among the first four
(assert (or (= f0 "") (= f1 "") (= f2 "") (= f3 "")))

; Also enforce at least one non-empty field to avoid the trivial all-empty case
(assert (or (not (= f0 "")) (not (= f1 "")) (not (= f2 "")) (not (= f3 ""))))

; Some sanity/shape constraints
(assert (>= (str.len rest1) 0))
(assert (>= (str.len rest2) 0))
(assert (>= (str.len f0) 0))
(assert (>= (str.len f1) 0))
(assert (>= (str.len f2) 0))
(assert (>= (str.len f3) 0))

; SAT branch: f0 must look like an integer id (digits only, at least 1)
(assert (str.in_re f0 (re.++ (re.range "0" "9") (re.* (re.range "0" "9")))))

; UNSAT branch: simultaneously require f0 to be empty (contradiction with digit-only length>=1)
(assert (= f0 ""))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
