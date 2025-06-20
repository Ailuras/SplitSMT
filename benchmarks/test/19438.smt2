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

(declare-sort var3309 0)
(declare-sort var1937 0)
(declare-sort var1379 0)
(declare-sort var913 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1379_getMethodName/-888969971 (var1379) String)
(declare-fun var1379_getArguments/1599692315 (var1379) (Array Int var913))
(declare-const null-var3309 var3309)
(declare-const null-String String)
(declare-const null-var1379 var1379)
(declare-const null-__Array__Int__var913__ (Array Int var913))
(declare-const var3640 var3309) ; Statement: r6 := @this: org.apache.dubbo.rpc.filter.GenericImplFilter 
(assert (not (= var3640 null-var3309)))
(declare-const var3483 String) ; Statement: r4 := @parameter0: java.lang.String 
(assert (not (= var3483 null-String)))
(declare-const var165 var1379) ; Statement: r0 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var165 null-var1379)))
(define-const var2788 String (var1379_getMethodName/-888969971 var165)) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>() 
(assert true)
(define-const var2959 Bool (= var2788 "$invoke")) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>("$invoke") 
 ; Statement: if $z0 != 0 goto $r2 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>() 
(assert (not (= (ite var2959 1 0) 0))) ; Cond: $z0 != 0 
(define-const var2093 (Array Int var913) (var1379_getArguments/1599692315 var165)) ; Statement: $r2 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>() 
 ; Statement: if $r2 == null goto $z3 = 0 
(assert (= var2093 null-__Array__Int__var913__)) ; Cond: $r2 == null 
(define-const var432 Bool (ite (= 1 0) true false)) ; Statement: $z3 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z3 
(check-sat)
; {var1379_getMethodName/-888969971=([org.apache.dubbo.rpc.Invocation], java.lang.String), var1379_getArguments/1599692315=([org.apache.dubbo.rpc.Invocation], java.lang.Object[])}
; {var3309=org.apache.dubbo.rpc.filter.GenericImplFilter, var3640=r6, var3483=r4, var1937=null_type, var1379=org.apache.dubbo.rpc.Invocation, var165=r0, var2788=$r1, var2959=$z0, var913=java.lang.Object, var2093=$r2, var432=$z3}
; {org.apache.dubbo.rpc.filter.GenericImplFilter=var3309, r6=var3640, r4=var3483, null_type=var1937, org.apache.dubbo.rpc.Invocation=var1379, r0=var165, $r1=var2788, $z0=var2959, java.lang.Object=var913, $r2=var2093, $z3=var432}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r6 := @this: org.apache.dubbo.rpc.filter.GenericImplFilter;	r4 := @parameter0: java.lang.String;	r0 := @parameter1: org.apache.dubbo.rpc.Invocation;	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>();	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>("$invoke");	if $z0 != 0 goto $r2 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>();	$r2 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>();	if $r2 == null goto $z3 = 0;	$z3 = 0;	return $z3
;block_num 4