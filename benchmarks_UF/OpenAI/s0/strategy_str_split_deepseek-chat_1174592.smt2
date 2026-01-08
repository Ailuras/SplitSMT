(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted interface operations for string split

; ==========================
; SAT instance: CSV processing
; ==========================
(declare-const csv_line String)
(declare-const comma String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const rest2 String)
(declare-const has_empty Bool)
(declare-const total_fields Int)

(assert (= comma ","))

; Example CSV line: 3 fields total, middle field empty
(assert (= csv_line "alpha,,gamma"))

(assert (= total_fields (num_splits csv_line comma)))
(assert (= f0 (split_at csv_line comma 0)))
(assert (= f1 (split_at csv_line comma 1)))
(assert (= f2 (split_at csv_line comma 2)))
(assert (= rest2 (split_rest csv_line comma 2)))

; Field count checks
(assert (>= total_fields 1))
(assert (= total_fields 3))

; Detect empty fields
(assert (= has_empty (or (= f0 "") (= f1 "") (= f2 ""))))
(assert has_empty)

; Non-empty constraints on specific fields
(assert (not (= f0 "")))
(assert (not (= f2 "")))

; Lightweight sanity: if there are at least 3 fields, f2 should match suffix remainder
(assert (>= (num_splits csv_line comma) 3))
(assert (= rest2 f2))

; ============================
; UNSAT instance: contradictory
; ============================
(declare-const csv_line_u String)
(declare-const u0 String)
(declare-const u1 String)
(declare-const u2 String)
(declare-const u3 String)
(declare-const u_has_empty Bool)
(declare-const u_total_fields Int)

(assert (= csv_line_u "a,,c"))
(assert (= u_total_fields (num_splits csv_line_u comma)))

; Force 4 fields even though the concrete string provides 3 segments
(assert (= u_total_fields 4))

(assert (= u0 (split_at csv_line_u comma 0)))
(assert (= u1 (split_at csv_line_u comma 1)))
(assert (= u2 (split_at csv_line_u comma 2)))
(assert (= u3 (split_at csv_line_u comma 3)))

; Require no empty fields, but the string has an empty middle field
(assert (= u_has_empty (or (= u0 "") (= u1 "") (= u2 "") (= u3 ""))))
(assert (not u_has_empty))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
