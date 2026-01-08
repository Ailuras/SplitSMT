(set-logic ALL)
(declare-fun var0 () String)
(assert (str.in_re var0 (re.++ (re.+ (re.union (str.to_re "000") (str.to_re "1"))) (re.++ (re.* (re.* (str.to_re "2"))) (re.++ (re.+ (re.+ (str.to_re "33"))) (re.++ (re.* (re.* (str.to_re "44"))) (re.++ (re.* (re.union (str.to_re "55") (str.to_re "666"))) (re.++ (re.+ (re.* (str.to_re "77"))) (re.++ (re.* (re.union (str.to_re "8") (str.to_re "9"))) (re.++ (re.+ (re.+ (str.to_re "a"))) (re.++ (re.* (re.union (str.to_re "bbb") (str.to_re "c"))) (re.++ (re.union (re.* (str.to_re "d")) (re.union (str.to_re "eee") (str.to_re "fff"))) (re.++ (re.* (re.union (str.to_re "ggg") (str.to_re "hh"))) (re.++ (re.* (re.union (str.to_re "i") (str.to_re "j"))) (re.++ (re.+ (re.+ (str.to_re "k"))) (re.++ (re.* (re.union (str.to_re "l") (str.to_re "mmm"))) (re.++ (re.+ (re.+ (str.to_re "nn"))) (re.++ (re.* (re.union (str.to_re "o") (str.to_re "p"))) (re.++ (re.* (re.+ (str.to_re "qq"))) (re.++ (re.+ (re.+ (str.to_re "rr"))) (re.++ (re.+ (re.+ (str.to_re "s"))) (re.++ (re.* (re.+ (str.to_re "ttt"))) (re.++ (re.* (re.union (str.to_re "uu") (str.to_re "v"))) (re.++ (re.union (re.* (str.to_re "w")) (re.union (str.to_re "xx") (str.to_re "yy"))) (re.++ (re.+ (re.+ (str.to_re "zz"))) (re.++ (re.union (re.* (str.to_re "AA")) (re.+ (str.to_re "BBB"))) (re.++ (re.+ (re.* (str.to_re "C"))) (re.++ (re.+ (re.* (str.to_re "DD"))) (re.++ (re.+ (re.+ (str.to_re "EE"))) (re.++ (re.* (re.+ (str.to_re "FF"))) (re.++ (re.* (re.+ (str.to_re "GGG"))) (re.++ (re.* (re.+ (str.to_re "HH"))) (re.++ (re.* (re.union (str.to_re "II") (str.to_re "JJJ"))) (re.++ (re.+ (re.* (str.to_re "KK"))) (re.++ (re.union (re.* (str.to_re "LLL")) (re.union (str.to_re "M") (str.to_re "NNN"))) (re.++ (re.union (re.* (str.to_re "O")) (re.union (str.to_re "P") (str.to_re "Q"))) (re.++ (re.+ (re.* (str.to_re "RRR"))) (re.++ (re.+ (re.union (str.to_re "SS") (str.to_re "T"))) (re.++ (re.union (re.* (str.to_re "UUU")) (re.+ (str.to_re "VVV"))) (re.++ (re.* (re.union (str.to_re "W") (str.to_re "XXX"))) (re.++ (re.union (re.+ (str.to_re "YYY")) (re.union (str.to_re "Z") (str.to_re "!!!"))) (re.++ (re.+ (re.* (str.to_re """"))) (re.++ (re.union (re.+ (str.to_re "#")) (re.+ (str.to_re "$$"))) (re.++ (re.* (re.* (str.to_re "%%%"))) (re.++ (re.* (re.union (str.to_re "&") (str.to_re "'"))) (re.++ (re.* (re.* (str.to_re "(("))) (re.++ (re.* (re.union (str.to_re ")") (str.to_re "***"))) (re.++ (re.union (re.* (str.to_re "++")) (re.+ (str.to_re ",,,"))) (re.++ (re.* (re.+ (str.to_re "---"))) (re.++ (re.+ (re.* (str.to_re "."))) (re.++ (re.* (re.+ (str.to_re "///"))) (re.++ (re.* (re.union (str.to_re "::") (str.to_re ";"))) (re.++ (re.* (re.union (str.to_re "<") (str.to_re "=="))) (re.++ (re.+ (re.+ (str.to_re ">"))) (re.++ (re.+ (re.+ (str.to_re "???"))) (re.++ (re.union (re.union (str.to_re "@@") (str.to_re "[")) (re.+ (str.to_re "\\\\\\"))) (re.* (re.union (str.to_re "]") (str.to_re "^")))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

(declare-const seg0 String)
(declare-const seg1 String)
(declare-const rest1 String)
(declare-const ns Int)

(assert (= ns (num_splits var0 "33")))
(assert (>= ns 2))
(assert (= seg0 (split_at var0 "33" 0)))
(assert (= seg1 (split_at var0 "33" 1)))
(assert (= rest1 (split_rest var0 "33" 1)))
(assert (= var0 (str.++ seg0 "33" rest1)))
(assert (not (str.contains seg0 "33")))
(assert (not (str.contains seg1 "33")))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
