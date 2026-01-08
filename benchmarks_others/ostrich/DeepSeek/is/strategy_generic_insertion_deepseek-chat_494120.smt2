(set-logic ALL)
(declare-fun  x1 () String )
(declare-fun  x2 () String )
(declare-fun  z1 () String )
(declare-fun  z2 () String )
(declare-fun  y1 () String )
(declare-fun  y2 () String )
(declare-fun  t1 () String )
(assert ( =( str.++( str.++( str.++( str.++ x1  "acdc"  )  x2  ) ( str.++( str.++ z1  t1  )  z2  )  ) ( str.++( str.++ y1  "nm"  )  y2  )  ) ( str.++( str.++( str.++( str.++ x2  "dcab"  )  x1  ) ( str.++( str.++ z2  "fe"  )  z1  )  ) ( str.++( str.++ y2  "nm"  )  y1  )  )  ) )

; --- START CONSTRAINT ---
; Declare interface functions for str_split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))
; Declare new variables for split operations
(declare-fun delimiter () String)
(declare-fun split_result1 () String)
(declare-fun split_result2 () String)
(declare-fun total_splits () Int)
; Assert constraints using str_split operations
(assert (= delimiter ":"))
(assert (= split_result1 (split_at x1 delimiter 0)))
(assert (= split_result2 (split_at x2 delimiter 1)))
(assert (>= (num_splits x1 delimiter) 2))
(assert (>= (num_splits x2 delimiter) 3))
(assert (= total_splits (num_splits (str.++ x1 x2) delimiter)))
(assert (>= total_splits 5))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
