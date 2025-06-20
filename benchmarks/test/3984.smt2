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

(declare-sort var3212 0)
(declare-sort var2136 0)
(declare-sort var3959 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getAndSet/-1992374461 (var2136 var3959 Int) Int)
(declare-fun cast-from-var3212-to-var3959 (var3212) var3959)
(declare-const null-var3212 var3212)
(declare-const null-Int Int)
(declare-const var3212-INDEX_UPDATER var2136)
(declare-const var2075 var3212) ; Statement: r0 := @this: org.apache.dubbo.common.utils.AtomicPositiveInteger 
(assert (not (= var2075 null-var3212)))
(declare-const var1967 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var1967 null-Int)))
 ; Statement: if i0 >= 0 goto $r1 = <org.apache.dubbo.common.utils.AtomicPositiveInteger: java.util.concurrent.atomic.AtomicIntegerFieldUpdater INDEX_UPDATER> 
(assert (>= var1967 0)) ; Cond: i0 >= 0 
(define-const var3825 var2136 var3212-INDEX_UPDATER) ; Statement: $r1 = <org.apache.dubbo.common.utils.AtomicPositiveInteger: java.util.concurrent.atomic.AtomicIntegerFieldUpdater INDEX_UPDATER> 
(assert true)
(define-const var3650 Int (getAndSet/-1992374461 var3825 (cast-from-var3212-to-var3959 var2075) var1967)) ; Statement: $i1 = virtualinvoke $r1.<java.util.concurrent.atomic.AtomicIntegerFieldUpdater: int getAndSet(java.lang.Object,int)>(r0, i0) 
(define-const var1345 Int (bv2nat (bvand ((_ int2bv 64) var3650) ((_ int2bv 64) 2147483647)))) ; Statement: $i2 = $i1 & 2147483647 
 ; Statement: return $i2 
(check-sat)
; {getAndSet/-1992374461=([java.util.concurrent.atomic.AtomicIntegerFieldUpdater, java.lang.Object, int], int), cast-from-var3212-to-var3959=([org.apache.dubbo.common.utils.AtomicPositiveInteger], java.lang.Object)}
; {var3212=org.apache.dubbo.common.utils.AtomicPositiveInteger, var2075=r0, var1967=i0, var2136=java.util.concurrent.atomic.AtomicIntegerFieldUpdater, var3825=$r1, var3959=java.lang.Object, var3650=$i1, var1345=$i2}
; {org.apache.dubbo.common.utils.AtomicPositiveInteger=var3212, r0=var2075, i0=var1967, java.util.concurrent.atomic.AtomicIntegerFieldUpdater=var2136, $r1=var3825, java.lang.Object=var3959, $i1=var3650, $i2=var1345}
;seq 
;cnt {}
;stmts r0 := @this: org.apache.dubbo.common.utils.AtomicPositiveInteger;	i0 := @parameter0: int;	if i0 >= 0 goto $r1 = <org.apache.dubbo.common.utils.AtomicPositiveInteger: java.util.concurrent.atomic.AtomicIntegerFieldUpdater INDEX_UPDATER>;	$r1 = <org.apache.dubbo.common.utils.AtomicPositiveInteger: java.util.concurrent.atomic.AtomicIntegerFieldUpdater INDEX_UPDATER>;	$i1 = virtualinvoke $r1.<java.util.concurrent.atomic.AtomicIntegerFieldUpdater: int getAndSet(java.lang.Object,int)>(r0, i0);	$i2 = $i1 & 2147483647;	return $i2
;block_num 2