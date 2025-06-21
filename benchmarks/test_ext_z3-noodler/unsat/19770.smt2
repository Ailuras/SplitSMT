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

(declare-sort var2789 0)
(declare-sort var1355 0)
(declare-sort var2345 0)
(declare-sort var3232 0)
(declare-sort var814 0)
(declare-sort var2803 0)
(declare-sort var1002 0)
(declare-sort var3657 0)
(declare-sort var3437 0)
(declare-sort var2695 0)
(declare-sort var3052 0)
(declare-sort var2261 0)
(declare-sort var2960 0)
(declare-sort var425 0)
(declare-sort var547 0)
(declare-sort var1815 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1002_identityHashCode/1096208673 (var814) Int)
(declare-fun var3657-init () var3657)
(declare-fun <init>/613807010 (var3657 Int) void)
(declare-fun toString/1090915316 (var2803) String)
(declare-fun var3437_put/1464166817 (var3437 var814 var814) var814)
(declare-fun cast-from-var3657-to-var3437 (var3657) var3437)
(declare-fun cast-from-String-to-var814 (String) var814)
(declare-fun getObjectAttachmentWithoutConvert/491812452 (var2345 String) var814)
(declare-fun cast-from-var814-to-String (var814) String)
(declare-fun var3052_getDeclaredMethodNames/-1512898996 (ClassObject) (Array Int String))
(declare-fun var2261_join/-2132544052 ((Array Int String) String) String)
(declare-fun <init>/-201242697 (var3657) void)
(declare-fun var3437_putAll/1656389889 (var3437 var3437) void)
(declare-fun var3437_remove/-1201052315 (var3437 var814) var814)
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun var2960-init () var2960)
(declare-fun var547_getLocalAddress/2019899378 (var547) var425)
(declare-fun cast-from-var1355-to-var547 (var1355) var547)
(declare-fun getAddress/1707481140 (var425) var1815)
(declare-fun getHostAddress/1493983505 (var1815) String)
(declare-fun getPort/-1397617271 (var425) Int)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1145568936 (var2960 String String Int String var3437) void)
(declare-fun var2789_getClientSideCallbackServiceCacheKey/1447029485 (Int) String)
(declare-fun var2789_getClientSideCountKey/299746518 (String) String)
(declare-fun booleanValue/-1820462562 (var2803) Bool)
(declare-fun var1355_hasAttribute/-735023424 (var1355 String) Bool)
(declare-fun String_valueOf/1240665136 (Int) String)
(declare-const null-var2789 var2789)
(declare-const null-var1355 var1355)
(declare-const null-var2345 var2345)
(declare-const null-var3232 var3232)
(declare-const null-ClassObject ClassObject)
(declare-const null-var814 var814)
(declare-const null-var2803 var2803)
(declare-const var2803-FALSE var2803)
(declare-const var2803-TRUE var2803)
(declare-const null-String String)
(declare-const var379 var2789) ; Statement: r32 := @this: org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec 
(assert (not (= var379 null-var2789)))
(declare-const var2836 var1355) ; Statement: r11 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var2836 null-var1355)))
(declare-const var2660 var2345) ; Statement: r6 := @parameter1: org.apache.dubbo.rpc.RpcInvocation 
(assert (not (= var2660 null-var2345)))
(declare-const var129 var3232) ; Statement: r10 := @parameter2: org.apache.dubbo.common.URL 
(assert (not (= var129 null-var3232)))
(declare-const var3056 ClassObject) ; Statement: r9 := @parameter3: java.lang.Class 
(assert (not (= var3056 null-ClassObject)))
(declare-const var3221 var814) ; Statement: r0 := @parameter4: java.lang.Object 
(assert (not (= var3221 null-var814)))
(declare-const var1317 var2803) ; Statement: r12 := @parameter5: java.lang.Boolean 
(assert (not (= var1317 null-var2803)))
(define-const var2162 Int (var1002_identityHashCode/1096208673 var3221)) ; Statement: i0 = staticinvoke <java.lang.System: int identityHashCode(java.lang.Object)>(r0) 
(define-const var2168 var3657 var3657-init) ; Statement: $r1 = new java.util.HashMap 
(assert true)
;(assert (<init>/613807010 var2168 3)) ; Statement: specialinvoke $r1.<java.util.HashMap: void <init>(int)>(3) 

