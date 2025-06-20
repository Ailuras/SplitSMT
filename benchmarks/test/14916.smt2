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

(declare-sort var171 0)
(declare-sort var3976 0)
(declare-sort var2915 0)
(declare-sort var3624 0)
(declare-sort var2493 0)
(declare-sort var630 0)
(declare-sort var2534 0)
(declare-sort var593 0)
(declare-sort var3614 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun forbidden/2129308851 (var171) Bool)
(declare-fun shouldFailFast/2129308851 (var171) Bool)
(declare-fun var2493-init () var2493)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var630) String)
(declare-fun cast-from-var171-to-var630 (var171) var630)
(declare-fun getConsumerUrl/1674456727 (var171) var2534)
(declare-fun getServiceKey/1456125852 (var2534) String)
(declare-fun var593_getLocalHost/-1653363627 () String)
(declare-fun var3614_getVersion/310196261 () String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/1027821060 (var2493 Int String) void)
(declare-const null-var171 var171)
(declare-const null-var3976 var3976)
(declare-const null-var2915 var2915)
(declare-const null-var3624 var3624)
(declare-const var136 var171) ; Statement: r0 := @this: org.apache.dubbo.registry.integration.DynamicDirectory 
(assert (not (= var136 null-var171)))
(declare-const var3899 var3976) ; Statement: r1 := @parameter0: org.apache.dubbo.rpc.cluster.SingleRouterChain 
(assert (not (= var3899 null-var3976)))
(declare-const var1173 var2915) ; Statement: r2 := @parameter1: org.apache.dubbo.rpc.cluster.router.state.BitList 
(assert (not (= var1173 null-var2915)))
(declare-const var1693 var3624) ; Statement: r3 := @parameter2: org.apache.dubbo.rpc.Invocation 
(assert (not (= var1693 null-var3624)))
(define-const var3261 Bool (forbidden/2129308851 var136)) ; Statement: $z0 = r0.<org.apache.dubbo.registry.integration.DynamicDirectory: boolean forbidden> 
 ; Statement: if $z0 == 0 goto $z1 = r0.<org.apache.dubbo.registry.integration.DynamicDirectory: boolean multiGroup> 
(assert (not (= (ite var3261 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var770 Bool (shouldFailFast/2129308851 var136)) ; Statement: $z2 = r0.<org.apache.dubbo.registry.integration.DynamicDirectory: boolean shouldFailFast> 
 ; Statement: if $z2 == 0 goto $z1 = r0.<org.apache.dubbo.registry.integration.DynamicDirectory: boolean multiGroup> 
(assert (not (= (ite var770 1 0) 0))) ; Negate: Cond: $z2 == 0  
(define-const var3877 var2493 var2493-init) ; Statement: $r6 = new org.apache.dubbo.rpc.RpcException 
(define-const var3562 String String-init) ; Statement: $r7 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3562)) ; Statement: specialinvoke $r7.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3562!1 String)
(assert (= var3562!1 ""))
(assert true)
(define-const var2405 String (append/672562846 var3562!1 "No provider available from registry ")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("No provider available from registry ") 
(declare-const var3562!2 String)
(assert (= var3562!2 (str.++ var3562!1 "No provider available from registry ")))
(assert true)
(define-const var1547 String (append/-1031950772 var2405 (cast-from-var171-to-var630 var136))) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0) 
(declare-const var2405!1 String)
(assert (str.prefixof var2405 var2405!1))
(assert true)
(define-const var1052 String (append/672562846 var1547 " for service ")) ; Statement: $r12 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" for service ") 
(declare-const var1547!1 String)
(assert (= var1547!1 (str.++ var1547 " for service ")))
(assert true)
(define-const var3845 var2534 (getConsumerUrl/1674456727 var136)) ; Statement: $r10 = virtualinvoke r0.<org.apache.dubbo.registry.integration.DynamicDirectory: org.apache.dubbo.common.URL getConsumerUrl()>() 
(assert true)
(define-const var2443 String (getServiceKey/1456125852 var3845)) ; Statement: $r11 = virtualinvoke $r10.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>() 
(assert true)
(define-const var258 String (append/672562846 var1052 var2443)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r11) 
(declare-const var1052!1 String)
(assert (= var1052!1 (str.++ var1052 var2443)))
(assert true)
(define-const var1618 String (append/672562846 var258 " on consumer ")) ; Statement: $r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" on consumer ") 
(declare-const var258!1 String)
(assert (= var258!1 (str.++ var258 " on consumer ")))
(define-const var559 String var593_getLocalHost/-1653363627) ; Statement: $r14 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHost()>() 
(assert true)
(define-const var421 String (append/672562846 var1618 var559)) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r14) 
(declare-const var1618!1 String)
(assert (= var1618!1 (str.++ var1618 var559)))
(assert true)
(define-const var2267 String (append/672562846 var421 " use dubbo version ")) ; Statement: $r18 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" use dubbo version ") 
(declare-const var421!1 String)
(assert (= var421!1 (str.++ var421 " use dubbo version ")))
(define-const var702 String var3614_getVersion/310196261) ; Statement: $r17 = staticinvoke <org.apache.dubbo.common.Version: java.lang.String getVersion()>() 
(assert true)
(define-const var2553 String (append/672562846 var2267 var702)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r17) 
(declare-const var2267!1 String)
(assert (= var2267!1 (str.++ var2267 var702)))
(assert true)
(define-const var3706 String (append/672562846 var2553 ", please check status of providers(disabled, not registered or in blocklist).")) ; Statement: $r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", please check status of providers(disabled, not registered or in blocklist).") 
(declare-const var2553!1 String)
(assert (= var2553!1 (str.++ var2553 ", please check status of providers(disabled, not registered or in blocklist).")))
(assert true)
(define-const var3124 String (toString/-2075883882 var3706)) ; Statement: $r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/1027821060 var3877 4 var3124)) ; Statement: specialinvoke $r6.<org.apache.dubbo.rpc.RpcException: void <init>(int,java.lang.String)>(4, $r21) 

