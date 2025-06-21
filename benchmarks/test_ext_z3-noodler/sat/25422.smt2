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

(declare-sort var2191 0)
(declare-sort var1359 0)
(declare-sort var2768 0)
(declare-sort var3195 0)
(declare-sort var2629 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3195_get/-492901218 (var3195 var2629) var2629)
(declare-fun cast-from-String-to-var2629 (String) var2629)
(declare-const null-var2191 var2191)
(declare-const null-var1359 var1359)
(declare-const null-var2768 var2768)
(declare-const null-var3195 var3195)
(declare-const var1263 var2191) ; Statement: r7 := @this: org.apache.dubbo.rpc.protocol.tri.rest.filter.RestFilterAdapter 
(assert (not (= var1263 null-var2191)))
(declare-const var2997 var1359) ; Statement: r8 := @parameter0: org.apache.dubbo.rpc.Result 
(assert (not (= var2997 null-var1359)))
(declare-const var3724 var2768) ; Statement: r9 := @parameter1: org.apache.dubbo.rpc.Invoker 
(assert (not (= var3724 null-var2768)))
(declare-const var2730 var3195) ; Statement: r0 := @parameter2: org.apache.dubbo.rpc.Invocation 
(assert (not (= var2730 null-var3195)))
(define-const var3817 String "rest") ; Statement: $r2 = "rest" 
(define-const var141 var2629 (var3195_get/-492901218 var2730 (cast-from-String-to-var2629 "tri.handler.type"))) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object get(java.lang.Object)>("tri.handler.type") 
(assert true)
(define-const var3061 Bool false) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: if $z0 == 0 goto return 
(assert (= (ite var3061 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 
(check-sat)
; {var3195_get/-492901218=([org.apache.dubbo.rpc.Invocation, java.lang.Object], java.lang.Object), cast-from-String-to-var2629=([java.lang.String], java.lang.Object)}
; {var2191=org.apache.dubbo.rpc.protocol.tri.rest.filter.RestFilterAdapter, var1263=r7, var1359=org.apache.dubbo.rpc.Result, var2997=r8, var2768=org.apache.dubbo.rpc.Invoker, var3724=r9, var3195=org.apache.dubbo.rpc.Invocation, var2730=r0, var3817=$r2, var2629=java.lang.Object, var141=$r1, var3061=$z0}
; {org.apache.dubbo.rpc.protocol.tri.rest.filter.RestFilterAdapter=var2191, r7=var1263, org.apache.dubbo.rpc.Result=var1359, r8=var2997, org.apache.dubbo.rpc.Invoker=var2768, r9=var3724, org.apache.dubbo.rpc.Invocation=var3195, r0=var2730, $r2=var3817, java.lang.Object=var2629, $r1=var141, $z0=var3061}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r7 := @this: org.apache.dubbo.rpc.protocol.tri.rest.filter.RestFilterAdapter;	r8 := @parameter0: org.apache.dubbo.rpc.Result;	r9 := @parameter1: org.apache.dubbo.rpc.Invoker;	r0 := @parameter2: org.apache.dubbo.rpc.Invocation;	$r2 = "rest";	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object get(java.lang.Object)>("tri.handler.type");	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	if $z0 == 0 goto return;	return
;block_num 2