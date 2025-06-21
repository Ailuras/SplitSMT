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

(declare-sort var2420 0)
(declare-sort var3142 0)
(declare-sort var3383 0)
(declare-sort var2709 0)
(declare-sort var3067 0)
(declare-sort var1795 0)
(declare-sort var2027 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3383_get/-492901218 (var3383 var2709) var2709)
(declare-fun cast-from-String-to-var2709 (String) var2709)
(declare-fun cast-from-var2709-to-var3067 (var2709) var3067)
(declare-fun cast-from-var2709-to-var1795 (var2709) var1795)
(declare-fun invoke/237886930 (var2420 var3142 var3383 var3067 var1795) var2027)
(declare-const null-var2420 var2420)
(declare-const null-var3142 var3142)
(declare-const null-var3383 var3383)
(declare-const var1300 var2420) ; Statement: r9 := @this: org.apache.dubbo.rpc.protocol.tri.rest.filter.RestFilterAdapter 
(assert (not (= var1300 null-var2420)))
(declare-const var3682 var3142) ; Statement: r3 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var3682 null-var3142)))
(declare-const var682 var3383) ; Statement: r0 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var682 null-var3383)))
(define-const var1926 String "rest") ; Statement: $r2 = "rest" 
(define-const var677 var2709 (var3383_get/-492901218 var682 (cast-from-String-to-var2709 "tri.handler.type"))) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object get(java.lang.Object)>("tri.handler.type") 
(assert true)
(define-const var3226 Bool false) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: if $z0 == 0 goto $r4 = interfaceinvoke r3.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.rpc.Result invoke(org.apache.dubbo.rpc.Invocation)>(r0) 
(assert (not (= (ite var3226 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2832 var2709 (var3383_get/-492901218 var682 (cast-from-String-to-var2709 "tri.http.request"))) ; Statement: $r5 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object get(java.lang.Object)>("tri.http.request") 
(define-const var37 var3067 (cast-from-var2709-to-var3067 var2832)) ; Statement: r6 = (org.apache.dubbo.remoting.http12.HttpRequest) $r5 
(define-const var1751 var2709 (var3383_get/-492901218 var682 (cast-from-String-to-var2709 "tri.http.response"))) ; Statement: $r7 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object get(java.lang.Object)>("tri.http.response") 
(define-const var663 var1795 (cast-from-var2709-to-var1795 var1751)) ; Statement: r8 = (org.apache.dubbo.remoting.http12.HttpResponse) $r7 
(assert true)
(define-const var1297 var2027 (invoke/237886930 var1300 var3682 var682 var37 var663)) ; Statement: $r10 = virtualinvoke r9.<org.apache.dubbo.rpc.protocol.tri.rest.filter.RestFilterAdapter: org.apache.dubbo.rpc.Result invoke(org.apache.dubbo.rpc.Invoker,org.apache.dubbo.rpc.Invocation,org.apache.dubbo.remoting.http12.HttpRequest,org.apache.dubbo.remoting.http12.HttpResponse)>(r3, r0, r6, r8) 
 ; Statement: return $r10 
(check-sat)
; {var3383_get/-492901218=([org.apache.dubbo.rpc.Invocation, java.lang.Object], java.lang.Object), cast-from-String-to-var2709=([java.lang.String], java.lang.Object), cast-from-var2709-to-var3067=([java.lang.Object], org.apache.dubbo.remoting.http12.HttpRequest), cast-from-var2709-to-var1795=([java.lang.Object], org.apache.dubbo.remoting.http12.HttpResponse), invoke/237886930=([org.apache.dubbo.rpc.protocol.tri.rest.filter.RestFilterAdapter, org.apache.dubbo.rpc.Invoker, org.apache.dubbo.rpc.Invocation, org.apache.dubbo.remoting.http12.HttpRequest, org.apache.dubbo.remoting.http12.HttpResponse], org.apache.dubbo.rpc.Result)}
; {var2420=org.apache.dubbo.rpc.protocol.tri.rest.filter.RestFilterAdapter, var1300=r9, var3142=org.apache.dubbo.rpc.Invoker, var3682=r3, var3383=org.apache.dubbo.rpc.Invocation, var682=r0, var1926=$r2, var2709=java.lang.Object, var677=$r1, var3226=$z0, var2832=$r5, var3067=org.apache.dubbo.remoting.http12.HttpRequest, var37=r6, var1751=$r7, var1795=org.apache.dubbo.remoting.http12.HttpResponse, var663=r8, var2027=org.apache.dubbo.rpc.Result, var1297=$r10}
; {org.apache.dubbo.rpc.protocol.tri.rest.filter.RestFilterAdapter=var2420, r9=var1300, org.apache.dubbo.rpc.Invoker=var3142, r3=var3682, org.apache.dubbo.rpc.Invocation=var3383, r0=var682, $r2=var1926, java.lang.Object=var2709, $r1=var677, $z0=var3226, $r5=var2832, org.apache.dubbo.remoting.http12.HttpRequest=var3067, r6=var37, $r7=var1751, org.apache.dubbo.remoting.http12.HttpResponse=var1795, r8=var663, org.apache.dubbo.rpc.Result=var2027, $r10=var1297}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r9 := @this: org.apache.dubbo.rpc.protocol.tri.rest.filter.RestFilterAdapter;	r3 := @parameter0: org.apache.dubbo.rpc.Invoker;	r0 := @parameter1: org.apache.dubbo.rpc.Invocation;	$r2 = "rest";	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object get(java.lang.Object)>("tri.handler.type");	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	if $z0 == 0 goto $r4 = interfaceinvoke r3.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.rpc.Result invoke(org.apache.dubbo.rpc.Invocation)>(r0);	$r5 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object get(java.lang.Object)>("tri.http.request");	r6 = (org.apache.dubbo.remoting.http12.HttpRequest) $r5;	$r7 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.Object get(java.lang.Object)>("tri.http.response");	r8 = (org.apache.dubbo.remoting.http12.HttpResponse) $r7;	$r10 = virtualinvoke r9.<org.apache.dubbo.rpc.protocol.tri.rest.filter.RestFilterAdapter: org.apache.dubbo.rpc.Result invoke(org.apache.dubbo.rpc.Invoker,org.apache.dubbo.rpc.Invocation,org.apache.dubbo.remoting.http12.HttpRequest,org.apache.dubbo.remoting.http12.HttpResponse)>(r3, r0, r6, r8);	return $r10
;block_num 2