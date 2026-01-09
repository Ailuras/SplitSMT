(set-logic ALL)

; Uninterpreted interface for string split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; ========== SAT instance: well-formed CSV with 4 fields, no empty fields ==========
(declare-const csv_ok String)
(declare-const ok_f0 String)
(declare-const ok_f1 String)
(declare-const ok_f2 String)
(declare-const ok_f3 String)

(assert (= csv_ok "alice,42,NY,active"))
(assert (= ok_f0 (split_at csv_ok "," 0)))
(assert (= ok_f1 (split_at csv_ok "," 1)))
(assert (= ok_f2 (split_at csv_ok "," 2)))
(assert (= ok_f3 (split_at csv_ok "," 3)))
(assert (= (num_splits csv_ok ",") 4))

; Detect empty fields: require all fields non-empty
(assert (> (str.len ok_f0) 0))
(assert (> (str.len ok_f1) 0))
(assert (> (str.len ok_f2) 0))
(assert (> (str.len ok_f3) 0))

; Additional consistency checks
(assert (= (str.++ ok_f0 "," ok_f1 "," ok_f2 "," ok_f3) csv_ok))
(assert (= (split_rest csv_ok "," 1) (str.++ ok_f1 "," ok_f2 "," ok_f3)))
(assert (not (str.contains ok_f0 ",")))
(assert (not (str.contains ok_f1 ",")))
(assert (not (str.contains ok_f2 ",")))
(assert (not (str.contains ok_f3 ",")))

; Parse constraints: field 1 is numeric, field 0 is alpha-only
(assert (str.in_re ok_f1 (re.+ (re.range "0" "9"))))
(assert (str.in_re ok_f0 (re.+ (re.union (re.range "a" "z") (re.range "A" "Z")))))

(check-sat)

; ========== UNSAT instance: conflicting requirements about empty fields ==========
(push 1)

(declare-const csv_bad String)
(declare-const bad_f0 String)
(declare-const bad_f1 String)
(declare-const bad_f2 String)

(assert (= csv_bad "a,,c"))
(assert (= (num_splits csv_bad ",") 3))
(assert (= bad_f0 (split_at csv_bad "," 0)))
(assert (= bad_f1 (split_at csv_bad "," 1)))
(assert (= bad_f2 (split_at csv_bad "," 2)))

; For "a,,c" the middle field should be empty, but we assert it is non-empty
(assert (= bad_f0 "a"))
(assert (= bad_f1 ""))
(assert (= bad_f2 "c"))
(assert (> (str.len bad_f1) 0))

; Also keep indices natural and within segment bounds (interface discipline)
(assert (>= (num_splits csv_bad ",") 1))

(check-sat)
(pop 1)

; ========== SAT instance: detect presence of an empty field ==========
(push 1)

(declare-const csv_maybe_empty String)
(declare-const m_f0 String)
(declare-const m_f1 String)
(declare-const m_f2 String)
(declare-const has_empty Bool)

(assert (= csv_maybe_empty "x,,z"))
(assert (= (num_splits csv_maybe_empty ",") 3))
(assert (= m_f0 (split_at csv_maybe_empty "," 0)))
(assert (= m_f1 (split_at csv_maybe_empty "," 1)))
(assert (= m_f2 (split_at csv_maybe_empty "," 2)))

(assert (= has_empty (or (= (str.len m_f0) 0) (= (str.len m_f1) 0) (= (str.len m_f2) 0))))
(assert has_empty)

; Ensure non-empty for first and last, allow middle empty
(assert (> (str.len m_f0) 0))
(assert (> (str.len m_f2) 0))

(check-sat)
(pop 1)



; [GENERATION STATUS: SUCCESS]
(check-sat)