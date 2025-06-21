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

(declare-sort var3439 0)
(declare-sort var3772 0)
(declare-sort var1340 0)
(declare-sort var2059 0)
(declare-sort var2275 0)
(declare-sort var3008 0)
(declare-sort var2404 0)
(declare-sort var2252 0)
(declare-sort var1646 0)
(declare-sort var242 0)
(declare-sort var3799 0)
(declare-sort var1992 0)
(declare-sort var321 0)
(declare-sort var1581 0)
(declare-sort var931 0)
(declare-sort var3218 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2404_identityHashCode/1096208673 (var2275) Int)
(declare-fun var2252-init () var2252)
(declare-fun <init>/613807010 (var2252 Int) void)
(declare-fun toString/1090915316 (var3008) String)
(declare-fun var1646_put/1464166817 (var1646 var2275 var2275) var2275)
(declare-fun cast-from-var2252-to-var1646 (var2252) var1646)
(declare-fun cast-from-String-to-var2275 (String) var2275)
(declare-fun var3799_getDeclaredMethodNames/-1512898996 (ClassObject) (Array Int String))
(declare-fun var1992_join/-2132544052 ((Array Int String) String) String)
(declare-fun <init>/-201242697 (var2252) void)
(declare-fun var1646_putAll/1656389889 (var1646 var1646) void)
(declare-fun var1646_remove/-1201052315 (var1646 var2275) var2275)
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun var321-init () var321)
(declare-fun var931_getLocalAddress/2019899378 (var931) var1581)
(declare-fun cast-from-var3772-to-var931 (var3772) var931)
(declare-fun getAddress/1707481140 (var1581) var3218)
(declare-fun getHostAddress/1493983505 (var3218) String)
(declare-fun getPort/-1397617271 (var1581) Int)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1145568936 (var321 String String Int String var1646) void)
(declare-fun var3439_getClientSideCallbackServiceCacheKey/1447029485 (Int) String)
(declare-fun var3439_getClientSideCountKey/299746518 (String) String)
(declare-fun booleanValue/-1820462562 (var3008) Bool)
(declare-fun var3772_hasAttribute/-735023424 (var3772 String) Bool)
(declare-fun String_valueOf/1240665136 (Int) String)
(declare-const null-var3439 var3439)
(declare-const null-var3772 var3772)
(declare-const null-var1340 var1340)
(declare-const null-var2059 var2059)
(declare-const null-ClassObject ClassObject)
(declare-const null-var2275 var2275)
(declare-const null-var3008 var3008)
(declare-const var3008-FALSE var3008)
(declare-const var3008-TRUE var3008)
(declare-const null-String String)
(declare-const var700 var3439) ; Statement: r32 := @this: org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec 
(assert (not (= var700 null-var3439)))
(declare-const var381 var3772) ; Statement: r11 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var381 null-var3772)))
(declare-const var3372 var1340) ; Statement: r6 := @parameter1: org.apache.dubbo.rpc.RpcInvocation 
(assert (not (= var3372 null-var1340)))
(declare-const var2734 var2059) ; Statement: r10 := @parameter2: org.apache.dubbo.common.URL 
(assert (not (= var2734 null-var2059)))
(declare-const var2421 ClassObject) ; Statement: r9 := @parameter3: java.lang.Class 
(assert (not (= var2421 null-ClassObject)))
(declare-const var1466 var2275) ; Statement: r0 := @parameter4: java.lang.Object 
(assert (not (= var1466 null-var2275)))
(declare-const var2974 var3008) ; Statement: r12 := @parameter5: java.lang.Boolean 
(assert (not (= var2974 null-var3008)))
(define-const var2023 Int (var2404_identityHashCode/1096208673 var1466)) ; Statement: i0 = staticinvoke <java.lang.System: int identityHashCode(java.lang.Object)>(r0) 
(define-const var89 var2252 var2252-init) ; Statement: $r1 = new java.util.HashMap 
(assert true)
;(assert (<init>/613807010 var89 3)) ; Statement: specialinvoke $r1.<java.util.HashMap: void <init>(int)>(3) 

