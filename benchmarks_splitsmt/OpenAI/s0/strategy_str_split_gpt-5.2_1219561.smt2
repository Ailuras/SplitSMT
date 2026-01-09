(set-logic ALL)

; Uninterpreted interface operations for str_split

; -----------------------------
; SAT instance: CSV with exactly 4 fields, detect empty fields, and enforce content constraints
; -----------------------------
(declare-const csv_line String)
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)
(declare-const rest1 String)
(declare-const rest2 String)
(declare-const rest3 String)
(declare-const has_empty Bool)

(assert (= delim ","))

; Require exactly 4 fields after splitting by comma
(assert (= (str.num_splits csv_line delim) 4))

; Bind fields via split_at
(assert (= f0 (str.split_at csv_line delim 0)))
(assert (= f1 (str.split_at csv_line delim 1)))
(assert (= f2 (str.split_at csv_line delim 2)))
(assert (= f3 (str.split_at csv_line delim 3)))

; Bind suffixes via split_rest
(assert (= rest1 (str.split_rest csv_line delim 1)))
(assert (= rest2 (str.split_rest csv_line delim 2)))
(assert (= rest3 (str.split_rest csv_line delim 3)))

; Basic validity: indices are natural
(assert (and (>= 0 0) (>= 1 0) (>= 2 0) (>= 3 0)))

; Concrete satisfiable example: "A,,C,42" (empty f1)
(assert (= csv_line "A,,C,42"))
(assert (= f0 "A"))
(assert (= f1 ""))
(assert (= f2 "C"))
(assert (= f3 "42"))

; Empty-field detection flag
(assert (= has_empty (or (= f0 "") (= f1 "") (= f2 "") (= f3 ""))))
(assert has_empty)

; Additional content constraints (mix simple and complex)
; f0 must be a single uppercase letter
(assert (= (str.len f0) 1))
(assert (str.in_re f0 (str.to_re "A")))

; f2 must be non-empty and must not contain comma
(assert (> (str.len f2) 0))
(assert (not (str.contains f2 ",")))

; f3 must be exactly two digits
(assert (= (str.len f3) 2))
(assert (str.in_re f3 (re.++ (re.union (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9"))
                              (re.union (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9")))))

; Ensure rest variables are consistent with known concrete line (lightweight sanity)
(assert (= rest3 "42"))

(check-sat)

; -----------------------------
; UNSAT instance: Contradictory requirements about empty fields and field count
; -----------------------------
(declare-const csv_line_u String)
(declare-const d_u String)
(declare-const u0 String)
(declare-const u1 String)
(declare-const u2 String)
(declare-const u3 String)
(declare-const no_empty Bool)

(assert (= d_u ","))

; Fix line to one that clearly contains an empty field
(assert (= csv_line_u "X,,Y,Z"))

; Require 4 fields
(assert (= (str.num_splits csv_line_u d_u) 4))
(assert (= u0 (str.split_at csv_line_u d_u 0)))
(assert (= u1 (str.split_at csv_line_u d_u 1)))
(assert (= u2 (str.split_at csv_line_u d_u 2)))
(assert (= u3 (str.split_at csv_line_u d_u 3)))

; Force specific field bindings (including empty u1)
(assert (= u0 "X"))
(assert (= u1 ""))
(assert (= u2 "Y"))
(assert (= u3 "Z"))

; Contradiction: state there are no empty fields
(assert (= no_empty (and (not (= u0 "")) (not (= u1 "")) (not (= u2 "")) (not (= u3 "")))))
(assert no_empty)

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
