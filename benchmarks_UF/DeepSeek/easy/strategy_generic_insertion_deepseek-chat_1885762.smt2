(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-const x String)
(assert (str.in_re x (re.+ (re.++ (str.to_re "") (str.to_re "1")))))
(assert (= 1 (str.len x)))
(assert (not (= x "BV")))
(assert (not (= x "I'\t'h'C(")))
(assert (not (= x "0^M")))

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter ","))
(assert (>= (num_splits x delimiter) 1))
(assert (= (split_at x delimiter 0) x))
(assert (= (split_rest x delimiter 0) x))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
