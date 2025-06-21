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

(declare-sort var2540 0)
(declare-sort var1774 0)
(declare-sort var2416 0)
(declare-sort var543 0)
(declare-sort var2041 0)
(declare-sort var2646 0)
(declare-sort var3246 0)
(declare-sort var2914 0)
(declare-sort var2563 0)
(declare-sort var1840 0)
(declare-sort var893 0)
(declare-sort var2553 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2041_getLocalAddress/2019899378 (var2041) var543)
(declare-fun cast-from-var1774-to-var2041 (var1774) var2041)
(declare-fun getPort/-1397617271 (var543) Int)
(declare-fun var2416_getObjectAttachmentWithoutConvert/-2125165309 (var2416 String) var2646)
(declare-fun cast-from-var2646-to-String (var2646) String)
(declare-fun toString/1090915316 (var3246) String)
(declare-fun isClientSide/776072184 (var2540 var1774) Bool)
(declare-fun var2914_serviceKey/-263494211 (Int String String String) String)
(declare-fun exporterMap/1326816129 (var2914) var2563)
(declare-fun cast-from-var2540-to-var2914 (var2540) var2914)
(declare-fun var2563_get/1088891777 (var2563 var2646) var2646)
(declare-fun cast-from-String-to-var2646 (String) var2646)
(declare-fun cast-from-var2646-to-var1840 (var2646) var1840)
(declare-fun var893-init () var893)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var2563_keySet/-712633290 (var2563) var2553)
(declare-fun append/-1031950772 (String var2646) String)
(declare-fun cast-from-var2553-to-var2646 (var2553) var2646)
(declare-fun var1774_getRemoteAddress/1597111645 (var1774) var543)
(declare-fun cast-from-var543-to-var2646 (var543) var2646)
(declare-fun getInvocationWithoutData/1955400546 (var2540 var2416) var2416)
(declare-fun cast-from-var2416-to-var2646 (var2416) var2646)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-2142452957 (var893 var1774 String) void)
(declare-const null-var2540 var2540)
(declare-const null-var1774 var1774)
(declare-const null-var2416 var2416)
(declare-const var3246-TRUE var3246)
(declare-const null-var1840 var1840)
(declare-const var1990 var2540) ; Statement: r7 := @this: org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol 
(assert (not (= var1990 null-var2540)))
(declare-const var3748 var1774) ; Statement: r0 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var3748 null-var1774)))
(declare-const var3641 var2416) ; Statement: r2 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var3641 null-var2416)))
(define-const var2155 var543 (var2041_getLocalAddress/2019899378 (cast-from-var1774-to-var2041 var3748))) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getLocalAddress()>() 
(assert true)
(define-const var3044 Int (getPort/-1397617271 var2155)) ; Statement: i0 = virtualinvoke $r1.<java.net.InetSocketAddress: int getPort()>() 
(define-const var1337 var2646 (var2416_getObjectAttachmentWithoutConvert/-2125165309 var3641 "path")) ; Statement: $r3 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("path") 
(define-const var851 String (cast-from-var2646-to-String var1337)) ; Statement: r44 = (java.lang.String) $r3 
(define-const var2388 var3246 var3246-TRUE) ; Statement: $r4 = <java.lang.Boolean: java.lang.Boolean TRUE> 
(assert true)
(define-const var3203 String (toString/1090915316 var2388)) ; Statement: $r6 = virtualinvoke $r4.<java.lang.Boolean: java.lang.String toString()>() 
(define-const var684 var2646 (var2416_getObjectAttachmentWithoutConvert/-2125165309 var3641 "dubbo.stub.event")) ; Statement: $r5 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("dubbo.stub.event") 
(assert true)
(define-const var17 Bool false) ; Statement: z0 = virtualinvoke $r6.<java.lang.String: boolean equals(java.lang.Object)>($r5) 
 ; Statement: if z0 == 0 goto $z1 = specialinvoke r7.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol: boolean isClientSide(org.apache.dubbo.remoting.Channel)>(r0) 
(assert (= (ite var17 1 0) 0)) ; Cond: z0 == 0 
(assert true)
(define-const var81 Bool (isClientSide/776072184 var1990 var3748)) ; Statement: $z1 = specialinvoke r7.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol: boolean isClientSide(org.apache.dubbo.remoting.Channel)>(r0) 
 ; Statement: if $z1 == 0 goto $z2 = 0 
(assert (= (ite var81 1 0) 0)) ; Cond: $z1 == 0 
(define-const var3384 Bool (ite (= 1 0) true false)) ; Statement: $z2 = 0 
(assert true) ; Non Conditional
 ; Statement: if $z2 == 0 goto $r8 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("version") 
