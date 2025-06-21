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

(declare-sort var804 0)
(declare-sort var3598 0)
(declare-sort var1592 0)
(declare-sort var1615 0)
(declare-sort var3849 0)
(declare-sort var854 0)
(declare-sort var2866 0)
(declare-sort var3145 0)
(declare-sort var324 0)
(declare-sort var906 0)
(declare-sort var1746 0)
(declare-sort var3784 0)
(declare-sort var2169 0)
(declare-sort var1310 0)
(declare-sort var1259 0)
(declare-sort var3871 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2866_identityHashCode/1096208673 (var3849) Int)
(declare-fun var3145-init () var3145)
(declare-fun <init>/613807010 (var3145 Int) void)
(declare-fun toString/1090915316 (var854) String)
(declare-fun var324_put/1464166817 (var324 var3849 var3849) var3849)
(declare-fun cast-from-var3145-to-var324 (var3145) var324)
(declare-fun cast-from-String-to-var3849 (String) var3849)
(declare-fun var1746_getDeclaredMethodNames/-1512898996 (ClassObject) (Array Int String))
(declare-fun var3784_join/-2132544052 ((Array Int String) String) String)
(declare-fun <init>/-201242697 (var3145) void)
(declare-fun var324_putAll/1656389889 (var324 var324) void)
(declare-fun var324_remove/-1201052315 (var324 var3849) var3849)
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun var2169-init () var2169)
(declare-fun var1259_getLocalAddress/2019899378 (var1259) var1310)
(declare-fun cast-from-var3598-to-var1259 (var3598) var1259)
(declare-fun getAddress/1707481140 (var1310) var3871)
(declare-fun getHostAddress/1493983505 (var3871) String)
(declare-fun getPort/-1397617271 (var1310) Int)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1145568936 (var2169 String String Int String var324) void)
(declare-fun var804_getClientSideCallbackServiceCacheKey/1447029485 (Int) String)
(declare-fun var804_getClientSideCountKey/299746518 (String) String)
(declare-fun booleanValue/-1820462562 (var854) Bool)
(declare-fun var3598_hasAttribute/-735023424 (var3598 String) Bool)
(declare-fun String_valueOf/1240665136 (Int) String)
(declare-const null-var804 var804)
(declare-const null-var3598 var3598)
(declare-const null-var1592 var1592)
(declare-const null-var1615 var1615)
(declare-const null-ClassObject ClassObject)
(declare-const null-var3849 var3849)
(declare-const null-var854 var854)
(declare-const var854-FALSE var854)
(declare-const var854-TRUE var854)
(declare-const null-String String)
(declare-const var3885 var804) ; Statement: r32 := @this: org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec 
(assert (not (= var3885 null-var804)))
(declare-const var2110 var3598) ; Statement: r11 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var2110 null-var3598)))
(declare-const var619 var1592) ; Statement: r6 := @parameter1: org.apache.dubbo.rpc.RpcInvocation 
(assert (not (= var619 null-var1592)))
(declare-const var2421 var1615) ; Statement: r10 := @parameter2: org.apache.dubbo.common.URL 
(assert (not (= var2421 null-var1615)))
(declare-const var625 ClassObject) ; Statement: r9 := @parameter3: java.lang.Class 
(assert (not (= var625 null-ClassObject)))
(declare-const var3400 var3849) ; Statement: r0 := @parameter4: java.lang.Object 
(assert (not (= var3400 null-var3849)))
(declare-const var2411 var854) ; Statement: r12 := @parameter5: java.lang.Boolean 
(assert (not (= var2411 null-var854)))
(define-const var2775 Int (var2866_identityHashCode/1096208673 var3400)) ; Statement: i0 = staticinvoke <java.lang.System: int identityHashCode(java.lang.Object)>(r0) 
(define-const var710 var3145 var3145-init) ; Statement: $r1 = new java.util.HashMap 
(assert true)
;(assert (<init>/613807010 var710 3)) ; Statement: specialinvoke $r1.<java.util.HashMap: void <init>(int)>(3) 

