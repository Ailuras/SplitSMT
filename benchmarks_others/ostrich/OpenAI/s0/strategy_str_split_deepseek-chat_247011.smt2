(set-logic ALL)

; Uninterpreted interface for string split operations
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; -----------------------------
; SAT instance: well-formed CSV with 4 fields, no empty fields
; -----------------------------
(declare-const csv_ok String)
(declare-const f0_ok String)
(declare-const f1_ok String)
(declare-const f2_ok String)
(declare-const f3_ok String)

(assert (= csv_ok (str.++ f0_ok "," f1_ok "," f2_ok "," f3_ok)))
(assert (= (num_splits csv_ok ",") 4))

(assert (= f0_ok (split_at csv_ok "," 0)))
(assert (= f1_ok (split_at csv_ok "," 1)))
(assert (= f2_ok (split_at csv_ok "," 2)))
(assert (= f3_ok (split_at csv_ok "," 3)))

; detect empty fields: all must be non-empty
(assert (> (str.len f0_ok) 0))
(assert (> (str.len f1_ok) 0))
(assert (> (str.len f2_ok) 0))
(assert (> (str.len f3_ok) 0))

; simple content sanity (avoid commas inside fields)
(assert (not (str.contains f0_ok ",")))
(assert (not (str.contains f1_ok ",")))
(assert (not (str.contains f2_ok ",")))
(assert (not (str.contains f3_ok ",")))

; rest-of-line relationships
(assert (= (split_rest csv_ok "," 0) csv_ok))
(assert (= (split_rest csv_ok "," 1) (str.++ f1_ok "," f2_ok "," f3_ok)))
(assert (= (split_rest csv_ok "," 2) (str.++ f2_ok "," f3_ok)))
(assert (= (split_rest csv_ok "," 3) f3_ok))

; indices are natural within split bounds
(assert (and (<= 0 0) (< 0 (num_splits csv_ok ","))))
(assert (and (<= 0 1) (< 1 (num_splits csv_ok ","))))
(assert (and (<= 0 2) (< 2 (num_splits csv_ok ","))))
(assert (and (<= 0 3) (< 3 (num_splits csv_ok ","))))

; -----------------------------
; UNSAT instance: claims 3 fields but also enforces an empty middle field while forbidding empties
; -----------------------------
(declare-const csv_bad String)
(declare-const b0 String)
(declare-const b1 String)
(declare-const b2 String)

(assert (= csv_bad (str.++ b0 "," b1 "," b2)))
(assert (= (num_splits csv_bad ",") 3))

(assert (= b0 (split_at csv_bad "," 0)))
(assert (= b1 (split_at csv_bad "," 1)))
(assert (= b2 (split_at csv_bad "," 2)))

; require an empty middle field
(assert (= (str.len b1) 0))

; but simultaneously require all fields to be non-empty (contradiction)
(assert (> (str.len b0) 0))
(assert (> (str.len b1) 0))
(assert (> (str.len b2) 0))

; additional rest constraints
(assert (= (split_rest csv_bad "," 0) csv_bad))
(assert (= (split_rest csv_bad "," 1) (str.++ b1 "," b2)))
(assert (= (split_rest csv_bad "," 2) b2))

; index bounds
(assert (and (<= 0 0) (< 0 (num_splits csv_bad ","))))
(assert (and (<= 0 1) (< 1 (num_splits csv_bad ","))))
(assert (and (<= 0 2) (< 2 (num_splits csv_bad ","))))

; -----------------------------
; Additional mixed constraints (SAT-compatible) about empty-field detection on a separate CSV line
; -----------------------------
(declare-const csv_mix String)
(declare-const m0 String)
(declare-const m1 String)
(declare-const m2 String)
(declare-const has_empty Bool)

(assert (= csv_mix (str.++ m0 "," m1 "," m2)))
(assert (= (num_splits csv_mix ",") 3))
(assert (= m0 (split_at csv_mix "," 0)))
(assert (= m1 (split_at csv_mix "," 1)))
(assert (= m2 (split_at csv_mix "," 2)))

; define has_empty as: some field is empty
(assert (= has_empty (or (= (str.len m0) 0) (= (str.len m1) 0) (= (str.len m2) 0))))

; require there exists at least one empty field
(assert has_empty)

; but also require at least one non-empty field, to avoid all-empty degenerate line
(assert (or (> (str.len m0) 0) (> (str.len m1) 0) (> (str.len m2) 0)))

; forbid commas in fields
(assert (not (str.contains m0 ",")))
(assert (not (str.contains m1 ",")))
(assert (not (str.contains m2 ",")))

; check-sat for the whole file: includes an UNSAT block, so overall is UNSAT
(check-sat)


; [GENERATION STATUS: SUCCESS]
