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

(declare-sort var624 0)
(declare-sort var2100 0)
(declare-sort var384 0)
(declare-sort var1751 0)
(declare-sort var1613 0)
(declare-sort var2447 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun done/1769217741 (var624) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun connectionClient/1769217741 (var624) var384)
(declare-fun append/-1031950772 (String var1751) String)
(declare-fun cast-from-var384-to-var1751 (var384) var1751)
(declare-fun requestMetadata/1769217741 (var624) var1613)
(declare-fun service/943479956 (var1613) String)
(declare-fun method/943479956 (var1613) var2447)
(declare-fun var2447_getMethodName/-1216290648 (var2447) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2100_warn/1431914100 (var2100 String String String String) void)
(declare-const null-var624 var624)
(declare-const null-__Array__Int__Int__ (Array Int Int))
(declare-const null-Bool Bool)
(declare-const var624-LOGGER var2100)
(declare-const var2088 var624) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.call.TripleClientCall 
(assert (not (= var2088 null-var624)))
(declare-const var3016 (Array Int Int)) ; Statement: r2 := @parameter0: byte[] 
(assert (not (= var3016 null-__Array__Int__Int__)))
(declare-const var2549 Bool) ; Statement: z1 := @parameter1: boolean 
(assert (not (= var2549 null-Bool)))
(define-const var3268 Bool (done/1769217741 var2088)) ; Statement: $z0 = r0.<org.apache.dubbo.rpc.protocol.tri.call.TripleClientCall: boolean done> 
 ; Statement: if $z0 == 0 goto $r1 = r0.<org.apache.dubbo.rpc.protocol.tri.call.TripleClientCall: org.apache.dubbo.rpc.protocol.tri.RequestMetadata requestMetadata> 
(assert (not (= (ite var3268 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2438 var2100 var624-LOGGER) ; Statement: $r6 = <org.apache.dubbo.rpc.protocol.tri.call.TripleClientCall: org.apache.dubbo.common.logger.ErrorTypeAwareLogger LOGGER> 
(define-const var1171 String String-init) ; Statement: $r5 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1171)) ; Statement: specialinvoke $r5.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1171!1 String)
(assert (= var1171!1 ""))
(assert true)
(define-const var2956 String (append/672562846 var1171!1 "Received message from closed stream,connection=")) ; Statement: $r8 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Received message from closed stream,connection=") 
(declare-const var1171!2 String)
(assert (= var1171!2 (str.++ var1171!1 "Received message from closed stream,connection=")))
(define-const var1592 var384 (connectionClient/1769217741 var2088)) ; Statement: $r7 = r0.<org.apache.dubbo.rpc.protocol.tri.call.TripleClientCall: org.apache.dubbo.remoting.api.connection.AbstractConnectionClient connectionClient> 
(assert true)
(define-const var291 String (append/-1031950772 var2956 (cast-from-var384-to-var1751 var1592))) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r7) 
(declare-const var2956!1 String)
(assert (str.prefixof var2956 var2956!1))
(assert true)
(define-const var2682 String (append/672562846 var291 " service=")) ; Statement: $r12 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" service=") 
(declare-const var291!1 String)
(assert (= var291!1 (str.++ var291 " service=")))
(define-const var3590 var1613 (requestMetadata/1769217741 var2088)) ; Statement: $r10 = r0.<org.apache.dubbo.rpc.protocol.tri.call.TripleClientCall: org.apache.dubbo.rpc.protocol.tri.RequestMetadata requestMetadata> 
(define-const var996 String (service/943479956 var3590)) ; Statement: $r11 = $r10.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String service> 
(assert true)
(define-const var943 String (append/672562846 var2682 var996)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r11) 
(declare-const var2682!1 String)
(assert (= var2682!1 (str.++ var2682 var996)))
(assert true)
(define-const var2138 String (append/672562846 var943 " method=")) ; Statement: $r17 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" method=") 
(declare-const var943!1 String)
(assert (= var943!1 (str.++ var943 " method=")))
(define-const var3303 var1613 (requestMetadata/1769217741 var2088)) ; Statement: $r14 = r0.<org.apache.dubbo.rpc.protocol.tri.call.TripleClientCall: org.apache.dubbo.rpc.protocol.tri.RequestMetadata requestMetadata> 
(define-const var3836 var2447 (method/943479956 var3303)) ; Statement: $r15 = $r14.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: org.apache.dubbo.rpc.model.MethodDescriptor method> 
(define-const var497 String (var2447_getMethodName/-1216290648 var3836)) ; Statement: $r16 = interfaceinvoke $r15.<org.apache.dubbo.rpc.model.MethodDescriptor: java.lang.String getMethodName()>() 
(assert true)
(define-const var2851 String (append/672562846 var2138 var497)) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r16) 
(declare-const var2138!1 String)
(assert (= var2138!1 (str.++ var2138 var497)))
(assert true)
(define-const var685 String (toString/-2075883882 var2851)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var2100_warn/1431914100 var2438 "4-15" "" "" var685)) ; Statement: interfaceinvoke $r6.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("4-15", "", "", $r19) 

