(set-logic ALL)

; Uninterpreted interface for string split constraints
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; Scenario: CSV Processing
; We model two CSV lines: one intended to be valid, and one intended to be invalid.

(declare-const csv_ok String)
(declare-const csv_bad String)

(declare-const delim String)
(assert (= delim ","))

; Fields for csv_ok
(declare-const ok_f0 String)
(declare-const ok_f1 String)
(declare-const ok_f2 String)
(declare-const ok_f3 String)

; Fields for csv_bad
(declare-const bad_f0 String)
(declare-const bad_f1 String)
(declare-const bad_f2 String)
(declare-const bad_f3 String)

; ---- SAT instance: csv_ok has exactly 4 fields, and no empty fields ----
(assert (= (num_splits csv_ok delim) 4))
(assert (= ok_f0 (split_at csv_ok delim 0)))
(assert (= ok_f1 (split_at csv_ok delim 1)))
(assert (= ok_f2 (split_at csv_ok delim 2)))
(assert (= ok_f3 (split_at csv_ok delim 3)))

; Indices are natural
(assert (and (<= 0 0) (<= 0 1) (<= 0 2) (<= 0 3)))

; No empty fields in the valid CSV line
(assert (and (> (str.len ok_f0) 0)
             (> (str.len ok_f1) 0)
             (> (str.len ok_f2) 0)
             (> (str.len ok_f3) 0)))

; Additional realistic constraints: fields do not contain the delimiter
(assert (and (not (str.contains ok_f0 delim))
             (not (str.contains ok_f1 delim))
             (not (str.contains ok_f2 delim))
             (not (str.contains ok_f3 delim))))

; Concrete-ish shape: header-like 4 columns: ID, NAME, AGE, CITY
; (keep content flexible but constrained)
(assert (>= (str.len ok_f0) 1))
(assert (>= (str.len ok_f1) 1))
(assert (>= (str.len ok_f2) 1))
(assert (>= (str.len ok_f3) 1))

; ---- UNSAT instance: csv_bad contradictions about empty fields and delimiters ----
; Intend csv_bad to have 4 fields, but simultaneously force it to contain an empty field while also disallowing empty fields.
(assert (= (num_splits csv_bad delim) 4))
(assert (= bad_f0 (split_at csv_bad delim 0)))
(assert (= bad_f1 (split_at csv_bad delim 1)))
(assert (= bad_f2 (split_at csv_bad delim 2)))
(assert (= bad_f3 (split_at csv_bad delim 3)))

; Detect empty fields: enforce that one middle field is empty (e.g., consecutive commas)
(assert (= bad_f2 ""))

; But also (incorrectly) assert that no field is empty => contradiction for csv_bad
(assert (and (> (str.len bad_f0) 0)
             (> (str.len bad_f1) 0)
             (> (str.len bad_f2) 0)
             (> (str.len bad_f3) 0)))

; Extra constraints: also require that bad_f2 contains a character, another direct contradiction
(assert (>= (str.len bad_f2) 1))

; Some bounds / sanity checks for split_rest usage
(declare-const bad_tail_from_2 String)
(assert (= bad_tail_from_2 (split_rest csv_bad delim 2)))
(assert (>= (str.len bad_tail_from_2) 0))

(check-sat)


; [GENERATION STATUS: SUCCESS]
