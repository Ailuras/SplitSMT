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

(declare-sort var1561 0)
(declare-sort var3943 0)
(declare-sort var1635 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1635_getMethodName/-888969971 (var1635) String)
(declare-const null-var1561 var1561)
(declare-const null-var3943 var3943)
(declare-const null-var1635 var1635)
(declare-const var3557 var1561) ; Statement: r12 := @this: org.apache.dubbo.rpc.filter.ExecuteLimitFilter 
(assert (not (= var3557 null-var1561)))
(declare-const var3773 var3943) ; Statement: r4 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var3773 null-var3943)))
(declare-const var1096 var1635) ; Statement: r0 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var1096 null-var1635)))
(define-const var574 String (var1635_getMethodName/-888969971 var1096)) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>() 
(assert true)
(define-const var1313 Bool (= var574 "$invoke")) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>("$invoke") 
 ; Statement: if $z0 != 0 goto $r2 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>() 
(assert (not (not (= (ite var1313 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var3293 String (var1635_getMethodName/-888969971 var1096)) ; Statement: $r11 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>() 
(assert true)
(define-const var2521 Bool (= var3293 "$invokeAsync")) ; Statement: $z2 = virtualinvoke $r11.<java.lang.String: boolean equals(java.lang.Object)>("$invokeAsync") 
 ; Statement: if $z2 == 0 goto $r13 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>() 
(assert (= (ite var2521 1 0) 0)) ; Cond: $z2 == 0 
(define-const var406 String (var1635_getMethodName/-888969971 var1096)) ; Statement: $r13 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>() 
 ; Statement: return $r13 
(check-sat)
; {var1635_getMethodName/-888969971=([org.apache.dubbo.rpc.Invocation], java.lang.String)}
; {var1561=org.apache.dubbo.rpc.filter.ExecuteLimitFilter, var3557=r12, var3943=org.apache.dubbo.rpc.Invoker, var3773=r4, var1635=org.apache.dubbo.rpc.Invocation, var1096=r0, var574=$r1, var1313=$z0, var3293=$r11, var2521=$z2, var406=$r13}
; {org.apache.dubbo.rpc.filter.ExecuteLimitFilter=var1561, r12=var3557, org.apache.dubbo.rpc.Invoker=var3943, r4=var3773, org.apache.dubbo.rpc.Invocation=var1635, r0=var1096, $r1=var574, $z0=var1313, $r11=var3293, $z2=var2521, $r13=var406}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 2}
;stmts r12 := @this: org.apache.dubbo.rpc.filter.ExecuteLimitFilter;	r4 := @parameter0: org.apache.dubbo.rpc.Invoker;	r0 := @parameter1: org.apache.dubbo.rpc.Invocation;	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>();	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>("$invoke");	if $z0 != 0 goto $r2 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>();	$r11 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>();	$z2 = virtualinvoke $r11.<java.lang.String: boolean equals(java.lang.Object)>("$invokeAsync");	if $z2 == 0 goto $r13 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>();	$r13 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>();	return $r13
;block_num 3