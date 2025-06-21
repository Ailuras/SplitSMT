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

(declare-sort var3704 0)
(declare-sort var2837 0)
(declare-sort var3583 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun weakCompareAndSet/-16796906 (var2837 var3583 Int Int) Bool)
(declare-fun cast-from-var3704-to-var3583 (var3704) var3583)
(declare-const null-var3704 var3704)
(declare-const null-Int Int)
(declare-const var3704-INDEX_UPDATER var2837)
(declare-const var1812 var3704) ; Statement: r0 := @this: org.apache.dubbo.common.utils.AtomicPositiveInteger 
(assert (not (= var1812 null-var3704)))
(declare-const var2800 Int) ; Statement: i1 := @parameter0: int 
(assert (not (= var2800 null-Int)))
(declare-const var1341 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var1341 null-Int)))
 ; Statement: if i0 >= 0 goto $r1 = <org.apache.dubbo.common.utils.AtomicPositiveInteger: java.util.concurrent.atomic.AtomicIntegerFieldUpdater INDEX_UPDATER> 
(assert (>= var1341 0)) ; Cond: i0 >= 0 
(define-const var2313 var2837 var3704-INDEX_UPDATER) ; Statement: $r1 = <org.apache.dubbo.common.utils.AtomicPositiveInteger: java.util.concurrent.atomic.AtomicIntegerFieldUpdater INDEX_UPDATER> 
(assert true)
(define-const var2807 Bool (weakCompareAndSet/-16796906 var2313 (cast-from-var3704-to-var3583 var1812) var2800 var1341)) ; Statement: $z0 = virtualinvoke $r1.<java.util.concurrent.atomic.AtomicIntegerFieldUpdater: boolean weakCompareAndSet(java.lang.Object,int,int)>(r0, i1, i0) 
 ; Statement: return $z0 
(check-sat)
; {weakCompareAndSet/-16796906=([java.util.concurrent.atomic.AtomicIntegerFieldUpdater, java.lang.Object, int, int], boolean), cast-from-var3704-to-var3583=([org.apache.dubbo.common.utils.AtomicPositiveInteger], java.lang.Object)}
; {var3704=org.apache.dubbo.common.utils.AtomicPositiveInteger, var1812=r0, var2800=i1, var1341=i0, var2837=java.util.concurrent.atomic.AtomicIntegerFieldUpdater, var2313=$r1, var3583=java.lang.Object, var2807=$z0}
; {org.apache.dubbo.common.utils.AtomicPositiveInteger=var3704, r0=var1812, i1=var2800, i0=var1341, java.util.concurrent.atomic.AtomicIntegerFieldUpdater=var2837, $r1=var2313, java.lang.Object=var3583, $z0=var2807}
;seq 
;cnt {}
;stmts r0 := @this: org.apache.dubbo.common.utils.AtomicPositiveInteger;	i1 := @parameter0: int;	i0 := @parameter1: int;	if i0 >= 0 goto $r1 = <org.apache.dubbo.common.utils.AtomicPositiveInteger: java.util.concurrent.atomic.AtomicIntegerFieldUpdater INDEX_UPDATER>;	$r1 = <org.apache.dubbo.common.utils.AtomicPositiveInteger: java.util.concurrent.atomic.AtomicIntegerFieldUpdater INDEX_UPDATER>;	$z0 = virtualinvoke $r1.<java.util.concurrent.atomic.AtomicIntegerFieldUpdater: boolean weakCompareAndSet(java.lang.Object,int,int)>(r0, i1, i0);	return $z0
;block_num 2