(declare-const var89!1 var2252)
(declare-const var1521 Int)
(define-const var3401 var3008 var3008-FALSE) ; Statement: $r2 = <java.lang.Boolean: java.lang.Boolean FALSE> 
(assert true)
(define-const var797 String (toString/1090915316 var3401)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.Boolean: java.lang.String toString()>() 
;(assert (var1646_put/1464166817 (cast-from-var2252-to-var1646 var89!1) (cast-from-String-to-var2275 "isserver") (cast-from-String-to-var2275 var797))) ; Statement: interfaceinvoke $r1.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("isserver", $r3) 

(declare-const var89!2 var2252)
(declare-const var2041 String)
(declare-const var797!1 String)
(define-const var2234 var3008 var3008-TRUE) ; Statement: $r4 = <java.lang.Boolean: java.lang.Boolean TRUE> 
(assert true)
(define-const var200 String (toString/1090915316 var2234)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.Boolean: java.lang.String toString()>() 
;(assert (var1646_put/1464166817 (cast-from-var2252-to-var1646 var89!2) (cast-from-String-to-var2275 "is_callback_service") (cast-from-String-to-var2275 var200))) ; Statement: interfaceinvoke $r1.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("is_callback_service", $r5) 

(declare-const var89!3 var2252)
(declare-const var2684 String)
(declare-const var200!1 String)
 ; Statement: if r6 != null goto $r7 = virtualinvoke r6.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("group") 
(assert (not (not (= var3372 null-var1340)))) ; Negate: Cond: r6 != null  
(define-const var300 String null-String) ; Statement: $r56 = null 
 ; Statement: goto [?= r8 = $r56] 
(assert true) ; Non Conditional
(define-const var136 String var300) ; Statement: r8 = $r56 
 ; Statement: if $r56 == null goto $r57 = staticinvoke <org.apache.dubbo.common.utils.ClassUtils: java.lang.String[] getDeclaredMethodNames(java.lang.Class)>(r9) 
(assert (= var300 null-String)) ; Cond: $r56 == null 
(define-const var925 (Array Int String) (var3799_getDeclaredMethodNames/-1512898996 var2421)) ; Statement: $r57 = staticinvoke <org.apache.dubbo.common.utils.ClassUtils: java.lang.String[] getDeclaredMethodNames(java.lang.Class)>(r9) 
(define-const var2167 String (var1992_join/-2132544052 var925 ",")) ; Statement: $r58 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String join(java.lang.String[],java.lang.String)>($r57, ",") 
;(assert (var1646_put/1464166817 (cast-from-var2252-to-var1646 var89!3) (cast-from-String-to-var2275 "methods") (cast-from-String-to-var2275 var2167))) ; Statement: interfaceinvoke $r1.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("methods", $r58) 

(declare-const var89!4 var2252)
(declare-const var1892 String)
(declare-const var2167!1 String)
(define-const var1546 var2252 var2252-init) ; Statement: $r59 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var1546)) ; Statement: specialinvoke $r59.<java.util.HashMap: void <init>()>() 

(declare-const var1546!1 var2252)
 ; Statement: if r10 == null goto interfaceinvoke $r59.<java.util.Map: void putAll(java.util.Map)>($r1) 
(assert (= var2734 null-var2059)) ; Cond: r10 == null 
;(assert (var1646_putAll/1656389889 (cast-from-var2252-to-var1646 var1546!1) (cast-from-var2252-to-var1646 var89!4))) ; Statement: interfaceinvoke $r59.<java.util.Map: void putAll(java.util.Map)>($r1) 

(declare-const var1546!2 var2252)
(declare-const var89!5 var2252)
;(assert (var1646_remove/-1201052315 (cast-from-var2252-to-var1646 var1546!2) (cast-from-String-to-var2275 "version"))) ; Statement: interfaceinvoke $r59.<java.util.Map: java.lang.Object remove(java.lang.Object)>("version") 

