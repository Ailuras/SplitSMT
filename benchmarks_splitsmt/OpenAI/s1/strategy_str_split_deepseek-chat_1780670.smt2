(set-logic ALL)

; CSV Processing scenario: comma-separated fields, enforce field counts, detect empty fields

(declare-fun H () String)
(declare-fun I () String)
(declare-fun N () String)
(declare-fun G () String)
(declare-fun L () String)

(declare-const csv String)
(declare-const comma String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const rest2 String)
(declare-const expected_suffix String)

; str_split interface

(assert (= comma ","))

; Preserve the core seed structure (mutated via added constraints tying to CSV variables)
(assert (= (str.++ H "a" H "aa" H "a" H "ab" H H "b" L)
           (str.++ "a" G I H I H "b" N N "baa")))

; Build a CSV line using existing symbols, ensuring commas appear
(assert (= csv (str.++ "id" comma H comma I comma L)))

; Enforce correct field count for a 4-field CSV record
(assert (= (str.num_splits csv comma) 4))

; Extract fields
(assert (= f0 (str.split_at csv comma 0)))
(assert (= f1 (str.split_at csv comma 1)))
(assert (= f2 (str.split_at csv comma 2)))
(assert (= rest2 (str.split_rest csv comma 2)))

; Validate expected fixed first field
(assert (= f0 "id"))

; Detect empty fields: require exactly one empty among middle two fields (XOR)
(assert (xor (= f1 "") (= f2 "")))

; Additional CSV sanity: no commas inside extracted fields (simple check)
(assert (not (str.contains f1 comma)))
(assert (not (str.contains f2 comma)))

; Constrain the remaining tail to be consistent with the constructed csv
(assert (= rest2 (str.++ f2 comma L)))

; Tie suffix expectations to seed variables to preserve structure dependency
(assert (= expected_suffix (str.++ "b" N N "baa")))
(assert (str.contains (str.++ "a" G I H I H expected_suffix) "baa"))

; Ensure indices are natural (interface constraint reminder)
(assert (and (>= 0 0) (>= 1 0) (>= 2 0)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
