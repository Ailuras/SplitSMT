(set-logic ALL)

; CSV Processing: split comma-separated fields, enforce counts, and detect empty fields.

; --- Uninterpreted interface for split operations ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; --- Data strings ---
(declare-const csv_line String)
(declare-const csv_line_ok String)
(declare-const csv_line_bad String)

; --- Delimiter ---
(declare-const delim String)
(assert (= delim ","))

; --- Field projections ---
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const rest_from_2 String)

; Bind projections for the main line
(assert (= f0 (split_at csv_line delim 0)))
(assert (= f1 (split_at csv_line delim 1)))
(assert (= f2 (split_at csv_line delim 2)))
(assert (= rest_from_2 (split_rest csv_line delim 2)))

; Indices are natural and intended to be within bounds (interface constraint)
(assert (>= (num_splits csv_line delim) 1))

; Core structure: detect empty fields and ensure correct count
; Require exactly 3 fields, and forbid empty first field
(assert (= (num_splits csv_line delim) 3))
(assert (not (= f0 "")))

; Empty middle field detection: f1 is empty iff the line contains ",,"
(assert (= (= f1 "") (str.contains csv_line ",,")))

; Simple CSV sanity: no newlines in a single CSV line
(assert (not (str.contains csv_line "\n")))
(assert (not (str.contains csv_line "\r")))

; Mutated/extended regex-based check (seed-derived idea): forbid an '@' anywhere in CSV (e.g., emails not allowed)
(assert (not (str.contains csv_line "@")))

; --- SAT sub-instance: a valid CSV line with exactly 3 fields and an empty middle field ---
(assert (= csv_line_ok "alpha,,omega"))
(assert (= (num_splits csv_line_ok delim) 3))
(assert (= (split_at csv_line_ok delim 0) "alpha"))
(assert (= (split_at csv_line_ok delim 1) ""))
(assert (= (split_at csv_line_ok delim 2) "omega"))

; Ensure sat instance aligns with the main constraints by choosing csv_line = csv_line_ok
(assert (= csv_line csv_line_ok))

; --- UNSAT sub-instance: a conflicting CSV line (enforces 4 fields but also equals 3 fields) ---
(assert (= csv_line_bad "a,b,,c"))
(assert (= (num_splits csv_line_bad delim) 4))
(assert (= (num_splits csv_line_bad delim) 3))

(check-sat)


; [GENERATION STATUS: SUCCESS]