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

(declare-sort var3067 0)
(declare-sort var970 0)
(declare-sort var2572 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun toString/1090915316 (var2572) String)
(declare-fun var970_getAttachment/-2134772037 (var970 String) String)
(declare-const null-var3067 var3067)
(declare-const null-var970 var970)
(declare-const var2572-TRUE var2572)
(declare-const var3392 var3067) ; Statement: r4 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var3392 null-var3067)))
(declare-const var3933 var970) ; Statement: r0 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var3933 null-var970)))
(define-const var2755 Bool true) ; Statement: $z0 = r0 instanceof org.apache.dubbo.rpc.RpcInvocation 
 ; Statement: if $z0 == 0 goto $r1 = <java.lang.Boolean: java.lang.Boolean TRUE> 
(assert (= (ite var2755 1 0) 0)) ; Cond: $z0 == 0 
(define-const var873 var2572 var2572-TRUE) ; Statement: $r1 = <java.lang.Boolean: java.lang.Boolean TRUE> 
(assert true)
(define-const var963 String (toString/1090915316 var873)) ; Statement: $r3 = virtualinvoke $r1.<java.lang.Boolean: java.lang.String toString()>() 
(define-const var2969 String (var970_getAttachment/-2134772037 var3933 "async")) ; Statement: $r2 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("async") 
(assert true)
(define-const var2653 Bool (= var963 var2969)) ; Statement: $z1 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>($r2) 
 ; Statement: if $z1 == 0 goto $r5 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r0) 
(assert (not (= (ite var2653 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var2789 Bool (ite (= 1 1) true false)) ; Statement: z3 = 1 
 ; Statement: goto [?= return z3] 
(assert true) ; Non Conditional
 ; Statement: return z3 
(check-sat)
; {toString/1090915316=([java.lang.Boolean], java.lang.String), var970_getAttachment/-2134772037=([org.apache.dubbo.rpc.Invocation, java.lang.String], java.lang.String)}
; {var3067=org.apache.dubbo.common.URL, var3392=r4, var970=org.apache.dubbo.rpc.Invocation, var3933=r0, var2755=$z0, var2572=java.lang.Boolean, var873=$r1, var963=$r3, var2969=$r2, var2653=$z1, var2789=z3}
; {org.apache.dubbo.common.URL=var3067, r4=var3392, org.apache.dubbo.rpc.Invocation=var970, r0=var3933, $z0=var2755, java.lang.Boolean=var2572, $r1=var873, $r3=var963, $r2=var2969, $z1=var2653, z3=var2789}
;seq <java.lang.Boolean: java.lang.String toString()>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r4 := @parameter0: org.apache.dubbo.common.URL;	r0 := @parameter1: org.apache.dubbo.rpc.Invocation;	$z0 = r0 instanceof org.apache.dubbo.rpc.RpcInvocation;	if $z0 == 0 goto $r1 = <java.lang.Boolean: java.lang.Boolean TRUE>;	$r1 = <java.lang.Boolean: java.lang.Boolean TRUE>;	$r3 = virtualinvoke $r1.<java.lang.Boolean: java.lang.String toString()>();	$r2 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("async");	$z1 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>($r2);	if $z1 == 0 goto $r5 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r0);	z3 = 1;	goto [?= return z3];	return z3
;block_num 4