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

(declare-sort var2841 0)
(declare-sort var1510 0)
(declare-sort var1650 0)
(declare-sort var2677 0)
(declare-sort var2097 0)
(declare-sort var665 0)
(declare-sort var2846 0)
(declare-sort var1659 0)
(declare-sort var519 0)
(declare-sort var3161 0)
(declare-sort var2939 0)
(declare-sort var2177 0)
(declare-sort var1829 0)
(declare-sort var1518 0)
(declare-sort var1436 0)
(declare-sort var2209 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2846_identityHashCode/1096208673 (var2097) Int)
(declare-fun var1659-init () var1659)
(declare-fun <init>/613807010 (var1659 Int) void)
(declare-fun toString/1090915316 (var665) String)
(declare-fun var519_put/1464166817 (var519 var2097 var2097) var2097)
(declare-fun cast-from-var1659-to-var519 (var1659) var519)
(declare-fun cast-from-String-to-var2097 (String) var2097)
(declare-fun getObjectAttachmentWithoutConvert/491812452 (var1650 String) var2097)
(declare-fun cast-from-var2097-to-String (var2097) String)
(declare-fun var2939_getDeclaredMethodNames/-1512898996 (ClassObject) (Array Int String))
(declare-fun var2177_join/-2132544052 ((Array Int String) String) String)
(declare-fun <init>/-201242697 (var1659) void)
(declare-fun var519_putAll/1656389889 (var519 var519) void)
(declare-fun var519_remove/-1201052315 (var519 var2097) var2097)
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun var1829-init () var1829)
(declare-fun var1436_getLocalAddress/2019899378 (var1436) var1518)
(declare-fun cast-from-var1510-to-var1436 (var1510) var1436)
(declare-fun getAddress/1707481140 (var1518) var2209)
(declare-fun getHostAddress/1493983505 (var2209) String)
(declare-fun getPort/-1397617271 (var1518) Int)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1145568936 (var1829 String String Int String var519) void)
(declare-fun var2841_getClientSideCallbackServiceCacheKey/1447029485 (Int) String)
(declare-fun var2841_getClientSideCountKey/299746518 (String) String)
(declare-fun booleanValue/-1820462562 (var665) Bool)
(declare-fun var1510_hasAttribute/-735023424 (var1510 String) Bool)
(declare-fun String_valueOf/1240665136 (Int) String)
(declare-const null-var2841 var2841)
(declare-const null-var1510 var1510)
(declare-const null-var1650 var1650)
(declare-const null-var2677 var2677)
(declare-const null-ClassObject ClassObject)
(declare-const null-var2097 var2097)
(declare-const null-var665 var665)
(declare-const var665-FALSE var665)
(declare-const var665-TRUE var665)
(declare-const null-String String)
(declare-const var3766 var2841) ; Statement: r32 := @this: org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec 
(assert (not (= var3766 null-var2841)))
(declare-const var3420 var1510) ; Statement: r11 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var3420 null-var1510)))
(declare-const var584 var1650) ; Statement: r6 := @parameter1: org.apache.dubbo.rpc.RpcInvocation 
(assert (not (= var584 null-var1650)))
(declare-const var3285 var2677) ; Statement: r10 := @parameter2: org.apache.dubbo.common.URL 
(assert (not (= var3285 null-var2677)))
(declare-const var1095 ClassObject) ; Statement: r9 := @parameter3: java.lang.Class 
(assert (not (= var1095 null-ClassObject)))
(declare-const var3807 var2097) ; Statement: r0 := @parameter4: java.lang.Object 
(assert (not (= var3807 null-var2097)))
(declare-const var3547 var665) ; Statement: r12 := @parameter5: java.lang.Boolean 
(assert (not (= var3547 null-var665)))
(define-const var302 Int (var2846_identityHashCode/1096208673 var3807)) ; Statement: i0 = staticinvoke <java.lang.System: int identityHashCode(java.lang.Object)>(r0) 
(define-const var1001 var1659 var1659-init) ; Statement: $r1 = new java.util.HashMap 
(assert true)
;(assert (<init>/613807010 var1001 3)) ; Statement: specialinvoke $r1.<java.util.HashMap: void <init>(int)>(3) 

