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

(declare-sort var2456 0)
(declare-sort var369 0)
(declare-sort var2420 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2420_getMethodName/-888969971 (var2420) String)
(declare-const null-var2456 var2456)
(declare-const null-String String)
(declare-const null-var2420 var2420)
(declare-const var803 var2456) ; Statement: r6 := @this: org.apache.dubbo.rpc.filter.GenericImplFilter 
(assert (not (= var803 null-var2456)))
(declare-const var3588 String) ; Statement: r4 := @parameter0: java.lang.String 
(assert (not (= var3588 null-String)))
(declare-const var3245 var2420) ; Statement: r0 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var3245 null-var2420)))
(define-const var81 String (var2420_getMethodName/-888969971 var3245)) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>() 
(assert true)
(define-const var329 Bool (= var81 "$invoke")) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>("$invoke") 
 ; Statement: if $z0 != 0 goto $r2 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>() 
(assert (not (not (= (ite var329 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var3650 String (var2420_getMethodName/-888969971 var3245)) ; Statement: $r5 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>() 
(assert true)
(define-const var964 Bool (= var3650 "$invokeAsync")) ; Statement: $z2 = virtualinvoke $r5.<java.lang.String: boolean equals(java.lang.Object)>("$invokeAsync") 
 ; Statement: if $z2 == 0 goto $z3 = 0 
(assert (= (ite var964 1 0) 0)) ; Cond: $z2 == 0 
(define-const var2708 Bool (ite (= 1 0) true false)) ; Statement: $z3 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z3 
(check-sat)
; {var2420_getMethodName/-888969971=([org.apache.dubbo.rpc.Invocation], java.lang.String)}
; {var2456=org.apache.dubbo.rpc.filter.GenericImplFilter, var803=r6, var3588=r4, var369=null_type, var2420=org.apache.dubbo.rpc.Invocation, var3245=r0, var81=$r1, var329=$z0, var3650=$r5, var964=$z2, var2708=$z3}
; {org.apache.dubbo.rpc.filter.GenericImplFilter=var2456, r6=var803, r4=var3588, null_type=var369, org.apache.dubbo.rpc.Invocation=var2420, r0=var3245, $r1=var81, $z0=var329, $r5=var3650, $z2=var964, $z3=var2708}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 2}
;stmts r6 := @this: org.apache.dubbo.rpc.filter.GenericImplFilter;	r4 := @parameter0: java.lang.String;	r0 := @parameter1: org.apache.dubbo.rpc.Invocation;	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>();	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>("$invoke");	if $z0 != 0 goto $r2 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object[] getArguments()>();	$r5 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>();	$z2 = virtualinvoke $r5.<java.lang.String: boolean equals(java.lang.Object)>("$invokeAsync");	if $z2 == 0 goto $z3 = 0;	$z3 = 0;	return $z3
;block_num 4