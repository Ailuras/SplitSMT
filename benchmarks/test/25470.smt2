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

(declare-sort var3929 0)
(declare-sort var2346 0)
(declare-sort var3138 0)
(declare-sort var3992 0)
(declare-sort var3333 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3992_get/-492901218 (var3992 var3333) var3333)
(declare-fun cast-from-String-to-var3333 (String) var3333)
(declare-const null-var3929 var3929)
(declare-const null-var2346 var2346)
(declare-const null-var3138 var3138)
(declare-const null-var3992 var3992)
(declare-const var394 var3929) ; Statement: r7 := @this: org.apache.dubbo.rpc.protocol.tri.rest.filter.RestFilterAdapter 
(assert (not (= var394 null-var3929)))
(declare-const var1327 var2346) ; Statement: r8 := @parameter0: java.lang.Throwable 
(assert (not (= var1327 null-var2346)))
(declare-const var2009 var3138) ; Statement: r9 := @parameter1: org.apache.dubbo.rpc.Invoker 
(assert (not (= var2009 null-var3138)))
(declare-const var2045 var3992) ; Statement: r0 := @parameter2: org.apache.dubbo.rpc.Invocation 
(assert (not (= var2045 null-var3992)))
(define-const var213 String "rest") ; Statement: $r2 = "rest" 
(define-const var1020 var3333 (var3992_get/-492901218 var2045 (cast-from-String-to-var3333 "tri.handler.type"))) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object get(java.lang.Object)>("tri.handler.type") 
(assert true)
(define-const var3210 Bool false) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: if $z0 == 0 goto return 
(assert (= (ite var3210 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 
(check-sat)
; {var3992_get/-492901218=([org.apache.dubbo.rpc.Invocation, java.lang.Object], java.lang.Object), cast-from-String-to-var3333=([java.lang.String], java.lang.Object)}
; {var3929=org.apache.dubbo.rpc.protocol.tri.rest.filter.RestFilterAdapter, var394=r7, var2346=java.lang.Throwable, var1327=r8, var3138=org.apache.dubbo.rpc.Invoker, var2009=r9, var3992=org.apache.dubbo.rpc.Invocation, var2045=r0, var213=$r2, var3333=java.lang.Object, var1020=$r1, var3210=$z0}
; {org.apache.dubbo.rpc.protocol.tri.rest.filter.RestFilterAdapter=var3929, r7=var394, java.lang.Throwable=var2346, r8=var1327, org.apache.dubbo.rpc.Invoker=var3138, r9=var2009, org.apache.dubbo.rpc.Invocation=var3992, r0=var2045, $r2=var213, java.lang.Object=var3333, $r1=var1020, $z0=var3210}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r7 := @this: org.apache.dubbo.rpc.protocol.tri.rest.filter.RestFilterAdapter;	r8 := @parameter0: java.lang.Throwable;	r9 := @parameter1: org.apache.dubbo.rpc.Invoker;	r0 := @parameter2: org.apache.dubbo.rpc.Invocation;	$r2 = "rest";	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object get(java.lang.Object)>("tri.handler.type");	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	if $z0 == 0 goto return;	return
;block_num 2