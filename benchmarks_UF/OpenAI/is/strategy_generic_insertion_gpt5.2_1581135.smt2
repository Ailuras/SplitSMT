(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun var0 () String)
(assert (str.in_re var0 (re.++ (re.+ (re.union (str.to_re "000") (str.to_re "11"))) (re.++ (re.union (re.+ (str.to_re "2")) (re.+ (str.to_re "33"))) (re.++ (re.+ (re.* (str.to_re "44"))) (re.++ (re.union (re.union (str.to_re "55") (str.to_re "666")) (re.+ (str.to_re "7"))) (re.++ (re.union (re.+ (str.to_re "88")) (re.union (str.to_re "9") (str.to_re "aa"))) (re.++ (re.union (re.+ (str.to_re "bbb")) (re.* (str.to_re "cc"))) (re.++ (re.* (re.union (str.to_re "dd") (str.to_re "e"))) (re.++ (re.* (re.+ (str.to_re "ff"))) (re.++ (re.union (re.+ (str.to_re "g")) (re.* (str.to_re "hh"))) (re.union (re.* (str.to_re "i")) (re.+ (str.to_re "j"))))))))))))))
(assert (str.in_re var0 (re.++ (re.* (re.union (str.to_re "000") (str.to_re "111"))) (re.++ (re.union (re.union (str.to_re "2") (str.to_re "333")) (re.union (str.to_re "4") (str.to_re "555"))) (re.++ (re.+ (re.* (str.to_re "666"))) (re.++ (re.union (re.* (str.to_re "77")) (re.* (str.to_re "88"))) (re.++ (re.+ (re.* (str.to_re "99"))) (re.++ (re.union (re.* (str.to_re "aaa")) (re.* (str.to_re "b"))) (re.++ (re.+ (re.+ (str.to_re "ccc"))) (re.++ (re.* (re.+ (str.to_re "d"))) (re.++ (re.+ (re.+ (str.to_re "ee"))) (re.union (re.union (str.to_re "fff") (str.to_re "g")) (re.union (str.to_re "hh") (str.to_re "i"))))))))))))))
(assert (str.in_re var0 (re.++ (re.* (re.+ (str.to_re "0"))) (re.++ (re.+ (re.* (str.to_re "1"))) (re.++ (re.union (re.* (str.to_re "22")) (re.union (str.to_re "333") (str.to_re "444"))) (re.++ (re.union (re.union (str.to_re "555") (str.to_re "6")) (re.* (str.to_re "777"))) (re.++ (re.+ (re.* (str.to_re "8"))) (re.++ (re.union (re.+ (str.to_re "999")) (re.union (str.to_re "a") (str.to_re "bb"))) (re.++ (re.* (re.union (str.to_re "c") (str.to_re "dd"))) (re.++ (re.* (re.* (str.to_re "eee"))) (re.++ (re.union (re.* (str.to_re "f")) (re.+ (str.to_re "ggg"))) (re.* (re.+ (str.to_re "hhh"))))))))))))))
(assert (str.in_re var0 (re.++ (re.+ (re.union (str.to_re "0") (str.to_re "11"))) (re.++ (re.union (re.* (str.to_re "222")) (re.* (str.to_re "33"))) (re.++ (re.+ (re.union (str.to_re "44") (str.to_re "5"))) (re.++ (re.union (re.* (str.to_re "666")) (re.union (str.to_re "7") (str.to_re "888"))) (re.++ (re.union (re.* (str.to_re "9")) (re.* (str.to_re "aaa"))) (re.++ (re.+ (re.union (str.to_re "bbb") (str.to_re "cc"))) (re.++ (re.* (re.* (str.to_re "d"))) (re.++ (re.+ (re.union (str.to_re "e") (str.to_re "f"))) (re.++ (re.union (re.union (str.to_re "g") (str.to_re "hhh")) (re.* (str.to_re "i"))) (re.union (re.* (str.to_re "j")) (re.union (re.+ (re.* (re.+ (str.to_re "")))) (str.to_re "lll"))))))))))))))

; --- START CONSTRAINT ---

(declare-fun seg0 () String)
(declare-fun seg1 () String)
(declare-fun seg2 () String)

(assert (>= (num_splits var0 "a") 3))
(assert (= seg0 (split_at var0 "a" 0)))
(assert (= seg1 (split_at var0 "a" 1)))
(assert (= seg2 (split_at var0 "a" 2)))
(assert (= (split_rest var0 "a" 1) (str.++ seg1 "a" (split_rest var0 "a" 2))))
(assert (str.in_re seg0 (re.* (re.union (str.to_re "0") (str.to_re "1")))))
(assert (> (str.len seg1) 0))
(assert (str.contains seg2 "bb"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