(declare-const var1001!1 var1659)
(declare-const var1674 Int)
(define-const var2405 var665 var665-FALSE) ; Statement: $r2 = <java.lang.Boolean: java.lang.Boolean FALSE> 
(assert true)
(define-const var1052 String (toString/1090915316 var2405)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.Boolean: java.lang.String toString()>() 
;(assert (var519_put/1464166817 (cast-from-var1659-to-var519 var1001!1) (cast-from-String-to-var2097 "isserver") (cast-from-String-to-var2097 var1052))) ; Statement: interfaceinvoke $r1.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("isserver", $r3) 

(declare-const var1001!2 var1659)
(declare-const var2764 String)
(declare-const var1052!1 String)
(define-const var1973 var665 var665-TRUE) ; Statement: $r4 = <java.lang.Boolean: java.lang.Boolean TRUE> 
(assert true)
(define-const var2231 String (toString/1090915316 var1973)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.Boolean: java.lang.String toString()>() 
;(assert (var519_put/1464166817 (cast-from-var1659-to-var519 var1001!2) (cast-from-String-to-var2097 "is_callback_service") (cast-from-String-to-var2097 var2231))) ; Statement: interfaceinvoke $r1.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("is_callback_service", $r5) 

(declare-const var1001!3 var1659)
(declare-const var2331 String)
(declare-const var2231!1 String)
 ; Statement: if r6 != null goto $r7 = virtualinvoke r6.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("group") 
(assert (not (= var584 null-var1650))) ; Cond: r6 != null 
(assert true)
(define-const var2574 var2097 (getObjectAttachmentWithoutConvert/491812452 var584 "group")) ; Statement: $r7 = virtualinvoke r6.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("group") 
(define-const var3317 String (cast-from-var2097-to-String var2574)) ; Statement: $r56 = (java.lang.String) $r7 
(assert true) ; Non Conditional
(define-const var1535 String var3317) ; Statement: r8 = $r56 
 ; Statement: if $r56 == null goto $r57 = staticinvoke <org.apache.dubbo.common.utils.ClassUtils: java.lang.String[] getDeclaredMethodNames(java.lang.Class)>(r9) 
(assert (= var3317 null-String)) ; Cond: $r56 == null 
(define-const var106 (Array Int String) (var2939_getDeclaredMethodNames/-1512898996 var1095)) ; Statement: $r57 = staticinvoke <org.apache.dubbo.common.utils.ClassUtils: java.lang.String[] getDeclaredMethodNames(java.lang.Class)>(r9) 
(define-const var2237 String (var2177_join/-2132544052 var106 ",")) ; Statement: $r58 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String join(java.lang.String[],java.lang.String)>($r57, ",") 
;(assert (var519_put/1464166817 (cast-from-var1659-to-var519 var1001!3) (cast-from-String-to-var2097 "methods") (cast-from-String-to-var2097 var2237))) ; Statement: interfaceinvoke $r1.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("methods", $r58) 

(declare-const var1001!4 var1659)
(declare-const var1583 String)
(declare-const var2237!1 String)
(define-const var1734 var1659 var1659-init) ; Statement: $r59 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var1734)) ; Statement: specialinvoke $r59.<java.util.HashMap: void <init>()>() 

(declare-const var1734!1 var1659)
 ; Statement: if r10 == null goto interfaceinvoke $r59.<java.util.Map: void putAll(java.util.Map)>($r1) 
(assert (= var3285 null-var2677)) ; Cond: r10 == null 
;(assert (var519_putAll/1656389889 (cast-from-var1659-to-var519 var1734!1) (cast-from-var1659-to-var519 var1001!4))) ; Statement: interfaceinvoke $r59.<java.util.Map: void putAll(java.util.Map)>($r1) 

