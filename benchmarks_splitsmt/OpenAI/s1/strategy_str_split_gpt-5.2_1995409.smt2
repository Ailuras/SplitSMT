(set-logic ALL)

; CSV Processing scenario: comma-separated data fields, ensuring correct field counts and detecting empty fields.
; Core seed structure preserved (same variables and equalities), extended with str_split constraints.

(declare-fun B () String)
(declare-fun A () String)
(declare-fun J () String)
(declare-fun C () String)

; str_split interface (uninterpreted per instructions)

; Derived CSV row string
(declare-const csv_row String)

; Field variables (CSV columns)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)

; Preserve core structure constraints from seed
(assert (= (str.++ "dbefbfbae" B "cc" J "dcbcfbe") (str.++ "dbefbfbaeb" C A "cbfbafcfdfcadcbcfbe")))
(assert (= (str.++ "fbfedbbcd" A "adeabed" A "dfafccdcfdddabcbfaff") (str.++ "fbfedbbcdeeadeabedeedfafccdcfdddabcbfaff" "")))
(assert (= (str.++ "cddaadaaddfbccdaafacaeadbcfadbfeedfcceca" "") (str.++ "cddaadaaddfbccdaafacaeadbcfadbf" A "dfcceca")))

; Adjusted size bounds (mutated slightly) while remaining consistent
(assert (<= (* (str.len A) 1) 4))
(assert (<= (* (str.len B) 12) 468))
(assert (>= (* (str.len J) 8) 88))
(assert (<= (* (str.len J) 3) 69))
(assert (>= (* (str.len C) 19) 95))

; CSV construction: four columns separated by commas
(assert (= csv_row (str.++ C "," A "," B "," J)))

; Enforce field count = 4 segments
(assert (= (str.num_splits csv_row ",") 4))

; Link split fields
(assert (= f0 (str.split_at csv_row "," 0)))
(assert (= f1 (str.split_at csv_row "," 1)))
(assert (= f2 (str.split_at csv_row "," 2)))
(assert (= f3 (str.split_at csv_row "," 3)))

; Field-to-variable mapping consistency
(assert (= f0 C))
(assert (= f1 A))
(assert (= f2 B))
(assert (= f3 J))

; Detect empty fields: ensure A is empty (forces an empty CSV field between commas)
(assert (= A ""))

; Non-empty constraints for other fields
(assert (> (str.len C) 0))
(assert (> (str.len B) 0))
(assert (> (str.len J) 0))

; Check that the rest from field 1 begins with the empty field delimiter pattern
(assert (= (str.split_rest csv_row "," 1) (str.++ A "," B "," J)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
