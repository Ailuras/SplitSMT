(set-logic ALL)           ; 启用支持 Seq 的逻辑

; ---------- 变量声明 ----------
; a、b 都是“整数序列”(Seq Int)
(declare-const a (Seq Int))
(declare-const b (Seq Int))

; ---------- 约束 1：长度 ----------
(assert (> (seq.len a) 3))    ; a 至少 4 个元素
(assert (= (seq.len b) 1))    ; b 恰好 1 个元素

; ---------- 约束 2：内容 ----------
; 设 b 唯一的元素是 42
(assert (= b (seq.unit 42)))

; a 的首元素也要求 > 42
(assert (> (seq.nth a 0) 42)) ; seq.nth 从 0 开始

; ---------- 约束 3：序列关系 ----------
; b 必须是 a 的前缀：  b ⪯ a
(assert (seq.prefix b a))

; ---------- 约束 4：子序列提取 ----------
; 取 a 的后缀（去掉首元素），记为 tailA
(define-fun tailA () (Seq Int)
  (seq.extract a 1 (- (seq.len a) 1)))

; tailA 不能再以 42 开头
(assert (not (seq.prefix (seq.unit 42) tailA)))

; ---------- 求解 ----------
(check-sat)
(get-model)
