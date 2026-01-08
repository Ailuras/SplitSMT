(set-logic ALL)
(declare-const x String)
(assert (str.in_re x (re.* (re.union (str.to_re "aaaabbbbccccdddd") (str.to_re "111122223333")))))
(assert (= 20 (str.len x)))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

(declare-const seg0 String)
(declare-const seg1 String)
(declare-const seg2 String)
(declare-const rest1 String)

(assert (>= (num_splits x "bb") 2))
(assert (= seg0 (split_at x "bb" 0)))
(assert (= seg1 (split_at x "bb" 1)))
(assert (= seg2 (split_at x "bb" 2)))
(assert (= rest1 (split_rest x "bb" 1)))
(assert (= (str.++ seg0 "bb" rest1) x))
(assert (str.contains x "bb"))
(assert (>= (str.len seg0) 0))
(assert (>= (str.len seg1) 0))
(assert (>= (str.len seg2) 0))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
