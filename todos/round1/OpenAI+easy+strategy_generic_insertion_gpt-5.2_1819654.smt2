(set-logic ALL)
(declare-const S String)
(assert (not (str.in_re S (str.to_re "aaa"))))
(assert (str.in_re S (re.++ re.allchar (re.++ re.allchar (str.to_re "bbbaaa")))))

; --- START CONSTRAINT ---
(declare-const prefix String)
(declare-const suffix String)
(assert (>= (str.num_splits S "aaa") 1))
(assert (= prefix (str.split_at S "aaa" 0)))
(assert (= suffix (str.split_rest S "aaa" 1)))
(assert (= S (str.++ prefix (str.++ "aaa" suffix))))
(assert (not (str.contains prefix "aaa")))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
