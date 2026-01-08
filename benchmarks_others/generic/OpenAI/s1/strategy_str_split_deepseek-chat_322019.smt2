(set-logic ALL)

; CSV Processing: comma-separated fields, enforce field counts, detect empty fields.

(declare-const csv_line String)
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)
(declare-const rest2 String)
(declare-const n Int)

; str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Mutated from seed: keep a negative regex membership constraint, now applied to CSV input
(assert (not (str.in_re csv_line (str.to_re "Port.body=ocllceclbhs/gthWeComputerLoggerHost:gdvsotuqwsg/dxt.hdUser-Agent:\u{a}"))))

; CSV delimiter is a comma
(assert (= delim ","))

; Basic well-formedness: no newline in the CSV line
(assert (not (str.contains csv_line "\n")))
(assert (not (str.contains csv_line "\r")))

; Extract up to 4 fields
(assert (= f0 (split_at csv_line delim 0)))
(assert (= f1 (split_at csv_line delim 1)))
(assert (= f2 (split_at csv_line delim 2)))
(assert (= f3 (split_at csv_line delim 3)))
(assert (= rest2 (split_rest csv_line delim 2)))

; Field-count constraint: exactly 4 segments (3 commas)
(assert (= n (num_splits csv_line delim)))
(assert (= n 4))

; Detect empty fields: at least one of the first three is empty
(assert (or (= f0 "") (= f1 "") (= f2 "")))

; Forbid all fields being empty simultaneously
(assert (not (and (= f0 "") (= f1 "") (= f2 "") (= f3 ""))))

; Structural consistency: the rest from index 2 must contain f2 as a prefix
(assert (str.contains rest2 f2))

; UNSAT check: additionally require no empty fields, contradicting the empty-field detection above
(assert (and (not (= f0 "")) (not (= f1 "")) (not (= f2 "")) (not (= f3 ""))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
