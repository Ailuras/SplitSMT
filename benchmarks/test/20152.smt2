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

(declare-sort var1872 0)
(declare-sort var886 0)
(declare-sort var1738 0)
(declare-sort var658 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun toString/1090915316 (var1738) String)
(declare-fun var886_getAttachment/-2134772037 (var886 String) String)
(declare-fun var658_getMethodName/-516674313 (var886) String)
(declare-fun getMethodParameter/568256539 (var1872 String String Bool) Bool)
(declare-const null-var1872 var1872)
(declare-const null-var886 var886)
(declare-const var1738-TRUE var1738)
(declare-const var2660 var1872) ; Statement: r4 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var2660 null-var1872)))
(declare-const var2700 var886) ; Statement: r0 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var2700 null-var886)))
(define-const var531 Bool true) ; Statement: $z0 = r0 instanceof org.apache.dubbo.rpc.RpcInvocation 
 ; Statement: if $z0 == 0 goto $r1 = <java.lang.Boolean: java.lang.Boolean TRUE> 
(assert (= (ite var531 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3115 var1738 var1738-TRUE) ; Statement: $r1 = <java.lang.Boolean: java.lang.Boolean TRUE> 
(assert true)
(define-const var3970 String (toString/1090915316 var3115)) ; Statement: $r3 = virtualinvoke $r1.<java.lang.Boolean: java.lang.String toString()>() 
(define-const var3870 String (var886_getAttachment/-2134772037 var2700 "async")) ; Statement: $r2 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("async") 
(assert true)
(define-const var1730 Bool (= var3970 var3870)) ; Statement: $z1 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>($r2) 
 ; Statement: if $z1 == 0 goto $r5 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r0) 
(assert (= (ite var1730 1 0) 0)) ; Cond: $z1 == 0 
(define-const var2696 String (var658_getMethodName/-516674313 var2700)) ; Statement: $r5 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r0) 
(assert true)
(define-const var304 Bool (getMethodParameter/568256539 var2660 var2696 "async" (ite (= 1 0) true false))) ; Statement: z3 = virtualinvoke r4.<org.apache.dubbo.common.URL: boolean getMethodParameter(java.lang.String,java.lang.String,boolean)>($r5, "async", 0) 
(assert true) ; Non Conditional
 ; Statement: return z3 
(check-sat)
; {toString/1090915316=([java.lang.Boolean], java.lang.String), var886_getAttachment/-2134772037=([org.apache.dubbo.rpc.Invocation, java.lang.String], java.lang.String), var658_getMethodName/-516674313=([org.apache.dubbo.rpc.Invocation], java.lang.String), getMethodParameter/568256539=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String, boolean], boolean)}
; {var1872=org.apache.dubbo.common.URL, var2660=r4, var886=org.apache.dubbo.rpc.Invocation, var2700=r0, var531=$z0, var1738=java.lang.Boolean, var3115=$r1, var3970=$r3, var3870=$r2, var1730=$z1, var658=org.apache.dubbo.rpc.support.RpcUtils, var2696=$r5, var304=z3}
; {org.apache.dubbo.common.URL=var1872, r4=var2660, org.apache.dubbo.rpc.Invocation=var886, r0=var2700, $z0=var531, java.lang.Boolean=var1738, $r1=var3115, $r3=var3970, $r2=var3870, $z1=var1730, org.apache.dubbo.rpc.support.RpcUtils=var658, $r5=var2696, z3=var304}
;seq <java.lang.Boolean: java.lang.String toString()>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r4 := @parameter0: org.apache.dubbo.common.URL;	r0 := @parameter1: org.apache.dubbo.rpc.Invocation;	$z0 = r0 instanceof org.apache.dubbo.rpc.RpcInvocation;	if $z0 == 0 goto $r1 = <java.lang.Boolean: java.lang.Boolean TRUE>;	$r1 = <java.lang.Boolean: java.lang.Boolean TRUE>;	$r3 = virtualinvoke $r1.<java.lang.Boolean: java.lang.String toString()>();	$r2 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("async");	$z1 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>($r2);	if $z1 == 0 goto $r5 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r0);	$r5 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r0);	z3 = virtualinvoke r4.<org.apache.dubbo.common.URL: boolean getMethodParameter(java.lang.String,java.lang.String,boolean)>($r5, "async", 0);	return z3
;block_num 4