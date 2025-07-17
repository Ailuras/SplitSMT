(set-logic ALL)

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

(declare-const var1 String)
(declare-const var2 String)
(declare-const var3 String)

(define-const var811 Int (get_split_length var1 var2 -1))
(define-const var812 String (get_split_element var1 var2 -1 0))
(define-const var813 String (get_split_element var1 var2 -1 1))

(assert (= var1 "hello-world-test"))
(assert (= var2 "-"))
(assert (= var3 "other"))

(assert (>= var811 2))
(assert (str.contains var812 "hello"))
(assert (str.contains var813 "world"))

(check-sat)
(get-model) 