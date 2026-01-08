(set-logic ALL)
(declare-fun var_3 () String)
(declare-fun var_4 () String)
(assert (str.in_re (str.++ var_3 "z" var_4 ) (re.++ (re.* (re.union (re.union (str.to_re "z") (str.to_re "b")) (re.++ (str.to_re "a") (re.union (re.union (str.to_re "z") (str.to_re "b")) (str.to_re "a"))))) (str.to_re "a"))))
(assert (str.in_re (str.++ var_3 "z" var_4 ) (re.* (re.union (str.to_re "a") (re.++ (re.union (str.to_re "z") (str.to_re "b")) (re.++ (re.* (str.to_re "b")) (re.union (str.to_re "z") (str.to_re "a"))))))))
(assert (str.in_re (str.++ var_3 "z" var_4 ) (re.++ (re.* (re.union (str.to_re "z") (re.++ (re.union (str.to_re "b") (str.to_re "a")) (re.union (str.to_re "z") (str.to_re "b"))))) (re.union (str.to_re "b") (str.to_re "a")))))
(assert (str.in_re (str.++ var_3 "z" var_4 ) (re.++ (re.* (re.union (str.to_re "z") (re.++ (str.to_re "a") (re.++ (re.* (str.to_re "a")) (str.to_re "z"))))) (re.++ (str.to_re "a") (re.* (str.to_re "a"))))))
(assert (str.in_re (str.++ var_3 "z" var_4 ) (re.++ (re.* (re.++ (str.to_re "a") (re.++ (re.* (re.union (str.to_re "b") (str.to_re "a"))) (str.to_re "z")))) (re.++ (str.to_re "a") (re.* (re.union (str.to_re "b") (str.to_re "a")))))))
(assert (str.in_re (str.++ var_3 "z" var_4 ) (re.++ (re.* (re.union (re.union (str.to_re "z") (str.to_re "b")) (re.++ (str.to_re "a") (re.union (str.to_re "z") (str.to_re "a"))))) (str.to_re "a"))))
(assert (str.in_re (str.++ var_3 "z" var_4 ) (re.* (re.++ (re.union (str.to_re "z") (str.to_re "a")) (re.++ (re.* (str.to_re "z")) (str.to_re "a"))))))
(assert (str.in_re var_4 (re.* (re.range "a" "u"))))
(assert (str.in_re var_4 (re.* (str.to_re "b"))))
(assert (str.in_re var_3 (re.* (re.range "a" "u"))))
(assert (str.in_re var_3 (re.* (str.to_re "a"))))
(assert (<= 0  (str.len var_4)))

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter "z"))
(assert (>= (str.num_splits (str.++ var_3 "z" var_4) delimiter) 2))
(assert (= var_3 (str.split_at (str.++ var_3 "z" var_4) delimiter 0)))
(assert (= var_4 (str.split_rest (str.++ var_3 "z" var_4) delimiter 1)))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