(declare-const var1546!3 var2252)
(declare-const var853 String)
;(assert (var1646_remove/-1201052315 (cast-from-var2252-to-var1646 var1546!3) (cast-from-String-to-var2275 "bind.port"))) ; Statement: interfaceinvoke $r59.<java.util.Map: java.lang.Object remove(java.lang.Object)>("bind.port") 

(declare-const var1546!4 var2252)
(declare-const var1242 String)
(assert true)
(define-const var459 String (getName/-1958580599 var2421)) ; Statement: $r61 = virtualinvoke r9.<java.lang.Class: java.lang.String getName()>() 
;(assert (var1646_put/1464166817 (cast-from-var2252-to-var1646 var1546!4) (cast-from-String-to-var2275 "interface") (cast-from-String-to-var2275 var459))) ; Statement: interfaceinvoke $r59.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("interface", $r61) 

(declare-const var1546!5 var2252)
(declare-const var817 String)
(declare-const var459!1 String)
(define-const var3892 var321 var321-init) ; Statement: $r62 = new org.apache.dubbo.common.url.component.ServiceConfigURL 
(define-const var3374 var1581 (var931_getLocalAddress/2019899378 (cast-from-var3772-to-var931 var381))) ; Statement: $r63 = interfaceinvoke r11.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getLocalAddress()>() 
(assert true)
(define-const var2881 var3218 (getAddress/1707481140 var3374)) ; Statement: $r64 = virtualinvoke $r63.<java.net.InetSocketAddress: java.net.InetAddress getAddress()>() 
(assert true)
(define-const var1794 String (getHostAddress/1493983505 var2881)) ; Statement: $r65 = virtualinvoke $r64.<java.net.InetAddress: java.lang.String getHostAddress()>() 
(define-const var3441 var1581 (var931_getLocalAddress/2019899378 (cast-from-var3772-to-var931 var381))) ; Statement: $r66 = interfaceinvoke r11.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getLocalAddress()>() 
(assert true)
(define-const var1145 Int (getPort/-1397617271 var3441)) ; Statement: $i2 = virtualinvoke $r66.<java.net.InetSocketAddress: int getPort()>() 
(define-const var1920 String String-init) ; Statement: $r67 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1920)) ; Statement: specialinvoke $r67.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1920!1 String)
(assert (= var1920!1 ""))
(assert true)
(define-const var2055 String (getName/-1958580599 var2421)) ; Statement: $r68 = virtualinvoke r9.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var2706 String (append/672562846 var1920!1 var2055)) ; Statement: $r69 = virtualinvoke $r67.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r68) 
(declare-const var1920!2 String)
(assert (= var1920!2 (str.++ var1920!1 var2055)))
(assert true)
(define-const var1802 String (append/672562846 var2706 ".")) ; Statement: $r70 = virtualinvoke $r69.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".") 
(declare-const var2706!1 String)
(assert (= var2706!1 (str.++ var2706 ".")))
(assert true)
(define-const var3858 String (append/-1001720160 var1802 var2023)) ; Statement: $r71 = virtualinvoke $r70.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var1802!1 String)
(assert (str.prefixof var1802 var1802!1))
(assert true)
(define-const var1196 String (toString/-2075883882 var3858)) ; Statement: $r72 = virtualinvoke $r71.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1145568936 var3892 "dubbo" var1794 var1145 var1196 (cast-from-var2252-to-var1646 var1546!5))) ; Statement: specialinvoke $r62.<org.apache.dubbo.common.url.component.ServiceConfigURL: void <init>(java.lang.String,java.lang.String,int,java.lang.String,java.util.Map)>("dubbo", $r65, $i2, $r72, $r59) 

