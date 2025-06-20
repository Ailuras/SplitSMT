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

(declare-sort var611 0)
(declare-sort var107 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var611_getMethodName/-888969971 (var611) String)
(declare-fun var611_getArguments/1599692315 (var611) (Array Int var107))
(declare-const null-var611 var611)
(declare-const null-__Array__Int__var107__ (Array Int var107))
(declare-const var2013 var611) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invocation 
(assert (not (= var2013 null-var611)))
(define-const var3315 String "$invoke") ; Statement: $r2 = "$invoke" 
(define-const var3228 String (var611_getMethodName/-888969971 var2013)) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>() 
(assert true)
(define-const var1927 Bool (= var3315 var3228)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: if $z0 != 0 goto $r3 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>() 
(assert (not (= (ite var1927 1 0) 0))) ; Cond: $z0 != 0 
(define-const var3942 (Array Int var107) (var611_getArguments/1599692315 var2013)) ; Statement: $r3 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>() 
 ; Statement: if $r3 == null goto $r12 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>() 
(assert (= var3942 null-__Array__Int__var107__)) ; Cond: $r3 == null 
(define-const var1470 String (var611_getMethodName/-888969971 var2013)) ; Statement: $r12 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>() 
 ; Statement: return $r12 
(check-sat)
; {var611_getMethodName/-888969971=([org.apache.dubbo.rpc.Invocation], java.lang.String), var611_getArguments/1599692315=([org.apache.dubbo.rpc.Invocation], java.lang.Object[])}
; {var611=org.apache.dubbo.rpc.Invocation, var2013=r0, var3315=$r2, var3228=$r1, var1927=$z0, var107=java.lang.Object, var3942=$r3, var1470=$r12}
; {org.apache.dubbo.rpc.Invocation=var611, r0=var2013, $r2=var3315, $r1=var3228, $z0=var1927, java.lang.Object=var107, $r3=var3942, $r12=var1470}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.rpc.Invocation;	$r2 = "$invoke";	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>();	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	if $z0 != 0 goto $r3 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>();	$r3 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>();	if $r3 == null goto $r12 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>();	$r12 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>();	return $r12
;block_num 3