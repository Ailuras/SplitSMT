(set-logic QF_LIRA)
(declare-const x Int)
(declare-const y Real)
(assert
    (and
        (>= x (* 3 y))
        (<= x y)
        (< (- 2) x)
    )
)

(push 1)
(assert (not (<= (- y x) (/ 2 3))))
(check-sat)
(pop 1)

(push 1)
(assert (not (> (- y x) (/ 2 3))))
(check-sat)
(get-model)
(pop 1)
