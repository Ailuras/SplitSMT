(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-Int Int)
(declare-const var837 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var837 null-Int)))
 ; Statement: if i0 >= 3 goto (branch) 
(assert (not (>= var837 3))) ; Negate: Cond: i0 >= 3  
 ; Statement: if i0 >= 0 goto $i2 = i0 + 1 
(assert (>= var837 0)) ; Cond: i0 >= 0 
(define-const var3459 Int (+ var837 1)) ; Statement: $i2 = i0 + 1 
 ; Statement: return $i2 
(check-sat)
; {}
; {var837=i0, var3459=$i2}
; {i0=var837, $i2=var3459}
;seq 
;cnt {}
;stmts i0 := @parameter0: int;	if i0 >= 3 goto (branch);	if i0 >= 0 goto $i2 = i0 + 1;	$i2 = i0 + 1;	return $i2
;block_num 3