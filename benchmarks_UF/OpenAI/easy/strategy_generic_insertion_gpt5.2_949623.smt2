(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun var0 () String)
(assert (str.in_re var0 (re.++ (re.union (re.+ (str.to_re "000")) (re.+ (str.to_re "11"))) (re.++ (re.union (re.* (str.to_re "222")) (re.+ (str.to_re "3"))) (re.++ (re.union (re.union (str.to_re "444") (str.to_re "5")) (re.* (str.to_re "666"))) (re.++ (re.* (re.union (str.to_re "77") (str.to_re "8"))) (re.++ (re.+ (re.* (str.to_re "999"))) (re.++ (re.union (re.union (str.to_re "a") (str.to_re "bb")) (re.* (str.to_re "c"))) (re.++ (re.* (re.* (str.to_re "dd"))) (re.++ (re.* (re.union (str.to_re "ee") (str.to_re "ff"))) (re.++ (re.union (re.union (str.to_re "g") (str.to_re "h")) (re.* (str.to_re "iii"))) (re.+ (re.+ (str.to_re "jjj"))))))))))))))
(assert (<= 26 (str.len var0)))

; --- START CONSTRAINT ---

(declare-fun seg0 () String)
(declare-fun seg1 () String)
(declare-fun rest2 () String)

(assert (>= (num_splits var0 "a") 2))
(assert (= seg0 (split_at var0 "a" 0)))
(assert (= seg1 (split_at var0 "a" 1)))
(assert (= rest2 (split_rest var0 "a" 2)))
(assert (str.contains seg0 "000"))
(assert (<= 1 (str.len seg1)))
(assert (>= (str.len rest2) 0))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
