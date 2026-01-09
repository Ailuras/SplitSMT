(set-logic ALL)

; Uninterpreted interface for string splitting

; -------------------------
; Scenario: CSV Processing
; -------------------------

; A CSV record with comma separator
(declare-const csv_line String)
(declare-const delim String)
(assert (= delim ","))

; Extracted fields (0-based)
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const field3 String)

(assert (= field0 (str.split_at csv_line delim 0)))
(assert (= field1 (str.split_at csv_line delim 1)))
(assert (= field2 (str.split_at csv_line delim 2)))
(assert (= field3 (str.split_at csv_line delim 3)))

; ========== SAT instance: well-formed record with 4 fields, and one empty field detected ==========
(declare-const sat_line String)
(declare-const sat_f0 String)
(declare-const sat_f1 String)
(declare-const sat_f2 String)
(declare-const sat_f3 String)

(assert (= sat_f0 (str.split_at sat_line delim 0)))
(assert (= sat_f1 (str.split_at sat_line delim 1)))
(assert (= sat_f2 (str.split_at sat_line delim 2)))
(assert (= sat_f3 (str.split_at sat_line delim 3)))

; Field count constraint: exactly 4 segments
(assert (= (str.num_splits sat_line delim) 4))

; Construct a concrete-like CSV line with an empty middle field: "A,,C,D"
(assert (= sat_line (str.++ "A" (str.++ delim (str.++ "" (str.++ delim (str.++ "C" (str.++ delim "D"))))))))

; Detect empty field
(assert (= sat_f1 ""))
(assert (not (= sat_f0 "")))
(assert (not (= sat_f2 "")))
(assert (not (= sat_f3 "")))

; Consistency with rest-of-line from index 2: should be "C,D"
(declare-const sat_rest2 String)
(assert (= sat_rest2 (str.split_rest sat_line delim 2)))
(assert (= sat_rest2 (str.++ "C" (str.++ delim "D"))))

; ========== UNSAT instance: contradictory requirements about emptiness and structure ==========
(declare-const unsat_line String)
(declare-const u0 String)
(declare-const u1 String)
(declare-const u2 String)

(assert (= u0 (str.split_at unsat_line delim 0)))
(assert (= u1 (str.split_at unsat_line delim 1)))
(assert (= u2 (str.split_at unsat_line delim 2)))

; Exactly 3 segments
(assert (= (str.num_splits unsat_line delim) 3))

; Force line to have an empty second field: "X,,Z"
(assert (= unsat_line (str.++ "X" (str.++ delim (str.++ "" (str.++ delim "Z"))))) )

; Contradiction: require the empty field to be non-empty
(assert (= u1 ""))
(assert (not (= u1 "")))

; ========== Additional mixed constraints over an unconstrained csv_line (may or may not be satisfiable) ==========
; Intended: show field count and empty-field detection patterns

; Require at least 2 fields in csv_line
(assert (>= (str.num_splits csv_line delim) 2))

; If there are 4 fields, then field2 is empty (encoded as implication)
(assert (=> (= (str.num_splits csv_line delim) 4) (= field2 "")))

; If field0 is empty, then csv_line must start with a comma (approximate by requiring first segment empty)
(assert (=> (= field0 "") (= (str.split_at csv_line delim 0) "")))

; Basic index validity style constraints (natural indices)
(declare-const k0 Int)
(declare-const k1 Int)
(assert (>= k0 0))
(assert (>= k1 0))
(assert (< k0 (str.num_splits csv_line delim)))
(assert (< k1 (str.num_splits csv_line delim)))

; k0-th field not containing delimiter (typical CSV segment property)
(assert (not (str.contains (str.split_at csv_line delim k0) delim)))

; Ensure split_rest from k1 is a suffix (approximate by non-increasing length)
(assert (<= (str.len (str.split_rest csv_line delim k1)) (str.len csv_line)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
