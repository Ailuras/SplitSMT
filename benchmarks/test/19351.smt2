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

(declare-sort var702 0)
(declare-sort var3886 0)
(declare-sort var1013 0)
(declare-sort var2157 0)
(declare-sort var1538 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2157_getMethodName/-888969971 (var2157) String)
(declare-fun var2157_getArguments/1599692315 (var2157) (Array Int var1538))
(declare-const null-var702 var702)
(declare-const null-var3886 var3886)
(declare-const null-var1013 var1013)
(declare-const null-var2157 var2157)
(declare-const null-__Array__Int__var1538__ (Array Int var1538))
(declare-const var880 var702) ; Statement: r13 := @this: org.apache.dubbo.rpc.filter.GenericFilter 
(assert (not (= var880 null-var702)))
(declare-const var1424 var3886) ; Statement: r7 := @parameter0: org.apache.dubbo.rpc.Result 
(assert (not (= var1424 null-var3886)))
(declare-const var2973 var1013) ; Statement: r4 := @parameter1: org.apache.dubbo.rpc.Invoker 
(assert (not (= var2973 null-var1013)))
(declare-const var1129 var2157) ; Statement: r0 := @parameter2: org.apache.dubbo.rpc.Invocation 
(assert (not (= var1129 null-var2157)))
(define-const var2635 String (var2157_getMethodName/-888969971 var1129)) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>() 
(assert true)
(define-const var2299 Bool (= var2635 "$invoke")) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>("$invoke") 
 ; Statement: if $z0 != 0 goto $r2 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>() 
(assert (not (= (ite var2299 1 0) 0))) ; Cond: $z0 != 0 
(define-const var1766 (Array Int var1538) (var2157_getArguments/1599692315 var1129)) ; Statement: $r2 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>() 
 ; Statement: if $r2 == null goto return 
(assert (= var1766 null-__Array__Int__var1538__)) ; Cond: $r2 == null 
 ; Statement: return 
(check-sat)
; {var2157_getMethodName/-888969971=([org.apache.dubbo.rpc.Invocation], java.lang.String), var2157_getArguments/1599692315=([org.apache.dubbo.rpc.Invocation], java.lang.Object[])}
; {var702=org.apache.dubbo.rpc.filter.GenericFilter, var880=r13, var3886=org.apache.dubbo.rpc.Result, var1424=r7, var1013=org.apache.dubbo.rpc.Invoker, var2973=r4, var2157=org.apache.dubbo.rpc.Invocation, var1129=r0, var2635=$r1, var2299=$z0, var1538=java.lang.Object, var1766=$r2}
; {org.apache.dubbo.rpc.filter.GenericFilter=var702, r13=var880, org.apache.dubbo.rpc.Result=var3886, r7=var1424, org.apache.dubbo.rpc.Invoker=var1013, r4=var2973, org.apache.dubbo.rpc.Invocation=var2157, r0=var1129, $r1=var2635, $z0=var2299, java.lang.Object=var1538, $r2=var1766}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r13 := @this: org.apache.dubbo.rpc.filter.GenericFilter;	r7 := @parameter0: org.apache.dubbo.rpc.Result;	r4 := @parameter1: org.apache.dubbo.rpc.Invoker;	r0 := @parameter2: org.apache.dubbo.rpc.Invocation;	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>();	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>("$invoke");	if $z0 != 0 goto $r2 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>();	$r2 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>();	if $r2 == null goto return;	return
;block_num 3