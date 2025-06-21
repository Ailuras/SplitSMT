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

(declare-sort var2211 0)
(declare-sort var794 0)
(declare-sort var450 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getAndAdd/598586404 (var794 var450 Int) Int)
(declare-fun cast-from-var2211-to-var450 (var2211) var450)
(declare-const null-var2211 var2211)
(declare-const null-Int Int)
(declare-const var2211-INDEX_UPDATER var794)
(declare-const var1524 var2211) ; Statement: r0 := @this: org.apache.dubbo.common.utils.AtomicPositiveInteger 
(assert (not (= var1524 null-var2211)))
(declare-const var1238 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var1238 null-Int)))
 ; Statement: if i0 >= 0 goto $r1 = <org.apache.dubbo.common.utils.AtomicPositiveInteger: java.util.concurrent.atomic.AtomicIntegerFieldUpdater INDEX_UPDATER> 
(assert (>= var1238 0)) ; Cond: i0 >= 0 
(define-const var2979 var794 var2211-INDEX_UPDATER) ; Statement: $r1 = <org.apache.dubbo.common.utils.AtomicPositiveInteger: java.util.concurrent.atomic.AtomicIntegerFieldUpdater INDEX_UPDATER> 
(assert true)
(define-const var323 Int (getAndAdd/598586404 var2979 (cast-from-var2211-to-var450 var1524) var1238)) ; Statement: $i1 = virtualinvoke $r1.<java.util.concurrent.atomic.AtomicIntegerFieldUpdater: int getAndAdd(java.lang.Object,int)>(r0, i0) 
(define-const var402 Int (bv2nat (bvand ((_ int2bv 64) var323) ((_ int2bv 64) 2147483647)))) ; Statement: $i2 = $i1 & 2147483647 
 ; Statement: return $i2 
(check-sat)
; {getAndAdd/598586404=([java.util.concurrent.atomic.AtomicIntegerFieldUpdater, java.lang.Object, int], int), cast-from-var2211-to-var450=([org.apache.dubbo.common.utils.AtomicPositiveInteger], java.lang.Object)}
; {var2211=org.apache.dubbo.common.utils.AtomicPositiveInteger, var1524=r0, var1238=i0, var794=java.util.concurrent.atomic.AtomicIntegerFieldUpdater, var2979=$r1, var450=java.lang.Object, var323=$i1, var402=$i2}
; {org.apache.dubbo.common.utils.AtomicPositiveInteger=var2211, r0=var1524, i0=var1238, java.util.concurrent.atomic.AtomicIntegerFieldUpdater=var794, $r1=var2979, java.lang.Object=var450, $i1=var323, $i2=var402}
;seq 
;cnt {}
;stmts r0 := @this: org.apache.dubbo.common.utils.AtomicPositiveInteger;	i0 := @parameter0: int;	if i0 >= 0 goto $r1 = <org.apache.dubbo.common.utils.AtomicPositiveInteger: java.util.concurrent.atomic.AtomicIntegerFieldUpdater INDEX_UPDATER>;	$r1 = <org.apache.dubbo.common.utils.AtomicPositiveInteger: java.util.concurrent.atomic.AtomicIntegerFieldUpdater INDEX_UPDATER>;	$i1 = virtualinvoke $r1.<java.util.concurrent.atomic.AtomicIntegerFieldUpdater: int getAndAdd(java.lang.Object,int)>(r0, i0);	$i2 = $i1 & 2147483647;	return $i2
;block_num 2