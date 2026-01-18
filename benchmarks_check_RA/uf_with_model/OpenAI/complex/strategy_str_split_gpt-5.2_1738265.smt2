(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Scenario: CSV Processing
; Goal: process comma-separated fields, ensure correct field counts, and detect empty fields.

; Uninterpreted split interface

; CSV input and derived fields
(declare-const csv String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)
(declare-const suffix_from_2 String)

; Preserve/extend core structure with a related regex over the whole CSV string
; This loosely constrains that data tokens are made from a small alphabet and separators.
(assert (str.in_re csv
  (re.++
    (re.* (re.union (str.to_re "00") (str.to_re "11") (str.to_re "2") (str.to_re "333") (str.to_re "444") (str.to_re "5") (str.to_re ",")))
    (re.* (str.to_re "")))))

; Split by comma into 4 fields
(assert (= 4 (num_splits csv ",")))
(assert (= f0 (split_at csv "," 0)))
(assert (= f1 (split_at csv "," 1)))
(assert (= f2 (split_at csv "," 2)))
(assert (= f3 (split_at csv "," 3)))
(assert (= suffix_from_2 (split_rest csv "," 2)))

; Non-empty fields expected for f0,f1,f3
(assert (> (str.len f0) 0))
(assert (> (str.len f1) 0))
(assert (> (str.len f3) 0))

; Detect empty field at position 2
(assert (= f2 ""))

; Additional structure: f0 must start with a typical token, and f3 must not contain commas
(assert (or (str.prefixof "00" f0) (str.prefixof "11" f0)))
(assert (not (str.contains f3 ",")))

; Consistency with suffix: since f2 is empty, the suffix from index 2 should begin with a comma
(assert (str.prefixof "," suffix_from_2))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(get-model)
(exit)
