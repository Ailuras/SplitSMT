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

(declare-sort var1562 0)
(declare-sort var179 0)
(declare-sort var3616 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun compareAndSet/733369214 (var179 var3616 Int Int) Bool)
(declare-fun cast-from-var1562-to-var3616 (var1562) var3616)
(declare-const null-var1562 var1562)
(declare-const null-Int Int)
(declare-const var1562-INDEX_UPDATER var179)
(declare-const var3221 var1562) ; Statement: r0 := @this: org.apache.dubbo.common.utils.AtomicPositiveInteger 
(assert (not (= var3221 null-var1562)))
(declare-const var3047 Int) ; Statement: i1 := @parameter0: int 
(assert (not (= var3047 null-Int)))
(declare-const var2721 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var2721 null-Int)))
 ; Statement: if i0 >= 0 goto $r1 = <org.apache.dubbo.common.utils.AtomicPositiveInteger: java.util.concurrent.atomic.AtomicIntegerFieldUpdater INDEX_UPDATER> 
(assert (>= var2721 0)) ; Cond: i0 >= 0 
(define-const var2428 var179 var1562-INDEX_UPDATER) ; Statement: $r1 = <org.apache.dubbo.common.utils.AtomicPositiveInteger: java.util.concurrent.atomic.AtomicIntegerFieldUpdater INDEX_UPDATER> 
(assert true)
(define-const var621 Bool (compareAndSet/733369214 var2428 (cast-from-var1562-to-var3616 var3221) var3047 var2721)) ; Statement: $z0 = virtualinvoke $r1.<java.util.concurrent.atomic.AtomicIntegerFieldUpdater: boolean compareAndSet(java.lang.Object,int,int)>(r0, i1, i0) 
 ; Statement: return $z0 
(check-sat)
; {compareAndSet/733369214=([java.util.concurrent.atomic.AtomicIntegerFieldUpdater, java.lang.Object, int, int], boolean), cast-from-var1562-to-var3616=([org.apache.dubbo.common.utils.AtomicPositiveInteger], java.lang.Object)}
; {var1562=org.apache.dubbo.common.utils.AtomicPositiveInteger, var3221=r0, var3047=i1, var2721=i0, var179=java.util.concurrent.atomic.AtomicIntegerFieldUpdater, var2428=$r1, var3616=java.lang.Object, var621=$z0}
; {org.apache.dubbo.common.utils.AtomicPositiveInteger=var1562, r0=var3221, i1=var3047, i0=var2721, java.util.concurrent.atomic.AtomicIntegerFieldUpdater=var179, $r1=var2428, java.lang.Object=var3616, $z0=var621}
;seq 
;cnt {}
;stmts r0 := @this: org.apache.dubbo.common.utils.AtomicPositiveInteger;	i1 := @parameter0: int;	i0 := @parameter1: int;	if i0 >= 0 goto $r1 = <org.apache.dubbo.common.utils.AtomicPositiveInteger: java.util.concurrent.atomic.AtomicIntegerFieldUpdater INDEX_UPDATER>;	$r1 = <org.apache.dubbo.common.utils.AtomicPositiveInteger: java.util.concurrent.atomic.AtomicIntegerFieldUpdater INDEX_UPDATER>;	$z0 = virtualinvoke $r1.<java.util.concurrent.atomic.AtomicIntegerFieldUpdater: boolean compareAndSet(java.lang.Object,int,int)>(r0, i1, i0);	return $z0
;block_num 2