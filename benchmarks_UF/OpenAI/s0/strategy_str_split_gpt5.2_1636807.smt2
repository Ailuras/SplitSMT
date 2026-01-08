(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted interface for string split

; =====================
; SAT instance: CSV processing with empty-field detection
; =====================
(declare-const csv_line String)
(declare-const delim String)
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const field3 String)
(declare-const rest1 String)
(declare-const rest2 String)
(declare-const rest3 String)
(declare-const total_fields Int)
(declare-const has_empty Bool)

(assert (= delim ","))

; At least 4 fields (3 commas) expected for the main SAT case
(assert (= total_fields (num_splits csv_line delim)))
(assert (= total_fields 4))

; Extract fields and suffixes
(assert (= field0 (split_at csv_line delim 0)))
(assert (= field1 (split_at csv_line delim 1)))
(assert (= field2 (split_at csv_line delim 2)))
(assert (= field3 (split_at csv_line delim 3)))
(assert (= rest1 (split_rest csv_line delim 1)))
(assert (= rest2 (split_rest csv_line delim 2)))
(assert (= rest3 (split_rest csv_line delim 3)))

; Indices are natural and within the expected segment count
(assert (and (<= 0 0) (< 0 total_fields)))
(assert (and (<= 0 1) (< 1 total_fields)))
(assert (and (<= 0 2) (< 2 total_fields)))
(assert (and (<= 0 3) (< 3 total_fields)))

; Basic sanity: no newline characters in the line (simple CSV line)
(assert (not (str.contains csv_line "\n")))
(assert (not (str.contains csv_line "\r")))

; Detect empty fields (including consecutive commas or trailing comma)
(assert (= has_empty (or (= field0 "") (= field1 "") (= field2 "") (= field3 ""))))

; Ensure we actually have an empty field and also at least one non-empty field
(assert has_empty)
(assert (or (not (= field0 "")) (not (= field1 "")) (not (= field2 "")) (not (= field3 ""))))

; Additional constraints to resemble typical CSV cleaning rules
; - No field contains the delimiter itself (no quoting modeled here)
(assert (not (str.contains field0 delim)))
(assert (not (str.contains field1 delim)))
(assert (not (str.contains field2 delim)))
(assert (not (str.contains field3 delim)))

; - A weak structural relation: the remaining suffix from k has length at least the length of segment k
(assert (>= (str.len rest1) (str.len field1)))
(assert (>= (str.len rest2) (str.len field2)))
(assert (>= (str.len rest3) (str.len field3)))

; =====================
; UNSAT instance: contradictory requirements on empty fields and counts
; =====================
(declare-const csv_line_bad String)
(declare-const bad_fields Int)
(declare-const bad0 String)
(declare-const bad1 String)
(declare-const bad2 String)
(declare-const bad3 String)
(declare-const bad4 String)
(declare-const bad_has_empty Bool)

(assert (= bad_fields (num_splits csv_line_bad delim)))

; Require exactly 5 fields
(assert (= bad_fields 5))

; Extract 5 fields
(assert (= bad0 (split_at csv_line_bad delim 0)))
(assert (= bad1 (split_at csv_line_bad delim 1)))
(assert (= bad2 (split_at csv_line_bad delim 2)))
(assert (= bad3 (split_at csv_line_bad delim 3)))
(assert (= bad4 (split_at csv_line_bad delim 4)))

; Define emptiness predicate, then force contradiction: both has_empty and all fields non-empty
(assert (= bad_has_empty (or (= bad0 "") (= bad1 "") (= bad2 "") (= bad3 "") (= bad4 ""))))
(assert bad_has_empty)
(assert (not (= bad0 "")))
(assert (not (= bad1 "")))
(assert (not (= bad2 "")))
(assert (not (= bad3 "")))
(assert (not (= bad4 "")))

; Also add a conflicting count condition to strengthen UNSAT
(assert (>= (num_splits csv_line_bad delim) 6))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
