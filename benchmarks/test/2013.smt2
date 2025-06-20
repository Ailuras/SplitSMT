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

(declare-sort var1569 0)
(declare-sort var1206 0)
(declare-sort var3060 0)
(declare-sort var3612 0)
(declare-sort var2797 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3612_isEmpty/73262611 (var2797) Bool)
(declare-fun cast-from-var1206-to-var2797 (var1206) var2797)
(declare-const null-var1569 var1569)
(declare-const null-var1206 var1206)
(declare-const null-var3060 var3060)
(declare-const var2287 var1569) ; Statement: r7 := @this: org.apache.dubbo.rpc.cluster.support.AbstractClusterInvoker 
(assert (not (= var2287 null-var1569)))
(declare-const var3745 var1206) ; Statement: r0 := @parameter0: java.util.List 
(assert (not (= var3745 null-var1206)))
(declare-const var38 var3060) ; Statement: r3 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var38 null-var3060)))
(define-const var606 Bool (var3612_isEmpty/73262611 (cast-from-var1206-to-var2797 var3745))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>(r0) 
 ; Statement: if $z0 == 0 goto return 
(assert (= (ite var606 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 
(check-sat)
; {var3612_isEmpty/73262611=([java.util.Collection], boolean), cast-from-var1206-to-var2797=([java.util.List], java.util.Collection)}
; {var1569=org.apache.dubbo.rpc.cluster.support.AbstractClusterInvoker, var2287=r7, var1206=java.util.List, var3745=r0, var3060=org.apache.dubbo.rpc.Invocation, var38=r3, var3612=org.apache.dubbo.common.utils.CollectionUtils, var2797=java.util.Collection, var606=$z0}
; {org.apache.dubbo.rpc.cluster.support.AbstractClusterInvoker=var1569, r7=var2287, java.util.List=var1206, r0=var3745, org.apache.dubbo.rpc.Invocation=var3060, r3=var38, org.apache.dubbo.common.utils.CollectionUtils=var3612, java.util.Collection=var2797, $z0=var606}
;seq 
;cnt {}
;stmts r7 := @this: org.apache.dubbo.rpc.cluster.support.AbstractClusterInvoker;	r0 := @parameter0: java.util.List;	r3 := @parameter1: org.apache.dubbo.rpc.Invocation;	$z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>(r0);	if $z0 == 0 goto return;	return
;block_num 2