(assert (= (ite var3384 1 0) 0)) ; Cond: $z2 == 0 
(define-const var882 var2646 (var2416_getObjectAttachmentWithoutConvert/-2125165309 var3641 "version")) ; Statement: $r8 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("version") 
(define-const var2321 String (cast-from-var2646-to-String var882)) ; Statement: $r11 = (java.lang.String) $r8 
(define-const var3253 var2646 (var2416_getObjectAttachmentWithoutConvert/-2125165309 var3641 "group")) ; Statement: $r9 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("group") 
(define-const var457 String (cast-from-var2646-to-String var3253)) ; Statement: $r10 = (java.lang.String) $r9 
(define-const var1425 String (var2914_serviceKey/-263494211 var3044 var851 var2321 var457)) ; Statement: $r42 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol: java.lang.String serviceKey(int,java.lang.String,java.lang.String,java.lang.String)>(i0, r44, $r11, $r10) 
(define-const var1183 var2563 (exporterMap/1326816129 (cast-from-var2540-to-var2914 var1990))) ; Statement: $r12 = r7.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol: java.util.Map exporterMap> 
(define-const var1223 var2646 (var2563_get/1088891777 var1183 (cast-from-String-to-var2646 var1425))) ; Statement: $r13 = interfaceinvoke $r12.<java.util.Map: java.lang.Object get(java.lang.Object)>($r42) 
(define-const var987 var1840 (cast-from-var2646-to-var1840 var1223)) ; Statement: $r43 = (org.apache.dubbo.rpc.protocol.dubbo.DubboExporter) $r13 
 ; Statement: if $r43 != null goto r14 = virtualinvoke $r43.<org.apache.dubbo.rpc.protocol.dubbo.DubboExporter: org.apache.dubbo.rpc.Invoker getInvoker()>() 
(assert (not (not (= var987 null-var1840)))) ; Negate: Cond: $r43 != null  
(define-const var374 var893 var893-init) ; Statement: $r17 = new org.apache.dubbo.remoting.RemotingException 
(define-const var2384 String String-init) ; Statement: $r18 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2384)) ; Statement: specialinvoke $r18.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2384!1 String)
(assert (= var2384!1 ""))
(assert true)
(define-const var3767 String (append/672562846 var2384!1 "Not found exported service: ")) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Not found exported service: ") 
(declare-const var2384!2 String)
(assert (= var2384!2 (str.++ var2384!1 "Not found exported service: ")))
(assert true)
(define-const var1832 String (append/672562846 var3767 var1425)) ; Statement: $r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r42) 
(declare-const var3767!1 String)
(assert (= var3767!1 (str.++ var3767 var1425)))
(assert true)
(define-const var2063 String (append/672562846 var1832 " in ")) ; Statement: $r23 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" in ") 
(declare-const var1832!1 String)
(assert (= var1832!1 (str.++ var1832 " in ")))
(define-const var3193 var2563 (exporterMap/1326816129 (cast-from-var2540-to-var2914 var1990))) ; Statement: $r21 = r7.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol: java.util.Map exporterMap> 
(define-const var1323 var2553 (var2563_keySet/-712633290 var3193)) ; Statement: $r22 = interfaceinvoke $r21.<java.util.Map: java.util.Set keySet()>() 
(assert true)
(define-const var377 String (append/-1031950772 var2063 (cast-from-var2553-to-var2646 var1323))) ; Statement: $r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r22) 
(declare-const var2063!1 String)
(assert (str.prefixof var2063 var2063!1))
(assert true)
(define-const var3976 String (append/672562846 var377 ", may be version or group mismatch , channel: consumer: ")) ; Statement: $r26 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", may be version or group mismatch , channel: consumer: ") 
(declare-const var377!1 String)
(assert (= var377!1 (str.++ var377 ", may be version or group mismatch , channel: consumer: ")))
(define-const var2515 var543 (var1774_getRemoteAddress/1597111645 var3748)) ; Statement: $r25 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>() 
(assert true)
(define-const var3155 String (append/-1031950772 var3976 (cast-from-var543-to-var2646 var2515))) ; Statement: $r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r25) 
(declare-const var3976!1 String)
(assert (str.prefixof var3976 var3976!1))
(assert true)
(define-const var3452 String (append/672562846 var3155 " --> provider: ")) ; Statement: $r29 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" --> provider: ") 
(declare-const var3155!1 String)
(assert (= var3155!1 (str.++ var3155 " --> provider: ")))
(define-const var1197 var543 (var2041_getLocalAddress/2019899378 (cast-from-var1774-to-var2041 var3748))) ; Statement: $r28 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getLocalAddress()>() 
(assert true)
(define-const var3544 String (append/-1031950772 var3452 (cast-from-var543-to-var2646 var1197))) ; Statement: $r30 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r28) 
(declare-const var3452!1 String)
(assert (str.prefixof var3452 var3452!1))
(assert true)
(define-const var472 String (append/672562846 var3544 ", message:")) ; Statement: $r32 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", message:") 
(declare-const var3544!1 String)
(assert (= var3544!1 (str.++ var3544 ", message:")))
(assert true)
(define-const var932 var2416 (getInvocationWithoutData/1955400546 var1990 var3641)) ; Statement: $r31 = specialinvoke r7.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol: org.apache.dubbo.rpc.Invocation getInvocationWithoutData(org.apache.dubbo.rpc.Invocation)>(r2) 
(assert true)
(define-const var1563 String (append/-1031950772 var472 (cast-from-var2416-to-var2646 var932))) ; Statement: $r33 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r31) 
(declare-const var472!1 String)
(assert (str.prefixof var472 var472!1))
(assert true)
(define-const var2982 String (toString/-2075883882 var1563)) ; Statement: $r34 = virtualinvoke $r33.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-2142452957 var374 var3748 var2982)) ; Statement: specialinvoke $r17.<org.apache.dubbo.remoting.RemotingException: void <init>(org.apache.dubbo.remoting.Channel,java.lang.String)>(r0, $r34) 