(declare-const var710!1 var3145)
(declare-const var3310 Int)
(define-const var520 var854 var854-FALSE) ; Statement: $r2 = <java.lang.Boolean: java.lang.Boolean FALSE> 
(assert true)
(define-const var998 String (toString/1090915316 var520)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.Boolean: java.lang.String toString()>() 
;(assert (var324_put/1464166817 (cast-from-var3145-to-var324 var710!1) (cast-from-String-to-var3849 "isserver") (cast-from-String-to-var3849 var998))) ; Statement: interfaceinvoke $r1.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("isserver", $r3) 

(declare-const var710!2 var3145)
(declare-const var3300 String)
(declare-const var998!1 String)
(define-const var681 var854 var854-TRUE) ; Statement: $r4 = <java.lang.Boolean: java.lang.Boolean TRUE> 
(assert true)
(define-const var314 String (toString/1090915316 var681)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.Boolean: java.lang.String toString()>() 
;(assert (var324_put/1464166817 (cast-from-var3145-to-var324 var710!2) (cast-from-String-to-var3849 "is_callback_service") (cast-from-String-to-var3849 var314))) ; Statement: interfaceinvoke $r1.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("is_callback_service", $r5) 

(declare-const var710!3 var3145)
(declare-const var1490 String)
(declare-const var314!1 String)
 ; Statement: if r6 != null goto $r7 = virtualinvoke r6.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("group") 
(assert (not (not (= var619 null-var1592)))) ; Negate: Cond: r6 != null  
(define-const var192 String null-String) ; Statement: $r56 = null 
 ; Statement: goto [?= r8 = $r56] 
(assert true) ; Non Conditional
(define-const var1139 String var192) ; Statement: r8 = $r56 
 ; Statement: if $r56 == null goto $r57 = staticinvoke <org.apache.dubbo.common.utils.ClassUtils: java.lang.String[] getDeclaredMethodNames(java.lang.Class)>(r9) 
(assert (= var192 null-String)) ; Cond: $r56 == null 
(define-const var306 (Array Int String) (var1746_getDeclaredMethodNames/-1512898996 var625)) ; Statement: $r57 = staticinvoke <org.apache.dubbo.common.utils.ClassUtils: java.lang.String[] getDeclaredMethodNames(java.lang.Class)>(r9) 
(define-const var2154 String (var3784_join/-2132544052 var306 ",")) ; Statement: $r58 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String join(java.lang.String[],java.lang.String)>($r57, ",") 
;(assert (var324_put/1464166817 (cast-from-var3145-to-var324 var710!3) (cast-from-String-to-var3849 "methods") (cast-from-String-to-var3849 var2154))) ; Statement: interfaceinvoke $r1.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("methods", $r58) 

(declare-const var710!4 var3145)
(declare-const var368 String)
(declare-const var2154!1 String)
(define-const var3104 var3145 var3145-init) ; Statement: $r59 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var3104)) ; Statement: specialinvoke $r59.<java.util.HashMap: void <init>()>() 

(declare-const var3104!1 var3145)
 ; Statement: if r10 == null goto interfaceinvoke $r59.<java.util.Map: void putAll(java.util.Map)>($r1) 
(assert (= var2421 null-var1615)) ; Cond: r10 == null 
;(assert (var324_putAll/1656389889 (cast-from-var3145-to-var324 var3104!1) (cast-from-var3145-to-var324 var710!4))) ; Statement: interfaceinvoke $r59.<java.util.Map: void putAll(java.util.Map)>($r1) 

(declare-const var3104!2 var3145)
(declare-const var710!5 var3145)
;(assert (var324_remove/-1201052315 (cast-from-var3145-to-var324 var3104!2) (cast-from-String-to-var3849 "version"))) ; Statement: interfaceinvoke $r59.<java.util.Map: java.lang.Object remove(java.lang.Object)>("version") 

