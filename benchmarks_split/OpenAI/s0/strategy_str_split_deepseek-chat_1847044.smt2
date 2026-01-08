(set-logic ALL)

; Uninterpreted interface functions for string split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; ---------- SAT instance: a well-formed CSV line with some constraints ----------
(declare-const csv_line String)
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)
(declare-const rest2 String)
(declare-const comma_count Int)

(assert (= delim ","))

; Field extraction via split
(assert (= f0 (split_at csv_line delim 0)))
(assert (= f1 (split_at csv_line delim 1)))
(assert (= f2 (split_at csv_line delim 2)))
(assert (= f3 (split_at csv_line delim 3)))
(assert (= rest2 (split_rest csv_line delim 2)))

; Expect exactly 4 fields
(assert (= (num_splits csv_line delim) 4))

; Basic CSV well-formedness in this simplified setting:
; length non-empty line and delimiter actually appears
(assert (> (str.len csv_line) 0))
(assert (str.contains csv_line delim))

; No empty fields in positions 0 and 2; allow field1 to be empty (tests empty-field detection)
(assert (> (str.len f0) 0))
(assert (= (str.len f1) 0))
(assert (> (str.len f2) 0))

; Constrain content patterns for fields: f0 alphabetic, f2 numeric-ish, f3 fixed tag
(assert (str.in_re f0 (re.+ (re.range "A" "Z"))))
(assert (str.in_re f2 (re.+ (re.range "0" "9"))))
(assert (= f3 "END"))

; Tie rest2 to a concrete shape "<f2>,<f3>" using concatenation
(assert (= rest2 (str.++ f2 delim f3)))

; Extra consistency: commas count derived from field count
(assert (= comma_count (- (num_splits csv_line delim) 1)))
(assert (= comma_count 3))

; A concrete satisfying witness (still consistent with split interface)
(assert (= csv_line (str.++ "ABC" delim "" delim "123" delim "END")))

; ---------- UNSAT instance: contradictory requirements about emptiness and split results ----------
(declare-const bad_csv String)
(declare-const g0 String)
(declare-const g1 String)
(declare-const g2 String)
(declare-const g3 String)

(assert (= g0 (split_at bad_csv "," 0)))
(assert (= g1 (split_at bad_csv "," 1)))
(assert (= g2 (split_at bad_csv "," 2)))
(assert (= g3 (split_at bad_csv "," 3)))

; Exactly 4 fields
(assert (= (num_splits bad_csv ",") 4))

; Force a concrete bad_csv where second field is empty
(assert (= bad_csv (str.++ "X" "," "" "," "Y" "," "Z")))

; Contradiction: require g1 to be both empty and non-empty
(assert (= g1 ""))
(assert (> (str.len g1) 0))

(check-sat)


; [GENERATION STATUS: SUCCESS]