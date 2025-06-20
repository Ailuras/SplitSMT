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

(declare-sort var878 0)
(declare-sort var1979 0)
(declare-sort var2340 0)
(declare-sort var1203 0)
(declare-sort var3994 0)
(declare-sort var1821 0)
(declare-sort var1369 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun statusMap/-511870876 (var878) var2340)
(declare-fun getService/-1311689935 (var1979) String)
(declare-fun var2340_get/1088891777 (var2340 var1203) var1203)
(declare-fun cast-from-String-to-var1203 (String) var1203)
(declare-fun cast-from-var1203-to-var3994 (var1203) var3994)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun withDescription/65961942 (var1821 String) var1821)
(declare-fun asException/-351536454 (var1821) var1369)
(declare-const null-var878 var878)
(declare-const null-var1979 var1979)
(declare-const null-var3994 var3994)
(declare-const var1821-NOT_FOUND var1821)
(declare-const var2842 var878) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.service.TriHealthImpl 
(assert (not (= var2842 null-var878)))
(declare-const var3377 var1979) ; Statement: r1 := @parameter0: io.grpc.health.v1.HealthCheckRequest 
(assert (not (= var3377 null-var1979)))
(define-const var3560 var2340 (statusMap/-511870876 var2842)) ; Statement: $r2 = r0.<org.apache.dubbo.rpc.protocol.tri.service.TriHealthImpl: java.util.Map statusMap> 
(assert true)
(define-const var3450 String (getService/-1311689935 var3377)) ; Statement: $r3 = virtualinvoke r1.<io.grpc.health.v1.HealthCheckRequest: java.lang.String getService()>() 
(define-const var2781 var1203 (var2340_get/1088891777 var3560 (cast-from-String-to-var1203 var3450))) ; Statement: $r4 = interfaceinvoke $r2.<java.util.Map: java.lang.Object get(java.lang.Object)>($r3) 
(define-const var3831 var3994 (cast-from-var1203-to-var3994 var2781)) ; Statement: r5 = (io.grpc.health.v1.HealthCheckResponse$ServingStatus) $r4 
 ; Statement: if r5 == null goto $r7 = <org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus NOT_FOUND> 
(assert (= var3831 null-var3994)) ; Cond: r5 == null 
(define-const var3069 var1821 var1821-NOT_FOUND) ; Statement: $r7 = <org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus NOT_FOUND> 
(define-const var1339 String String-init) ; Statement: $r6 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1339)) ; Statement: specialinvoke $r6.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1339!1 String)
(assert (= var1339!1 ""))
(assert true)
(define-const var2258 String (append/672562846 var1339!1 "unknown service ")) ; Statement: $r9 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("unknown service ") 
(declare-const var1339!2 String)
(assert (= var1339!2 (str.++ var1339!1 "unknown service ")))
(assert true)
(define-const var199 String (getService/-1311689935 var3377)) ; Statement: $r8 = virtualinvoke r1.<io.grpc.health.v1.HealthCheckRequest: java.lang.String getService()>() 
(assert true)
(define-const var3640 String (append/672562846 var2258 var199)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8) 
(declare-const var2258!1 String)
(assert (= var2258!1 (str.++ var2258 var199)))
(assert true)
(define-const var1717 String (toString/-2075883882 var3640)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
(define-const var1844 var1821 (withDescription/65961942 var3069 var1717)) ; Statement: $r12 = virtualinvoke $r7.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus withDescription(java.lang.String)>($r11) 
(assert true)
(define-const var2714 var1369 (asException/-351536454 var1844)) ; Statement: $r13 = virtualinvoke $r12.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.StatusRpcException asException()>() 
 ; Statement: throw $r13 
(check-sat)
; {statusMap/-511870876=([org.apache.dubbo.rpc.protocol.tri.service.TriHealthImpl], java.util.Map), getService/-1311689935=([io.grpc.health.v1.HealthCheckRequest], java.lang.String), var2340_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var1203=([java.lang.String], java.lang.Object), cast-from-var1203-to-var3994=([java.lang.Object], io.grpc.health.v1.HealthCheckResponse$ServingStatus), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), withDescription/65961942=([org.apache.dubbo.rpc.TriRpcStatus, java.lang.String], org.apache.dubbo.rpc.TriRpcStatus), asException/-351536454=([org.apache.dubbo.rpc.TriRpcStatus], org.apache.dubbo.rpc.StatusRpcException)}
; {var878=org.apache.dubbo.rpc.protocol.tri.service.TriHealthImpl, var2842=r0, var1979=io.grpc.health.v1.HealthCheckRequest, var3377=r1, var2340=java.util.Map, var3560=$r2, var3450=$r3, var1203=java.lang.Object, var2781=$r4, var3994=io.grpc.health.v1.HealthCheckResponse$ServingStatus, var3831=r5, var1821=org.apache.dubbo.rpc.TriRpcStatus, var3069=$r7, var1339=$r6, var2258=$r9, var199=$r8, var3640=$r10, var1717=$r11, var1844=$r12, var1369=org.apache.dubbo.rpc.StatusRpcException, var2714=$r13}
; {org.apache.dubbo.rpc.protocol.tri.service.TriHealthImpl=var878, r0=var2842, io.grpc.health.v1.HealthCheckRequest=var1979, r1=var3377, java.util.Map=var2340, $r2=var3560, $r3=var3450, java.lang.Object=var1203, $r4=var2781, io.grpc.health.v1.HealthCheckResponse$ServingStatus=var3994, r5=var3831, org.apache.dubbo.rpc.TriRpcStatus=var1821, $r7=var3069, $r6=var1339, $r9=var2258, $r8=var199, $r10=var3640, $r11=var1717, $r12=var1844, org.apache.dubbo.rpc.StatusRpcException=var1369, $r13=var2714}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.service.TriHealthImpl;	r1 := @parameter0: io.grpc.health.v1.HealthCheckRequest;	$r2 = r0.<org.apache.dubbo.rpc.protocol.tri.service.TriHealthImpl: java.util.Map statusMap>;	$r3 = virtualinvoke r1.<io.grpc.health.v1.HealthCheckRequest: java.lang.String getService()>();	$r4 = interfaceinvoke $r2.<java.util.Map: java.lang.Object get(java.lang.Object)>($r3);	r5 = (io.grpc.health.v1.HealthCheckResponse$ServingStatus) $r4;	if r5 == null goto $r7 = <org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus NOT_FOUND>;	$r7 = <org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus NOT_FOUND>;	$r6 = new java.lang.StringBuilder;	specialinvoke $r6.<java.lang.StringBuilder: void <init>()>();	$r9 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("unknown service ");	$r8 = virtualinvoke r1.<io.grpc.health.v1.HealthCheckRequest: java.lang.String getService()>();	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	$r12 = virtualinvoke $r7.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus withDescription(java.lang.String)>($r11);	$r13 = virtualinvoke $r12.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.StatusRpcException asException()>();	throw $r13
;block_num 2