(declare-const var3892!1 var321)
(declare-const var1861 String)
(declare-const var1794!1 String)
(declare-const var1145!1 Int)
(declare-const var1196!1 String)
(declare-const var1546!6 var2252)
(define-const var2504 String (var3439_getClientSideCallbackServiceCacheKey/1447029485 var2023)) ; Statement: $r73 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec: java.lang.String getClientSideCallbackServiceCacheKey(int)>(i0) 
(assert true)
(define-const var3688 String (getName/-1958580599 var2421)) ; Statement: $r74 = virtualinvoke r9.<java.lang.Class: java.lang.String getName()>() 
(define-const var3597 String (var3439_getClientSideCountKey/299746518 var3688)) ; Statement: $r75 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec: java.lang.String getClientSideCountKey(java.lang.String)>($r74) 
(assert true)
(define-const var3389 Bool (booleanValue/-1820462562 var2974)) ; Statement: $z4 = virtualinvoke r12.<java.lang.Boolean: boolean booleanValue()>() 
 ; Statement: if $z4 == 0 goto $z0 = interfaceinvoke r11.<org.apache.dubbo.remoting.Channel: boolean hasAttribute(java.lang.String)>($r73) 
(assert (not (= (ite var3389 1 0) 0))) ; Negate: Cond: $z4 == 0  
(define-const var457 Bool (var3772_hasAttribute/-735023424 var381 var2504)) ; Statement: $z1 = interfaceinvoke r11.<org.apache.dubbo.remoting.Channel: boolean hasAttribute(java.lang.String)>($r73) 
 ; Statement: if $z1 != 0 goto $r78 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i0) 
(assert (not (= (ite var457 1 0) 0))) ; Cond: $z1 != 0 
(define-const var3944 String (String_valueOf/1240665136 var2023)) ; Statement: $r78 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i0) 
 ; Statement: return $r78 
