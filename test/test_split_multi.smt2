; 建模前
(set-logic QF_S)
(declare-fun x () String)
(declare-fun temp () String)
(assert (= (str.split_at x "--" 0) "-"))
(assert (= (str.split_at x "--" 1) "-"))
(check-sat)
(get-model)

; 建模后
(set-logic QF_S)
(declare-fun div1_split_index_1 () Int)
(declare-fun b_div1_split_index_1 () Bool)
(declare-fun div1_split_index_0 () Int)
(declare-fun b_div1_split_num_1 () Bool)
(declare-fun div1_split_1 () String)
(declare-fun b_div1_split_num_0 () Bool)
(declare-fun div1_split_0 () String)
(declare-fun div1_last () String)
(declare-fun div1_split () String)
(declare-fun temp () String)
(declare-fun b_div1_split_index_0 () Bool)
(declare-fun x () String)
(assert (= div1_split_0 "-"))
(assert (= div1_split_1 "-"))
(assert (= x (str.++ div1_split div1_last)))
(assert (or (str.prefixof "--" div1_last) (= "" div1_last)))
(assert (not (str.contains div1_split_0 "--")))
(assert (not (str.contains div1_split_1 "--")))
(assert (= (= div1_split_0 div1_split) b_div1_split_num_0))
(assert (= (= (str.++ div1_split_0 "--" div1_split_1) div1_split) b_div1_split_num_1))

; 新增加的约束
; 首先定义div1_split_index_i，它是分割后得到的列表中第i个元素在原字符串中的起始位置下标
(assert (= div1_split_index_0 (str.indexof div1_split "--" 0)))
(assert (= div1_split_index_1 (str.indexof div1_split "--" (+ div1_split_index_0 2))))
; 然后定义b_div1_split_index_i，它是分割后得到的列表中第i个元素在原字符串中的起始位置下标是否有效
(assert (=> b_div1_split_index_0 (or (= div1_split_index_0 (- 1)) (= div1_split_index_0 (str.len div1_split_0)))))
(assert (=> b_div1_split_index_1 (or (= div1_split_index_1 (- 1)) (= (- div1_split_index_1 div1_split_index_0 2) (str.len div1_split_1)))))
; 之后定义b_div1_split_num_0和b_div1_split_index_0之间的蕴含关系
(assert (=> b_div1_split_num_0 b_div1_split_index_0))
(assert (=> b_div1_split_num_1 (and b_div1_split_index_0 b_div1_split_index_1)))



(assert (=> (= div1_split_0 "-") (or b_div1_split_num_0 b_div1_split_num_1)))
(assert (=> (= div1_split_1 "-") b_div1_split_num_1))
(check-sat)
(exit)