(set-logic ALL)

; Scenario: CSV Processing
; Goal: model comma-separated fields, ensure correct field count, and detect empty fields.

; Seed variable (kept)
(declare-const x String)

; CSV-specific variables
(declare-const csv String)
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)
(declare-const rest2 String)
(declare-const rest3 String)
(declare-const hasEmptyField Bool)

; str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; Keep core structure flavor but adapt to CSV context
(assert (= delim ","))

; Tie x into CSV processing to preserve seed structure linkage
(assert (= csv (str.++ x "," "" "," "42" "," "end")))

; Ensure fixed-length payload part (seed) with a relaxed regex membership that is always true
(assert (= 16 (str.len x)))
(assert (str.in_re x (re.* (str.to_re "ddccbbaa"))))

; Extract fields
(assert (= f0 (split_at csv delim 0)))
(assert (= f1 (split_at csv delim 1)))
(assert (= f2 (split_at csv delim 2)))
(assert (= f3 (split_at csv delim 3)))
(assert (= rest2 (split_rest csv delim 2)))
(assert (= rest3 (split_rest csv delim 3)))

; Field count constraints: expect exactly 4 segments (3 commas)
(assert (= (num_splits csv delim) 4))

; Detect empty fields: at least one field is empty
(assert (= hasEmptyField (or (= f0 "") (= f1 "") (= f2 "") (= f3 ""))))
(assert hasEmptyField)

; Additional CSV sanity: no field may contain a comma
(assert (not (str.contains f0 delim)))
(assert (not (str.contains f1 delim)))
(assert (not (str.contains f2 delim)))
(assert (not (str.contains f3 delim)))

; Make one specific empty-field location explicit to create a concrete CSV issue
(assert (= f1 ""))

; Relate rest concatenations to expected suffixes
(assert (= rest3 f3))
(assert (= rest2 (str.++ f2 delim f3)))

; SAT/UNSAT mix: add a contradictory requirement about f1 to force UNSAT in this instance
(assert (not (= f1 "")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