(declare-const var2168!1 var3657)
(declare-const var1390 Int)
(define-const var1168 var2803 var2803-FALSE) ; Statement: $r2 = <java.lang.Boolean: java.lang.Boolean FALSE> 
(assert true)
(define-const var3158 String (toString/1090915316 var1168)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.Boolean: java.lang.String toString()>() 
;(assert (var3437_put/1464166817 (cast-from-var3657-to-var3437 var2168!1) (cast-from-String-to-var814 "isserver") (cast-from-String-to-var814 var3158))) ; Statement: interfaceinvoke $r1.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("isserver", $r3) 

(declare-const var2168!2 var3657)
(declare-const var3310 String)
(declare-const var3158!1 String)
(define-const var952 var2803 var2803-TRUE) ; Statement: $r4 = <java.lang.Boolean: java.lang.Boolean TRUE> 
(assert true)
(define-const var920 String (toString/1090915316 var952)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.Boolean: java.lang.String toString()>() 
;(assert (var3437_put/1464166817 (cast-from-var3657-to-var3437 var2168!2) (cast-from-String-to-var814 "is_callback_service") (cast-from-String-to-var814 var920))) ; Statement: interfaceinvoke $r1.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("is_callback_service", $r5) 

(declare-const var2168!3 var3657)
(declare-const var354 String)
(declare-const var920!1 String)
 ; Statement: if r6 != null goto $r7 = virtualinvoke r6.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("group") 
(assert (not (= var2660 null-var2345))) ; Cond: r6 != null 
(assert true)
(define-const var2702 var814 (getObjectAttachmentWithoutConvert/491812452 var2660 "group")) ; Statement: $r7 = virtualinvoke r6.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("group") 
(define-const var3031 String (cast-from-var814-to-String var2702)) ; Statement: $r56 = (java.lang.String) $r7 
(assert true) ; Non Conditional
(define-const var745 String var3031) ; Statement: r8 = $r56 
 ; Statement: if $r56 == null goto $r57 = staticinvoke <org.apache.dubbo.common.utils.ClassUtils: java.lang.String[] getDeclaredMethodNames(java.lang.Class)>(r9) 
(assert (= var3031 null-String)) ; Cond: $r56 == null 
(define-const var1236 (Array Int String) (var3052_getDeclaredMethodNames/-1512898996 var3056)) ; Statement: $r57 = staticinvoke <org.apache.dubbo.common.utils.ClassUtils: java.lang.String[] getDeclaredMethodNames(java.lang.Class)>(r9) 
(define-const var7 String (var2261_join/-2132544052 var1236 ",")) ; Statement: $r58 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String join(java.lang.String[],java.lang.String)>($r57, ",") 
;(assert (var3437_put/1464166817 (cast-from-var3657-to-var3437 var2168!3) (cast-from-String-to-var814 "methods") (cast-from-String-to-var814 var7))) ; Statement: interfaceinvoke $r1.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("methods", $r58) 

(declare-const var2168!4 var3657)
(declare-const var3377 String)
(declare-const var7!1 String)
(define-const var302 var3657 var3657-init) ; Statement: $r59 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var302)) ; Statement: specialinvoke $r59.<java.util.HashMap: void <init>()>() 

(declare-const var302!1 var3657)
 ; Statement: if r10 == null goto interfaceinvoke $r59.<java.util.Map: void putAll(java.util.Map)>($r1) 
(assert (= var129 null-var3232)) ; Cond: r10 == null 
;(assert (var3437_putAll/1656389889 (cast-from-var3657-to-var3437 var302!1) (cast-from-var3657-to-var3437 var2168!4))) ; Statement: interfaceinvoke $r59.<java.util.Map: void putAll(java.util.Map)>($r1) 

