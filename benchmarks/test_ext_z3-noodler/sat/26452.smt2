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

(declare-sort var3963 0)
(declare-sort var19 0)
(declare-sort var1400 0)
(declare-sort var1663 0)
(declare-sort var2503 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun methodsCondition/-1662532433 (var3963) var1400)
(declare-fun name/1633728430 (var2503) String)
(declare-fun cast-from-var1663-to-var2503 (var1663) var2503)
(declare-fun var19_method/1452675274 (var19) String)
(declare-fun compareTo/2019048779 (var1400 var1400 var19) Int)
(declare-const null-var3963 var3963)
(declare-const null-var19 var19)
(declare-const null-var1400 var1400)
(declare-const var1663-HEAD var1663)
(declare-const var811 var3963) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping 
(assert (not (= var811 null-var3963)))
(declare-const var3399 var3963) ; Statement: r9 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping 
(assert (not (= var3399 null-var3963)))
(declare-const var948 var19) ; Statement: r11 := @parameter1: org.apache.dubbo.remoting.http12.HttpRequest 
(assert (not (= var948 null-var19)))
(define-const var2306 var1400 (methodsCondition/-1662532433 var811)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MethodsCondition methodsCondition> 
 ; Statement: if $r1 == null goto $r34 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition pathCondition> 
(assert (not (= var2306 null-var1400))) ; Negate: Cond: $r1 == null  
(define-const var3473 var1663 var1663-HEAD) ; Statement: $r29 = <org.apache.dubbo.remoting.http12.HttpMethods: org.apache.dubbo.remoting.http12.HttpMethods HEAD> 
(assert true)
(define-const var2409 String (name/1633728430 (cast-from-var1663-to-var2503 var3473))) ; Statement: $r31 = virtualinvoke $r29.<org.apache.dubbo.remoting.http12.HttpMethods: java.lang.String name()>() 
(define-const var2519 String (var19_method/1452675274 var948)) ; Statement: $r30 = interfaceinvoke r11.<org.apache.dubbo.remoting.http12.HttpRequest: java.lang.String method()>() 
(assert true)
(define-const var594 Bool (= var2409 var2519)) ; Statement: $z0 = virtualinvoke $r31.<java.lang.String: boolean equals(java.lang.Object)>($r30) 
 ; Statement: if $z0 == 0 goto $r34 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition pathCondition> 
(assert (not (= (ite var594 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var815 var1400 (methodsCondition/-1662532433 var811)) ; Statement: $r33 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MethodsCondition methodsCondition> 
(define-const var1167 var1400 (methodsCondition/-1662532433 var3399)) ; Statement: $r32 = r9.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MethodsCondition methodsCondition> 
(assert true)
(define-const var2060 Int (compareTo/2019048779 var815 var1167 var948)) ; Statement: i3 = virtualinvoke $r33.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MethodsCondition: int compareTo(org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MethodsCondition,org.apache.dubbo.remoting.http12.HttpRequest)>($r32, r11) 
 ; Statement: if i3 == 0 goto $r34 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition pathCondition> 
(assert (not (= var2060 0))) ; Negate: Cond: i3 == 0  
 ; Statement: return i3 
(check-sat)
; {methodsCondition/-1662532433=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping], org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MethodsCondition), name/1633728430=([java.lang.Enum], java.lang.String), cast-from-var1663-to-var2503=([org.apache.dubbo.remoting.http12.HttpMethods], java.lang.Enum), var19_method/1452675274=([org.apache.dubbo.remoting.http12.HttpRequest], java.lang.String), compareTo/2019048779=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MethodsCondition, org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MethodsCondition, org.apache.dubbo.remoting.http12.HttpRequest], int)}
; {var3963=org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping, var811=r0, var3399=r9, var19=org.apache.dubbo.remoting.http12.HttpRequest, var948=r11, var1400=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MethodsCondition, var2306=$r1, var1663=org.apache.dubbo.remoting.http12.HttpMethods, var3473=$r29, var2503=java.lang.Enum, var2409=$r31, var2519=$r30, var594=$z0, var815=$r33, var1167=$r32, var2060=i3}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping=var3963, r0=var811, r9=var3399, org.apache.dubbo.remoting.http12.HttpRequest=var19, r11=var948, org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MethodsCondition=var1400, $r1=var2306, org.apache.dubbo.remoting.http12.HttpMethods=var1663, $r29=var3473, java.lang.Enum=var2503, $r31=var2409, $r30=var2519, $z0=var594, $r33=var815, $r32=var1167, i3=var2060}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping;	r9 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping;	r11 := @parameter1: org.apache.dubbo.remoting.http12.HttpRequest;	$r1 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MethodsCondition methodsCondition>;	if $r1 == null goto $r34 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition pathCondition>;	$r29 = <org.apache.dubbo.remoting.http12.HttpMethods: org.apache.dubbo.remoting.http12.HttpMethods HEAD>;	$r31 = virtualinvoke $r29.<org.apache.dubbo.remoting.http12.HttpMethods: java.lang.String name()>();	$r30 = interfaceinvoke r11.<org.apache.dubbo.remoting.http12.HttpRequest: java.lang.String method()>();	$z0 = virtualinvoke $r31.<java.lang.String: boolean equals(java.lang.Object)>($r30);	if $z0 == 0 goto $r34 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition pathCondition>;	$r33 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MethodsCondition methodsCondition>;	$r32 = r9.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MethodsCondition methodsCondition>;	i3 = virtualinvoke $r33.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MethodsCondition: int compareTo(org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MethodsCondition,org.apache.dubbo.remoting.http12.HttpRequest)>($r32, r11);	if i3 == 0 goto $r34 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition pathCondition>;	return i3
;block_num 4