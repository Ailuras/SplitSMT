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

(declare-sort var3081 0)
(declare-sort var186 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3081_getMethodName/-888969971 (var3081) String)
(declare-fun var3081_getArguments/1599692315 (var3081) (Array Int var186))
(declare-const null-var3081 var3081)
(declare-const var418 var3081) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invocation 
(assert (not (= var418 null-var3081)))
(define-const var110 String "$invoke") ; Statement: $r2 = "$invoke" 
(define-const var2273 String (var3081_getMethodName/-888969971 var418)) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>() 
(assert true)
(define-const var2517 Bool (= var110 var2273)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: if $z0 != 0 goto $r3 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>() 
(assert (not (not (= (ite var2517 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var3490 String "$invokeAsync") ; Statement: $r11 = "$invokeAsync" 
(define-const var1148 String (var3081_getMethodName/-888969971 var418)) ; Statement: $r10 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>() 
(assert true)
(define-const var2686 Bool (= var3490 var1148)) ; Statement: $z2 = virtualinvoke $r11.<java.lang.String: boolean equals(java.lang.Object)>($r10) 
 ; Statement: if $z2 == 0 goto $r12 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>() 
(assert (= (ite var2686 1 0) 0)) ; Cond: $z2 == 0 
(define-const var616 (Array Int var186) (var3081_getArguments/1599692315 var418)) ; Statement: $r12 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>() 
 ; Statement: return $r12 
(check-sat)
; {var3081_getMethodName/-888969971=([org.apache.dubbo.rpc.Invocation], java.lang.String), var3081_getArguments/1599692315=([org.apache.dubbo.rpc.Invocation], java.lang.Object[])}
; {var3081=org.apache.dubbo.rpc.Invocation, var418=r0, var110=$r2, var2273=$r1, var2517=$z0, var3490=$r11, var1148=$r10, var2686=$z2, var186=java.lang.Object, var616=$r12}
; {org.apache.dubbo.rpc.Invocation=var3081, r0=var418, $r2=var110, $r1=var2273, $z0=var2517, $r11=var3490, $r10=var1148, $z2=var2686, java.lang.Object=var186, $r12=var616}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 2}
;stmts r0 := @parameter0: org.apache.dubbo.rpc.Invocation;	$r2 = "$invoke";	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>();	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	if $z0 != 0 goto $r3 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>();	$r11 = "$invokeAsync";	$r10 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>();	$z2 = virtualinvoke $r11.<java.lang.String: boolean equals(java.lang.Object)>($r10);	if $z2 == 0 goto $r12 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>();	$r12 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>();	return $r12
;block_num 3