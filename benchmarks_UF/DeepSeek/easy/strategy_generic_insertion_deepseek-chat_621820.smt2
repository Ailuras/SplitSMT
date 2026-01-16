(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun var0 () String)
(assert (str.in_re var0 (re.++ (re.+ (re.+ (str.to_re "00"))) (re.++ (re.+ (re.union (str.to_re "1") (str.to_re "22"))) (re.++ (re.+ (re.* (str.to_re "333"))) (re.++ (re.union (re.+ (str.to_re "444")) (re.+ (str.to_re "55"))) (re.++ (re.+ (re.* (str.to_re "66"))) (re.++ (re.* (re.+ (str.to_re "77"))) (re.++ (re.* (re.union (str.to_re "888") (str.to_re "9"))) (re.++ (re.* (re.union (str.to_re "a") (str.to_re "bbb"))) (re.++ (re.* (re.* (str.to_re "ccc"))) (re.++ (re.* (re.+ (str.to_re "dd"))) (re.++ (re.union (re.+ (str.to_re "ee")) (re.* (str.to_re "ff"))) (re.++ (re.union (re.* (str.to_re "ggg")) (re.* (str.to_re "hh"))) (re.++ (re.union (re.union (str.to_re "ii") (str.to_re "j")) (re.+ (str.to_re "kkk"))) (re.++ (re.union (re.union (str.to_re "l") (str.to_re "mm")) (re.* (str.to_re "n"))) (re.++ (re.* (re.+ (str.to_re "oo"))) (re.++ (re.+ (re.+ (str.to_re "ppp"))) (re.++ (re.+ (re.* (str.to_re "qqq"))) (re.++ (re.union (re.+ (str.to_re "rr")) (re.union (str.to_re "sss") (str.to_re "t"))) (re.++ (re.+ (re.union (str.to_re "uuu") (str.to_re "vvv"))) (re.++ (re.union (re.* (str.to_re "w")) (re.union (str.to_re "xxx") (str.to_re "yy"))) (re.++ (re.union (re.union (str.to_re "zzz") (str.to_re "AAA")) (re.union (str.to_re "BBB") (str.to_re "CCC"))) (re.++ (re.+ (re.* (str.to_re "DD"))) (re.++ (re.+ (re.+ (str.to_re "EEE"))) (re.++ (re.union (re.* (str.to_re "F")) (re.union (str.to_re "GGG") (str.to_re "H"))) (re.++ (re.+ (re.* (str.to_re "II"))) (re.++ (re.* (re.union (str.to_re "JJ") (str.to_re "K"))) (re.++ (re.union (re.* (str.to_re "LLL")) (re.+ (str.to_re "M"))) (re.++ (re.union (re.union (str.to_re "NNN") (str.to_re "O")) (re.* (str.to_re "P"))) (re.++ (re.* (re.+ (str.to_re "QQ"))) (re.++ (re.union (re.union (str.to_re "RR") (str.to_re "S")) (re.+ (str.to_re "T"))) (re.++ (re.* (re.union (str.to_re "U") (str.to_re "V"))) (re.++ (re.+ (re.+ (str.to_re "WWW"))) (re.++ (re.* (re.* (str.to_re "XX"))) (re.++ (re.* (re.union (str.to_re "Y") (str.to_re "Z"))) (re.++ (re.union (re.union (str.to_re "!") (str.to_re """""""")) (re.+ (str.to_re "#"))) (re.++ (re.+ (re.union (str.to_re "$$$") (str.to_re "%%%"))) (re.++ (re.union (re.* (str.to_re "&&")) (re.union (str.to_re "'''") (str.to_re "((("))) (re.++ (re.* (re.union (str.to_re "))") (str.to_re "**"))) (re.++ (re.+ (re.* (str.to_re "+"))) (re.++ (re.* (re.* (str.to_re ",,"))) (re.++ (re.* (re.union (str.to_re "--") (str.to_re ".."))) (re.++ (re.* (re.+ (str.to_re "/"))) (re.++ (re.+ (re.+ (str.to_re ":::"))) (re.++ (re.+ (re.+ (str.to_re ";;;"))) (re.++ (re.* (re.union (str.to_re "<") (str.to_re "==="))) (re.++ (re.* (re.+ (str.to_re ">>"))) (re.++ (re.union (re.union (str.to_re "???") (str.to_re "@")) (re.+ (str.to_re "["))) (re.++ (re.+ (re.+ (str.to_re "\\"))) (re.++ (re.+ (re.union (str.to_re "]]") (str.to_re "^^^"))) (re.++ (re.union (re.* (str.to_re "__")) (re.* (str.to_re "`"))) (re.++ (re.+ (re.union (str.to_re "{") (str.to_re "|"))) (re.++ (re.union (re.union (str.to_re "}}}") (str.to_re "~")) (re.* (str.to_re "0"))) (re.* (re.union (str.to_re "11") (str.to_re "222")))))))))))))))))))))))))))))))))))))))))))))))))))))))))

; --- START CONSTRAINT ---
; Declare interface functions for str_split
; Declare new variables for split operations
(declare-const delimiter String)
(declare-const segment0 String)
(declare-const segment1 String)
(declare-const rest_segments String)
; Assert constraints using str_split operations
(assert (= delimiter ":::"))
(assert (= segment0 (split_at var0 delimiter 0)))
(assert (= segment1 (split_at var0 delimiter 1)))
(assert (= rest_segments (split_rest var0 delimiter 2)))
(assert (>= (num_splits var0 delimiter) 3))
(assert (>= (str.len segment0) 5))
(assert (>= (str.len segment1) 3))
(assert (str.contains rest_segments "00"))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
