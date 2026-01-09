(set-logic ALL)

; Uninterpreted interface for string split

; =========
; CSV Processing Scenario
; =========

; --- SAT instance: well-formed CSV row with 4 fields, no empty fields ---
(declare-const csv_row_ok String)
(declare-const ok_f0 String)
(declare-const ok_f1 String)
(declare-const ok_f2 String)
(declare-const ok_f3 String)

(assert (= csv_row_ok (str.++ ok_f0 "," ok_f1 "," ok_f2 "," ok_f3)))
(assert (= ok_f0 (str.split_at csv_row_ok "," 0)))
(assert (= ok_f1 (str.split_at csv_row_ok "," 1)))
(assert (= ok_f2 (str.split_at csv_row_ok "," 2)))
(assert (= ok_f3 (str.split_at csv_row_ok "," 3)))
(assert (= (str.split_rest csv_row_ok "," 2) (str.++ ok_f2 "," ok_f3)))

; valid split index bounds and count
(assert (>= (str.num_splits csv_row_ok ",") 4))
(assert (<= (str.num_splits csv_row_ok ",") 4))

; detect empty fields: none should be empty
(assert (> (str.len ok_f0) 0))
(assert (> (str.len ok_f1) 0))
(assert (> (str.len ok_f2) 0))
(assert (> (str.len ok_f3) 0))

; add realistic content constraints
(assert (str.contains csv_row_ok ","))
(assert (>= (str.len csv_row_ok) 7))
(assert (not (str.contains ok_f0 ",")))
(assert (not (str.contains ok_f1 ",")))
(assert (not (str.contains ok_f2 ",")))
(assert (not (str.contains ok_f3 ",")))

; --- UNSAT instance: claims 3 fields but also enforces a trailing comma that induces an empty 4th field ---
(declare-const csv_row_bad String)
(declare-const bad_a String)
(declare-const bad_b String)
(declare-const bad_c String)
(declare-const bad_tail String)

; syntactically looks like three fields plus trailing comma
(assert (= csv_row_bad (str.++ bad_a "," bad_b "," bad_c ",")))

; attempt to enforce exactly 3 segments (inconsistent with trailing comma -> empty segment)
(assert (= (str.num_splits csv_row_bad ",") 3))

; bind first three fields
(assert (= bad_a (str.split_at csv_row_bad "," 0)))
(assert (= bad_b (str.split_at csv_row_bad "," 1)))
(assert (= bad_c (str.split_at csv_row_bad "," 2)))

; assert there is no extra content after the 3rd field
(assert (= bad_tail (str.split_rest csv_row_bad "," 3)))
(assert (= bad_tail ""))

; but also require that the segment at index 3 exists and is empty (trailing comma creates empty field)
; combined with num_splits = 3 makes this inconsistent under intended split semantics
(assert (= (str.split_at csv_row_bad "," 3) ""))

; ensure indices are natural and within some reasonable bounds
(declare-const k_ok Int)
(declare-const k_bad Int)
(assert (and (>= k_ok 0) (< k_ok 4)))
(assert (and (>= k_bad 0) (< k_bad 4)))

; relate k_ok to a concrete access to diversify constraints
(assert (= (str.split_at csv_row_ok "," k_ok) (str.split_at csv_row_ok "," k_ok)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
