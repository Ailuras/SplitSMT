(set-logic ALL)

; Uninterpreted interface for str_split

; Scenario: CSV Processing
; We model CSV rows separated by ',' and enforce field counts and empty-field detection.

; ----------------------------
; SAT instance: valid-ish CSV row with an empty field
; ----------------------------
(declare-const csv_row_sat String)
(declare-const comma String)
(declare-const sat_f0 String)
(declare-const sat_f1 String)
(declare-const sat_f2 String)
(declare-const sat_f3 String)

(assert (= comma ","))

; Exactly 4 fields
(assert (= (str.num_splits csv_row_sat comma) 4))

; Bind each field via split_at
(assert (= sat_f0 (str.split_at csv_row_sat comma 0)))
(assert (= sat_f1 (str.split_at csv_row_sat comma 1)))
(assert (= sat_f2 (str.split_at csv_row_sat comma 2)))
(assert (= sat_f3 (str.split_at csv_row_sat comma 3)))

; Indices are natural
(assert (and (<= 0 0) (<= 0 1) (<= 0 2) (<= 0 3)))

; Detect an empty middle field (consecutive commas)
(assert (= sat_f1 ""))

; Other fields non-empty and no extra commas inside them
(assert (> (str.len sat_f0) 0))
(assert (> (str.len sat_f2) 0))
(assert (> (str.len sat_f3) 0))
(assert (not (str.contains sat_f0 comma)))
(assert (not (str.contains sat_f2 comma)))
(assert (not (str.contains sat_f3 comma)))

; Constrain a concrete shape: alpha,empty,numeric,alpha
(assert (str.in_re sat_f0 (re.+ (re.range "a" "z"))))
(assert (str.in_re sat_f2 (re.+ (re.range "0" "9"))))
(assert (str.in_re sat_f3 (re.+ (re.range "a" "z"))))

; Reconstruct row (sanity cross-check using concatenation)
(assert (= csv_row_sat (str.++ sat_f0 comma sat_f1 comma sat_f2 comma sat_f3)))

; Also relate split_rest: rest from index 2 equals f2,f3
(assert (= (str.split_rest csv_row_sat comma 2) (str.++ sat_f2 comma sat_f3)))

; ----------------------------
; UNSAT instance: impossible constraints about emptiness
; ----------------------------
(declare-const csv_row_unsat String)
(declare-const unsat_f0 String)
(declare-const unsat_f1 String)
(declare-const unsat_f2 String)

; Exactly 3 fields
(assert (= (str.num_splits csv_row_unsat comma) 3))
(assert (= unsat_f0 (str.split_at csv_row_unsat comma 0)))
(assert (= unsat_f1 (str.split_at csv_row_unsat comma 1)))
(assert (= unsat_f2 (str.split_at csv_row_unsat comma 2)))

; Require field 1 to be empty
(assert (= unsat_f1 ""))

; But also require it to have positive length (contradiction)
(assert (> (str.len unsat_f1) 0))

; Additional CSV-ish shape constraints
(assert (not (str.contains unsat_f0 comma)))
(assert (not (str.contains unsat_f2 comma)))
(assert (= csv_row_unsat (str.++ unsat_f0 comma unsat_f1 comma unsat_f2)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
