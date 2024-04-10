; 声明LRA理论
(set-logic LRA)

; 声明变量
(declare-fun x () Real)
(declare-fun y () Real)

; 增量求解开始
(push 1)

; 添加约束条件
(assert (<= (+ x y) 10))
(assert (>= (* x 2) 5))

; 检查可满足性
(check-sat)

; 获取解
(get-model)

; 增量求解结束
(pop)

; 另一个增量求解示例
(push 1)

; 添加新的约束条件
(assert (<= x 3))
(assert (>= y 2))

; 检查可满足性
(check-sat)

; 获取解
(get-model)

; 结束增量求解
(pop)
