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

(declare-sort var3730 0)
(declare-sort var2647 0)
(declare-sort var946 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getAndIncrement/-1505044446 (var2647 var946) Int)
(declare-fun cast-from-var3730-to-var946 (var3730) var946)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-var3730 var3730)
(declare-const var3730-COUNTER_UPDATER var2647)
(declare-const var1604 var3730) ; Statement: r0 := @this: org.apache.dubbo.remoting.api.connection.AbstractConnectionClient 
(assert (not (= var1604 null-var3730)))
(define-const var3954 var2647 var3730-COUNTER_UPDATER) ; Statement: $r1 = <org.apache.dubbo.remoting.api.connection.AbstractConnectionClient: java.util.concurrent.atomic.AtomicLongFieldUpdater COUNTER_UPDATER> 
(assert true)
(define-const var3453 Int (getAndIncrement/-1505044446 var3954 (cast-from-var3730-to-var946 var1604))) ; Statement: l0 = virtualinvoke $r1.<java.util.concurrent.atomic.AtomicLongFieldUpdater: long getAndIncrement(java.lang.Object)>(r0) 
(define-const var3953 Int (ite (> var3453 0) 1 (ite (< var3453 0) -1 0))) ; Statement: $b1 = l0 cmp 0L 
(define-const var3175 Int (cast-from-Int-to-Int var3953)) ; Statement: $i2 = (int) $b1 
 ; Statement: if $i2 > 0 goto return 1 
(assert (> var3175 0)) ; Cond: $i2 > 0 
 ; Statement: return 1 
(check-sat)
; {getAndIncrement/-1505044446=([java.util.concurrent.atomic.AtomicLongFieldUpdater, java.lang.Object], long), cast-from-var3730-to-var946=([org.apache.dubbo.remoting.api.connection.AbstractConnectionClient], java.lang.Object), cast-from-Int-to-Int=([byte], int)}
; {var3730=org.apache.dubbo.remoting.api.connection.AbstractConnectionClient, var1604=r0, var2647=java.util.concurrent.atomic.AtomicLongFieldUpdater, var3954=$r1, var946=java.lang.Object, var3453=l0, var3953=$b1, var3175=$i2}
; {org.apache.dubbo.remoting.api.connection.AbstractConnectionClient=var3730, r0=var1604, java.util.concurrent.atomic.AtomicLongFieldUpdater=var2647, $r1=var3954, java.lang.Object=var946, l0=var3453, $b1=var3953, $i2=var3175}
;seq 
;cnt {}
;stmts r0 := @this: org.apache.dubbo.remoting.api.connection.AbstractConnectionClient;	$r1 = <org.apache.dubbo.remoting.api.connection.AbstractConnectionClient: java.util.concurrent.atomic.AtomicLongFieldUpdater COUNTER_UPDATER>;	l0 = virtualinvoke $r1.<java.util.concurrent.atomic.AtomicLongFieldUpdater: long getAndIncrement(java.lang.Object)>(r0);	$b1 = l0 cmp 0L;	$i2 = (int) $b1;	if $i2 > 0 goto return 1;	return 1
;block_num 2