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

(declare-sort var2755 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-const null-String String)
(declare-const var1475 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1475 null-String)))
(define-const var373 Int 0) ; Statement: i2 = 0 
(assert true)
(define-const var2400 Int (length/-134980193 var1475)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int length()>() 
(assert true) ; Non Conditional
 ; Statement: if i2 >= i0 goto return r0 
(assert (>= var373 var2400)) ; Cond: i2 >= i0 
 ; Statement: return r0 
(check-sat)
; {length/-134980193=([java.lang.String], int)}
; {var1475=r0, var2755=null_type, var373=i2, var2400=i0}
; {r0=var1475, null_type=var2755, i2=var373, i0=var2400}
;seq <java.lang.String: int length()>
;cnt {"<java.lang.String: int length()>": 1}
;stmts r0 := @parameter0: java.lang.String;	i2 = 0;	i0 = virtualinvoke r0.<java.lang.String: int length()>();	if i2 >= i0 goto return r0;	return r0
;block_num 3