(declare-const var1734!2 var1659)
(declare-const var1001!5 var1659)
;(assert (var519_remove/-1201052315 (cast-from-var1659-to-var519 var1734!2) (cast-from-String-to-var2097 "version"))) ; Statement: interfaceinvoke $r59.<java.util.Map: java.lang.Object remove(java.lang.Object)>("version") 

(declare-const var1734!3 var1659)
(declare-const var912 String)
;(assert (var519_remove/-1201052315 (cast-from-var1659-to-var519 var1734!3) (cast-from-String-to-var2097 "bind.port"))) ; Statement: interfaceinvoke $r59.<java.util.Map: java.lang.Object remove(java.lang.Object)>("bind.port") 

(declare-const var1734!4 var1659)
(declare-const var2383 String)
(assert true)
(define-const var1454 String (getName/-1958580599 var1095)) ; Statement: $r61 = virtualinvoke r9.<java.lang.Class: java.lang.String getName()>() 
;(assert (var519_put/1464166817 (cast-from-var1659-to-var519 var1734!4) (cast-from-String-to-var2097 "interface") (cast-from-String-to-var2097 var1454))) ; Statement: interfaceinvoke $r59.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("interface", $r61) 

(declare-const var1734!5 var1659)
(declare-const var2105 String)
(declare-const var1454!1 String)
(define-const var3709 var1829 var1829-init) ; Statement: $r62 = new org.apache.dubbo.common.url.component.ServiceConfigURL 
(define-const var27 var1518 (var1436_getLocalAddress/2019899378 (cast-from-var1510-to-var1436 var3420))) ; Statement: $r63 = interfaceinvoke r11.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getLocalAddress()>() 
(assert true)
(define-const var816 var2209 (getAddress/1707481140 var27)) ; Statement: $r64 = virtualinvoke $r63.<java.net.InetSocketAddress: java.net.InetAddress getAddress()>() 
(assert true)
(define-const var1026 String (getHostAddress/1493983505 var816)) ; Statement: $r65 = virtualinvoke $r64.<java.net.InetAddress: java.lang.String getHostAddress()>() 
(define-const var3751 var1518 (var1436_getLocalAddress/2019899378 (cast-from-var1510-to-var1436 var3420))) ; Statement: $r66 = interfaceinvoke r11.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getLocalAddress()>() 
(assert true)
(define-const var697 Int (getPort/-1397617271 var3751)) ; Statement: $i2 = virtualinvoke $r66.<java.net.InetSocketAddress: int getPort()>() 
(define-const var2274 String String-init) ; Statement: $r67 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2274)) ; Statement: specialinvoke $r67.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2274!1 String)
(assert (= var2274!1 ""))
(assert true)
(define-const var3052 String (getName/-1958580599 var1095)) ; Statement: $r68 = virtualinvoke r9.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var829 String (append/672562846 var2274!1 var3052)) ; Statement: $r69 = virtualinvoke $r67.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r68) 
(declare-const var2274!2 String)
(assert (= var2274!2 (str.++ var2274!1 var3052)))
(assert true)
(define-const var3437 String (append/672562846 var829 ".")) ; Statement: $r70 = virtualinvoke $r69.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".") 
(declare-const var829!1 String)
(assert (= var829!1 (str.++ var829 ".")))
(assert true)
(define-const var1420 String (append/-1001720160 var3437 var302)) ; Statement: $r71 = virtualinvoke $r70.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var3437!1 String)
(assert (str.prefixof var3437 var3437!1))
(assert true)
(define-const var3679 String (toString/-2075883882 var1420)) ; Statement: $r72 = virtualinvoke $r71.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1145568936 var3709 "dubbo" var1026 var697 var3679 (cast-from-var1659-to-var519 var1734!5))) ; Statement: specialinvoke $r62.<org.apache.dubbo.common.url.component.ServiceConfigURL: void <init>(java.lang.String,java.lang.String,int,java.lang.String,java.util.Map)>("dubbo", $r65, $i2, $r72, $r59) 

