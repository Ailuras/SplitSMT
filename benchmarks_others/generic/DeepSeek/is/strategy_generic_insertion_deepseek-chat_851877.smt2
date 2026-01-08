(set-logic ALL)
(declare-fun var0 () String)
(assert (str.in_re var0 (re.++ (re.union (re.union (str.to_re "00") (str.to_re "111")) (re.+ (str.to_re "2"))) (re.++ (re.union (re.+ (str.to_re "3")) (re.+ (str.to_re "44"))) (re.++ (re.* (re.* (str.to_re "555"))) (re.++ (re.union (re.+ (str.to_re "666")) (re.+ (str.to_re "7"))) (re.++ (re.union (re.union (str.to_re "88") (str.to_re "9")) (re.+ (str.to_re "aa"))) (re.++ (re.+ (re.union (str.to_re "bb") (str.to_re "cc"))) (re.++ (re.* (re.+ (str.to_re "d"))) (re.++ (re.union (re.union (str.to_re "e") (str.to_re "fff")) (re.+ (str.to_re "gg"))) (re.++ (re.union (re.+ (str.to_re "hhh")) (re.union (str.to_re "iii") (str.to_re "jjj"))) (re.++ (re.* (re.union (str.to_re "k") (str.to_re "l"))) (re.+ (re.union (str.to_re "mmm") (str.to_re "n")))))))))))))))
(assert (not (str.in_re var0 (re.++ (re.union (re.* (str.to_re "0")) (re.union (str.to_re "1") (str.to_re "222"))) (re.++ (re.+ (re.* (str.to_re "33"))) (re.++ (re.union (re.* (str.to_re "44")) (re.* (str.to_re "55"))) (re.++ (re.* (re.* (str.to_re "666"))) (re.++ (re.* (re.union (str.to_re "777") (str.to_re "8"))) (re.++ (re.+ (re.union (str.to_re "9") (str.to_re "aa"))) (re.++ (re.union (re.* (str.to_re "bbb")) (re.* (str.to_re "cc"))) (re.++ (re.union (re.+ (str.to_re "dd")) (re.* (str.to_re "e"))) (re.++ (re.union (re.* (str.to_re "ff")) (re.* (str.to_re "ggg"))) (re.++ (re.+ (re.union (str.to_re "hhh") (str.to_re "i"))) (re.union (re.+ (str.to_re "j")) (re.+ (str.to_re "kkk"))))))))))))))))

; --- START CONSTRAINT ---
; Declare interface functions for str_split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
; Declare new variables for split operations
(declare-const delimiter String)
(declare-const segment0 String)
(declare-const segment1 String)
(declare-const total_segments Int)
(declare-const rest_string String)
; Assert constraints using str_split operations
(assert (= delimiter ":"))
(assert (= segment0 (split_at var0 delimiter 0)))
(assert (= segment1 (split_at var0 delimiter 1)))
(assert (= total_segments (num_splits var0 delimiter)))
(assert (>= total_segments 2))
(assert (= rest_string (split_rest var0 delimiter 2)))
(assert (>= (str.len segment0) 1))
(assert (>= (str.len segment1) 1))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
