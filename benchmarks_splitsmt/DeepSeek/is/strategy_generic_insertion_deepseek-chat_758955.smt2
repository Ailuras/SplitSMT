(set-logic ALL)
(declare-fun s () String)
(assert ( <= ( - ( - ( - ( str.len s  ) 1  ) ( + 1 1  )  ) 1  ) 3  ))
(assert ( > ( - ( - ( - ( str.len s  ) 1  ) ( + 1 1  )  ) 1  ) 0  ))
(assert ( = ( str.at ( str.substr s ( + 1 1  ) ( - ( + ( + 1 1  ) ( + ( + 1 1  ) 1  )  ) ( + 1 1  )  )  ) 0  ) "0"  ))
(assert (not ( = ( str.len ( str.substr s ( + 1 1  ) ( - ( + ( + 1 1  ) ( + ( + 1 1  ) 1  )  ) ( + 1 1  )  )  )  ) 1  )))
(assert ( = ( str.len ( str.substr s 1 ( - ( + 1 1  ) 1  )  )  ) 1  ))
(assert ( = ( str.len ( str.substr s 0 ( - 1 0  )  )  ) 1  ))
(assert ( <= ( - ( - ( - ( str.len s  ) 1  ) 1  ) ( + ( + 1 1  ) 1  )  ) 3  ))
(assert ( > ( - ( - ( - ( str.len s  ) 1  ) 1  ) ( + ( + 1 1  ) 1  )  ) 0  ))
(assert ( = ( str.at ( str.substr s ( + 1 1  ) ( - ( + ( + 1 1  ) ( + 1 1  )  ) ( + 1 1  )  )  ) 0  ) "0"  ))
(assert (not ( = ( str.len ( str.substr s ( + 1 1  ) ( - ( + ( + 1 1  ) ( + 1 1  )  ) ( + 1 1  )  )  )  ) 1  )))
(assert ( = ( str.len ( str.substr s 1 ( - ( + 1 1  ) 1  )  )  ) 1  ))
(assert ( = ( str.len ( str.substr s 0 ( - 1 0  )  )  ) 1  ))
(assert ( <= ( - ( - ( - ( str.len s  ) 1  ) 1  ) ( + 1 1  )  ) 3  ))
(assert ( > ( - ( - ( - ( str.len s  ) 1  ) 1  ) ( + 1 1  )  ) 0  ))
(assert ( = ( str.at ( str.substr s ( + ( + 1 1  ) 1  ) ( - ( str.len s  ) ( + ( + 1 1  ) 1  )  )  ) 0  ) "0"  ))
(assert (not ( = ( str.len ( str.substr s ( + ( + 1 1  ) 1  ) ( - ( str.len s  ) ( + ( + 1 1  ) 1  )  )  )  ) 1  )))
(assert ( = ( str.len ( str.substr s ( + 1 1  ) ( - ( + ( + 1 1  ) 1  ) ( + 1 1  )  )  )  ) 1  ))
(assert ( = ( str.len ( str.substr s 1 ( - ( + 1 1  ) 1  )  )  ) 1  ))
(assert ( = ( str.len ( str.substr s 0 ( - 1 0  )  )  ) 1  ))
(assert ( <= ( - ( - ( - ( str.len s  ) 1  ) 1  ) 1  ) 3  ))
(assert ( > ( - ( - ( - ( str.len s  ) 1  ) 1  ) 1  ) 0  ))
(assert ( str.in_re s ( re.+ ( re.range "0" "9"  )  )  ))
(assert (not ( > ( str.len s  ) 12  )))
(assert (not ( = ( str.len s  ) 0  )))
(assert (not ( = ( str.len ( str.substr s 0 ( - 1 0  )  )  ) 1  )))

; --- START CONSTRAINT ---
; Declare interface functions for str_split
; Declare new variables for delimiter and indices
(declare-const delim String)
(declare-const idx Int)
; Assert constraints using str_split operations
(assert (= delim "0"))
(assert (>= idx 0))
(assert (<= idx (str.num_splits s delim)))
(assert (>= (str.num_splits s delim) 2))
(assert (= (str.split_at s delim 0) (str.substr s 0 (str.indexof s delim 0))))
(assert (not (= (str.split_at s delim 1) "")))
(assert (str.contains (str.split_rest s delim 2) delim))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
