(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted interface for string split

; -----------------------------
; Scenario: CSV Processing
; We model comma-separated fields, require correct field counts,
; and detect empty fields.
; Provide both SAT and UNSAT clusters under assumptions.
; -----------------------------

; Common delimiter
(declare-const delim String)
(assert (= delim ","))

; ===== SAT instance: a CSV row with 4 fields, with at least one empty field =====
(declare-const csv_sat String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)
(declare-const rest2_sat String)

; Indices are natural
(assert (>= (num_splits csv_sat delim) 0))

; Exactly 4 fields
(assert (= (num_splits csv_sat delim) 4))

; Extract fields
(assert (= f0_sat (split_at csv_sat delim 0)))
(assert (= f1_sat (split_at csv_sat delim 1)))
(assert (= f2_sat (split_at csv_sat delim 2)))
(assert (= f3_sat (split_at csv_sat delim 3)))

; The remaining string from index 2 should be field2,comma,field3
(assert (= rest2_sat (split_rest csv_sat delim 2)))
(assert (= rest2_sat (str.++ f2_sat delim f3_sat)))

; Construct a concrete satisfiable shape with one empty middle field
(assert (= f0_sat "alpha"))
(assert (= f1_sat ""))
(assert (= f2_sat "gamma"))
(assert (= f3_sat "delta"))
(assert (= csv_sat (str.++ f0_sat delim f1_sat delim f2_sat delim f3_sat)))

; Detect empty fields: at least one empty among the 4
(assert (or (= f0_sat "") (= f1_sat "") (= f2_sat "") (= f3_sat "")))

; Also ensure no field contains the delimiter itself (typical unquoted CSV restriction)
(assert (not (str.contains f0_sat delim)))
(assert (not (str.contains f1_sat delim)))
(assert (not (str.contains f2_sat delim)))
(assert (not (str.contains f3_sat delim)))

; ===== UNSAT instance: demand 3 fields but also force 4 delimiters worth of structure =====
(declare-const csv_unsat String)
(declare-const u0 String)
(declare-const u1 String)
(declare-const u2 String)
(declare-const u3 String)

; Indices are natural
(assert (>= (num_splits csv_unsat delim) 0))

; Claim: exactly 3 fields
(assert (= (num_splits csv_unsat delim) 3))

; But simultaneously constrain it to be composed of 4 fields separated by commas
(assert (= u0 (split_at csv_unsat delim 0)))
(assert (= u1 (split_at csv_unsat delim 1)))
(assert (= u2 (split_at csv_unsat delim 2)))
(assert (= u3 (split_at csv_unsat delim 3)))
(assert (= csv_unsat (str.++ u0 delim u1 delim u2 delim u3)))

; Further enforce non-empty fields to avoid degenerate interpretations
(assert (> (str.len u0) 0))
(assert (> (str.len u1) 0))
(assert (> (str.len u2) 0))
(assert (> (str.len u3) 0))

; ===== Additional mixed constraints on another CSV row (kept SAT) =====
(declare-const csv_mixed String)
(declare-const m0 String)
(declare-const m1 String)
(declare-const m2 String)
(declare-const mrest1 String)

; Must have 3 fields
(assert (= (num_splits csv_mixed delim) 3))

; Extract
(assert (= m0 (split_at csv_mixed delim 0)))
(assert (= m1 (split_at csv_mixed delim 1)))
(assert (= m2 (split_at csv_mixed delim 2)))

; Rest from index 1 should be field1,comma,field2
(assert (= mrest1 (split_rest csv_mixed delim 1)))
(assert (= mrest1 (str.++ m1 delim m2)))

; Enforce that first field is an integer-like token (digits, possibly leading '-')
(declare-const digit_re RegLan)
(declare-const digits_re RegLan)
(declare-const int_re RegLan)
(assert (= digit_re (re.range "0" "9")))
(assert (= digits_re (re.+ digit_re)))
(assert (= int_re (re.union digits_re (re.++ (str.to_re "-") digits_re))))
(assert (str.in_re m0 int_re))

; Ensure second field is empty (detect missing value), third non-empty
(assert (= m1 ""))
(assert (> (str.len m2) 0))

; Build concrete mixed row
(assert (= m0 "42"))
(assert (= m2 "ok"))
(assert (= csv_mixed (str.++ m0 delim m1 delim m2)))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(get-model)
(exit)