(declare-const var3104!3 var3145)
(declare-const var2928 String)
;(assert (var324_remove/-1201052315 (cast-from-var3145-to-var324 var3104!3) (cast-from-String-to-var3849 "bind.port"))) ; Statement: interfaceinvoke $r59.<java.util.Map: java.lang.Object remove(java.lang.Object)>("bind.port") 

(declare-const var3104!4 var3145)
(declare-const var1533 String)
(assert true)
(define-const var691 String (getName/-1958580599 var625)) ; Statement: $r61 = virtualinvoke r9.<java.lang.Class: java.lang.String getName()>() 
;(assert (var324_put/1464166817 (cast-from-var3145-to-var324 var3104!4) (cast-from-String-to-var3849 "interface") (cast-from-String-to-var3849 var691))) ; Statement: interfaceinvoke $r59.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("interface", $r61) 

(declare-const var3104!5 var3145)
(declare-const var3939 String)
(declare-const var691!1 String)
(define-const var2613 var2169 var2169-init) ; Statement: $r62 = new org.apache.dubbo.common.url.component.ServiceConfigURL 
(define-const var1438 var1310 (var1259_getLocalAddress/2019899378 (cast-from-var3598-to-var1259 var2110))) ; Statement: $r63 = interfaceinvoke r11.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getLocalAddress()>() 
(assert true)
(define-const var3130 var3871 (getAddress/1707481140 var1438)) ; Statement: $r64 = virtualinvoke $r63.<java.net.InetSocketAddress: java.net.InetAddress getAddress()>() 
(assert true)
(define-const var1548 String (getHostAddress/1493983505 var3130)) ; Statement: $r65 = virtualinvoke $r64.<java.net.InetAddress: java.lang.String getHostAddress()>() 
(define-const var3038 var1310 (var1259_getLocalAddress/2019899378 (cast-from-var3598-to-var1259 var2110))) ; Statement: $r66 = interfaceinvoke r11.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getLocalAddress()>() 
(assert true)
(define-const var2309 Int (getPort/-1397617271 var3038)) ; Statement: $i2 = virtualinvoke $r66.<java.net.InetSocketAddress: int getPort()>() 
(define-const var2180 String String-init) ; Statement: $r67 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2180)) ; Statement: specialinvoke $r67.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2180!1 String)
(assert (= var2180!1 ""))
(assert true)
(define-const var3452 String (getName/-1958580599 var625)) ; Statement: $r68 = virtualinvoke r9.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var3246 String (append/672562846 var2180!1 var3452)) ; Statement: $r69 = virtualinvoke $r67.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r68) 
(declare-const var2180!2 String)
(assert (= var2180!2 (str.++ var2180!1 var3452)))
(assert true)
(define-const var1516 String (append/672562846 var3246 ".")) ; Statement: $r70 = virtualinvoke $r69.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".") 
(declare-const var3246!1 String)
(assert (= var3246!1 (str.++ var3246 ".")))
(assert true)
(define-const var3520 String (append/-1001720160 var1516 var2775)) ; Statement: $r71 = virtualinvoke $r70.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var1516!1 String)
(assert (str.prefixof var1516 var1516!1))
(assert true)
(define-const var3609 String (toString/-2075883882 var3520)) ; Statement: $r72 = virtualinvoke $r71.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1145568936 var2613 "dubbo" var1548 var2309 var3609 (cast-from-var3145-to-var324 var3104!5))) ; Statement: specialinvoke $r62.<org.apache.dubbo.common.url.component.ServiceConfigURL: void <init>(java.lang.String,java.lang.String,int,java.lang.String,java.util.Map)>("dubbo", $r65, $i2, $r72, $r59) 

