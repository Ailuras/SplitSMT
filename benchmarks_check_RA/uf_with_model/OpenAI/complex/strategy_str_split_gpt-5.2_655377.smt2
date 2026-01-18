(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Scenario: CSV Processing
; Goal: Process comma-separated data fields to ensure correct field counts and detect empty fields.

; --- str_split interface ---

; --- CSV inputs/derived fields ---
(declare-const csv String)
(declare-const delim String)
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const rest2 String)
(declare-const has_empty Bool)
(declare-const sat_case Bool)

; delimiter fixed to comma
(assert (= delim ","))

; Restrict csv characters: alnum, comma, newline. Keep overall structure similar to seed by ending with newline.
(assert (str.in_re csv
  (re.++
    (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re ",")))
    (str.to_re "\u{a}"))))

; Extract fields using split_at
(assert (= field0 (split_at csv delim 0)))
(assert (= field1 (split_at csv delim 1)))
(assert (= field2 (split_at csv delim 2)))
(assert (= rest2  (split_rest csv delim 2)))

; CSV should have at least 3 segments (i.e., at least 2 commas or equivalent split behavior)
(assert (>= (num_splits csv delim) 3))

; Define empty-field detection flag (empty in first three fields)
(assert (= has_empty (or (= field0 "") (= field1 "") (= field2 ""))))

; --- Case split: one SAT and one UNSAT branch within the same file ---
; sat_case=true: enforce exactly three segments and no empty fields (SAT should be possible)
(assert (=> sat_case (and (= (num_splits csv delim) 3)
                         (not has_empty)
                         (>= (str.len field0) 1)
                         (>= (str.len field1) 1)
                         (>= (str.len field2) 1))))

; sat_case=false: force contradictory requirements to create an UNSAT branch
; exactly three segments, and field1 both empty and non-empty
(assert (=> (not sat_case) (and (= (num_splits csv delim) 3)
                               (= field1 "")
                               (>= (str.len field1) 1))))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(get-model)
(exit)
