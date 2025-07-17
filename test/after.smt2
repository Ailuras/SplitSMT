(set-logic ALL)

(declare-fun var2602 () String)
(declare-fun var3742 () String)
(declare-fun var3662 () String)
(declare-fun var3874 () Int)
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)
(define-const var3874 Int (get_split_length var3662 "=" -1)) ; Statement: $i0 = lengthof r2 
(define-const var3742 String (get_split_element var3662 "=" -1 var2602)) ; Statement: $r3 = r2[i1] 

(check-sat)