(declare-const var302!2 var3657)
(declare-const var2168!5 var3657)
;(assert (var3437_remove/-1201052315 (cast-from-var3657-to-var3437 var302!2) (cast-from-String-to-var814 "version"))) ; Statement: interfaceinvoke $r59.<java.util.Map: java.lang.Object remove(java.lang.Object)>("version") 

(declare-const var302!3 var3657)
(declare-const var1898 String)
;(assert (var3437_remove/-1201052315 (cast-from-var3657-to-var3437 var302!3) (cast-from-String-to-var814 "bind.port"))) ; Statement: interfaceinvoke $r59.<java.util.Map: java.lang.Object remove(java.lang.Object)>("bind.port") 

(declare-const var302!4 var3657)
(declare-const var6 String)
(assert true)
(define-const var2453 String (getName/-1958580599 var3056)) ; Statement: $r61 = virtualinvoke r9.<java.lang.Class: java.lang.String getName()>() 
;(assert (var3437_put/1464166817 (cast-from-var3657-to-var3437 var302!4) (cast-from-String-to-var814 "interface") (cast-from-String-to-var814 var2453))) ; Statement: interfaceinvoke $r59.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("interface", $r61) 

(declare-const var302!5 var3657)
(declare-const var2333 String)
(declare-const var2453!1 String)
(define-const var2515 var2960 var2960-init) ; Statement: $r62 = new org.apache.dubbo.common.url.component.ServiceConfigURL 
(define-const var111 var425 (var547_getLocalAddress/2019899378 (cast-from-var1355-to-var547 var2836))) ; Statement: $r63 = interfaceinvoke r11.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getLocalAddress()>() 
(assert true)
(define-const var3405 var1815 (getAddress/1707481140 var111)) ; Statement: $r64 = virtualinvoke $r63.<java.net.InetSocketAddress: java.net.InetAddress getAddress()>() 
(assert true)
(define-const var2732 String (getHostAddress/1493983505 var3405)) ; Statement: $r65 = virtualinvoke $r64.<java.net.InetAddress: java.lang.String getHostAddress()>() 
(define-const var2256 var425 (var547_getLocalAddress/2019899378 (cast-from-var1355-to-var547 var2836))) ; Statement: $r66 = interfaceinvoke r11.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getLocalAddress()>() 
(assert true)
(define-const var1820 Int (getPort/-1397617271 var2256)) ; Statement: $i2 = virtualinvoke $r66.<java.net.InetSocketAddress: int getPort()>() 
(define-const var2978 String String-init) ; Statement: $r67 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2978)) ; Statement: specialinvoke $r67.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2978!1 String)
(assert (= var2978!1 ""))
(assert true)
(define-const var2628 String (getName/-1958580599 var3056)) ; Statement: $r68 = virtualinvoke r9.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var2013 String (append/672562846 var2978!1 var2628)) ; Statement: $r69 = virtualinvoke $r67.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r68) 
(declare-const var2978!2 String)
(assert (= var2978!2 (str.++ var2978!1 var2628)))
(assert true)
(define-const var2442 String (append/672562846 var2013 ".")) ; Statement: $r70 = virtualinvoke $r69.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".") 
(declare-const var2013!1 String)
(assert (= var2013!1 (str.++ var2013 ".")))
(assert true)
(define-const var3340 String (append/-1001720160 var2442 var2162)) ; Statement: $r71 = virtualinvoke $r70.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var2442!1 String)
(assert (str.prefixof var2442 var2442!1))
(assert true)
(define-const var3267 String (toString/-2075883882 var3340)) ; Statement: $r72 = virtualinvoke $r71.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1145568936 var2515 "dubbo" var2732 var1820 var3267 (cast-from-var3657-to-var3437 var302!5))) ; Statement: specialinvoke $r62.<org.apache.dubbo.common.url.component.ServiceConfigURL: void <init>(java.lang.String,java.lang.String,int,java.lang.String,java.util.Map)>("dubbo", $r65, $i2, $r72, $r59) 

