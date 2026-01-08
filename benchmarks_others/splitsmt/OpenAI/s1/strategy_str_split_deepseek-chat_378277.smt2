(set-logic ALL)

; Scenario: CSV Processing
; Goal: process comma-separated fields, ensure correct field counts, and detect empty fields

; Base strings
(declare-const csv String)
(declare-const comma String)
(declare-const header String)
(declare-const y String)

; str_split interface

; Field variables
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)
(declare-const tail1 String)
(declare-const tail2 String)

; Basic setup
(assert (= comma ","))
(assert (= header "id,name,age,city"))

; CSV must start with the header and have at least one data row (newline separator)
(assert (str.contains csv header))
(assert (str.contains csv "\n"))

; Focus on the first data row after header newline
(assert (= y (str.replace csv (str.++ header "\n") "")))

; Core structure mutation from seed: keep a similar "not (= ... (= ...))" shape with string ops
(assert (not (= (str.contains csv (str.replace y "" csv)) (= csv (str.++ csv y)))))

; Interpret y as a CSV row (no newline inside it, for simplicity)
(assert (not (str.contains y "\n")))
(assert (>= (str.len y) 1))

; Ensure y has exactly 4 fields separated by commas
(assert (= (str.num_splits y comma) 4))
(assert (= f0 (str.split_at y comma 0)))
(assert (= f1 (str.split_at y comma 1)))
(assert (= f2 (str.split_at y comma 2)))
(assert (= f3 (str.split_at y comma 3)))
(assert (= tail1 (str.split_rest y comma 1)))
(assert (= tail2 (str.split_rest y comma 2)))

; Field sanity constraints
(assert (>= (str.len f0) 1))
(assert (not (str.contains f0 comma)))
(assert (not (str.contains f1 comma)))
(assert (not (str.contains f2 comma)))
(assert (not (str.contains f3 comma)))

; Detect empty fields: at least one empty field must exist
(assert (or (= f0 "") (= f1 "") (= f2 "") (= f3 "")))

; Additional structure: tails should still contain expected commas when enough fields remain
(assert (str.contains tail1 comma))
(assert (str.contains tail2 comma))

; UNSAT trigger: simultaneously require all fields non-empty (contradicts empty-field detection)
(assert (and (not (= f0 "")) (not (= f1 "")) (not (= f2 "")) (not (= f3 ""))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