(declare-const var2613!1 var2169)
(declare-const var2107 String)
(declare-const var1548!1 String)
(declare-const var2309!1 Int)
(declare-const var3609!1 String)
(declare-const var3104!6 var3145)
(define-const var1028 String (var804_getClientSideCallbackServiceCacheKey/1447029485 var2775)) ; Statement: $r73 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec: java.lang.String getClientSideCallbackServiceCacheKey(int)>(i0) 
(assert true)
(define-const var2361 String (getName/-1958580599 var625)) ; Statement: $r74 = virtualinvoke r9.<java.lang.Class: java.lang.String getName()>() 
(define-const var1697 String (var804_getClientSideCountKey/299746518 var2361)) ; Statement: $r75 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec: java.lang.String getClientSideCountKey(java.lang.String)>($r74) 
(assert true)
(define-const var1629 Bool (booleanValue/-1820462562 var2411)) ; Statement: $z4 = virtualinvoke r12.<java.lang.Boolean: boolean booleanValue()>() 
 ; Statement: if $z4 == 0 goto $z0 = interfaceinvoke r11.<org.apache.dubbo.remoting.Channel: boolean hasAttribute(java.lang.String)>($r73) 
(assert (= (ite var1629 1 0) 0)) ; Cond: $z4 == 0 
(define-const var2414 Bool (var3598_hasAttribute/-735023424 var2110 var1028)) ; Statement: $z0 = interfaceinvoke r11.<org.apache.dubbo.remoting.Channel: boolean hasAttribute(java.lang.String)>($r73) 
 ; Statement: if $z0 == 0 goto $r78 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i0) 
