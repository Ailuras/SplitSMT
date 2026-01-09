(set-logic ALL)

; Uninterpreted interface for string split operations
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; ----------------------
; SAT instance: CSV with 4 fields, no empty fields, simple validation
; ----------------------
(declare-const csv_line String)
(declare-const delim String)
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const field3 String)

(assert (= delim ","))

; Bind fields via split interface
(assert (= field0 (split_at csv_line delim 0)))
(assert (= field1 (split_at csv_line delim 1)))
(assert (= field2 (split_at csv_line delim 2)))
(assert (= field3 (split_at csv_line delim 3)))

; Exactly 4 segments (fields)
(assert (= (num_splits csv_line delim) 4))

; Reconstruct the CSV line from fields (commas between fields)
(assert (= csv_line (str.++ field0 delim field1 delim field2 delim field3)))

; Detect and forbid empty fields
(assert (> (str.len field0) 0))
(assert (> (str.len field1) 0))
(assert (> (str.len field2) 0))
(assert (> (str.len field3) 0))

; Additional CSV-ish constraints: no commas inside fields
(assert (not (str.contains field0 delim)))
(assert (not (str.contains field1 delim)))
(assert (not (str.contains field2 delim)))
(assert (not (str.contains field3 delim)))

; A small format restriction for field0: alphabetic tag, at least 2 chars
(assert (>= (str.len field0) 2))
(assert (str.in_re field0 (re.++ (re.+ (re.union (str.to_re "A") (str.to_re "B") (str.to_re "C") (str.to_re "D") (str.to_re "E") (str.to_re "F") (str.to_re "G") (str.to_re "H") (str.to_re "I") (str.to_re "J") (str.to_re "K") (str.to_re "L") (str.to_re "M") (str.to_re "N") (str.to_re "O") (str.to_re "P") (str.to_re "Q") (str.to_re "R") (str.to_re "S") (str.to_re "T") (str.to_re "U") (str.to_re "V") (str.to_re "W") (str.to_re "X") (str.to_re "Y") (str.to_re "Z")
                                              (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e") (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j") (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o") (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t") (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y") (str.to_re "z")))
                  (re.* (re.union (str.to_re "A") (str.to_re "B") (str.to_re "C") (str.to_re "D") (str.to_re "E") (str.to_re "F") (str.to_re "G") (str.to_re "H") (str.to_re "I") (str.to_re "J") (str.to_re "K") (str.to_re "L") (str.to_re "M") (str.to_re "N") (str.to_re "O") (str.to_re "P") (str.to_re "Q") (str.to_re "R") (str.to_re "S") (str.to_re "T") (str.to_re "U") (str.to_re "V") (str.to_re "W") (str.to_re "X") (str.to_re "Y") (str.to_re "Z")
                               (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e") (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j") (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o") (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t") (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y") (str.to_re "z"))))))

; field1 numeric: all digits and at least 1 char
(assert (>= (str.len field1) 1))
(assert (str.in_re field1 (re.+ (re.union (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9")))))

; field2 could be an email-ish token: must contain '@' and no spaces
(assert (str.contains field2 "@"))
(assert (not (str.contains field2 " ")))

; field3 is a flag: "Y" or "N"
(assert (or (= field3 "Y") (= field3 "N")))

(check-sat)

; ----------------------
; UNSAT instance: CSV requires an empty middle field but also forbids empties
; ----------------------
(push 1)

(declare-const csv_line_bad String)
(declare-const bad_f0 String)
(declare-const bad_f1 String)
(declare-const bad_f2 String)

(assert (= (num_splits csv_line_bad ",") 3))
(assert (= bad_f0 (split_at csv_line_bad "," 0)))
(assert (= bad_f1 (split_at csv_line_bad "," 1)))
(assert (= bad_f2 (split_at csv_line_bad "," 2)))

; Force an empty field in the middle (",,") by construction
(assert (= csv_line_bad (str.++ bad_f0 "," "" "," bad_f2)))
(assert (= bad_f1 ""))

; But also enforce "no empty fields" -> contradiction
(assert (> (str.len bad_f0) 0))
(assert (> (str.len bad_f1) 0))
(assert (> (str.len bad_f2) 0))

(check-sat)
(pop 1)

; ----------------------
; SAT instance: detect empty fields allowed, ensure count and suffix processing using split_rest
; ----------------------
(push 1)

(declare-const csv_line2 String)
(declare-const f2_0 String)
(declare-const f2_1 String)
(declare-const f2_2 String)
(declare-const tail_from_1 String)

(assert (= (num_splits csv_line2 ",") 3))
(assert (= f2_0 (split_at csv_line2 "," 0)))
(assert (= f2_1 (split_at csv_line2 "," 1)))
(assert (= f2_2 (split_at csv_line2 "," 2)))

; Allow empties, but require at least one empty field exists
(assert (or (= f2_0 "") (= f2_1 "") (= f2_2 "")))

; Define tail starting at field index 1
(assert (= tail_from_1 (split_rest csv_line2 "," 1)))

; If we reconstruct, tail_from_1 should match "f2_1,f2_2"
(assert (= tail_from_1 (str.++ f2_1 "," f2_2)))

; Constrain line to a particular pattern with an empty middle field
(assert (= csv_line2 (str.++ "A" "," "" "," "Z")))

(check-sat)
(pop 1)



; [GENERATION STATUS: SUCCESS]
(check-sat)