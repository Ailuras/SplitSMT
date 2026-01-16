(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Scenario: CSV Processing
; Purpose: reason about comma-separated fields, enforce field counts, and detect empty fields

; --- Uninterpreted split interface (str_split) ---

; --- CSV inputs and derived fields ---
(declare-const csv_line String)
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)
(declare-const trailing String)

; delimiter is comma
(assert (= delim ","))

; split projections
(assert (= f0 (split_at csv_line delim 0)))
(assert (= f1 (split_at csv_line delim 1)))
(assert (= f2 (split_at csv_line delim 2)))
(assert (= f3 (split_at csv_line delim 3)))
(assert (= trailing (split_rest csv_line delim 2)))

; core CSV well-formedness: at least 3 fields (i.e., at least two commas)
(assert (>= (num_splits csv_line delim) 3))

; require exactly 4 fields for a fixed schema
(assert (= (num_splits csv_line delim) 4))

; enforce that first and third fields are non-empty
(assert (> (str.len f0) 0))
(assert (> (str.len f2) 0))

; enforce detection of an empty field at position 1 (i.e., consecutive commas like ",,")
(assert (= f1 ""))

; field 3 is expected to be a simple integer token (optional sign, then digits)
(declare-const re_digits RegLan)
(declare-const re_int RegLan)
(assert (= re_digits (re.+ (re.range "0" "9"))))
(assert (= re_int (re.union re_digits (re.++ (str.to_re "-") re_digits))))
(assert (str.in_re f3 re_int))

; trailing from index 2 onward must contain exactly one comma (fields 2 and 3)
(assert (= (num_splits trailing delim) 2))

; additional CSV rule: no spaces anywhere in the line
(assert (not (str.contains csv_line " ")))

; Mutated seed-like regex structure to preserve core style and add a CSV-specific twist
; Here we relate presence of "A,B,A" vs "AB,AA" patterns in the CSV line
(assert
  (let ((_let_0 (re.* re.allchar)))
    (not
      (= (str.in_re csv_line (re.++ _let_0 (str.to_re (str.++ "A" (str.++ "," (str.++ "B" (str.++ "," "A"))))) _let_0))
         (str.in_re csv_line (re.++ _let_0 (str.to_re (str.++ "AB" (str.++ "," "AA"))) _let_0))))))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
