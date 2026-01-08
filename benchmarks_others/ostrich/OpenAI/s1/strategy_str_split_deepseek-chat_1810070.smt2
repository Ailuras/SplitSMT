(set-logic ALL)

; Scenario: CSV Processing
; Goal: process comma-separated data fields, ensure field counts and detect empty fields.

; Non-primitive interface operations (string split)
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; Primary CSV line
(declare-const s String)

; Additional CSV lines to create both SAT and UNSAT sub-instances
(declare-const csv_ok String)
(declare-const csv_bad String)

; ---------------------------
; Mutated/extended core from seed: numeric-only string constraints on s
; Keep a similar structure but incorporate CSV delimiter checks.
; ---------------------------

; s is a non-empty numeric token of bounded length (kept from seed spirit)
(assert (str.in_re s (re.+ (re.range "0" "9"))))
(assert (not (= (str.len s) 0)))
(assert (<= (str.len s) 12))

; Preserve a "core structure" style constraint about substr/len being 1
(assert (= (str.len (str.substr s 0 (- 1 0))) 1))

; Mutate the last seed constraint: force second character to be "0" but avoid trivial 1-length
(assert (>= (str.len s) 2))
(assert (= (str.at (str.substr s 1 1) 0) "0"))

; New CSV-related constraints about s used as a field: it must not contain comma
(assert (not (str.contains s ",")))

; ---------------------------
; SAT instance: csv_ok has exactly 3 fields, no empty fields
; ---------------------------
(assert (>= (num_splits csv_ok ",") 3))
(assert (<= (num_splits csv_ok ",") 3))

; Each field non-empty
(assert (> (str.len (split_at csv_ok "," 0)) 0))
(assert (> (str.len (split_at csv_ok "," 1)) 0))
(assert (> (str.len (split_at csv_ok "," 2)) 0))

; Constrain first field to be numeric-only and reuse s as that field
(assert (= (split_at csv_ok "," 0) s))
(assert (str.in_re (split_at csv_ok "," 1) (re.+ (re.range "A" "Z"))))
(assert (str.in_re (split_at csv_ok "," 2) (re.+ (re.range "a" "z"))))

; Delimiter sanity: the rest from index 1 should still contain a comma (since 3 fields)
(assert (str.contains (split_rest csv_ok "," 1) ","))

; ---------------------------
; UNSAT instance: csv_bad forced to have an empty middle field AND no empty fields
; ---------------------------
(assert (>= (num_splits csv_bad ",") 3))
(assert (<= (num_splits csv_bad ",") 3))

; Force an empty middle field
(assert (= (split_at csv_bad "," 1) ""))

; But also require all fields non-empty -> contradiction
(assert (> (str.len (split_at csv_bad "," 0)) 0))
(assert (> (str.len (split_at csv_bad "," 1)) 0))
(assert (> (str.len (split_at csv_bad "," 2)) 0))

; Additional structure: if middle field is empty, then ",," should appear (consistent, but doesn't resolve contradiction)
(assert (str.contains csv_bad ",,"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
