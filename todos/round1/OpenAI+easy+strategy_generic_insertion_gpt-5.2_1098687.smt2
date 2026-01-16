(set-logic ALL)
(declare-fun var0 () String)
(assert (str.in_re var0 (re.++ (re.+ (re.union (str.to_re "00") (str.to_re "11"))) (re.++ (re.* (re.* (str.to_re "2"))) (re.union (re.* (str.to_re "333")) (re.union (str.to_re "444") (str.to_re "5")))))))

; --- START CONSTRAINT ---
(declare-fun seg0 () String)
(declare-fun seg1 () String)
(assert (>= (str.len var0) 2))
(assert (= seg0 (str.split_at var0 "2" 0)))
(assert (= seg1 (str.split_at var0 "2" 1)))
(assert (>= (str.num_splits var0 "2") 2))
(assert (= var0 (str.++ seg0 (str.++ "2" (str.split_rest var0 "2" 1)))))
(assert (= (str.split_rest var0 "2" 1) (str.++ seg1 (str.split_rest var0 "2" 2))))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
