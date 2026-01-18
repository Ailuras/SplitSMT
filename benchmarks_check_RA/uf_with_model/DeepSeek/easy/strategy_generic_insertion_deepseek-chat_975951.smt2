(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
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
(declare-const delimiter String)
(assert (= delimiter "A"))
(assert (>= (num_splits y delimiter) 3))
(assert (= (split_at y delimiter 0) "CTTG"))
(assert (= (split_at y delimiter 1) "T"))
(assert (= (split_at y delimiter 2) "AGCAACCT"))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(get-model)
(exit)