(assert (= (ite var2414 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1741 String (String_valueOf/1240665136 var2775)) ; Statement: $r78 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i0) 
 ; Statement: return $r78 
(check-sat)
; {var2866_identityHashCode/1096208673=([java.lang.Object], int), var3145-init=([], java.util.HashMap), <init>/613807010=([java.util.HashMap, int], void), toString/1090915316=([java.lang.Boolean], java.lang.String), var324_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-var3145-to-var324=([java.util.HashMap], java.util.Map), cast-from-String-to-var3849=([java.lang.String], java.lang.Object), var1746_getDeclaredMethodNames/-1512898996=([java.lang.Class], java.lang.String[]), var3784_join/-2132544052=([java.lang.String[], java.lang.String], java.lang.String), <init>/-201242697=([java.util.HashMap], void), var324_putAll/1656389889=([java.util.Map, java.util.Map], void), var324_remove/-1201052315=([java.util.Map, java.lang.Object], java.lang.Object), getName/-1958580599=([java.lang.Class], java.lang.String), var2169-init=([], org.apache.dubbo.common.url.component.ServiceConfigURL), var1259_getLocalAddress/2019899378=([org.apache.dubbo.remoting.Endpoint], java.net.InetSocketAddress), cast-from-var3598-to-var1259=([org.apache.dubbo.remoting.Channel], org.apache.dubbo.remoting.Endpoint), getAddress/1707481140=([java.net.InetSocketAddress], java.net.InetAddress), getHostAddress/1493983505=([java.net.InetAddress], java.lang.String), getPort/-1397617271=([java.net.InetSocketAddress], int), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1145568936=([org.apache.dubbo.common.url.component.ServiceConfigURL, java.lang.String, java.lang.String, int, java.lang.String, java.util.Map], void), var804_getClientSideCallbackServiceCacheKey/1447029485=([int], java.lang.String), var804_getClientSideCountKey/299746518=([java.lang.String], java.lang.String), booleanValue/-1820462562=([java.lang.Boolean], boolean), var3598_hasAttribute/-735023424=([org.apache.dubbo.remoting.Channel, java.lang.String], boolean), String_valueOf/1240665136=([int], java.lang.String)}
; {var804=org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec, var3885=r32, var3598=org.apache.dubbo.remoting.Channel, var2110=r11, var1592=org.apache.dubbo.rpc.RpcInvocation, var619=r6, var1615=org.apache.dubbo.common.URL, var2421=r10, var625=r9, var3849=java.lang.Object, var3400=r0, var854=java.lang.Boolean, var2411=r12, var2866=java.lang.System, var2775=i0, var3145=java.util.HashMap, var710=$r1, var3310=3, var520=$r2, var998=$r3, var324=java.util.Map, var3300="isserver", var681=$r4, var314=$r5, var1490="is_callback_service", var906=null_type, var192=$r56, var1139=r8, var1746=org.apache.dubbo.common.utils.ClassUtils, var306=$r57, var3784=org.apache.dubbo.common.utils.StringUtils, var2154=$r58, var368="methods", var3104=$r59, var2928="version", var1533="bind.port", var691=$r61, var3939="interface", var2169=org.apache.dubbo.common.url.component.ServiceConfigURL, var2613=$r62, var1310=java.net.InetSocketAddress, var1259=org.apache.dubbo.remoting.Endpoint, var1438=$r63, var3871=java.net.InetAddress, var3130=$r64, var1548=$r65, var3038=$r66, var2309=$i2, var2180=$r67, var3452=$r68, var3246=$r69, var1516=$r70, var3520=$r71, var3609=$r72, var2107="dubbo", var1028=$r73, var2361=$r74, var1697=$r75, var1629=$z4, var2414=$z0, var1741=$r78}
; {org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec=var804, r32=var3885, org.apache.dubbo.remoting.Channel=var3598, r11=var2110, org.apache.dubbo.rpc.RpcInvocation=var1592, r6=var619, org.apache.dubbo.common.URL=var1615, r10=var2421, r9=var625, java.lang.Object=var3849, r0=var3400, java.lang.Boolean=var854, r12=var2411, java.lang.System=var2866, i0=var2775, java.util.HashMap=var3145, $r1=var710, 3=var3310, $r2=var520, $r3=var998, java.util.Map=var324, "isserver"=var3300, $r4=var681, $r5=var314, "is_callback_service"=var1490, null_type=var906, $r56=var192, r8=var1139, org.apache.dubbo.common.utils.ClassUtils=var1746, $r57=var306, org.apache.dubbo.common.utils.StringUtils=var3784, $r58=var2154, "methods"=var368, $r59=var3104, "version"=var2928, "bind.port"=var1533, $r61=var691, "interface"=var3939, org.apache.dubbo.common.url.component.ServiceConfigURL=var2169, $r62=var2613, java.net.InetSocketAddress=var1310, org.apache.dubbo.remoting.Endpoint=var1259, $r63=var1438, java.net.InetAddress=var3871, $r64=var3130, $r65=var1548, $r66=var3038, $i2=var2309, $r67=var2180, $r68=var3452, $r69=var3246, $r70=var1516, $r71=var3520, $r72=var3609, "dubbo"=var2107, $r73=var1028, $r74=var2361, $r75=var1697, $z4=var1629, $z0=var2414, $r78=var1741}
;seq <java.lang.Boolean: java.lang.String toString()>;	<java.lang.Boolean: java.lang.String toString()>;	<org.apache.dubbo.common.utils.StringUtils: java.lang.String join(java.lang.String[],java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.String: java.lang.String valueOf(int)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.lang.String join(java.lang.String[],java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1,"<java.lang.String: java.lang.String valueOf(int)>": 1}
;stmts r32 := @this: org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec;	r11 := @parameter0: org.apache.dubbo.remoting.Channel;	r6 := @parameter1: org.apache.dubbo.rpc.RpcInvocation;	r10 := @parameter2: org.apache.dubbo.common.URL;	r9 := @parameter3: java.lang.Class;	r0 := @parameter4: java.lang.Object;	r12 := @parameter5: java.lang.Boolean;	i0 = staticinvoke <java.lang.System: int identityHashCode(java.lang.Object)>(r0);	$r1 = new java.util.HashMap;	specialinvoke $r1.<java.util.HashMap: void <init>(int)>(3);	$r2 = <java.lang.Boolean: java.lang.Boolean FALSE>;	$r3 = virtualinvoke $r2.<java.lang.Boolean: java.lang.String toString()>();	interfaceinvoke $r1.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("isserver", $r3);	$r4 = <java.lang.Boolean: java.lang.Boolean TRUE>;	$r5 = virtualinvoke $r4.<java.lang.Boolean: java.lang.String toString()>();	interfaceinvoke $r1.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("is_callback_service", $r5);	if r6 != null goto $r7 = virtualinvoke r6.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("group");	$r56 = null;	goto [?= r8 = $r56];	r8 = $r56;	if $r56 == null goto $r57 = staticinvoke <org.apache.dubbo.common.utils.ClassUtils: java.lang.String[] getDeclaredMethodNames(java.lang.Class)>(r9);	$r57 = staticinvoke <org.apache.dubbo.common.utils.ClassUtils: java.lang.String[] getDeclaredMethodNames(java.lang.Class)>(r9);	$r58 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String join(java.lang.String[],java.lang.String)>($r57, ",");	interfaceinvoke $r1.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("methods", $r58);	$r59 = new java.util.HashMap;	specialinvoke $r59.<java.util.HashMap: void <init>()>();	if r10 == null goto interfaceinvoke $r59.<java.util.Map: void putAll(java.util.Map)>($r1);	interfaceinvoke $r59.<java.util.Map: void putAll(java.util.Map)>($r1);	interfaceinvoke $r59.<java.util.Map: java.lang.Object remove(java.lang.Object)>("version");	interfaceinvoke $r59.<java.util.Map: java.lang.Object remove(java.lang.Object)>("bind.port");	$r61 = virtualinvoke r9.<java.lang.Class: java.lang.String getName()>();	interfaceinvoke $r59.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("interface", $r61);	$r62 = new org.apache.dubbo.common.url.component.ServiceConfigURL;	$r63 = interfaceinvoke r11.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getLocalAddress()>();	$r64 = virtualinvoke $r63.<java.net.InetSocketAddress: java.net.InetAddress getAddress()>();	$r65 = virtualinvoke $r64.<java.net.InetAddress: java.lang.String getHostAddress()>();	$r66 = interfaceinvoke r11.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getLocalAddress()>();	$i2 = virtualinvoke $r66.<java.net.InetSocketAddress: int getPort()>();	$r67 = new java.lang.StringBuilder;	specialinvoke $r67.<java.lang.StringBuilder: void <init>()>();	$r68 = virtualinvoke r9.<java.lang.Class: java.lang.String getName()>();	$r69 = virtualinvoke $r67.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r68);	$r70 = virtualinvoke $r69.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".");	$r71 = virtualinvoke $r70.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r72 = virtualinvoke $r71.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r62.<org.apache.dubbo.common.url.component.ServiceConfigURL: void <init>(java.lang.String,java.lang.String,int,java.lang.String,java.util.Map)>("dubbo", $r65, $i2, $r72, $r59);	$r73 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec: java.lang.String getClientSideCallbackServiceCacheKey(int)>(i0);	$r74 = virtualinvoke r9.<java.lang.Class: java.lang.String getName()>();	$r75 = staticinvoke <org.apache.dubbo.rpc.protocol.dubbo.CallbackServiceCodec: java.lang.String getClientSideCountKey(java.lang.String)>($r74);	$z4 = virtualinvoke r12.<java.lang.Boolean: boolean booleanValue()>();	if $z4 == 0 goto $z0 = interfaceinvoke r11.<org.apache.dubbo.remoting.Channel: boolean hasAttribute(java.lang.String)>($r73);	$z0 = interfaceinvoke r11.<org.apache.dubbo.remoting.Channel: boolean hasAttribute(java.lang.String)>($r73);	if $z0 == 0 goto $r78 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i0);	$r78 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i0);	return $r78
;block_num 7