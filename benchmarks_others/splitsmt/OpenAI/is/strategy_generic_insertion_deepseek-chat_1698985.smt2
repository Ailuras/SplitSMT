(set-logic ALL)
(declare-fun Top_0 () String)
(declare-fun Bottom_0 () String)
(assert (= Top_0 "1111"))
(assert (= Bottom_0 "111"))
(declare-fun Top_1 () String)
(declare-fun Bottom_1 () String)
(assert (= Top_1 "110"))
(assert (= Bottom_1 "1"))
(declare-fun Top_2 () String)
(declare-fun Bottom_2 () String)
(assert (= Top_2 "11"))
(assert (= Bottom_2 "0111"))
(declare-fun replace () String)
(assert (str.in_re replace (re.+ (re.union (str.to_re "2") (str.to_re "3") (str.to_re "4")))))
(declare-fun x () String)
(declare-fun y () String)
(declare-fun x_0 () String)
(declare-fun y_0 () String)
(declare-fun x_1 () String)
(declare-fun y_1 () String)
(declare-fun x_2 () String)
(declare-fun y_2 () String)
(assert (= x_1 (str.replace_all x_0 "2" Top_0)))
(assert (= x_2 (str.replace_all x_1 "3" Top_1)))
(assert (= x (str.replace_all x_2 "4" Top_2)))
(assert (= y_1 (str.replace_all y_0 "2" Bottom_0)))
(assert (= y_2 (str.replace_all y_1 "3" Bottom_1)))
(assert (= y (str.replace_all y_2 "4" Bottom_2)))
(assert (= x_0 replace))
(assert (= y_0 replace))
(assert (= x y))

; --- START CONSTRAINT ---

(declare-fun s0 () String)
(declare-fun s1 () String)
(declare-fun s2 () String)

(assert (= s0 (str.split_at replace "3" 0)))
(assert (= s1 (str.split_at replace "3" 1)))
(assert (= s2 (str.split_rest replace "3" 2)))

(assert (>= (str.num_splits replace "3") 2))
(assert (= replace (str.++ s0 "3" s1 s2)))

(assert (not (str.contains s0 "3")))
(assert (not (str.contains s1 "3")))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
