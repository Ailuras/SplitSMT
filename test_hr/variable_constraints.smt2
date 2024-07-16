(set-logic ALL)
; Single Variables
(declare-fun var_10 () String)
; Inclusion Constraints
(assert (str.in_re var_10 (re.++ (str.to_re "a") (re.* (str.to_re "aa")))))
; Exclusion Constraints
(assert (not (str.in_re var_10 (re.++ (re.* (str.to_re "aa")) (str.to_re "a")))))
; Length Constraints
(assert (exists ((tmp_1 Int)) (= (str.len var_10) (+ 1 (* 2 tmp_1)))))
(assert (not (exists ((tmp_2 Int)) (= (str.len var_10) (+ (* 2 tmp_2) 1)))))
; Allowed Chars
(assert (str.in_re var_10 (re.* (str.to_re "a"))))
(declare-fun RE_UNFOLD_POS_COMPONENT_4 () String)
; Inclusion Constraints
(assert (str.in_re RE_UNFOLD_POS_COMPONENT_4 (re.* (str.to_re "aa"))))
; Exclusion Constraints
; Length Constraints
(assert (exists ((tmp_3 Int)) (= (str.len RE_UNFOLD_POS_COMPONENT_4) (* 2 tmp_3))))
; Allowed Chars
(assert (str.in_re RE_UNFOLD_POS_COMPONENT_4 (re.* (str.to_re "a"))))
(declare-fun RE_UNFOLD_POS_COMPONENT_6 () String)
; Inclusion Constraints
(assert (str.in_re RE_UNFOLD_POS_COMPONENT_6 (re.* (str.to_re "aa"))))
; Exclusion Constraints
; Length Constraints
(assert (exists ((tmp_4 Int)) (= (str.len RE_UNFOLD_POS_COMPONENT_6) (* 2 tmp_4))))
; Allowed Chars
(assert (str.in_re RE_UNFOLD_POS_COMPONENT_6 (re.* (str.to_re "a"))))
(declare-fun RE_UNFOLD_POS_COMPONENT_8 () String)
; Inclusion Constraints
(assert (str.in_re RE_UNFOLD_POS_COMPONENT_8 (re.* (str.to_re "aa"))))
; Exclusion Constraints
; Length Constraints
(assert (exists ((tmp_5 Int)) (= (str.len RE_UNFOLD_POS_COMPONENT_8) (* 2 tmp_5))))
; Allowed Chars
(assert (str.in_re RE_UNFOLD_POS_COMPONENT_8 (re.* (str.to_re "a"))))
(declare-fun RE_UNFOLD_POS_COMPONENT_10 () String)
; Inclusion Constraints
(assert (str.in_re RE_UNFOLD_POS_COMPONENT_10 (re.* (str.to_re "aa"))))
; Exclusion Constraints
; Length Constraints
(assert (exists ((tmp_6 Int)) (= (str.len RE_UNFOLD_POS_COMPONENT_10) (* 2 tmp_6))))
; Allowed Chars
(assert (str.in_re RE_UNFOLD_POS_COMPONENT_10 (re.* (str.to_re "a"))))
(declare-fun RE_UNFOLD_POS_COMPONENT_12 () String)
; Inclusion Constraints
(assert (str.in_re RE_UNFOLD_POS_COMPONENT_12 (re.* (str.to_re "aa"))))
; Exclusion Constraints
; Length Constraints
(assert (exists ((tmp_7 Int)) (= (str.len RE_UNFOLD_POS_COMPONENT_12) (* 2 tmp_7))))
; Allowed Chars
(assert (str.in_re RE_UNFOLD_POS_COMPONENT_12 (re.* (str.to_re "a"))))
(declare-fun RE_UNFOLD_POS_COMPONENT_14 () String)
; Inclusion Constraints
(assert (str.in_re RE_UNFOLD_POS_COMPONENT_14 (re.* (str.to_re "aa"))))
; Exclusion Constraints
; Length Constraints
(assert (exists ((tmp_8 Int)) (= (str.len RE_UNFOLD_POS_COMPONENT_14) (* 2 tmp_8))))
; Allowed Chars
(assert (str.in_re RE_UNFOLD_POS_COMPONENT_14 (re.* (str.to_re "a"))))
(declare-fun RE_UNFOLD_POS_COMPONENT_16 () String)
; Inclusion Constraints
(assert (str.in_re RE_UNFOLD_POS_COMPONENT_16 (re.* (str.to_re "aa"))))
; Exclusion Constraints
; Length Constraints
(assert (exists ((tmp_9 Int)) (= (str.len RE_UNFOLD_POS_COMPONENT_16) (* 2 tmp_9))))
; Allowed Chars
(assert (str.in_re RE_UNFOLD_POS_COMPONENT_16 (re.* (str.to_re "a"))))
(declare-fun RE_UNFOLD_POS_COMPONENT_18 () String)
; Inclusion Constraints
(assert (str.in_re RE_UNFOLD_POS_COMPONENT_18 (re.* (str.to_re "aa"))))
; Exclusion Constraints
; Length Constraints
(assert (exists ((tmp_10 Int)) (= (str.len RE_UNFOLD_POS_COMPONENT_18) (* 2 tmp_10))))
; Allowed Chars
(assert (str.in_re RE_UNFOLD_POS_COMPONENT_18 (re.* (str.to_re "a"))))
(declare-fun RE_UNFOLD_POS_COMPONENT_20 () String)
; Inclusion Constraints
(assert (str.in_re RE_UNFOLD_POS_COMPONENT_20 (re.* (str.to_re "aa"))))
; Exclusion Constraints
; Length Constraints
(assert (exists ((tmp_11 Int)) (= (str.len RE_UNFOLD_POS_COMPONENT_20) (* 2 tmp_11))))
; Allowed Chars
(assert (str.in_re RE_UNFOLD_POS_COMPONENT_20 (re.* (str.to_re "a"))))
(declare-fun RE_UNFOLD_POS_COMPONENT_22 () String)
; Inclusion Constraints
(assert (str.in_re RE_UNFOLD_POS_COMPONENT_22 (re.* (str.to_re "aa"))))
; Exclusion Constraints
; Length Constraints
(assert (exists ((tmp_12 Int)) (= (str.len RE_UNFOLD_POS_COMPONENT_22) (* 2 tmp_12))))
; Allowed Chars
(assert (str.in_re RE_UNFOLD_POS_COMPONENT_22 (re.* (str.to_re "a"))))
(declare-fun RE_UNFOLD_POS_COMPONENT_24 () String)
; Inclusion Constraints
(assert (str.in_re RE_UNFOLD_POS_COMPONENT_24 (re.* (str.to_re "aa"))))
; Exclusion Constraints
; Length Constraints
(assert (exists ((tmp_13 Int)) (= (str.len RE_UNFOLD_POS_COMPONENT_24) (* 2 tmp_13))))
; Allowed Chars
(assert (str.in_re RE_UNFOLD_POS_COMPONENT_24 (re.* (str.to_re "a"))))
(declare-fun RE_UNFOLD_POS_COMPONENT_26 () String)
; Inclusion Constraints
(assert (str.in_re RE_UNFOLD_POS_COMPONENT_26 (re.* (str.to_re "aa"))))
; Exclusion Constraints
; Length Constraints
(assert (exists ((tmp_14 Int)) (= (str.len RE_UNFOLD_POS_COMPONENT_26) (* 2 tmp_14))))
; Allowed Chars
(assert (str.in_re RE_UNFOLD_POS_COMPONENT_26 (re.* (str.to_re "a"))))
(declare-fun RE_UNFOLD_POS_COMPONENT_28 () String)
; Inclusion Constraints
(assert (str.in_re RE_UNFOLD_POS_COMPONENT_28 (re.* (str.to_re "aa"))))
; Exclusion Constraints
; Length Constraints
(assert (exists ((tmp_15 Int)) (= (str.len RE_UNFOLD_POS_COMPONENT_28) (* 2 tmp_15))))
; Allowed Chars
(assert (str.in_re RE_UNFOLD_POS_COMPONENT_28 (re.* (str.to_re "a"))))
(declare-fun RE_UNFOLD_POS_COMPONENT_30 () String)
; Inclusion Constraints
(assert (str.in_re RE_UNFOLD_POS_COMPONENT_30 (re.* (str.to_re "aa"))))
; Exclusion Constraints
; Length Constraints
(assert (exists ((tmp_16 Int)) (= (str.len RE_UNFOLD_POS_COMPONENT_30) (* 2 tmp_16))))
; Allowed Chars
(assert (str.in_re RE_UNFOLD_POS_COMPONENT_30 (re.* (str.to_re "a"))))
(declare-fun RE_UNFOLD_POS_COMPONENT_32 () String)
; Inclusion Constraints
(assert (str.in_re RE_UNFOLD_POS_COMPONENT_32 (re.* (str.to_re "aa"))))
; Exclusion Constraints
; Length Constraints
(assert (exists ((tmp_17 Int)) (= (str.len RE_UNFOLD_POS_COMPONENT_32) (* 2 tmp_17))))
; Allowed Chars
(assert (str.in_re RE_UNFOLD_POS_COMPONENT_32 (re.* (str.to_re "a"))))
(check-sat)
