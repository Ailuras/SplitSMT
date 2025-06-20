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

(declare-sort var510 0)
(declare-sort var1678 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var510_getMethodName/-888969971 (var510) String)
(declare-fun var510_getArguments/1599692315 (var510) (Array Int var1678))
(declare-fun var510_getParameterTypes/-2027342342 (var510) (Array Int ClassObject))
(declare-const null-var510 var510)
(declare-const null-__Array__Int__var1678__ (Array Int var1678))
(declare-const var2375 var510) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invocation 
(assert (not (= var2375 null-var510)))
(define-const var2367 String "$invoke") ; Statement: $r2 = "$invoke" 
(define-const var1732 String (var510_getMethodName/-888969971 var2375)) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>() 
(assert true)
(define-const var2509 Bool (= var2367 var1732)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: if $z0 != 0 goto $r3 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>() 
(assert (not (= (ite var2509 1 0) 0))) ; Cond: $z0 != 0 
(define-const var2726 (Array Int var1678) (var510_getArguments/1599692315 var2375)) ; Statement: $r3 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>() 
 ; Statement: if $r3 == null goto $r16 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Class[] getParameterTypes()>() 
(assert (= var2726 null-__Array__Int__var1678__)) ; Cond: $r3 == null 
(define-const var306 (Array Int ClassObject) (var510_getParameterTypes/-2027342342 var2375)) ; Statement: $r16 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Class[] getParameterTypes()>() 
 ; Statement: return $r16 
(check-sat)
; {var510_getMethodName/-888969971=([org.apache.dubbo.rpc.Invocation], java.lang.String), var510_getArguments/1599692315=([org.apache.dubbo.rpc.Invocation], java.lang.Object[]), var510_getParameterTypes/-2027342342=([org.apache.dubbo.rpc.Invocation], java.lang.Class[])}
; {var510=org.apache.dubbo.rpc.Invocation, var2375=r0, var2367=$r2, var1732=$r1, var2509=$z0, var1678=java.lang.Object, var2726=$r3, var306=$r16}
; {org.apache.dubbo.rpc.Invocation=var510, r0=var2375, $r2=var2367, $r1=var1732, $z0=var2509, java.lang.Object=var1678, $r3=var2726, $r16=var306}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.rpc.Invocation;	$r2 = "$invoke";	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>();	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	if $z0 != 0 goto $r3 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>();	$r3 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>();	if $r3 == null goto $r16 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Class[] getParameterTypes()>();	$r16 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Class[] getParameterTypes()>();	return $r16
;block_num 3