(set-logic ALL)

; Uninterpreted interface for string splitting (CSV-style)

; =====================
; SAT instance: validate a 4-field CSV record with constraints, allow empty fields
; =====================
(declare-const csv_line String)
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)
(declare-const rest1 String)
(declare-const rest2 String)
(declare-const rest3 String)

(assert (= delim ","))

; Total segments should be exactly 4
(assert (= (str.num_splits csv_line delim) 4))

; Extract fields
(assert (= f0 (str.split_at csv_line delim 0)))
(assert (= f1 (str.split_at csv_line delim 1)))
(assert (= f2 (str.split_at csv_line delim 2)))
(assert (= f3 (str.split_at csv_line delim 3)))

; Connect remainder views
(assert (= rest1 (str.split_rest csv_line delim 1)))
(assert (= rest2 (str.split_rest csv_line delim 2)))
(assert (= rest3 (str.split_rest csv_line delim 3)))

; Basic bounds and sanity
(assert (>= (str.len csv_line) 0))
(assert (>= (str.len f0) 0))
(assert (>= (str.len f1) 0))
(assert (>= (str.len f2) 0))
(assert (>= (str.len f3) 0))

; Detect empty fields: require at least one empty field among middle fields
(assert (or (= f1 "") (= f2 "")))

; Require first field non-empty and looks like an identifier (no commas)
(assert (not (= f0 "")))
(assert (not (str.contains f0 ",")))

; Require last field is numeric-like: optional leading '-' then digits (non-empty)
(declare-const reDigit RegLan)
(declare-const reDigits RegLan)
(declare-const reOptMinus RegLan)
(declare-const reNumber RegLan)
(assert (= reDigit (re.range "0" "9")))
(assert (= reDigits (re.+ reDigit)))
(assert (= reOptMinus (re.union (str.to_re "") (str.to_re "-"))))
(assert (= reNumber (re.++ reOptMinus reDigits)))
(assert (str.in_re f3 reNumber))

; Pin a concrete satisfying shape to ensure SAT exists (contains an empty middle field)
(assert (= csv_line (str.++ "id123" "," "" "," "abc" "," "-42")))

(check-sat)

; =====================
; UNSAT instance: enforce contradictions about empty fields and counts
; =====================
(declare-const bad_csv String)
(declare-const b0 String)
(declare-const b1 String)
(declare-const b2 String)

; Exactly 3 fields
(assert (= (str.num_splits bad_csv delim) 3))
(assert (= b0 (str.split_at bad_csv delim 0)))
(assert (= b1 (str.split_at bad_csv delim 1)))
(assert (= b2 (str.split_at bad_csv delim 2)))

; Claim there is an empty field
(assert (or (= b0 "") (= b1 "") (= b2 "")))

; Contradict by requiring all fields non-empty
(assert (and (not (= b0 "")) (not (= b1 "")) (not (= b2 ""))))

; Also pin a line with no empty fields (reinforces UNSAT)
(assert (= bad_csv (str.++ "a" "," "b" "," "c")))

(check-sat)
(exit)
