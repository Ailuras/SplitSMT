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

(declare-sort var819 0)
(declare-sort var448 0)
(declare-sort var1203 0)
(declare-sort var2154 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun get/68863423 (var1203 var2154) var2154)
(declare-fun cast-from-String-to-var2154 (String) var2154)
(declare-const null-var819 var819)
(declare-const null-var448 var448)
(declare-const null-var1203 var1203)
(declare-const var527 var819) ; Statement: r7 := @this: org.apache.dubbo.rpc.protocol.tri.rest.filter.RestHeaderFilterAdapter 
(assert (not (= var527 null-var819)))
(declare-const var3756 var448) ; Statement: r8 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var3756 null-var448)))
(declare-const var3446 var1203) ; Statement: r0 := @parameter1: org.apache.dubbo.rpc.RpcInvocation 
(assert (not (= var3446 null-var1203)))
(define-const var2261 String "rest") ; Statement: $r2 = "rest" 
(assert true)
(define-const var2270 var2154 (get/68863423 var3446 (cast-from-String-to-var2154 "tri.handler.type"))) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Object get(java.lang.Object)>("tri.handler.type") 
(assert true)
(define-const var3786 Bool false) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: if $z0 == 0 goto return r0 
(assert (= (ite var3786 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return r0 
(check-sat)
; {get/68863423=([org.apache.dubbo.rpc.RpcInvocation, java.lang.Object], java.lang.Object), cast-from-String-to-var2154=([java.lang.String], java.lang.Object)}
; {var819=org.apache.dubbo.rpc.protocol.tri.rest.filter.RestHeaderFilterAdapter, var527=r7, var448=org.apache.dubbo.rpc.Invoker, var3756=r8, var1203=org.apache.dubbo.rpc.RpcInvocation, var3446=r0, var2261=$r2, var2154=java.lang.Object, var2270=$r1, var3786=$z0}
; {org.apache.dubbo.rpc.protocol.tri.rest.filter.RestHeaderFilterAdapter=var819, r7=var527, org.apache.dubbo.rpc.Invoker=var448, r8=var3756, org.apache.dubbo.rpc.RpcInvocation=var1203, r0=var3446, $r2=var2261, java.lang.Object=var2154, $r1=var2270, $z0=var3786}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r7 := @this: org.apache.dubbo.rpc.protocol.tri.rest.filter.RestHeaderFilterAdapter;	r8 := @parameter0: org.apache.dubbo.rpc.Invoker;	r0 := @parameter1: org.apache.dubbo.rpc.RpcInvocation;	$r2 = "rest";	$r1 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Object get(java.lang.Object)>("tri.handler.type");	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	if $z0 == 0 goto return r0;	return r0
;block_num 2