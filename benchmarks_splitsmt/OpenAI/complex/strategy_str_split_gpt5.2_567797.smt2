(set-logic ALL)
; Scenario: CSV Processing
; Goal: process comma-separated fields, ensure correct field counts, and detect empty fields

; str_split interface (uninterpreted)

; CSV line and delimiter
(declare-const X String)
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const tail2 String)
(declare-const has_empty Bool)

(assert (= delim ","))

; Keep core structure: keep seed-style regex constraints but adapt to CSV-like prefix/suffix
(assert (str.in_re X
  (re.++
    (str.to_re "name,age,score")
    (str.to_re "\u{a}")
    (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re ",") (str.to_re " ") (str.to_re "-")))
  )
))

; Another regex: require at least one comma somewhere after header to ensure CSV nature
(assert (str.in_re X
  (re.++
    (re.* (re.comp (str.to_re "\u{a}")))
    (str.to_re ",")
    (re.* (re.comp (str.to_re "\u{a}")))
  )
))

; Adapt seed's negative pattern: forbid a filename-like injection in the CSV line
(assert (not (str.in_re X
  (re.++ (str.to_re "/filename=") (re.* (re.comp (str.to_re "\u{a}"))) (str.to_re ".f4p") )
)))

; Split constraints for CSV processing
(assert (>= (str.len X) 1))
(assert (>= (str.num_splits X delim) 3))

(assert (= f0 (str.split_at X delim 0)))
(assert (= f1 (str.split_at X delim 1)))
(assert (= f2 (str.split_at X delim 2)))
(assert (= tail2 (str.split_rest X delim 2)))

; Indices are natural / valid
(assert (and (>= 0 0) (>= 1 0) (>= 2 0)))

; Header fields must be exact and non-empty
(assert (= f0 "name"))
(assert (= f1 "age"))
(assert (= f2 "score\u{a}"))

; Detect empty fields: either a leading empty field, middle empty, or trailing empty
(assert (= has_empty
  (or
    (= (str.split_at X delim 0) "")
    (= (str.split_at X delim 1) "")
    (= (str.split_at X delim 2) "")
    (str.contains X ",,")
    (str.in_re X (re.++ (re.* (re.comp (str.to_re "\u{a}"))) (str.to_re ",\u{a}")))
  )
))

; For this instance, enforce that empty-field detection is false (i.e., no empty fields)
(assert (not has_empty))

; Also require exactly 3 fields for a simple CSV row after header
(assert (= (str.num_splits X delim) 3))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