(declare-const var2515!1 var2960)
(declare-const var355 String)
(declare-const var2732!1 String)
(declare-const var1820!1 Int)
(declare-const var3267!1 String)
(declare-const var302!6 var3657)
(define-const var2882 String (var2789_getClientSideCallbackServiceCacheKey/1447029485 var2162)) ; Statement: $r73 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec: java.lang.String getClientSideCallbackServiceCacheKey(int)>(i0) 
(assert true)
(define-const var1314 String (getName/-1958580599 var3056)) ; Statement: $r74 = virtualinvoke r9.<java.lang.Class: java.lang.String getName()>() 
(define-const var1252 String (var2789_getClientSideCountKey/299746518 var1314)) ; Statement: $r75 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec: java.lang.String getClientSideCountKey(java.lang.String)>($r74) 
(assert true)
(define-const var1887 Bool (booleanValue/-1820462562 var1317)) ; Statement: $z4 = virtualinvoke r12.<java.lang.Boolean: boolean booleanValue()>() 
 ; Statement: if $z4 == 0 goto $z0 = interfaceinvoke r11.<org.apache.dubbo.remoting.Channel: boolean hasAttribute(java.lang.String)>($r73) 
(assert (not (= (ite var1887 1 0) 0))) ; Negate: Cond: $z4 == 0  
(define-const var314 Bool (var1355_hasAttribute/-735023424 var2836 var2882)) ; Statement: $z1 = interfaceinvoke r11.<org.apache.dubbo.remoting.Channel: boolean hasAttribute(java.lang.String)>($r73) 
 ; Statement: if $z1 != 0 goto $r78 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i0) 
(assert (not (= (ite var314 1 0) 0))) ; Cond: $z1 != 0 
(define-const var15 String (String_valueOf/1240665136 var2162)) ; Statement: $r78 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i0) 
 ; Statement: return $r78 