(declare-const var3877!1 var2493)
(declare-const var2792 Int)
(declare-const var3124!1 String)
 ; Statement: throw $r6 
(check-sat)
; {forbidden/2129308851=([org.apache.dubbo.registry.integration.DynamicDirectory], boolean), shouldFailFast/2129308851=([org.apache.dubbo.registry.integration.DynamicDirectory], boolean), var2493-init=([], org.apache.dubbo.rpc.RpcException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var171-to-var630=([org.apache.dubbo.registry.integration.DynamicDirectory], java.lang.Object), getConsumerUrl/1674456727=([org.apache.dubbo.registry.integration.DynamicDirectory], org.apache.dubbo.common.URL), getServiceKey/1456125852=([org.apache.dubbo.common.URL], java.lang.String), var593_getLocalHost/-1653363627=([], java.lang.String), var3614_getVersion/310196261=([], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/1027821060=([org.apache.dubbo.rpc.RpcException, int, java.lang.String], void)}
; {var171=org.apache.dubbo.registry.integration.DynamicDirectory, var136=r0, var3976=org.apache.dubbo.rpc.cluster.SingleRouterChain, var3899=r1, var2915=org.apache.dubbo.rpc.cluster.router.state.BitList, var1173=r2, var3624=org.apache.dubbo.rpc.Invocation, var1693=r3, var3261=$z0, var770=$z2, var2493=org.apache.dubbo.rpc.RpcException, var3877=$r6, var3562=$r7, var2405=$r8, var630=java.lang.Object, var1547=$r9, var1052=$r12, var2534=org.apache.dubbo.common.URL, var3845=$r10, var2443=$r11, var258=$r13, var1618=$r15, var593=org.apache.dubbo.common.utils.NetUtils, var559=$r14, var421=$r16, var2267=$r18, var3614=org.apache.dubbo.common.Version, var702=$r17, var2553=$r19, var3706=$r20, var3124=$r21, var2792=4}
; {org.apache.dubbo.registry.integration.DynamicDirectory=var171, r0=var136, org.apache.dubbo.rpc.cluster.SingleRouterChain=var3976, r1=var3899, org.apache.dubbo.rpc.cluster.router.state.BitList=var2915, r2=var1173, org.apache.dubbo.rpc.Invocation=var3624, r3=var1693, $z0=var3261, $z2=var770, org.apache.dubbo.rpc.RpcException=var2493, $r6=var3877, $r7=var3562, $r8=var2405, java.lang.Object=var630, $r9=var1547, $r12=var1052, org.apache.dubbo.common.URL=var2534, $r10=var3845, $r11=var2443, $r13=var258, $r15=var1618, org.apache.dubbo.common.utils.NetUtils=var593, $r14=var559, $r16=var421, $r18=var2267, org.apache.dubbo.common.Version=var3614, $r17=var702, $r19=var2553, $r20=var3706, $r21=var3124, 4=var2792}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 8,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.integration.DynamicDirectory;	r1 := @parameter0: org.apache.dubbo.rpc.cluster.SingleRouterChain;	r2 := @parameter1: org.apache.dubbo.rpc.cluster.router.state.BitList;	r3 := @parameter2: org.apache.dubbo.rpc.Invocation;	$z0 = r0.<org.apache.dubbo.registry.integration.DynamicDirectory: boolean forbidden>;	if $z0 == 0 goto $z1 = r0.<org.apache.dubbo.registry.integration.DynamicDirectory: boolean multiGroup>;	$z2 = r0.<org.apache.dubbo.registry.integration.DynamicDirectory: boolean shouldFailFast>;	if $z2 == 0 goto $z1 = r0.<org.apache.dubbo.registry.integration.DynamicDirectory: boolean multiGroup>;	$r6 = new org.apache.dubbo.rpc.RpcException;	$r7 = new java.lang.StringBuilder;	specialinvoke $r7.<java.lang.StringBuilder: void <init>()>();	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("No provider available from registry ");	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0);	$r12 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" for service ");	$r10 = virtualinvoke r0.<org.apache.dubbo.registry.integration.DynamicDirectory: org.apache.dubbo.common.URL getConsumerUrl()>();	$r11 = virtualinvoke $r10.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>();	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r11);	$r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" on consumer ");	$r14 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHost()>();	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r14);	$r18 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" use dubbo version ");	$r17 = staticinvoke <org.apache.dubbo.common.Version: java.lang.String getVersion()>();	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r17);	$r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", please check status of providers(disabled, not registered or in blocklist).");	$r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r6.<org.apache.dubbo.rpc.RpcException: void <init>(int,java.lang.String)>(4, $r21);	throw $r6
;block_num 3