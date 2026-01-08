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
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

(declare-fun whole () String)
(declare-fun seg0 () String)
(declare-fun seg1 () String)

(assert (= whole (str.++ var_3 "z" var_4)))
(assert (>= (num_splits whole "z") 2))
(assert (= seg0 (split_at whole "z" 0)))
(assert (= seg1 (split_at whole "z" 1)))
(assert (= seg0 var_3))
(assert (= seg1 var_4))
(assert (= (split_rest whole "z" 1) var_4))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]