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
(declare-const var2859 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var2859 null-Int)))
 ; Statement: if i0 >= 3 goto (branch) 
(assert (>= var2859 3)) ; Cond: i0 >= 3 
 ; Statement: if i0 >= 1073741824 goto return 2147483647 
(assert (>= var2859 1073741824)) ; Cond: i0 >= 1073741824 
 ; Statement: return 2147483647 
(check-sat)
; {}
; {var2859=i0}
; {i0=var2859}
;seq 
;cnt {}
;stmts i0 := @parameter0: int;	if i0 >= 3 goto (branch);	if i0 >= 1073741824 goto return 2147483647;	return 2147483647
;block_num 3