(check-sat)
; {var2404_identityHashCode/1096208673=([java.lang.Object], int), var2252-init=([], java.util.HashMap), <init>/613807010=([java.util.HashMap, int], void), toString/1090915316=([java.lang.Boolean], java.lang.String), var1646_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-var2252-to-var1646=([java.util.HashMap], java.util.Map), cast-from-String-to-var2275=([java.lang.String], java.lang.Object), var3799_getDeclaredMethodNames/-1512898996=([java.lang.Class], java.lang.String[]), var1992_join/-2132544052=([java.lang.String[], java.lang.String], java.lang.String), <init>/-201242697=([java.util.HashMap], void), var1646_putAll/1656389889=([java.util.Map, java.util.Map], void), var1646_remove/-1201052315=([java.util.Map, java.lang.Object], java.lang.Object), getName/-1958580599=([java.lang.Class], java.lang.String), var321-init=([], org.apache.dubbo.common.url.component.ServiceConfigURL), var931_getLocalAddress/2019899378=([org.apache.dubbo.remoting.Endpoint], java.net.InetSocketAddress), cast-from-var3772-to-var931=([org.apache.dubbo.remoting.Channel], org.apache.dubbo.remoting.Endpoint), getAddress/1707481140=([java.net.InetSocketAddress], java.net.InetAddress), getHostAddress/1493983505=([java.net.InetAddress], java.lang.String), getPort/-1397617271=([java.net.InetSocketAddress], int), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1145568936=([org.apache.dubbo.common.url.component.ServiceConfigURL, java.lang.String, java.lang.String, int, java.lang.String, java.util.Map], void), var3439_getClientSideCallbackServiceCacheKey/1447029485=([int], java.lang.String), var3439_getClientSideCountKey/299746518=([java.lang.String], java.lang.String), booleanValue/-1820462562=([java.lang.Boolean], boolean), var3772_hasAttribute/-735023424=([org.apache.dubbo.remoting.Channel, java.lang.String], boolean), String_valueOf/1240665136=([int], java.lang.String)}
; {var3439=org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec, var700=r32, var3772=org.apache.dubbo.remoting.Channel, var381=r11, var1340=org.apache.dubbo.rpc.RpcInvocation, var3372=r6, var2059=org.apache.dubbo.common.URL, var2734=r10, var2421=r9, var2275=java.lang.Object, var1466=r0, var3008=java.lang.Boolean, var2974=r12, var2404=java.lang.System, var2023=i0, var2252=java.util.HashMap, var89=$r1, var1521=3, var3401=$r2, var797=$r3, var1646=java.util.Map, var2041="isserver", var2234=$r4, var200=$r5, var2684="is_callback_service", var242=null_type, var300=$r56, var136=r8, var3799=org.apache.dubbo.common.utils.ClassUtils, var925=$r57, var1992=org.apache.dubbo.common.utils.StringUtils, var2167=$r58, var1892="methods", var1546=$r59, var853="version", var1242="bind.port", var459=$r61, var817="interface", var321=org.apache.dubbo.common.url.component.ServiceConfigURL, var3892=$r62, var1581=java.net.InetSocketAddress, var931=org.apache.dubbo.remoting.Endpoint, var3374=$r63, var3218=java.net.InetAddress, var2881=$r64, var1794=$r65, var3441=$r66, var1145=$i2, var1920=$r67, var2055=$r68, var2706=$r69, var1802=$r70, var3858=$r71, var1196=$r72, var1861="dubbo", var2504=$r73, var3688=$r74, var3597=$r75, var3389=$z4, var457=$z1, var3944=$r78}
; {org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec=var3439, r32=var700, org.apache.dubbo.remoting.Channel=var3772, r11=var381, org.apache.dubbo.rpc.RpcInvocation=var1340, r6=var3372, org.apache.dubbo.common.URL=var2059, r10=var2734, r9=var2421, java.lang.Object=var2275, r0=var1466, java.lang.Boolean=var3008, r12=var2974, java.lang.System=var2404, i0=var2023, java.util.HashMap=var2252, $r1=var89, 3=var1521, $r2=var3401, $r3=var797, java.util.Map=var1646, "isserver"=var2041, $r4=var2234, $r5=var200, "is_callback_service"=var2684, null_type=var242, $r56=var300, r8=var136, org.apache.dubbo.common.utils.ClassUtils=var3799, $r57=var925, org.apache.dubbo.common.utils.StringUtils=var1992, $r58=var2167, "methods"=var1892, $r59=var1546, "version"=var853, "bind.port"=var1242, $r61=var459, "interface"=var817, org.apache.dubbo.common.url.component.ServiceConfigURL=var321, $r62=var3892, java.net.InetSocketAddress=var1581, org.apache.dubbo.remoting.Endpoint=var931, $r63=var3374, java.net.InetAddress=var3218, $r64=var2881, $r65=var1794, $r66=var3441, $i2=var1145, $r67=var1920, $r68=var2055, $r69=var2706, $r70=var1802, $r71=var3858, $r72=var1196, "dubbo"=var1861, $r73=var2504, $r74=var3688, $r75=var3597, $z4=var3389, $z1=var457, $r78=var3944}
;seq <java.lang.Boolean: java.lang.String toString()>;	<java.lang.Boolean: java.lang.String toString()>;	<org.apache.dubbo.common.utils.StringUtils: java.lang.String join(java.lang.String[],java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.String: java.lang.String valueOf(int)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.lang.String join(java.lang.String[],java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1,"<java.lang.String: java.lang.String valueOf(int)>": 1}
;stmts r32 := @this: org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec;	r11 := @parameter0: org.apache.dubbo.remoting.Channel;	r6 := @parameter1: org.apache.dubbo.rpc.RpcInvocation;	r10 := @parameter2: org.apache.dubbo.common.URL;	r9 := @parameter3: java.lang.Class;	r0 := @parameter4: java.lang.Object;	r12 := @parameter5: java.lang.Boolean;	i0 = staticinvoke <java.lang.System: int identityHashCode(java.lang.Object)>(r0);	$r1 = new java.util.HashMap;	specialinvoke $r1.<java.util.HashMap: void <init>(int)>(3);	$r2 = <java.lang.Boolean: java.lang.Boolean FALSE>;	$r3 = virtualinvoke $r2.<java.lang.Boolean: java.lang.String toString()>();	interfaceinvoke $r1.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("isserver", $r3);	$r4 = <java.lang.Boolean: java.lang.Boolean TRUE>;	$r5 = virtualinvoke $r4.<java.lang.Boolean: java.lang.String toString()>();	interfaceinvoke $r1.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("is_callback_service", $r5);	if r6 != null goto $r7 = virtualinvoke r6.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("group");	$r56 = null;	goto [?= r8 = $r56];	r8 = $r56;	if $r56 == null goto $r57 = staticinvoke <org.apache.dubbo.common.utils.ClassUtils: java.lang.String[] getDeclaredMethodNames(java.lang.Class)>(r9);	$r57 = staticinvoke <org.apache.dubbo.common.utils.ClassUtils: java.lang.String[] getDeclaredMethodNames(java.lang.Class)>(r9);	$r58 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String join(java.lang.String[],java.lang.String)>($r57, ",");	interfaceinvoke $r1.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("methods", $r58);	$r59 = new java.util.HashMap;	specialinvoke $r59.<java.util.HashMap: void <init>()>();	if r10 == null goto interfaceinvoke $r59.<java.util.Map: void putAll(java.util.Map)>($r1);	interfaceinvoke $r59.<java.util.Map: void putAll(java.util.Map)>($r1);	interfaceinvoke $r59.<java.util.Map: java.lang.Object remove(java.lang.Object)>("version");	interfaceinvoke $r59.<java.util.Map: java.lang.Object remove(java.lang.Object)>("bind.port");	$r61 = virtualinvoke r9.<java.lang.Class: java.lang.String getName()>();	interfaceinvoke $r59.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("interface", $r61);	$r62 = new org.apache.dubbo.common.url.component.ServiceConfigURL;	$r63 = interfaceinvoke r11.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getLocalAddress()>();	$r64 = virtualinvoke $r63.<java.net.InetSocketAddress: java.net.InetAddress getAddress()>();	$r65 = virtualinvoke $r64.<java.net.InetAddress: java.lang.String getHostAddress()>();	$r66 = interfaceinvoke r11.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getLocalAddress()>();	$i2 = virtualinvoke $r66.<java.net.InetSocketAddress: int getPort()>();	$r67 = new java.lang.StringBuilder;	specialinvoke $r67.<java.lang.StringBuilder: void <init>()>();	$r68 = virtualinvoke r9.<java.lang.Class: java.lang.String getName()>();	$r69 = virtualinvoke $r67.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r68);	$r70 = virtualinvoke $r69.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".");	$r71 = virtualinvoke $r70.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r72 = virtualinvoke $r71.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r62.<org.apache.dubbo.common.url.component.ServiceConfigURL: void <init>(java.lang.String,java.lang.String,int,java.lang.String,java.util.Map)>("dubbo", $r65, $i2, $r72, $r59);	$r73 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec: java.lang.String getClientSideCallbackServiceCacheKey(int)>(i0);	$r74 = virtualinvoke r9.<java.lang.Class: java.lang.String getName()>();	$r75 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec: java.lang.String getClientSideCountKey(java.lang.String)>($r74);	$z4 = virtualinvoke r12.<java.lang.Boolean: boolean booleanValue()>();	if $z4 == 0 goto $z0 = interfaceinvoke r11.<org.apache.dubbo.remoting.Channel: boolean hasAttribute(java.lang.String)>($r73);	$z1 = interfaceinvoke r11.<org.apache.dubbo.remoting.Channel: boolean hasAttribute(java.lang.String)>($r73);	if $z1 != 0 goto $r78 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i0);	$r78 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i0);	return $r78
;block_num 7