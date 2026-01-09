; Scenario: CSV Processing
; Goal: Process comma-separated data fields, ensure correct field counts, and detect empty fields.
(set-logic ALL)

; str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Core inputs
(declare-const value String) ; CSV line
(declare-const key String)   ; record type / header name

; Derived fields
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const tail2 String)

; Helper ints
(declare-const idx_first_comma Int)
(declare-const idx_second_comma Int)

; Basic well-formedness
(assert (not (= (str.len value) 0)))
(assert (not (str.contains value " \t")))

; Define split fields (core structure via split)
(assert (= f0 (split_at value "," 0)))
(assert (= f1 (split_at value "," 1)))
(assert (= f2 (split_at value "," 2)))
(assert (= tail2 (split_rest value "," 2)))

; Field-count constraints: expect exactly 3 fields for data rows
(assert (= (num_splits value ",") 3))

; Detect empty fields: for DATA rows, disallow empty f0,f2 but allow f1 to be empty
(assert (=> (= key "DATA") (not (= (str.len f0) 0))))
(assert (=> (= key "DATA") (not (= (str.len f2) 0))))
(assert (=> (= key "DATA") (or (= (str.len f1) 0) (>= (str.len f1) 1))))

; For HEADER rows, all fields must be non-empty
(assert (=> (= key "HEADER") (and (> (str.len f0) 0) (> (str.len f1) 0) (> (str.len f2) 0))))

; Additional sanity checks using indexof/substr similar to seed's style
(assert (= idx_first_comma (str.indexof value "," 0)))
(assert (>= idx_first_comma 0))
(assert (= idx_second_comma (str.indexof value "," (+ idx_first_comma 1))))
(assert (>= idx_second_comma 0))
(assert (< idx_first_comma idx_second_comma))

; Ensure the first field equals prefix before the first comma
(assert (= f0 (str.substr value 0 idx_first_comma)))

; Ensure the last field is the suffix after the second comma
(assert (= f2 (str.substr value (+ idx_second_comma 1) (- (str.len value) (+ idx_second_comma 1)))))

; No trailing comma (i.e., last field not empty) for DATA and HEADER
(assert (=> (or (= key "DATA") (= key "HEADER")) (not (= (str.at value (- (str.len value) 1)) ","))))

; Light pattern constraints: f0 must be one of a small set of row types
(assert (or (= f0 "A") (= f0 "B") (= f0 "C") (= f0 "D")))

; Mix SAT and UNSAT branches: enforce key is DATA, but also impose a conflicting requirement
(assert (= key "DATA"))
; Contradiction: require f2 both non-empty (from DATA) and empty here
(assert (= (str.len f2) 0))

(check-sat)


; [GENERATION STATUS: SUCCESS]