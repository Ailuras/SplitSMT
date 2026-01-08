(set-logic ALL)
(declare-const y String)
(declare-const y1 String)
(declare-const y2 String)
(declare-const y3 String)
(declare-const x String)
(declare-const z String)
(assert (= y1 (str.replace_all y "u" "A")))
(assert (= y2 (str.replace_all y1 "a" "T")))
(assert (= y3 (str.replace_all y2 "g" "C")))
(assert (= x  (str.replace_all y3 "c" "G")))
(assert (= x "CTTGTAAGCAACCTATGAGACTGTATGTCGCTCTCTTCACGTATGTACGGATGATTAGTACAAGTAGTTTACTGTCTAACTCTCCTATAGCCTAACTACTGTGGTCATGCGGTGCACATTTTGGGTAGCAATGACCTGGGCCGGAAGCGCCCACCCGGTCCCTAGCGTGTACAATTAGAGGCGGACATTGCGGTCGTCCG"))
(assert (= z "ugaugacaccaguacg"))
(assert (str.contains y z))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

(declare-const del String)
(declare-const k Int)
(declare-const prefix String)
(declare-const suffix String)

(assert (= del z))
(assert (= k 1))
(assert (>= (num_splits y del) 2))
(assert (= prefix (split_at y del 0)))
(assert (= suffix (split_rest y del k)))
(assert (= y (str.++ prefix del suffix)))
(assert (>= (str.len prefix) 0))
(assert (>= (str.len suffix) 0))
; --- END CONSTRAINT ---

(check-sat)
(get-value (y))

; [GENERATION STATUS: SUCCESS]
(check-sat)