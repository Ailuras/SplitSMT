(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-const S String)
(assert (not (str.in_re S (str.to_re "aaa"))))
(assert (str.in_re S (re.++ re.allchar (re.++ re.allchar (str.to_re "bbbaaa")))))

; --- START CONSTRAINT ---
(declare-const prefix String)
(declare-const suffix String)
(assert (>= (num_splits S "aaa") 1))
(assert (= prefix (split_at S "aaa" 0)))
(assert (= suffix (split_rest S "aaa" 1)))
(assert (= S (str.++ prefix (str.++ "aaa" suffix))))
(assert (not (str.contains prefix "aaa")))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(get-model)
(exit)
