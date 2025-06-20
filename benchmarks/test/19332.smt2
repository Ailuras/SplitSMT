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

(declare-sort var157 0)
(declare-sort var2013 0)
(declare-sort var2025 0)
(declare-sort var3157 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3157_getMethodName/-888969971 (var3157) String)
(declare-const null-var157 var157)
(declare-const null-var2013 var2013)
(declare-const null-var2025 var2025)
(declare-const null-var3157 var3157)
(declare-const var158 var157) ; Statement: r13 := @this: org.apache.dubbo.rpc.filter.GenericFilter 
(assert (not (= var158 null-var157)))
(declare-const var200 var2013) ; Statement: r7 := @parameter0: org.apache.dubbo.rpc.Result 
(assert (not (= var200 null-var2013)))
(declare-const var177 var2025) ; Statement: r4 := @parameter1: org.apache.dubbo.rpc.Invoker 
(assert (not (= var177 null-var2025)))
(declare-const var2428 var3157) ; Statement: r0 := @parameter2: org.apache.dubbo.rpc.Invocation 
(assert (not (= var2428 null-var3157)))
(define-const var2555 String (var3157_getMethodName/-888969971 var2428)) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>() 
(assert true)
(define-const var2429 Bool (= var2555 "$invoke")) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>("$invoke") 
 ; Statement: if $z0 != 0 goto $r2 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>() 
(assert (not (not (= (ite var2429 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var3736 String (var3157_getMethodName/-888969971 var2428)) ; Statement: $r38 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>() 
(assert true)
(define-const var830 Bool (= var3736 "$invokeAsync")) ; Statement: $z11 = virtualinvoke $r38.<java.lang.String: boolean equals(java.lang.Object)>("$invokeAsync") 
 ; Statement: if $z11 == 0 goto return 
(assert (= (ite var830 1 0) 0)) ; Cond: $z11 == 0 
 ; Statement: return 
(check-sat)
; {var3157_getMethodName/-888969971=([org.apache.dubbo.rpc.Invocation], java.lang.String)}
; {var157=org.apache.dubbo.rpc.filter.GenericFilter, var158=r13, var2013=org.apache.dubbo.rpc.Result, var200=r7, var2025=org.apache.dubbo.rpc.Invoker, var177=r4, var3157=org.apache.dubbo.rpc.Invocation, var2428=r0, var2555=$r1, var2429=$z0, var3736=$r38, var830=$z11}
; {org.apache.dubbo.rpc.filter.GenericFilter=var157, r13=var158, org.apache.dubbo.rpc.Result=var2013, r7=var200, org.apache.dubbo.rpc.Invoker=var2025, r4=var177, org.apache.dubbo.rpc.Invocation=var3157, r0=var2428, $r1=var2555, $z0=var2429, $r38=var3736, $z11=var830}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 2}
;stmts r13 := @this: org.apache.dubbo.rpc.filter.GenericFilter;	r7 := @parameter0: org.apache.dubbo.rpc.Result;	r4 := @parameter1: org.apache.dubbo.rpc.Invoker;	r0 := @parameter2: org.apache.dubbo.rpc.Invocation;	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>();	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>("$invoke");	if $z0 != 0 goto $r2 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>();	$r38 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>();	$z11 = virtualinvoke $r38.<java.lang.String: boolean equals(java.lang.Object)>("$invokeAsync");	if $z11 == 0 goto return;	return
;block_num 3