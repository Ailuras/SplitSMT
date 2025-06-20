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

(declare-sort var82 0)
(declare-sort var49 0)
(declare-sort var2734 0)
(declare-sort var99 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2734_getMethodName/-888969971 (var2734) String)
(declare-fun var2734_getArguments/1599692315 (var2734) (Array Int var99))
(declare-const null-var82 var82)
(declare-const null-var49 var49)
(declare-const null-var2734 var2734)
(declare-const null-__Array__Int__var99__ (Array Int var99))
(declare-const var2282 var82) ; Statement: r12 := @this: org.apache.dubbo.rpc.filter.ExecuteLimitFilter 
(assert (not (= var2282 null-var82)))
(declare-const var2894 var49) ; Statement: r4 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var2894 null-var49)))
(declare-const var1708 var2734) ; Statement: r0 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var1708 null-var2734)))
(define-const var136 String (var2734_getMethodName/-888969971 var1708)) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>() 
(assert true)
(define-const var2324 Bool (= var136 "$invoke")) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>("$invoke") 
 ; Statement: if $z0 != 0 goto $r2 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>() 
(assert (not (= (ite var2324 1 0) 0))) ; Cond: $z0 != 0 
(define-const var971 (Array Int var99) (var2734_getArguments/1599692315 var1708)) ; Statement: $r2 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>() 
 ; Statement: if $r2 == null goto $r13 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>() 
(assert (= var971 null-__Array__Int__var99__)) ; Cond: $r2 == null 
(define-const var1080 String (var2734_getMethodName/-888969971 var1708)) ; Statement: $r13 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>() 
 ; Statement: return $r13 
(check-sat)
; {var2734_getMethodName/-888969971=([org.apache.dubbo.rpc.Invocation], java.lang.String), var2734_getArguments/1599692315=([org.apache.dubbo.rpc.Invocation], java.lang.Object[])}
; {var82=org.apache.dubbo.rpc.filter.ExecuteLimitFilter, var2282=r12, var49=org.apache.dubbo.rpc.Invoker, var2894=r4, var2734=org.apache.dubbo.rpc.Invocation, var1708=r0, var136=$r1, var2324=$z0, var99=java.lang.Object, var971=$r2, var1080=$r13}
; {org.apache.dubbo.rpc.filter.ExecuteLimitFilter=var82, r12=var2282, org.apache.dubbo.rpc.Invoker=var49, r4=var2894, org.apache.dubbo.rpc.Invocation=var2734, r0=var1708, $r1=var136, $z0=var2324, java.lang.Object=var99, $r2=var971, $r13=var1080}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r12 := @this: org.apache.dubbo.rpc.filter.ExecuteLimitFilter;	r4 := @parameter0: org.apache.dubbo.rpc.Invoker;	r0 := @parameter1: org.apache.dubbo.rpc.Invocation;	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>();	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>("$invoke");	if $z0 != 0 goto $r2 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>();	$r2 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>();	if $r2 == null goto $r13 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>();	$r13 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>();	return $r13
;block_num 3