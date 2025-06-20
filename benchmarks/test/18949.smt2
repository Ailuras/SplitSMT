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

(declare-sort var3876 0)
(declare-sort var43 0)
(declare-sort var3091 0)
(declare-sort var1308 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3091_getMethodName/-888969971 (var3091) String)
(declare-fun var43_invoke/-1860754555 (var43 var3091) var1308)
(declare-const null-var3876 var3876)
(declare-const null-var43 var43)
(declare-const null-var3091 var3091)
(declare-const var57 var3876) ; Statement: r8 := @this: org.apache.dubbo.rpc.filter.EchoFilter 
(assert (not (= var57 null-var3876)))
(declare-const var9 var43) ; Statement: r2 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var9 null-var43)))
(declare-const var1979 var3091) ; Statement: r0 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var1979 null-var3091)))
(define-const var2840 String (var3091_getMethodName/-888969971 var1979)) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>() 
(assert true)
(define-const var2612 Bool (= var2840 "$echo")) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>("$echo") 
 ; Statement: if $z0 == 0 goto $r9 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.rpc.Result invoke(org.apache.dubbo.rpc.Invocation)>(r0) 
(assert (= (ite var2612 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3770 var1308 (var43_invoke/-1860754555 var9 var1979)) ; Statement: $r9 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.rpc.Result invoke(org.apache.dubbo.rpc.Invocation)>(r0) 
 ; Statement: return $r9 
(check-sat)
; {var3091_getMethodName/-888969971=([org.apache.dubbo.rpc.Invocation], java.lang.String), var43_invoke/-1860754555=([org.apache.dubbo.rpc.Invoker, org.apache.dubbo.rpc.Invocation], org.apache.dubbo.rpc.Result)}
; {var3876=org.apache.dubbo.rpc.filter.EchoFilter, var57=r8, var43=org.apache.dubbo.rpc.Invoker, var9=r2, var3091=org.apache.dubbo.rpc.Invocation, var1979=r0, var2840=$r1, var2612=$z0, var1308=org.apache.dubbo.rpc.Result, var3770=$r9}
; {org.apache.dubbo.rpc.filter.EchoFilter=var3876, r8=var57, org.apache.dubbo.rpc.Invoker=var43, r2=var9, org.apache.dubbo.rpc.Invocation=var3091, r0=var1979, $r1=var2840, $z0=var2612, org.apache.dubbo.rpc.Result=var1308, $r9=var3770}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r8 := @this: org.apache.dubbo.rpc.filter.EchoFilter;	r2 := @parameter0: org.apache.dubbo.rpc.Invoker;	r0 := @parameter1: org.apache.dubbo.rpc.Invocation;	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>();	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>("$echo");	if $z0 == 0 goto $r9 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.rpc.Result invoke(org.apache.dubbo.rpc.Invocation)>(r0);	$r9 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.rpc.Result invoke(org.apache.dubbo.rpc.Invocation)>(r0);	return $r9
;block_num 2