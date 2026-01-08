(set-logic ALL)
(declare-const x String)
(assert (= x "'\x0c''\x0c'MMssccsscc!!"))
(assert (str.in_re x (re.union (re.* (re.* (str.to_re "sscc!!"))) (str.to_re "'\x0c''\x0c'MMsscc"))))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

(declare-const seg0 String)
(declare-const seg1 String)
(declare-const seg2 String)
(declare-const rest1 String)

(assert (= (num_splits x "sscc") 3))
(assert (= seg0 (split_at x "sscc" 0)))
(assert (= seg1 (split_at x "sscc" 1)))
(assert (= seg2 (split_at x "sscc" 2)))
(assert (= rest1 (split_rest x "sscc" 1)))

(assert (= seg0 "'\x0c''\x0c'MM"))
(assert (= seg1 ""))
(assert (= seg2 "!!"))
(assert (= rest1 "sscc!!"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]