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

(declare-sort var3628 0)
(declare-sort var1955 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun destroyed/-1410107996 (var3628) var1955)
(declare-fun get/2135855162 (var1955) Bool)
(declare-const null-var3628 var3628)
(declare-const var2503 var3628) ; Statement: r0 := @this: org.apache.dubbo.rpc.cluster.support.AbstractClusterInvoker 
(assert (not (= var2503 null-var3628)))
(define-const var2874 var1955 (destroyed/-1410107996 var2503)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.cluster.support.AbstractClusterInvoker: java.util.concurrent.atomic.AtomicBoolean destroyed> 
(assert true)
(define-const var3355 Bool (get/2135855162 var2874)) ; Statement: $z0 = virtualinvoke $r1.<java.util.concurrent.atomic.AtomicBoolean: boolean get()>() 
 ; Statement: if $z0 == 0 goto return 
(assert (= (ite var3355 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 
(check-sat)
; {destroyed/-1410107996=([org.apache.dubbo.rpc.cluster.support.AbstractClusterInvoker], java.util.concurrent.atomic.AtomicBoolean), get/2135855162=([java.util.concurrent.atomic.AtomicBoolean], boolean)}
; {var3628=org.apache.dubbo.rpc.cluster.support.AbstractClusterInvoker, var2503=r0, var1955=java.util.concurrent.atomic.AtomicBoolean, var2874=$r1, var3355=$z0}
; {org.apache.dubbo.rpc.cluster.support.AbstractClusterInvoker=var3628, r0=var2503, java.util.concurrent.atomic.AtomicBoolean=var1955, $r1=var2874, $z0=var3355}
;seq 
;cnt {}
;stmts r0 := @this: org.apache.dubbo.rpc.cluster.support.AbstractClusterInvoker;	$r1 = r0.<org.apache.dubbo.rpc.cluster.support.AbstractClusterInvoker: java.util.concurrent.atomic.AtomicBoolean destroyed>;	$z0 = virtualinvoke $r1.<java.util.concurrent.atomic.AtomicBoolean: boolean get()>();	if $z0 == 0 goto return;	return
;block_num 2