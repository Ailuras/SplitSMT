(set-logic ALL)

; Uninterpreted interface for string split operations

; =====================
; Scenario: CSV Processing
; =====================

; --------- SAT instance: well-formed CSV with 4 fields, no empty fields, numeric constraints
(declare-const csv_ok String)
(declare-const ok_f0 String)
(declare-const ok_f1 String)
(declare-const ok_f2 String)
(declare-const ok_f3 String)

(assert (= csv_ok (str.++ ok_f0 "," ok_f1 "," ok_f2 "," ok_f3)))
(assert (= 4 (str.num_splits csv_ok ",")))

(assert (= ok_f0 (str.split_at csv_ok "," 0)))
(assert (= ok_f1 (str.split_at csv_ok "," 1)))
(assert (= ok_f2 (str.split_at csv_ok "," 2)))
(assert (= ok_f3 (str.split_at csv_ok "," 3)))

; No empty fields (detect empty field as "")
(assert (> (str.len ok_f0) 0))
(assert (> (str.len ok_f1) 0))
(assert (> (str.len ok_f2) 0))
(assert (> (str.len ok_f3) 0))

; Basic sanitation: no field contains commas
(assert (not (str.contains ok_f0 ",")))
(assert (not (str.contains ok_f1 ",")))
(assert (not (str.contains ok_f2 ",")))
(assert (not (str.contains ok_f3 ",")))

; Numeric field constraints: ok_f1 is exactly 3 digits, ok_f2 is a signed integer token, ok_f3 is 2 uppercase letters
(declare-const digit_re RegLan)
(declare-const digits3_re RegLan)
(declare-const sign_re RegLan)
(declare-const int_re RegLan)
(declare-const upper_re RegLan)
(declare-const upper2_re RegLan)

(assert (= digit_re (re.range "0" "9")))
(assert (= digits3_re (re.++ digit_re (re.++ digit_re digit_re))))
(assert (= sign_re (re.union (str.to_re "-") (str.to_re "+"))))
(assert (= int_re (re.++ (re.opt sign_re) (re.+ digit_re))))
(assert (= upper_re (re.range "A" "Z")))
(assert (= upper2_re (re.++ upper_re upper_re)))

(assert (str.in_re ok_f1 digits3_re))
(assert (str.in_re ok_f2 int_re))
(assert (str.in_re ok_f3 upper2_re))

; Additional split_rest sanity: rest from index 2 equals f2,f3
(assert (= (str.split_rest csv_ok "," 2) (str.++ ok_f2 "," ok_f3)))

; --------- UNSAT instance: constraints intentionally conflicting to model empty-field detection and incorrect counts
(declare-const csv_bad String)
(declare-const bad_f0 String)
(declare-const bad_f1 String)
(declare-const bad_f2 String)

; Shape suggests 3 segments (2 commas)
(assert (= csv_bad (str.++ bad_f0 "," bad_f1 "," bad_f2)))
(assert (= 3 (str.num_splits csv_bad ",")))

; Define split components
(assert (= bad_f0 (str.split_at csv_bad "," 0)))
(assert (= bad_f1 (str.split_at csv_bad "," 1)))
(assert (= bad_f2 (str.split_at csv_bad "," 2)))

; Require empty middle field (detect empty)
(assert (= bad_f1 ""))

; Contradiction: simultaneously require no empty fields
(assert (> (str.len bad_f1) 0))

; Further conflicting count requirement: claim 4 fields
(assert (= 4 (str.num_splits csv_bad ",")))

; Index bounds (natural indices)
(assert (>= 0 0))
(assert (>= 1 0))
(assert (>= 2 0))
(assert (>= 3 0))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
