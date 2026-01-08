(set-logic ALL)
(declare-fun var0 () String)
(assert (str.in_re var0 (re.++ (re.+ (re.* (str.to_re "00"))) (re.++ (re.* (re.* (str.to_re "1"))) (re.++ (re.union (re.* (str.to_re "222")) (re.* (str.to_re "333"))) (re.++ (re.union (re.union (str.to_re "444") (str.to_re "5")) (re.* (str.to_re "6"))) (re.++ (re.union (re.* (str.to_re "777")) (re.+ (str.to_re "88"))) (re.++ (re.+ (re.* (str.to_re "9"))) (re.++ (re.+ (re.* (str.to_re "aa"))) (re.++ (re.union (re.union (str.to_re "bbb") (str.to_re "c")) (re.union (str.to_re "d") (str.to_re "eee"))) (re.++ (re.* (re.union (str.to_re "ff") (str.to_re "gg"))) (re.++ (re.* (re.+ (str.to_re "h"))) (re.++ (re.union (re.* (str.to_re "iii")) (re.* (str.to_re "j"))) (re.++ (re.+ (re.+ (str.to_re "kkk"))) (re.++ (re.* (re.+ (str.to_re "lll"))) (re.++ (re.union (re.union (str.to_re "mm") (str.to_re "nn")) (re.* (str.to_re "o"))) (re.* (re.* (str.to_re "pp")))))))))))))))))))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

(declare-fun seg0 () String)
(declare-fun seg1 () String)
(declare-fun rest1 () String)

(assert (>= (num_splits var0 "aa") 2))
(assert (= seg0 (split_at var0 "aa" 0)))
(assert (= seg1 (split_at var0 "aa" 1)))
(assert (= rest1 (split_rest var0 "aa" 1)))

(assert (= var0 (str.++ seg0 "aa" rest1)))
(assert (not (str.contains seg0 "aa")))
(assert (not (str.contains seg1 "aa")))
(assert (not (= seg0 "")))
(assert (not (= seg1 "")))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]