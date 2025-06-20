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

(declare-sort var956 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun isEmpty/-1285796103 ((s String)) Bool (= (str.len s) 0))
(declare-const null-String String)
(declare-const var3401 String) ; Statement: r26 := @parameter0: java.lang.String 
(assert (not (= var3401 null-String)))
(declare-const var1466 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var1466 null-String)))
(assert true)
(define-const var2091 Bool (isEmpty/-1285796103 var3401)) ; Statement: $z0 = virtualinvoke r26.<java.lang.String: boolean isEmpty()>() 
 ; Statement: if $z0 == 0 goto $z1 = virtualinvoke r0.<java.lang.String: boolean isEmpty()>() 
(assert (= (ite var2091 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var1678 Bool (isEmpty/-1285796103 var1466)) ; Statement: $z1 = virtualinvoke r0.<java.lang.String: boolean isEmpty()>() 
 ; Statement: if $z1 == 0 goto i0 = virtualinvoke r26.<java.lang.String: int length()>() 
(assert (not (= (ite var1678 1 0) 0))) ; Negate: Cond: $z1 == 0  
 ; Statement: return r26 
(check-sat)
; {isEmpty/-1285796103=([java.lang.String], boolean)}
; {var3401=r26, var956=null_type, var1466=r0, var2091=$z0, var1678=$z1}
; {r26=var3401, null_type=var956, r0=var1466, $z0=var2091, $z1=var1678}
;seq <java.lang.String: boolean isEmpty()>;	<java.lang.String: boolean isEmpty()>
;cnt {"<java.lang.String: boolean isEmpty()>": 2}
;stmts r26 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String;	$z0 = virtualinvoke r26.<java.lang.String: boolean isEmpty()>();	if $z0 == 0 goto $z1 = virtualinvoke r0.<java.lang.String: boolean isEmpty()>();	$z1 = virtualinvoke r0.<java.lang.String: boolean isEmpty()>();	if $z1 == 0 goto i0 = virtualinvoke r26.<java.lang.String: int length()>();	return r26
;block_num 3