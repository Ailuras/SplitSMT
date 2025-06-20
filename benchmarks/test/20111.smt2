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

(declare-sort var1385 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1385_getMethodName/-888969971 (var1385) String)
(declare-fun var1385_getParameterTypes/-2027342342 (var1385) (Array Int ClassObject))
(declare-const null-var1385 var1385)
(declare-const var3067 var1385) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invocation 
(assert (not (= var3067 null-var1385)))
(define-const var361 String "$invoke") ; Statement: $r2 = "$invoke" 
(define-const var2244 String (var1385_getMethodName/-888969971 var3067)) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>() 
(assert true)
(define-const var574 Bool (= var361 var2244)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: if $z0 != 0 goto $r3 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>() 
(assert (not (not (= (ite var574 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var1225 String "$invokeAsync") ; Statement: $r15 = "$invokeAsync" 
(define-const var2311 String (var1385_getMethodName/-888969971 var3067)) ; Statement: $r14 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>() 
(assert true)
(define-const var1953 Bool (= var1225 var2311)) ; Statement: $z2 = virtualinvoke $r15.<java.lang.String: boolean equals(java.lang.Object)>($r14) 
 ; Statement: if $z2 == 0 goto $r16 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Class[] getParameterTypes()>() 
(assert (= (ite var1953 1 0) 0)) ; Cond: $z2 == 0 
(define-const var2236 (Array Int ClassObject) (var1385_getParameterTypes/-2027342342 var3067)) ; Statement: $r16 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Class[] getParameterTypes()>() 
 ; Statement: return $r16 
(check-sat)
; {var1385_getMethodName/-888969971=([org.apache.dubbo.rpc.Invocation], java.lang.String), var1385_getParameterTypes/-2027342342=([org.apache.dubbo.rpc.Invocation], java.lang.Class[])}
; {var1385=org.apache.dubbo.rpc.Invocation, var3067=r0, var361=$r2, var2244=$r1, var574=$z0, var1225=$r15, var2311=$r14, var1953=$z2, var2236=$r16}
; {org.apache.dubbo.rpc.Invocation=var1385, r0=var3067, $r2=var361, $r1=var2244, $z0=var574, $r15=var1225, $r14=var2311, $z2=var1953, $r16=var2236}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 2}
;stmts r0 := @parameter0: org.apache.dubbo.rpc.Invocation;	$r2 = "$invoke";	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>();	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	if $z0 != 0 goto $r3 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>();	$r15 = "$invokeAsync";	$r14 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>();	$z2 = virtualinvoke $r15.<java.lang.String: boolean equals(java.lang.Object)>($r14);	if $z2 == 0 goto $r16 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Class[] getParameterTypes()>();	$r16 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Class[] getParameterTypes()>();	return $r16
;block_num 3