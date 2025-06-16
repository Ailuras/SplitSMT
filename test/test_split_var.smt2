(set-logic QF_S)
(declare-fun x () String)
(assert (or (= (str.split_at x "aa" 0) "hello") (= (str.split_at x "aa" 2) "w")))
; (assert (= (str.split_at "apple,banana,cherry" "," 1) "banana"))
; (assert (= (str.split_at "apple,banana,cherry" "," 3) "no_such_index"))
(check-sat)
(get-model)

; (assert (str.prefixof "w" (str.split_at x "-" 2)))

; ; AuxiliaryAssert，分为三部分，第一部分是关于x和x_last的声明，第二部分是关于x_split_0, x_split_1, x_split_2的声明，第三部分是关于b_x_split_num_0, b_x_split_num_2的声明
; (assert (= x (str.++ x_split + x_last)))
; (assert (or (= x_last "") (str.prefixof x_last "-")))
; (assert (not (str.contains x_split_0 "-")))
; (assert (not (str.contains x_split_1 "-")))
; (assert (not (str.contains x_split_2 "-")))
; ; 因为原始式子中没有 x_split_1，所以不用声明b_x_split_num_1相关的断言
; (assert (= b_x_split_num_0 (= x_split x_split_0))
; (assert (= b_x_split_num_2 (= x_split (str.++ x_split_0 "-" x_split_1 "-" x_split_2)))

; ; AuxiliaryLemmas，对于每个str.split_at x "-"的节点，生成对应包含他的atom的auxiliary lemmas
; (assert (implies (= (str.split_at x "-" 0) "hello") (or b_x_split_num_0 b_x_split_num_2)))
; (assert (implies (str.prefixof (str.split_at x "-" 2) "w") b_x_split_num_2))
; assert (=> (= "hello" x_split_0) (or b_x_split_num_0 b_x_split_num_2)))

; ; replaceSplitAtVarNodes，最后将原公式中的(str.split_at x "-" 0)替换为x_split_0，(str.split_at x "-" 2)替换为x_split_2