(declare-const var3709!1 var1829)
(declare-const var1301 String)
(declare-const var1026!1 String)
(declare-const var697!1 Int)
(declare-const var3679!1 String)
(declare-const var1734!6 var1659)
(define-const var1286 String (var2841_getClientSideCallbackServiceCacheKey/1447029485 var302)) ; Statement: $r73 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec: java.lang.String getClientSideCallbackServiceCacheKey(int)>(i0) 
(assert true)
(define-const var2504 String (getName/-1958580599 var1095)) ; Statement: $r74 = virtualinvoke r9.<java.lang.Class: java.lang.String getName()>() 
(define-const var2540 String (var2841_getClientSideCountKey/299746518 var2504)) ; Statement: $r75 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec: java.lang.String getClientSideCountKey(java.lang.String)>($r74) 
(assert true)
(define-const var1819 Bool (booleanValue/-1820462562 var3547)) ; Statement: $z4 = virtualinvoke r12.<java.lang.Boolean: boolean booleanValue()>() 
 ; Statement: if $z4 == 0 goto $z0 = interfaceinvoke r11.<org.apache.dubbo.remoting.Channel: boolean hasAttribute(java.lang.String)>($r73) 
(assert (= (ite var1819 1 0) 0)) ; Cond: $z4 == 0 
(define-const var1038 Bool (var1510_hasAttribute/-735023424 var3420 var1286)) ; Statement: $z0 = interfaceinvoke r11.<org.apache.dubbo.remoting.Channel: boolean hasAttribute(java.lang.String)>($r73) 
 ; Statement: if $z0 == 0 goto $r78 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i0) 
