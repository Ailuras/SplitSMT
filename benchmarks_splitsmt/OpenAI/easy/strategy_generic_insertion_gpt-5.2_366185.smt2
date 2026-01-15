(set-logic ALL)
(declare-fun s () String)
(assert (not ( = ( str.len ( str.substr s ( + ( + 1 ( + 1 1  )  ) ( + 1 1  )  ) ( - ( str.len s  ) ( + ( + 1 ( + 1 1  )  ) ( + 1 1  )  )  )  )  ) 1  )))
(assert ( <= ( ite ( str.prefixof "-" ( str.substr s ( + 1 ( + 1 1  )  ) ( - ( + ( + 1 ( + 1 1  )  ) ( + 1 1  )  ) ( + 1 ( + 1 1  )  )  )  )  ) ( - ( str.to_int ( str.substr ( str.substr s ( + 1 ( + 1 1  )  ) ( - ( + ( + 1 ( + 1 1  )  ) ( + 1 1  )  ) ( + 1 ( + 1 1  )  )  )  ) 1 ( - ( str.len ( str.substr s ( + 1 ( + 1 1  )  ) ( - ( + ( + 1 ( + 1 1  )  ) ( + 1 1  )  ) ( + 1 ( + 1 1  )  )  )  )  ) 1  )  )  )  ) ( str.to_int ( str.substr s ( + 1 ( + 1 1  )  ) ( - ( + ( + 1 ( + 1 1  )  ) ( + 1 1  )  ) ( + 1 ( + 1 1  )  )  )  )  )  ) 255  ))
(assert ( ite ( str.prefixof "-" ( str.substr s ( + 1 ( + 1 1  )  ) ( - ( + ( + 1 ( + 1 1  )  ) ( + 1 1  )  ) ( + 1 ( + 1 1  )  )  )  )  ) ( and ( ite ( = (- 1) ( str.to_int ( str.substr ( str.substr s ( + 1 ( + 1 1  )  ) ( - ( + ( + 1 ( + 1 1  )  ) ( + 1 1  )  ) ( + 1 ( + 1 1  )  )  )  ) 1 ( - ( str.len ( str.substr s ( + 1 ( + 1 1  )  ) ( - ( + ( + 1 ( + 1 1  )  ) ( + 1 1  )  ) ( + 1 ( + 1 1  )  )  )  )  ) 1  )  )  )  ) false true  ) ( > ( str.len ( str.substr s ( + 1 ( + 1 1  )  ) ( - ( + ( + 1 ( + 1 1  )  ) ( + 1 1  )  ) ( + 1 ( + 1 1  )  )  )  )  ) 1  )  ) ( ite ( = (- 1) ( str.to_int ( str.substr s ( + 1 ( + 1 1  )  ) ( - ( + ( + 1 ( + 1 1  )  ) ( + 1 1  )  ) ( + 1 ( + 1 1  )  )  )  )  )  ) false true  )  ))
(assert (not ( = ( str.at ( str.substr s ( + 1 ( + 1 1  )  ) ( - ( + ( + 1 ( + 1 1  )  ) ( + 1 1  )  ) ( + 1 ( + 1 1  )  )  )  ) 0  ) "0"  )))
(assert (not ( = ( str.len ( str.substr s ( + 1 ( + 1 1  )  ) ( - ( + ( + 1 ( + 1 1  )  ) ( + 1 1  )  ) ( + 1 ( + 1 1  )  )  )  )  ) 1  )))
(assert ( <= ( ite ( str.prefixof "-" ( str.substr s 1 ( - ( + 1 ( + 1 1  )  ) 1  )  )  ) ( - ( str.to_int ( str.substr ( str.substr s 1 ( - ( + 1 ( + 1 1  )  ) 1  )  ) 1 ( - ( str.len ( str.substr s 1 ( - ( + 1 ( + 1 1  )  ) 1  )  )  ) 1  )  )  )  ) ( str.to_int ( str.substr s 1 ( - ( + 1 ( + 1 1  )  ) 1  )  )  )  ) 255  ))
(assert ( ite ( str.prefixof "-" ( str.substr s 1 ( - ( + 1 ( + 1 1  )  ) 1  )  )  ) ( and ( ite ( = (- 1) ( str.to_int ( str.substr ( str.substr s 1 ( - ( + 1 ( + 1 1  )  ) 1  )  ) 1 ( - ( str.len ( str.substr s 1 ( - ( + 1 ( + 1 1  )  ) 1  )  )  ) 1  )  )  )  ) false true  ) ( > ( str.len ( str.substr s 1 ( - ( + 1 ( + 1 1  )  ) 1  )  )  ) 1  )  ) ( ite ( = (- 1) ( str.to_int ( str.substr s 1 ( - ( + 1 ( + 1 1  )  ) 1  )  )  )  ) false true  )  ))
(assert (not ( = ( str.at ( str.substr s 1 ( - ( + 1 ( + 1 1  )  ) 1  )  ) 0  ) "0"  )))
(assert (not ( = ( str.len ( str.substr s 1 ( - ( + 1 ( + 1 1  )  ) 1  )  )  ) 1  )))
(assert ( = ( str.len ( str.substr s 0 ( - 1 0  )  )  ) 1  ))
(assert ( <= ( - ( - ( - ( str.len s  ) 1  ) ( + 1 1  )  ) ( + 1 1  )  ) 3  ))
(assert ( > ( - ( - ( - ( str.len s  ) 1  ) ( + 1 1  )  ) ( + 1 1  )  ) 0  ))
(assert (not ( <= ( - ( - ( - ( str.len s  ) 1  ) ( + 1 1  )  ) 1  ) 3  )))
(assert ( > ( - ( - ( - ( str.len s  ) 1  ) ( + 1 1  )  ) 1  ) 0  ))
(assert ( = ( str.at ( str.substr s ( + 1 1  ) ( - ( + ( + 1 1  ) ( + ( + 1 1  ) 1  )  ) ( + 1 1  )  )  ) 0  ) "0"  ))
(assert (not ( = ( str.len ( str.substr s ( + 1 1  ) ( - ( + ( + 1 1  ) ( + ( + 1 1  ) 1  )  ) ( + 1 1  )  )  )  ) 1  )))
(assert ( = ( str.len ( str.substr s 1 ( - ( + 1 1  ) 1  )  )  ) 1  ))
(assert ( = ( str.len ( str.substr s 0 ( - 1 0  )  )  ) 1  ))
(assert ( <= ( - ( - ( - ( str.len s  ) 1  ) 1  ) ( + ( + 1 1  ) 1  )  ) 3  ))
(assert ( > ( - ( - ( - ( str.len s  ) 1  ) 1  ) ( + ( + 1 1  ) 1  )  ) 0  ))
(assert (not ( <= ( - ( - ( - ( str.len s  ) 1  ) 1  ) ( + 1 1  )  ) 3  )))
(assert ( > ( - ( - ( - ( str.len s  ) 1  ) 1  ) ( + 1 1  )  ) 0  ))
(assert (not ( <= ( - ( - ( - ( str.len s  ) 1  ) 1  ) 1  ) 3  )))
(assert ( > ( - ( - ( - ( str.len s  ) 1  ) 1  ) 1  ) 0  ))
(assert ( str.in_re s ( re.+ ( re.range "0" "9"  )  )  ))
(assert (not ( > ( str.len s  ) 12  )))
(assert (not ( = ( str.len s  ) 0  )))
(assert (not ( = ( str.at ( str.substr s ( + ( + 1 ( + 1 1  )  ) ( + 1 1  )  ) ( - ( str.len s  ) ( + ( + 1 ( + 1 1  )  ) ( + 1 1  )  )  )  ) 0  ) "0"  )))

; --- START CONSTRAINT ---
; str_split interface signatures

; new helper variables
(declare-fun chunk0 () String)

; use str_split to further constrain s (which is all digits already)
(assert (= (str.num_splits s "0") 2))
(assert (= chunk0 (str.split_at s "0" 0)))
(assert (= (str.len chunk0) 1))
(assert (str.in_re chunk0 (re.range "1" "9")))
(assert (= (str.split_rest s "0" 1) ""))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