(check-sat)
; {var1002_identityHashCode/1096208673=([java.lang.Object], int), var3657-init=([], java.util.HashMap), <init>/613807010=([java.util.HashMap, int], void), toString/1090915316=([java.lang.Boolean], java.lang.String), var3437_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-var3657-to-var3437=([java.util.HashMap], java.util.Map), cast-from-String-to-var814=([java.lang.String], java.lang.Object), getObjectAttachmentWithoutConvert/491812452=([org.apache.dubbo.rpc.RpcInvocation, java.lang.String], java.lang.Object), cast-from-var814-to-String=([java.lang.Object], java.lang.String), var3052_getDeclaredMethodNames/-1512898996=([java.lang.Class], java.lang.String[]), var2261_join/-2132544052=([java.lang.String[], java.lang.String], java.lang.String), <init>/-201242697=([java.util.HashMap], void), var3437_putAll/1656389889=([java.util.Map, java.util.Map], void), var3437_remove/-1201052315=([java.util.Map, java.lang.Object], java.lang.Object), getName/-1958580599=([java.lang.Class], java.lang.String), var2960-init=([], org.apache.dubbo.common.url.component.ServiceConfigURL), var547_getLocalAddress/2019899378=([org.apache.dubbo.remoting.Endpoint], java.net.InetSocketAddress), cast-from-var1355-to-var547=([org.apache.dubbo.remoting.Channel], org.apache.dubbo.remoting.Endpoint), getAddress/1707481140=([java.net.InetSocketAddress], java.net.InetAddress), getHostAddress/1493983505=([java.net.InetAddress], java.lang.String), getPort/-1397617271=([java.net.InetSocketAddress], int), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1145568936=([org.apache.dubbo.common.url.component.ServiceConfigURL, java.lang.String, java.lang.String, int, java.lang.String, java.util.Map], void), var2789_getClientSideCallbackServiceCacheKey/1447029485=([int], java.lang.String), var2789_getClientSideCountKey/299746518=([java.lang.String], java.lang.String), booleanValue/-1820462562=([java.lang.Boolean], boolean), var1355_hasAttribute/-735023424=([org.apache.dubbo.remoting.Channel, java.lang.String], boolean), String_valueOf/1240665136=([int], java.lang.String)}
; {var2789=org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec, var379=r32, var1355=org.apache.dubbo.remoting.Channel, var2836=r11, var2345=org.apache.dubbo.rpc.RpcInvocation, var2660=r6, var3232=org.apache.dubbo.common.URL, var129=r10, var3056=r9, var814=java.lang.Object, var3221=r0, var2803=java.lang.Boolean, var1317=r12, var1002=java.lang.System, var2162=i0, var3657=java.util.HashMap, var2168=$r1, var1390=3, var1168=$r2, var3158=$r3, var3437=java.util.Map, var3310="isserver", var952=$r4, var920=$r5, var354="is_callback_service", var2702=$r7, var3031=$r56, var745=r8, var2695=null_type, var3052=org.apache.dubbo.common.utils.ClassUtils, var1236=$r57, var2261=org.apache.dubbo.common.utils.StringUtils, var7=$r58, var3377="methods", var302=$r59, var1898="version", var6="bind.port", var2453=$r61, var2333="interface", var2960=org.apache.dubbo.common.url.component.ServiceConfigURL, var2515=$r62, var425=java.net.InetSocketAddress, var547=org.apache.dubbo.remoting.Endpoint, var111=$r63, var1815=java.net.InetAddress, var3405=$r64, var2732=$r65, var2256=$r66, var1820=$i2, var2978=$r67, var2628=$r68, var2013=$r69, var2442=$r70, var3340=$r71, var3267=$r72, var355="dubbo", var2882=$r73, var1314=$r74, var1252=$r75, var1887=$z4, var314=$z1, var15=$r78}
; {org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec=var2789, r32=var379, org.apache.dubbo.remoting.Channel=var1355, r11=var2836, org.apache.dubbo.rpc.RpcInvocation=var2345, r6=var2660, org.apache.dubbo.common.URL=var3232, r10=var129, r9=var3056, java.lang.Object=var814, r0=var3221, java.lang.Boolean=var2803, r12=var1317, java.lang.System=var1002, i0=var2162, java.util.HashMap=var3657, $r1=var2168, 3=var1390, $r2=var1168, $r3=var3158, java.util.Map=var3437, "isserver"=var3310, $r4=var952, $r5=var920, "is_callback_service"=var354, $r7=var2702, $r56=var3031, r8=var745, null_type=var2695, org.apache.dubbo.common.utils.ClassUtils=var3052, $r57=var1236, org.apache.dubbo.common.utils.StringUtils=var2261, $r58=var7, "methods"=var3377, $r59=var302, "version"=var1898, "bind.port"=var6, $r61=var2453, "interface"=var2333, org.apache.dubbo.common.url.component.ServiceConfigURL=var2960, $r62=var2515, java.net.InetSocketAddress=var425, org.apache.dubbo.remoting.Endpoint=var547, $r63=var111, java.net.InetAddress=var1815, $r64=var3405, $r65=var2732, $r66=var2256, $i2=var1820, $r67=var2978, $r68=var2628, $r69=var2013, $r70=var2442, $r71=var3340, $r72=var3267, "dubbo"=var355, $r73=var2882, $r74=var1314, $r75=var1252, $z4=var1887, $z1=var314, $r78=var15}
;seq <java.lang.Boolean: java.lang.String toString()>;	<java.lang.Boolean: java.lang.String toString()>;	<org.apache.dubbo.common.utils.StringUtils: java.lang.String join(java.lang.String[],java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.String: java.lang.String valueOf(int)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.lang.String join(java.lang.String[],java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1,"<java.lang.String: java.lang.String valueOf(int)>": 1}
;stmts r32 := @this: org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec;	r11 := @parameter0: org.apache.dubbo.remoting.Channel;	r6 := @parameter1: org.apache.dubbo.rpc.RpcInvocation;	r10 := @parameter2: org.apache.dubbo.common.URL;	r9 := @parameter3: java.lang.Class;	r0 := @parameter4: java.lang.Object;	r12 := @parameter5: java.lang.Boolean;	i0 = staticinvoke <java.lang.System: int identityHashCode(java.lang.Object)>(r0);	$r1 = new java.util.HashMap;	specialinvoke $r1.<java.util.HashMap: void <init>(int)>(3);	$r2 = <java.lang.Boolean: java.lang.Boolean FALSE>;	$r3 = virtualinvoke $r2.<java.lang.Boolean: java.lang.String toString()>();	interfaceinvoke $r1.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("isserver", $r3);	$r4 = <java.lang.Boolean: java.lang.Boolean TRUE>;	$r5 = virtualinvoke $r4.<java.lang.Boolean: java.lang.String toString()>();	interfaceinvoke $r1.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("is_callback_service", $r5);	if r6 != null goto $r7 = virtualinvoke r6.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("group");	$r7 = virtualinvoke r6.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("group");	$r56 = (java.lang.String) $r7;	r8 = $r56;	if $r56 == null goto $r57 = staticinvoke <org.apache.dubbo.common.utils.ClassUtils: java.lang.String[] getDeclaredMethodNames(java.lang.Class)>(r9);	$r57 = staticinvoke <org.apache.dubbo.common.utils.ClassUtils: java.lang.String[] getDeclaredMethodNames(java.lang.Class)>(r9);	$r58 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String join(java.lang.String[],java.lang.String)>($r57, ",");	interfaceinvoke $r1.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("methods", $r58);	$r59 = new java.util.HashMap;	specialinvoke $r59.<java.util.HashMap: void <init>()>();	if r10 == null goto interfaceinvoke $r59.<java.util.Map: void putAll(java.util.Map)>($r1);	interfaceinvoke $r59.<java.util.Map: void putAll(java.util.Map)>($r1);	interfaceinvoke $r59.<java.util.Map: java.lang.Object remove(java.lang.Object)>("version");	interfaceinvoke $r59.<java.util.Map: java.lang.Object remove(java.lang.Object)>("bind.port");	$r61 = virtualinvoke r9.<java.lang.Class: java.lang.String getName()>();	interfaceinvoke $r59.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("interface", $r61);	$r62 = new org.apache.dubbo.common.url.component.ServiceConfigURL;	$r63 = interfaceinvoke r11.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getLocalAddress()>();	$r64 = virtualinvoke $r63.<java.net.InetSocketAddress: java.net.InetAddress getAddress()>();	$r65 = virtualinvoke $r64.<java.net.InetAddress: java.lang.String getHostAddress()>();	$r66 = interfaceinvoke r11.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getLocalAddress()>();	$i2 = virtualinvoke $r66.<java.net.InetSocketAddress: int getPort()>();	$r67 = new java.lang.StringBuilder;	specialinvoke $r67.<java.lang.StringBuilder: void <init>()>();	$r68 = virtualinvoke r9.<java.lang.Class: java.lang.String getName()>();	$r69 = virtualinvoke $r67.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r68);	$r70 = virtualinvoke $r69.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".");	$r71 = virtualinvoke $r70.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r72 = virtualinvoke $r71.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r62.<org.apache.dubbo.common.url.component.ServiceConfigURL: void <init>(java.lang.String,java.lang.String,int,java.lang.String,java.util.Map)>("dubbo", $r65, $i2, $r72, $r59);	$r73 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec: java.lang.String getClientSideCallbackServiceCacheKey(int)>(i0);	$r74 = virtualinvoke r9.<java.lang.Class: java.lang.String getName()>();	$r75 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec: java.lang.String getClientSideCountKey(java.lang.String)>($r74);	$z4 = virtualinvoke r12.<java.lang.Boolean: boolean booleanValue()>();	if $z4 == 0 goto $z0 = interfaceinvoke r11.<org.apache.dubbo.remoting.Channel: boolean hasAttribute(java.lang.String)>($r73);	$z1 = interfaceinvoke r11.<org.apache.dubbo.remoting.Channel: boolean hasAttribute(java.lang.String)>($r73);	if $z1 != 0 goto $r78 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i0);	$r78 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i0);	return $r78
;block_num 7