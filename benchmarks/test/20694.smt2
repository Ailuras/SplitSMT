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

(declare-sort var1084 0)
(declare-sort var3265 0)
(declare-sort var252 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun toString/1090915316 (var252) String)
(declare-fun var3265_getAttachment/-2134772037 (var3265 String) String)
(declare-const null-var1084 var1084)
(declare-const null-var3265 var3265)
(declare-const var252-FALSE var252)
(declare-const var738 var1084) ; Statement: r4 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var738 null-var1084)))
(declare-const var2065 var3265) ; Statement: r1 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var2065 null-var3265)))
(define-const var2851 var252 var252-FALSE) ; Statement: $r0 = <java.lang.Boolean: java.lang.Boolean FALSE> 
(assert true)
(define-const var2903 String (toString/1090915316 var2851)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.Boolean: java.lang.String toString()>() 
(define-const var1094 String (var3265_getAttachment/-2134772037 var2065 "return")) ; Statement: $r2 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("return") 
(assert true)
(define-const var1408 Bool (= var2903 var1094)) ; Statement: $z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>($r2) 
 ; Statement: if $z0 == 0 goto $r5 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r1) 
(assert (not (= (ite var1408 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3492 Bool (ite (= 1 1) true false)) ; Statement: z2 = 1 
 ; Statement: goto [?= return z2] 
(assert true) ; Non Conditional
 ; Statement: return z2 
(check-sat)
; {toString/1090915316=([java.lang.Boolean], java.lang.String), var3265_getAttachment/-2134772037=([org.apache.dubbo.rpc.Invocation, java.lang.String], java.lang.String)}
; {var1084=org.apache.dubbo.common.URL, var738=r4, var3265=org.apache.dubbo.rpc.Invocation, var2065=r1, var252=java.lang.Boolean, var2851=$r0, var2903=$r3, var1094=$r2, var1408=$z0, var3492=z2}
; {org.apache.dubbo.common.URL=var1084, r4=var738, org.apache.dubbo.rpc.Invocation=var3265, r1=var2065, java.lang.Boolean=var252, $r0=var2851, $r3=var2903, $r2=var1094, $z0=var1408, z2=var3492}
;seq <java.lang.Boolean: java.lang.String toString()>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r4 := @parameter0: org.apache.dubbo.common.URL;	r1 := @parameter1: org.apache.dubbo.rpc.Invocation;	$r0 = <java.lang.Boolean: java.lang.Boolean FALSE>;	$r3 = virtualinvoke $r0.<java.lang.Boolean: java.lang.String toString()>();	$r2 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("return");	$z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>($r2);	if $z0 == 0 goto $r5 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r1);	z2 = 1;	goto [?= return z2];	return z2
;block_num 3