(assert (= (ite var1038 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1264 String (String_valueOf/1240665136 var302)) ; Statement: $r78 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i0) 
 ; Statement: return $r78 
(check-sat)
; {var2846_identityHashCode/1096208673=([java.lang.Object], int), var1659-init=([], java.util.HashMap), <init>/613807010=([java.util.HashMap, int], void), toString/1090915316=([java.lang.Boolean], java.lang.String), var519_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-var1659-to-var519=([java.util.HashMap], java.util.Map), cast-from-String-to-var2097=([java.lang.String], java.lang.Object), getObjectAttachmentWithoutConvert/491812452=([org.apache.dubbo.rpc.RpcInvocation, java.lang.String], java.lang.Object), cast-from-var2097-to-String=([java.lang.Object], java.lang.String), var2939_getDeclaredMethodNames/-1512898996=([java.lang.Class], java.lang.String[]), var2177_join/-2132544052=([java.lang.String[], java.lang.String], java.lang.String), <init>/-201242697=([java.util.HashMap], void), var519_putAll/1656389889=([java.util.Map, java.util.Map], void), var519_remove/-1201052315=([java.util.Map, java.lang.Object], java.lang.Object), getName/-1958580599=([java.lang.Class], java.lang.String), var1829-init=([], org.apache.dubbo.common.url.component.ServiceConfigURL), var1436_getLocalAddress/2019899378=([org.apache.dubbo.remoting.Endpoint], java.net.InetSocketAddress), cast-from-var1510-to-var1436=([org.apache.dubbo.remoting.Channel], org.apache.dubbo.remoting.Endpoint), getAddress/1707481140=([java.net.InetSocketAddress], java.net.InetAddress), getHostAddress/1493983505=([java.net.InetAddress], java.lang.String), getPort/-1397617271=([java.net.InetSocketAddress], int), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1145568936=([org.apache.dubbo.common.url.component.ServiceConfigURL, java.lang.String, java.lang.String, int, java.lang.String, java.util.Map], void), var2841_getClientSideCallbackServiceCacheKey/1447029485=([int], java.lang.String), var2841_getClientSideCountKey/299746518=([java.lang.String], java.lang.String), booleanValue/-1820462562=([java.lang.Boolean], boolean), var1510_hasAttribute/-735023424=([org.apache.dubbo.remoting.Channel, java.lang.String], boolean), String_valueOf/1240665136=([int], java.lang.String)}
; {var2841=org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec, var3766=r32, var1510=org.apache.dubbo.remoting.Channel, var3420=r11, var1650=org.apache.dubbo.rpc.RpcInvocation, var584=r6, var2677=org.apache.dubbo.common.URL, var3285=r10, var1095=r9, var2097=java.lang.Object, var3807=r0, var665=java.lang.Boolean, var3547=r12, var2846=java.lang.System, var302=i0, var1659=java.util.HashMap, var1001=$r1, var1674=3, var2405=$r2, var1052=$r3, var519=java.util.Map, var2764="isserver", var1973=$r4, var2231=$r5, var2331="is_callback_service", var2574=$r7, var3317=$r56, var1535=r8, var3161=null_type, var2939=org.apache.dubbo.common.utils.ClassUtils, var106=$r57, var2177=org.apache.dubbo.common.utils.StringUtils, var2237=$r58, var1583="methods", var1734=$r59, var912="version", var2383="bind.port", var1454=$r61, var2105="interface", var1829=org.apache.dubbo.common.url.component.ServiceConfigURL, var3709=$r62, var1518=java.net.InetSocketAddress, var1436=org.apache.dubbo.remoting.Endpoint, var27=$r63, var2209=java.net.InetAddress, var816=$r64, var1026=$r65, var3751=$r66, var697=$i2, var2274=$r67, var3052=$r68, var829=$r69, var3437=$r70, var1420=$r71, var3679=$r72, var1301="dubbo", var1286=$r73, var2504=$r74, var2540=$r75, var1819=$z4, var1038=$z0, var1264=$r78}
; {org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec=var2841, r32=var3766, org.apache.dubbo.remoting.Channel=var1510, r11=var3420, org.apache.dubbo.rpc.RpcInvocation=var1650, r6=var584, org.apache.dubbo.common.URL=var2677, r10=var3285, r9=var1095, java.lang.Object=var2097, r0=var3807, java.lang.Boolean=var665, r12=var3547, java.lang.System=var2846, i0=var302, java.util.HashMap=var1659, $r1=var1001, 3=var1674, $r2=var2405, $r3=var1052, java.util.Map=var519, "isserver"=var2764, $r4=var1973, $r5=var2231, "is_callback_service"=var2331, $r7=var2574, $r56=var3317, r8=var1535, null_type=var3161, org.apache.dubbo.common.utils.ClassUtils=var2939, $r57=var106, org.apache.dubbo.common.utils.StringUtils=var2177, $r58=var2237, "methods"=var1583, $r59=var1734, "version"=var912, "bind.port"=var2383, $r61=var1454, "interface"=var2105, org.apache.dubbo.common.url.component.ServiceConfigURL=var1829, $r62=var3709, java.net.InetSocketAddress=var1518, org.apache.dubbo.remoting.Endpoint=var1436, $r63=var27, java.net.InetAddress=var2209, $r64=var816, $r65=var1026, $r66=var3751, $i2=var697, $r67=var2274, $r68=var3052, $r69=var829, $r70=var3437, $r71=var1420, $r72=var3679, "dubbo"=var1301, $r73=var1286, $r74=var2504, $r75=var2540, $z4=var1819, $z0=var1038, $r78=var1264}
;seq <java.lang.Boolean: java.lang.String toString()>;	<java.lang.Boolean: java.lang.String toString()>;	<org.apache.dubbo.common.utils.StringUtils: java.lang.String join(java.lang.String[],java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.String: java.lang.String valueOf(int)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.lang.String join(java.lang.String[],java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1,"<java.lang.String: java.lang.String valueOf(int)>": 1}
;stmts r32 := @this: org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec;	r11 := @parameter0: org.apache.dubbo.remoting.Channel;	r6 := @parameter1: org.apache.dubbo.rpc.RpcInvocation;	r10 := @parameter2: org.apache.dubbo.common.URL;	r9 := @parameter3: java.lang.Class;	r0 := @parameter4: java.lang.Object;	r12 := @parameter5: java.lang.Boolean;	i0 = staticinvoke <java.lang.System: int identityHashCode(java.lang.Object)>(r0);	$r1 = new java.util.HashMap;	specialinvoke $r1.<java.util.HashMap: void <init>(int)>(3);	$r2 = <java.lang.Boolean: java.lang.Boolean FALSE>;	$r3 = virtualinvoke $r2.<java.lang.Boolean: java.lang.String toString()>();	interfaceinvoke $r1.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("isserver", $r3);	$r4 = <java.lang.Boolean: java.lang.Boolean TRUE>;	$r5 = virtualinvoke $r4.<java.lang.Boolean: java.lang.String toString()>();	interfaceinvoke $r1.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("is_callback_service", $r5);	if r6 != null goto $r7 = virtualinvoke r6.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("group");	$r7 = virtualinvoke r6.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("group");	$r56 = (java.lang.String) $r7;	r8 = $r56;	if $r56 == null goto $r57 = staticinvoke <org.apache.dubbo.common.utils.ClassUtils: java.lang.String[] getDeclaredMethodNames(java.lang.Class)>(r9);	$r57 = staticinvoke <org.apache.dubbo.common.utils.ClassUtils: java.lang.String[] getDeclaredMethodNames(java.lang.Class)>(r9);	$r58 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String join(java.lang.String[],java.lang.String)>($r57, ",");	interfaceinvoke $r1.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("methods", $r58);	$r59 = new java.util.HashMap;	specialinvoke $r59.<java.util.HashMap: void <init>()>();	if r10 == null goto interfaceinvoke $r59.<java.util.Map: void putAll(java.util.Map)>($r1);	interfaceinvoke $r59.<java.util.Map: void putAll(java.util.Map)>($r1);	interfaceinvoke $r59.<java.util.Map: java.lang.Object remove(java.lang.Object)>("version");	interfaceinvoke $r59.<java.util.Map: java.lang.Object remove(java.lang.Object)>("bind.port");	$r61 = virtualinvoke r9.<java.lang.Class: java.lang.String getName()>();	interfaceinvoke $r59.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("interface", $r61);	$r62 = new org.apache.dubbo.common.url.component.ServiceConfigURL;	$r63 = interfaceinvoke r11.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getLocalAddress()>();	$r64 = virtualinvoke $r63.<java.net.InetSocketAddress: java.net.InetAddress getAddress()>();	$r65 = virtualinvoke $r64.<java.net.InetAddress: java.lang.String getHostAddress()>();	$r66 = interfaceinvoke r11.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getLocalAddress()>();	$i2 = virtualinvoke $r66.<java.net.InetSocketAddress: int getPort()>();	$r67 = new java.lang.StringBuilder;	specialinvoke $r67.<java.lang.StringBuilder: void <init>()>();	$r68 = virtualinvoke r9.<java.lang.Class: java.lang.String getName()>();	$r69 = virtualinvoke $r67.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r68);	$r70 = virtualinvoke $r69.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".");	$r71 = virtualinvoke $r70.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r72 = virtualinvoke $r71.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r62.<org.apache.dubbo.common.url.component.ServiceConfigURL: void <init>(java.lang.String,java.lang.String,int,java.lang.String,java.util.Map)>("dubbo", $r65, $i2, $r72, $r59);	$r73 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec: java.lang.String getClientSideCallbackServiceCacheKey(int)>(i0);	$r74 = virtualinvoke r9.<java.lang.Class: java.lang.String getName()>();	$r75 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec: java.lang.String getClientSideCountKey(java.lang.String)>($r74);	$z4 = virtualinvoke r12.<java.lang.Boolean: boolean booleanValue()>();	if $z4 == 0 goto $z0 = interfaceinvoke r11.<org.apache.dubbo.remoting.Channel: boolean hasAttribute(java.lang.String)>($r73);	$z0 = interfaceinvoke r11.<org.apache.dubbo.remoting.Channel: boolean hasAttribute(java.lang.String)>($r73);	if $z0 == 0 goto $r78 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i0);	$r78 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i0);	return $r78
;block_num 7