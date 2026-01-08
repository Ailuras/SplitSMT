(set-logic ALL)
(declare-fun data () String)
(assert (not ( > ( str.indexof "" "-" 0  ) 0  )))
(assert ( = ( str.indexof "" "+" 0  ) (- 1)  ))
(assert ( = 4 4  ))
(assert (not ( = 4 3  )))
(assert ( str.suffixof "," ( str.substr data 0 ( - ( str.indexof data " " 0  ) 0  )  )  ))
(assert (not ( = ( str.len data  ) 0  )))
(assert ( < 5 5  ))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const delimiter String)
(assert (= delimiter ","))
(assert (>= (num_splits data delimiter) 2))
(assert (str.contains (split_at data delimiter 0) " "))
(assert (not (str.contains (split_at data delimiter 1) " ")))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
