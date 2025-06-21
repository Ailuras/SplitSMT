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

(declare-sort var3843 0)
(declare-sort var883 0)
(declare-sort var1303 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun set/-1932558467 (var883 var1303 Int) void)
(declare-fun cast-from-var3843-to-var1303 (var3843) var1303)
(declare-const null-var3843 var3843)
(declare-const null-Int Int)
(declare-const var3843-INDEX_UPDATER var883)
(declare-const var1695 var3843) ; Statement: r0 := @this: org.apache.dubbo.common.utils.AtomicPositiveInteger 
(assert (not (= var1695 null-var3843)))
(declare-const var2216 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var2216 null-Int)))
 ; Statement: if i0 >= 0 goto $r1 = <org.apache.dubbo.common.utils.AtomicPositiveInteger: java.util.concurrent.atomic.AtomicIntegerFieldUpdater INDEX_UPDATER> 
(assert (>= var2216 0)) ; Cond: i0 >= 0 
(define-const var1119 var883 var3843-INDEX_UPDATER) ; Statement: $r1 = <org.apache.dubbo.common.utils.AtomicPositiveInteger: java.util.concurrent.atomic.AtomicIntegerFieldUpdater INDEX_UPDATER> 
(assert true)
;(assert (set/-1932558467 var1119 (cast-from-var3843-to-var1303 var1695) var2216)) ; Statement: virtualinvoke $r1.<java.util.concurrent.atomic.AtomicIntegerFieldUpdater: void set(java.lang.Object,int)>(r0, i0) 

(declare-const var1119!1 var883)
(declare-const var1695!1 var3843)
(declare-const var2216!1 Int)
 ; Statement: return 
(check-sat)
; {set/-1932558467=([java.util.concurrent.atomic.AtomicIntegerFieldUpdater, java.lang.Object, int], void), cast-from-var3843-to-var1303=([org.apache.dubbo.common.utils.AtomicPositiveInteger], java.lang.Object)}
; {var3843=org.apache.dubbo.common.utils.AtomicPositiveInteger, var1695=r0, var2216=i0, var883=java.util.concurrent.atomic.AtomicIntegerFieldUpdater, var1119=$r1, var1303=java.lang.Object}
; {org.apache.dubbo.common.utils.AtomicPositiveInteger=var3843, r0=var1695, i0=var2216, java.util.concurrent.atomic.AtomicIntegerFieldUpdater=var883, $r1=var1119, java.lang.Object=var1303}
;seq 
;cnt {}
;stmts r0 := @this: org.apache.dubbo.common.utils.AtomicPositiveInteger;	i0 := @parameter0: int;	if i0 >= 0 goto $r1 = <org.apache.dubbo.common.utils.AtomicPositiveInteger: java.util.concurrent.atomic.AtomicIntegerFieldUpdater INDEX_UPDATER>;	$r1 = <org.apache.dubbo.common.utils.AtomicPositiveInteger: java.util.concurrent.atomic.AtomicIntegerFieldUpdater INDEX_UPDATER>;	virtualinvoke $r1.<java.util.concurrent.atomic.AtomicIntegerFieldUpdater: void set(java.lang.Object,int)>(r0, i0);	return
;block_num 2