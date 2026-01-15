(set-logic ALL)
(declare-fun var0 () String)
(assert (str.in_re var0 (re.++ (re.+ (re.union (re.* (re.union (re.+ (re.union (str.to_re "0") (str.to_re "11"))) (re.+ (re.union (str.to_re "2") (str.to_re "333"))))) (re.+ (re.union (re.+ (re.+ (str.to_re "4"))) (re.* (re.* (str.to_re "5"))))))) (re.+ (re.union (re.+ (re.union (re.* (re.union (str.to_re "666") (str.to_re "777"))) (re.* (re.* (str.to_re "8"))))) (re.+ (re.union (re.union (re.union (str.to_re "999") (str.to_re "a")) (re.union (str.to_re "b") (str.to_re "c"))) (re.* (re.* (str.to_re "dd"))))))))))
(assert (<= 15 (str.len var0)))

; --- START CONSTRAINT ---

(declare-fun seg0 () String)
(declare-fun seg1 () String)
(declare-fun rest1 () String)

(assert (>= (str.num_splits var0 "a") 2))
(assert (= seg0 (str.split_at var0 "a" 0)))
(assert (= seg1 (str.split_at var0 "a" 1)))
(assert (= rest1 (str.split_rest var0 "a" 1)))
(assert (= var0 (str.++ seg0 "a" rest1)))
(assert (<= 1 (str.len seg0)))
(assert (<= 1 (str.len seg1)))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
