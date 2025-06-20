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

(declare-sort var850 0)
(declare-sort var1461 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var850_getMethodName/-888969971 (var850) String)
(declare-fun var850_getArguments/1599692315 (var850) (Array Int var1461))
(declare-const null-var850 var850)
(declare-const null-__Array__Int__var1461__ (Array Int var1461))
(declare-const var2312 var850) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invocation 
(assert (not (= var2312 null-var850)))
(define-const var429 String "$invoke") ; Statement: $r2 = "$invoke" 
(define-const var2548 String (var850_getMethodName/-888969971 var2312)) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>() 
(assert true)
(define-const var3947 Bool (= var429 var2548)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: if $z0 != 0 goto $r3 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>() 
(assert (not (= (ite var3947 1 0) 0))) ; Cond: $z0 != 0 
(define-const var3980 (Array Int var1461) (var850_getArguments/1599692315 var2312)) ; Statement: $r3 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>() 
 ; Statement: if $r3 == null goto $r12 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>() 
(assert (= var3980 null-__Array__Int__var1461__)) ; Cond: $r3 == null 
(define-const var3527 (Array Int var1461) (var850_getArguments/1599692315 var2312)) ; Statement: $r12 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>() 
 ; Statement: return $r12 
(check-sat)
; {var850_getMethodName/-888969971=([org.apache.dubbo.rpc.Invocation], java.lang.String), var850_getArguments/1599692315=([org.apache.dubbo.rpc.Invocation], java.lang.Object[])}
; {var850=org.apache.dubbo.rpc.Invocation, var2312=r0, var429=$r2, var2548=$r1, var3947=$z0, var1461=java.lang.Object, var3980=$r3, var3527=$r12}
; {org.apache.dubbo.rpc.Invocation=var850, r0=var2312, $r2=var429, $r1=var2548, $z0=var3947, java.lang.Object=var1461, $r3=var3980, $r12=var3527}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.rpc.Invocation;	$r2 = "$invoke";	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>();	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	if $z0 != 0 goto $r3 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>();	$r3 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>();	if $r3 == null goto $r12 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>();	$r12 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>();	return $r12
;block_num 3