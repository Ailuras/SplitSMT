(set-logic QF_S)
(set-info :source |
    Test file for string constraints and theory literals
|)

(declare-fun x () String)
(declare-fun y () String)
(declare-fun z () String)
(declare-fun i () Int)
(declare-fun j () Int)

; Some string constraints
(assert (= x "hello"))
(assert (= y "world"))
(assert (= z (str.++ x " " y)))

; Some integer constraints
(assert (>= i 0))
(assert (< j 100))
(assert (= (+ i j) 50))

; Some clauses with logical connectives
(assert (or (= x "hi") (= y "there")))
(assert (or (not (= z "hello world")) (> i 10)))
(assert (or (< j 50) (= i 20) (= x y)))

(check-sat)
(get-model) 