(declare-const var2438!1 var2100)
(declare-const var2793 String)
(declare-const var3781 String)
(declare-const var3781!1 String)
(declare-const var685!1 String)
 ; Statement: return 
(check-sat)
; {done/1769217741=([org.apache.dubbo.rpc.protocol.tri.call.TripleClientCall], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), connectionClient/1769217741=([org.apache.dubbo.rpc.protocol.tri.call.TripleClientCall], org.apache.dubbo.remoting.api.connection.AbstractConnectionClient), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var384-to-var1751=([org.apache.dubbo.remoting.api.connection.AbstractConnectionClient], java.lang.Object), requestMetadata/1769217741=([org.apache.dubbo.rpc.protocol.tri.call.TripleClientCall], org.apache.dubbo.rpc.protocol.tri.RequestMetadata), service/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], java.lang.String), method/943479956=([org.apache.dubbo.rpc.protocol.tri.RequestMetadata], org.apache.dubbo.rpc.model.MethodDescriptor), var2447_getMethodName/-1216290648=([org.apache.dubbo.rpc.model.MethodDescriptor], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2100_warn/1431914100=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String], void)}
; {var624=org.apache.dubbo.rpc.protocol.tri.call.TripleClientCall, var2088=r0, var3016=r2, var2549=z1, var3268=$z0, var2100=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var2438=$r6, var1171=$r5, var2956=$r8, var384=org.apache.dubbo.remoting.api.connection.AbstractConnectionClient, var1592=$r7, var1751=java.lang.Object, var291=$r9, var2682=$r12, var1613=org.apache.dubbo.rpc.protocol.tri.RequestMetadata, var3590=$r10, var996=$r11, var943=$r13, var2138=$r17, var3303=$r14, var2447=org.apache.dubbo.rpc.model.MethodDescriptor, var3836=$r15, var497=$r16, var2851=$r18, var685=$r19, var2793="4-15", var3781=""}
; {org.apache.dubbo.rpc.protocol.tri.call.TripleClientCall=var624, r0=var2088, r2=var3016, z1=var2549, $z0=var3268, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var2100, $r6=var2438, $r5=var1171, $r8=var2956, org.apache.dubbo.remoting.api.connection.AbstractConnectionClient=var384, $r7=var1592, java.lang.Object=var1751, $r9=var291, $r12=var2682, org.apache.dubbo.rpc.protocol.tri.RequestMetadata=var1613, $r10=var3590, $r11=var996, $r13=var943, $r17=var2138, $r14=var3303, org.apache.dubbo.rpc.model.MethodDescriptor=var2447, $r15=var3836, $r16=var497, $r18=var2851, $r19=var685, "4-15"=var2793, ""=var3781}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.call.TripleClientCall;	r2 := @parameter0: byte[];	z1 := @parameter1: boolean;	$z0 = r0.<org.apache.dubbo.rpc.protocol.tri.call.TripleClientCall: boolean done>;	if $z0 == 0 goto $r1 = r0.<org.apache.dubbo.rpc.protocol.tri.call.TripleClientCall: org.apache.dubbo.rpc.protocol.tri.RequestMetadata requestMetadata>;	$r6 = <org.apache.dubbo.rpc.protocol.tri.call.TripleClientCall: org.apache.dubbo.common.logger.ErrorTypeAwareLogger LOGGER>;	$r5 = new java.lang.StringBuilder;	specialinvoke $r5.<java.lang.StringBuilder: void <init>()>();	$r8 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Received message from closed stream,connection=");	$r7 = r0.<org.apache.dubbo.rpc.protocol.tri.call.TripleClientCall: org.apache.dubbo.remoting.api.connection.AbstractConnectionClient connectionClient>;	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r7);	$r12 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" service=");	$r10 = r0.<org.apache.dubbo.rpc.protocol.tri.call.TripleClientCall: org.apache.dubbo.rpc.protocol.tri.RequestMetadata requestMetadata>;	$r11 = $r10.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: java.lang.String service>;	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r11);	$r17 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" method=");	$r14 = r0.<org.apache.dubbo.rpc.protocol.tri.call.TripleClientCall: org.apache.dubbo.rpc.protocol.tri.RequestMetadata requestMetadata>;	$r15 = $r14.<org.apache.dubbo.rpc.protocol.tri.RequestMetadata: org.apache.dubbo.rpc.model.MethodDescriptor method>;	$r16 = interfaceinvoke $r15.<org.apache.dubbo.rpc.model.MethodDescriptor: java.lang.String getMethodName()>();	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r16);	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r6.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("4-15", "", "", $r19);	return
;block_num 2