(set-logic ALL)

; CSV Processing scenario: comma-separated fields, field counts, and empty-field detection
; This file includes both a satisfiable instance (csv_ok) and an unsatisfiable instance (csv_bad).

; --- str_split interface (uninterpreted) ---

; --- Shared constants ---
(declare-const comma String)
(assert (= comma ","))

; ========== SAT instance: well-formed CSV with an empty middle field ==========
(declare-const csv_ok String)
(declare-const ok_f0 String)
(declare-const ok_f1 String)
(declare-const ok_f2 String)
(declare-const ok_rest1 String)
(declare-const ok_rest2 String)
(declare-const ok_field_count Int)

; Field count constraints (3 fields)
(assert (= ok_field_count (str.num_splits csv_ok comma)))
(assert (= ok_field_count 3))

; Extract fields
(assert (= ok_f0 (str.split_at csv_ok comma 0)))
(assert (= ok_f1 (str.split_at csv_ok comma 1)))
(assert (= ok_f2 (str.split_at csv_ok comma 2)))

; Rest segments
(assert (= ok_rest1 (str.split_rest csv_ok comma 1)))
(assert (= ok_rest2 (str.split_rest csv_ok comma 2)))

; Ensure indices are natural
(assert (>= ok_field_count 0))

; Detect empty field: middle field is empty
(assert (= ok_f1 ""))

; Non-empty constraints for other fields
(assert (not (= ok_f0 "")))
(assert (not (= ok_f2 "")))

; No commas inside individual fields (simple CSV without quoting)
(assert (not (str.contains ok_f0 comma)))
(assert (not (str.contains ok_f1 comma)))
(assert (not (str.contains ok_f2 comma)))

; Make the instance concrete enough for SAT
(assert (= ok_f0 "alpha"))
(assert (= ok_f2 "gamma"))

; Optional sanity: length properties
(assert (> (str.len csv_ok) 0))
(assert (>= (str.len ok_rest1) (str.len ok_f2)))

; ========== UNSAT instance: contradictory constraints about emptiness ==========
(declare-const csv_bad String)
(declare-const bad_f0 String)
(declare-const bad_f1 String)
(declare-const bad_f2 String)
(declare-const bad_count Int)
(declare-const bad_rest0 String)

; Claim 3 fields
(assert (= bad_count (str.num_splits csv_bad comma)))
(assert (= bad_count 3))

; Extract fields
(assert (= bad_f0 (str.split_at csv_bad comma 0)))
(assert (= bad_f1 (str.split_at csv_bad comma 1)))
(assert (= bad_f2 (str.split_at csv_bad comma 2)))

; Rest from 0 is the whole string (interface-style expectation for k=0)
(assert (= bad_rest0 (str.split_rest csv_bad comma 0)))

; Set a concrete CSV with an empty middle field
(assert (= csv_bad "x,,z"))

; Emptiness detection expects middle field empty
(assert (= bad_f1 ""))

; Contradiction: require all fields non-empty
(assert (not (= bad_f0 "")))
(assert (not (= bad_f1 "")))
(assert (not (= bad_f2 "")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
