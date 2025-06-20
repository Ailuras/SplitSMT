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

(declare-sort var1242 0)
(declare-sort var1462 0)
(declare-sort var690 0)
(declare-sort var3087 0)
(declare-sort var418 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var690_get/-492901218 (var690 var3087) var3087)
(declare-fun cast-from-String-to-var3087 (String) var3087)
(declare-fun var1462_invoke/-1860754555 (var1462 var690) var418)
(declare-const null-var1242 var1242)
(declare-const null-var1462 var1462)
(declare-const null-var690 var690)
(declare-const var1141 var1242) ; Statement: r9 := @this: org.apache.dubbo.rpc.protocol.tri.rest.filter.RestFilterAdapter 
(assert (not (= var1141 null-var1242)))
(declare-const var1653 var1462) ; Statement: r3 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var1653 null-var1462)))
(declare-const var73 var690) ; Statement: r0 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var73 null-var690)))
(define-const var2645 String "rest") ; Statement: $r2 = "rest" 
(define-const var2765 var3087 (var690_get/-492901218 var73 (cast-from-String-to-var3087 "tri.handler.type"))) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object get(java.lang.Object)>("tri.handler.type") 
(assert true)
(define-const var2731 Bool false) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: if $z0 == 0 goto $r4 = interfaceinvoke r3.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.rpc.Result invoke(org.apache.dubbo.rpc.Invocation)>(r0) 
(assert (= (ite var2731 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1008 var418 (var1462_invoke/-1860754555 var1653 var73)) ; Statement: $r4 = interfaceinvoke r3.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.rpc.Result invoke(org.apache.dubbo.rpc.Invocation)>(r0) 
 ; Statement: return $r4 
(check-sat)
; {var690_get/-492901218=([org.apache.dubbo.rpc.Invocation, java.lang.Object], java.lang.Object), cast-from-String-to-var3087=([java.lang.String], java.lang.Object), var1462_invoke/-1860754555=([org.apache.dubbo.rpc.Invoker, org.apache.dubbo.rpc.Invocation], org.apache.dubbo.rpc.Result)}
; {var1242=org.apache.dubbo.rpc.protocol.tri.rest.filter.RestFilterAdapter, var1141=r9, var1462=org.apache.dubbo.rpc.Invoker, var1653=r3, var690=org.apache.dubbo.rpc.Invocation, var73=r0, var2645=$r2, var3087=java.lang.Object, var2765=$r1, var2731=$z0, var418=org.apache.dubbo.rpc.Result, var1008=$r4}
; {org.apache.dubbo.rpc.protocol.tri.rest.filter.RestFilterAdapter=var1242, r9=var1141, org.apache.dubbo.rpc.Invoker=var1462, r3=var1653, org.apache.dubbo.rpc.Invocation=var690, r0=var73, $r2=var2645, java.lang.Object=var3087, $r1=var2765, $z0=var2731, org.apache.dubbo.rpc.Result=var418, $r4=var1008}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r9 := @this: org.apache.dubbo.rpc.protocol.tri.rest.filter.RestFilterAdapter;	r3 := @parameter0: org.apache.dubbo.rpc.Invoker;	r0 := @parameter1: org.apache.dubbo.rpc.Invocation;	$r2 = "rest";	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object get(java.lang.Object)>("tri.handler.type");	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	if $z0 == 0 goto $r4 = interfaceinvoke r3.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.rpc.Result invoke(org.apache.dubbo.rpc.Invocation)>(r0);	$r4 = interfaceinvoke r3.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.rpc.Result invoke(org.apache.dubbo.rpc.Invocation)>(r0);	return $r4
;block_num 2