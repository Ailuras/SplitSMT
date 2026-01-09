(set-logic ALL)

; Uninterpreted functions for str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; -----------------------------
; SAT instance: CSV line processing
; -----------------------------
(declare-const csv_line String)
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)
(declare-const tail2 String)
(declare-const idx0 Int)
(declare-const idx1 Int)
(declare-const idx2 Int)
(declare-const idx3 Int)

(assert (= delim ","))

; indices are natural
(assert (and (<= 0 idx0) (<= 0 idx1) (<= 0 idx2) (<= 0 idx3)))
(assert (= idx0 0))
(assert (= idx1 1))
(assert (= idx2 2))
(assert (= idx3 3))

; CSV has exactly 4 fields
(assert (= (num_splits csv_line delim) 4))

; Extract fields and rest
(assert (= f0 (split_at csv_line delim idx0)))
(assert (= f1 (split_at csv_line delim idx1)))
(assert (= f2 (split_at csv_line delim idx2)))
(assert (= f3 (split_at csv_line delim idx3)))
(assert (= tail2 (split_rest csv_line delim 2)))

; Basic well-formedness: fields cannot contain commas themselves
(assert (not (str.contains f0 delim)))
(assert (not (str.contains f1 delim)))
(assert (not (str.contains f2 delim)))
(assert (not (str.contains f3 delim)))

; Detect empty field: require at least one empty field among the four
(assert (or (= f0 "") (= f1 "") (= f2 "") (= f3 "")))

; But require first field is a non-empty identifier of letters/underscores/digits
(declare-const id_re RegLan)
(assert (= id_re (re.++ (re.union (str.to_re "_") (re.range "A" "Z") (re.range "a" "z"))
                       (re.* (re.union (str.to_re "_") (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9"))))))
(assert (str.in_re f0 id_re))
(assert (> (str.len f0) 0))

; Require second field is empty specifically (typical missing column)
(assert (= f1 ""))

; Third field is an integer-like string: optional '-' then digits, and non-empty
(declare-const int_re RegLan)
(assert (= int_re (re.++ (re.* (str.to_re "-")) (re.+ (re.range "0" "9")))))
(assert (str.in_re f2 int_re))

; Fourth field is either empty or alphabetic word
(declare-const word_re RegLan)
(assert (= word_re (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))) )
(assert (or (= f3 "") (str.in_re f3 word_re)))

; Rest-from-2 should mention delimiter if there are fields after index 2
(assert (>= (num_splits tail2 delim) 1))

; Ensure the whole line is not empty
(assert (> (str.len csv_line) 0))

(check-sat)

; -----------------------------
; UNSAT instance: contradictory CSV constraints (field count vs empty-field placement)
; -----------------------------
(declare-const bad_line String)
(declare-const b0 String)
(declare-const b1 String)
(declare-const b2 String)
(declare-const b3 String)

; Claim exactly 3 fields but also constrain 4th field extraction to be non-empty
(assert (= (num_splits bad_line delim) 3))
(assert (= b0 (split_at bad_line delim 0)))
(assert (= b1 (split_at bad_line delim 1)))
(assert (= b2 (split_at bad_line delim 2)))
(assert (= b3 (split_at bad_line delim 3)))

; additionally require all three existing fields are non-empty
(assert (> (str.len b0) 0))
(assert (> (str.len b1) 0))
(assert (> (str.len b2) 0))

; but require b3 is empty (as if trailing comma created empty field) AND non-empty simultaneously
(assert (= b3 ""))
(assert (> (str.len b3) 0))

(check-sat)



; [GENERATION STATUS: SUCCESS]