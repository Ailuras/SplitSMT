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

(declare-sort var1480 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1480_getMethodName/-888969971 (var1480) String)
(declare-const null-var1480 var1480)
(declare-const var1724 var1480) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invocation 
(assert (not (= var1724 null-var1480)))
(define-const var2232 String "$invoke") ; Statement: $r2 = "$invoke" 
(define-const var2032 String (var1480_getMethodName/-888969971 var1724)) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>() 
(assert true)
(define-const var48 Bool (= var2232 var2032)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: if $z0 != 0 goto $r3 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>() 
(assert (not (not (= (ite var48 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var192 String "$invokeAsync") ; Statement: $r11 = "$invokeAsync" 
(define-const var600 String (var1480_getMethodName/-888969971 var1724)) ; Statement: $r10 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>() 
(assert true)
(define-const var1261 Bool (= var192 var600)) ; Statement: $z2 = virtualinvoke $r11.<java.lang.String: boolean equals(java.lang.Object)>($r10) 
 ; Statement: if $z2 == 0 goto $r12 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>() 
(assert (= (ite var1261 1 0) 0)) ; Cond: $z2 == 0 
(define-const var1524 String (var1480_getMethodName/-888969971 var1724)) ; Statement: $r12 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>() 
 ; Statement: return $r12 
(check-sat)
; {var1480_getMethodName/-888969971=([org.apache.dubbo.rpc.Invocation], java.lang.String)}
; {var1480=org.apache.dubbo.rpc.Invocation, var1724=r0, var2232=$r2, var2032=$r1, var48=$z0, var192=$r11, var600=$r10, var1261=$z2, var1524=$r12}
; {org.apache.dubbo.rpc.Invocation=var1480, r0=var1724, $r2=var2232, $r1=var2032, $z0=var48, $r11=var192, $r10=var600, $z2=var1261, $r12=var1524}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 2}
;stmts r0 := @parameter0: org.apache.dubbo.rpc.Invocation;	$r2 = "$invoke";	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>();	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	if $z0 != 0 goto $r3 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>();	$r11 = "$invokeAsync";	$r10 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>();	$z2 = virtualinvoke $r11.<java.lang.String: boolean equals(java.lang.Object)>($r10);	if $z2 == 0 goto $r12 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>();	$r12 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>();	return $r12
;block_num 3