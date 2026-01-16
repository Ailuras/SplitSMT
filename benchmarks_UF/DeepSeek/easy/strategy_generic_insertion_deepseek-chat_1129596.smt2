(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun var0 () String)
(assert (str.in_re var0 (re.++ (re.* (re.* (re.union (re.* (re.* (re.+ (re.+ (str.to_re "00"))))) (re.+ (re.+ (re.union (re.+ (str.to_re "111")) (re.union (str.to_re "22") (str.to_re "33")))))))) (re.union (re.* (re.union (re.union (re.union (re.+ (re.union (str.to_re "444") (str.to_re "55"))) (re.* (re.+ (str.to_re "666")))) (re.+ (re.* (re.union (str.to_re "777") (str.to_re "88"))))) (re.union (re.+ (re.+ (re.+ (str.to_re "9")))) (re.* (re.+ (re.union (str.to_re "aaa") (str.to_re "b"))))))) (re.union (re.+ (re.union (re.+ (re.+ (re.+ (str.to_re "cc")))) (re.* (re.* (re.+ (str.to_re "dd")))))) (re.union (re.+ (re.union (re.union (re.* (str.to_re "eee")) (re.+ (str.to_re "fff"))) (re.union (re.union (str.to_re "gg") (str.to_re "hhh")) (re.union (str.to_re "ii") (str.to_re "j"))))) (re.* (re.union (re.+ (re.* (str.to_re "k"))) (re.+ (re.* (str.to_re "l")))))))))))
(assert (<= 15 (str.len var0)))

; --- START CONSTRAINT ---
; Declare interface functions for str_split
; Declare new variables for split results
(declare-const delimiter String)
(declare-const segment0 String)
(declare-const segment1 String)
(declare-const rest_segments String)
; Assert constraints using str_split operations
(assert (= delimiter ":"))
(assert (= segment0 (split_at var0 delimiter 0)))
(assert (= segment1 (split_at var0 delimiter 1)))
(assert (= rest_segments (split_rest var0 delimiter 2)))
(assert (>= (num_splits var0 delimiter) 3))
(assert (>= (str.len segment0) 5))
(assert (<= (str.len segment1) 10))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
