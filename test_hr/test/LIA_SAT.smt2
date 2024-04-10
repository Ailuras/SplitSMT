; SAT的带量词的LIA公式
(set-info :smt-lib-version 2.6)
(set-logic LIA)

(declare-fun x () Int)
(declare-fun z () Int)
(assert 
  (forall ((w Int)) 
  (exists ((y Int)) 
    (and (> y 0) 
           (=> (> w 0) (< z (+ x (+ y w)))))))
)
(check-sat)
