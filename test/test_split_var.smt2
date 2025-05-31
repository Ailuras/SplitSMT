(set-logic QF_S)
(set-info :status sat)

(declare-const x String)
(declare-const y String)

(assert (= (str.num_splits x ",") 4))
(assert (= (str.split_at x "," 1) y))

; (assert (= x (str.++ x_1 "," x_2 "," x_3 "," x_4)))
; (assert (not (str.contains x_1 ",")))
; (assert (not (str.contains x_2 ",")))
; (assert (not (str.contains x_3 ",")))
; (assert (not (str.contains x_4 ",")))
; (assert (= x_1 y))

(check-sat)
(get-model)