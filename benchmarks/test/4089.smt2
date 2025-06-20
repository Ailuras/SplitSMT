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

(declare-sort var3604 0)
(declare-sort var3829 0)
(declare-sort var1947 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun addAndGet/574218340 (var3829 var1947 Int) Int)
(declare-fun cast-from-var3604-to-var1947 (var3604) var1947)
(declare-const null-var3604 var3604)
(declare-const null-Int Int)
(declare-const var3604-INDEX_UPDATER var3829)
(declare-const var441 var3604) ; Statement: r0 := @this: org.apache.dubbo.common.utils.AtomicPositiveInteger 
(assert (not (= var441 null-var3604)))
(declare-const var1652 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var1652 null-Int)))
 ; Statement: if i0 >= 0 goto $r1 = <org.apache.dubbo.common.utils.AtomicPositiveInteger: java.util.concurrent.atomic.AtomicIntegerFieldUpdater INDEX_UPDATER> 
(assert (>= var1652 0)) ; Cond: i0 >= 0 
(define-const var3308 var3829 var3604-INDEX_UPDATER) ; Statement: $r1 = <org.apache.dubbo.common.utils.AtomicPositiveInteger: java.util.concurrent.atomic.AtomicIntegerFieldUpdater INDEX_UPDATER> 
(assert true)
(define-const var1433 Int (addAndGet/574218340 var3308 (cast-from-var3604-to-var1947 var441) var1652)) ; Statement: $i1 = virtualinvoke $r1.<java.util.concurrent.atomic.AtomicIntegerFieldUpdater: int addAndGet(java.lang.Object,int)>(r0, i0) 
(define-const var3987 Int (bv2nat (bvand ((_ int2bv 64) var1433) ((_ int2bv 64) 2147483647)))) ; Statement: $i2 = $i1 & 2147483647 
 ; Statement: return $i2 
(check-sat)
; {addAndGet/574218340=([java.util.concurrent.atomic.AtomicIntegerFieldUpdater, java.lang.Object, int], int), cast-from-var3604-to-var1947=([org.apache.dubbo.common.utils.AtomicPositiveInteger], java.lang.Object)}
; {var3604=org.apache.dubbo.common.utils.AtomicPositiveInteger, var441=r0, var1652=i0, var3829=java.util.concurrent.atomic.AtomicIntegerFieldUpdater, var3308=$r1, var1947=java.lang.Object, var1433=$i1, var3987=$i2}
; {org.apache.dubbo.common.utils.AtomicPositiveInteger=var3604, r0=var441, i0=var1652, java.util.concurrent.atomic.AtomicIntegerFieldUpdater=var3829, $r1=var3308, java.lang.Object=var1947, $i1=var1433, $i2=var3987}
;seq 
;cnt {}
;stmts r0 := @this: org.apache.dubbo.common.utils.AtomicPositiveInteger;	i0 := @parameter0: int;	if i0 >= 0 goto $r1 = <org.apache.dubbo.common.utils.AtomicPositiveInteger: java.util.concurrent.atomic.AtomicIntegerFieldUpdater INDEX_UPDATER>;	$r1 = <org.apache.dubbo.common.utils.AtomicPositiveInteger: java.util.concurrent.atomic.AtomicIntegerFieldUpdater INDEX_UPDATER>;	$i1 = virtualinvoke $r1.<java.util.concurrent.atomic.AtomicIntegerFieldUpdater: int addAndGet(java.lang.Object,int)>(r0, i0);	$i2 = $i1 & 2147483647;	return $i2
;block_num 2