(declare-const var374!1 var893)
(declare-const var3748!1 var1774)
(declare-const var2982!1 String)
 ; Statement: throw $r17 
(check-sat)
; {var2041_getLocalAddress/2019899378=([org.apache.dubbo.remoting.Endpoint], java.net.InetSocketAddress), cast-from-var1774-to-var2041=([org.apache.dubbo.remoting.Channel], org.apache.dubbo.remoting.Endpoint), getPort/-1397617271=([java.net.InetSocketAddress], int), var2416_getObjectAttachmentWithoutConvert/-2125165309=([org.apache.dubbo.rpc.Invocation, java.lang.String], java.lang.Object), cast-from-var2646-to-String=([java.lang.Object], java.lang.String), toString/1090915316=([java.lang.Boolean], java.lang.String), isClientSide/776072184=([org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol, org.apache.dubbo.remoting.Channel], boolean), var2914_serviceKey/-263494211=([int, java.lang.String, java.lang.String, java.lang.String], java.lang.String), exporterMap/1326816129=([org.apache.dubbo.rpc.protocol.AbstractProtocol], java.util.Map), cast-from-var2540-to-var2914=([org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol], org.apache.dubbo.rpc.protocol.AbstractProtocol), var2563_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var2646=([java.lang.String], java.lang.Object), cast-from-var2646-to-var1840=([java.lang.Object], org.apache.dubbo.rpc.protocol.dubbo.DubboExporter), var893-init=([], org.apache.dubbo.remoting.RemotingException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var2563_keySet/-712633290=([java.util.Map], java.util.Set), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2553-to-var2646=([java.util.Set], java.lang.Object), var1774_getRemoteAddress/1597111645=([org.apache.dubbo.remoting.Channel], java.net.InetSocketAddress), cast-from-var543-to-var2646=([java.net.InetSocketAddress], java.lang.Object), getInvocationWithoutData/1955400546=([org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol, org.apache.dubbo.rpc.Invocation], org.apache.dubbo.rpc.Invocation), cast-from-var2416-to-var2646=([org.apache.dubbo.rpc.Invocation], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-2142452957=([org.apache.dubbo.remoting.RemotingException, org.apache.dubbo.remoting.Channel, java.lang.String], void)}
; {var2540=org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol, var1990=r7, var1774=org.apache.dubbo.remoting.Channel, var3748=r0, var2416=org.apache.dubbo.rpc.Invocation, var3641=r2, var543=java.net.InetSocketAddress, var2041=org.apache.dubbo.remoting.Endpoint, var2155=$r1, var3044=i0, var2646=java.lang.Object, var1337=$r3, var851=r44, var3246=java.lang.Boolean, var2388=$r4, var3203=$r6, var684=$r5, var17=z0, var81=$z1, var3384=$z2, var882=$r8, var2321=$r11, var3253=$r9, var457=$r10, var2914=org.apache.dubbo.rpc.protocol.AbstractProtocol, var1425=$r42, var2563=java.util.Map, var1183=$r12, var1223=$r13, var1840=org.apache.dubbo.rpc.protocol.dubbo.DubboExporter, var987=$r43, var893=org.apache.dubbo.remoting.RemotingException, var374=$r17, var2384=$r18, var3767=$r19, var1832=$r20, var2063=$r23, var3193=$r21, var2553=java.util.Set, var1323=$r22, var377=$r24, var3976=$r26, var2515=$r25, var3155=$r27, var3452=$r29, var1197=$r28, var3544=$r30, var472=$r32, var932=$r31, var1563=$r33, var2982=$r34}
; {org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol=var2540, r7=var1990, org.apache.dubbo.remoting.Channel=var1774, r0=var3748, org.apache.dubbo.rpc.Invocation=var2416, r2=var3641, java.net.InetSocketAddress=var543, org.apache.dubbo.remoting.Endpoint=var2041, $r1=var2155, i0=var3044, java.lang.Object=var2646, $r3=var1337, r44=var851, java.lang.Boolean=var3246, $r4=var2388, $r6=var3203, $r5=var684, z0=var17, $z1=var81, $z2=var3384, $r8=var882, $r11=var2321, $r9=var3253, $r10=var457, org.apache.dubbo.rpc.protocol.AbstractProtocol=var2914, $r42=var1425, java.util.Map=var2563, $r12=var1183, $r13=var1223, org.apache.dubbo.rpc.protocol.dubbo.DubboExporter=var1840, $r43=var987, org.apache.dubbo.remoting.RemotingException=var893, $r17=var374, $r18=var2384, $r19=var3767, $r20=var1832, $r23=var2063, $r21=var3193, java.util.Set=var2553, $r22=var1323, $r24=var377, $r26=var3976, $r25=var2515, $r27=var3155, $r29=var3452, $r28=var1197, $r30=var3544, $r32=var472, $r31=var932, $r33=var1563, $r34=var2982}
;seq <java.lang.Boolean: java.lang.String toString()>;	<java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 6,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r7 := @this: org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol;	r0 := @parameter0: org.apache.dubbo.remoting.Channel;	r2 := @parameter1: org.apache.dubbo.rpc.Invocation;	$r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getLocalAddress()>();	i0 = virtualinvoke $r1.<java.net.InetSocketAddress: int getPort()>();	$r3 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("path");	r44 = (java.lang.String) $r3;	$r4 = <java.lang.Boolean: java.lang.Boolean TRUE>;	$r6 = virtualinvoke $r4.<java.lang.Boolean: java.lang.String toString()>();	$r5 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("dubbo.stub.event");	z0 = virtualinvoke $r6.<java.lang.String: boolean equals(java.lang.Object)>($r5);	if z0 == 0 goto $z1 = specialinvoke r7.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol: boolean isClientSide(org.apache.dubbo.remoting.Channel)>(r0);	$z1 = specialinvoke r7.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol: boolean isClientSide(org.apache.dubbo.remoting.Channel)>(r0);	if $z1 == 0 goto $z2 = 0;	$z2 = 0;	if $z2 == 0 goto $r8 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("version");	$r8 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("version");	$r11 = (java.lang.String) $r8;	$r9 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("group");	$r10 = (java.lang.String) $r9;	$r42 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol: java.lang.String serviceKey(int,java.lang.String,java.lang.String,java.lang.String)>(i0, r44, $r11, $r10);	$r12 = r7.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol: java.util.Map exporterMap>;	$r13 = interfaceinvoke $r12.<java.util.Map: java.lang.Object get(java.lang.Object)>($r42);	$r43 = (org.apache.dubbo.rpc.protocol.dubbo.DubboExporter) $r13;	if $r43 != null goto r14 = virtualinvoke $r43.<org.apache.dubbo.rpc.protocol.dubbo.DubboExporter: org.apache.dubbo.rpc.Invoker getInvoker()>();	$r17 = new org.apache.dubbo.remoting.RemotingException;	$r18 = new java.lang.StringBuilder;	specialinvoke $r18.<java.lang.StringBuilder: void <init>()>();	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Not found exported service: ");	$r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r42);	$r23 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" in ");	$r21 = r7.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol: java.util.Map exporterMap>;	$r22 = interfaceinvoke $r21.<java.util.Map: java.util.Set keySet()>();	$r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r22);	$r26 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", may be version or group mismatch , channel: consumer: ");	$r25 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>();	$r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r25);	$r29 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" --> provider: ");	$r28 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getLocalAddress()>();	$r30 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r28);	$r32 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", message:");	$r31 = specialinvoke r7.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol: org.apache.dubbo.rpc.Invocation getInvocationWithoutData(org.apache.dubbo.rpc.Invocation)>(r2);	$r33 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r31);	$r34 = virtualinvoke $r33.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r17.<org.apache.dubbo.remoting.RemotingException: void <init>(org.apache.dubbo.remoting.Channel,java.lang.String)>(r0, $r34);	throw $r17
;block_num 6