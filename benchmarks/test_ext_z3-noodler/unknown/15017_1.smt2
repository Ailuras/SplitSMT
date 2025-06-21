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

(declare-sort var279 0)
(declare-sort var943 0)
(declare-sort var1703 0)
(declare-sort var2396 0)
(declare-sort var3393 0)
(declare-sort var1531 0)
(declare-sort var1904 0)
(declare-sort var3668 0)
(declare-sort var1373 0)
(declare-sort var209 0)
(declare-sort var3025 0)
(declare-sort var159 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1703_notNull/751190363 (var2396 String) void)
(declare-fun cast-from-var943-to-var2396 (var943) var2396)
(declare-fun var943_size/-959786421 (var943) Int)
(declare-fun var943_get/-1216255739 (var943 Int) var2396)
(declare-fun cast-from-var2396-to-var3393 (var2396) var3393)
(declare-fun getProtocol/491749358 (var3393) String)
(declare-fun var1531_emptyList/-142670980 () var1531)
(declare-fun var3668_bootstrap$/325012201 (var279) var1904)
(declare-fun refreshRouter/-887806803 (var1373 var1531 var1904) void)
(declare-fun cast-from-var279-to-var1373 (var279) var1373)
(declare-fun destroyAllInvokers/-712141914 (var279) void)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getConsumerUrl/1674456727 (var3025) var3393)
(declare-fun cast-from-var279-to-var3025 (var279) var3025)
(declare-fun getServiceKey/1456125852 (var3393) String)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun getInvokers/-1026765557 (var1373) var1531)
(declare-fun size/306862997 (var1531) Int)
(declare-fun getValidInvokers/-1541930559 (var1373) var1531)
(declare-fun joinValidInvokerAddresses/1128379477 (var1373) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var159_info/484404803 (var159 String) void)
(declare-fun cast-from-var209-to-var159 (var209) var159)
(declare-const null-var279 var279)
(declare-const null-var943 var943)
(declare-const null-var2396 var2396)
(declare-const var279-logger var209)
(declare-const var16 var279) ; Statement: r0 := @this: org.apache.dubbo.registry.integration.RegistryDirectory 
(assert (not (= var16 null-var279)))
(declare-const var257 var943) ; Statement: r39 := @parameter0: java.util.List 
(assert (not (= var257 null-var943)))
;(assert (var1703_notNull/751190363 (cast-from-var943-to-var2396 var257) "invokerUrls should not be null")) ; Statement: staticinvoke <org.apache.dubbo.common.utils.Assert: void notNull(java.lang.Object,java.lang.String)>(r39, "invokerUrls should not be null") 

(declare-const var257!1 var943)
(declare-const var3144 String)
(define-const var173 Int (var943_size/-959786421 var257!1)) ; Statement: $i0 = interfaceinvoke r39.<java.util.List: int size()>() 
 ; Statement: if $i0 != 1 goto r0.<org.apache.dubbo.registry.integration.RegistryDirectory: boolean forbidden> = 0 
(assert (not (not (= var173 1)))) ; Negate: Cond: $i0 != 1  
(define-const var3445 var2396 (var943_get/-1216255739 var257!1 0)) ; Statement: $r30 = interfaceinvoke r39.<java.util.List: java.lang.Object get(int)>(0) 
 ; Statement: if $r30 == null goto r0.<org.apache.dubbo.registry.integration.RegistryDirectory: boolean forbidden> = 0 
(assert (not (= var3445 null-var2396))) ; Negate: Cond: $r30 == null  
(define-const var1187 String "empty") ; Statement: $r34 = "empty" 
(define-const var896 var2396 (var943_get/-1216255739 var257!1 0)) ; Statement: $r31 = interfaceinvoke r39.<java.util.List: java.lang.Object get(int)>(0) 
(define-const var3673 var3393 (cast-from-var2396-to-var3393 var896)) ; Statement: $r32 = (org.apache.dubbo.common.URL) $r31 
(assert true)
(define-const var659 String (getProtocol/491749358 var3673)) ; Statement: $r33 = virtualinvoke $r32.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(assert true)
(define-const var628 Bool (= var1187 var659)) ; Statement: $z4 = virtualinvoke $r34.<java.lang.String: boolean equals(java.lang.Object)>($r33) 
 ; Statement: if $z4 == 0 goto r0.<org.apache.dubbo.registry.integration.RegistryDirectory: boolean forbidden> = 0 
(assert (not (= (ite var628 1 0) 0))) ; Negate: Cond: $z4 == 0  
(define-const var2720 var1531 var1531_emptyList/-142670980) ; Statement: $r36 = staticinvoke <org.apache.dubbo.rpc.cluster.router.state.BitList: org.apache.dubbo.rpc.cluster.router.state.BitList emptyList()>() 
(define-const var3195 var1904 (var3668_bootstrap$/325012201 var16)) ; Statement: $r35 = staticinvoke <org.apache.dubbo.registry.integration.RegistryDirectory$lambda_refreshInvoker_3__1092: java.lang.Runnable bootstrap$(org.apache.dubbo.registry.integration.RegistryDirectory)>(r0) 
(assert true)
;(assert (refreshRouter/-887806803 (cast-from-var279-to-var1373 var16) var2720 var3195)) ; Statement: virtualinvoke r0.<org.apache.dubbo.registry.integration.RegistryDirectory: void refreshRouter(org.apache.dubbo.rpc.cluster.router.state.BitList,java.lang.Runnable)>($r36, $r35) 

(declare-const var16!1 var279)
(declare-const var2720!1 var1531)
(declare-const var3195!1 var1904)
(assert true)
;(assert (destroyAllInvokers/-712141914 var16!1)) ; Statement: virtualinvoke r0.<org.apache.dubbo.registry.integration.RegistryDirectory: void destroyAllInvokers()>() 

(declare-const var16!2 var279)
 ; Statement: goto [?= $r43 = <org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>] 
(assert true) ; Non Conditional
(define-const var361 var209 var279-logger) ; Statement: $r43 = <org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var3385 String String-init) ; Statement: $r44 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3385)) ; Statement: specialinvoke $r44.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3385!1 String)
(assert (= var3385!1 ""))
(assert true)
(define-const var1200 String (append/672562846 var3385!1 "Received invokers changed event from registry. Registry type: interface. Service Key: ")) ; Statement: $r45 = virtualinvoke $r44.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Received invokers changed event from registry. Registry type: interface. Service Key: ") 
(declare-const var3385!2 String)
(assert (= var3385!2 (str.++ var3385!1 "Received invokers changed event from registry. Registry type: interface. Service Key: ")))
(assert true)
(define-const var3249 var3393 (getConsumerUrl/1674456727 (cast-from-var279-to-var3025 var16!2))) ; Statement: $r46 = virtualinvoke r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.common.URL getConsumerUrl()>() 
(assert true)
(define-const var3749 String (getServiceKey/1456125852 var3249)) ; Statement: $r47 = virtualinvoke $r46.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>() 
(assert true)
(define-const var2226 String (append/672562846 var1200 var3749)) ; Statement: $r48 = virtualinvoke $r45.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r47) 
(declare-const var1200!1 String)
(assert (= var1200!1 (str.++ var1200 var3749)))
(assert true)
(define-const var1337 String (append/672562846 var2226 ". Urls Size : ")) ; Statement: $r49 = virtualinvoke $r48.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(". Urls Size : ") 
(declare-const var2226!1 String)
(assert (= var2226!1 (str.++ var2226 ". Urls Size : ")))
(define-const var2000 Int (var943_size/-959786421 var257!1)) ; Statement: $i4 = interfaceinvoke r39.<java.util.List: int size()>() 
(assert true)
(define-const var1461 String (append/-1001720160 var1337 var2000)) ; Statement: $r50 = virtualinvoke $r49.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i4) 
(declare-const var1337!1 String)
(assert (str.prefixof var1337 var1337!1))
(assert true)
(define-const var3406 String (append/672562846 var1461 ". Invokers Size : ")) ; Statement: $r51 = virtualinvoke $r50.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(". Invokers Size : ") 
(declare-const var1461!1 String)
(assert (= var1461!1 (str.++ var1461 ". Invokers Size : ")))
(assert true)
(define-const var3636 var1531 (getInvokers/-1026765557 (cast-from-var279-to-var1373 var16!2))) ; Statement: $r52 = virtualinvoke r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.rpc.cluster.router.state.BitList getInvokers()>() 
(assert true)
(define-const var2423 Int (size/306862997 var3636)) ; Statement: $i5 = virtualinvoke $r52.<org.apache.dubbo.rpc.cluster.router.state.BitList: int size()>() 
(assert true)
(define-const var1580 String (append/-1001720160 var3406 var2423)) ; Statement: $r53 = virtualinvoke $r51.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i5) 
(declare-const var3406!1 String)
(assert (str.prefixof var3406 var3406!1))
(assert true)
(define-const var938 String (append/672562846 var1580 ". Available Size: ")) ; Statement: $r54 = virtualinvoke $r53.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(". Available Size: ") 
(declare-const var1580!1 String)
(assert (= var1580!1 (str.++ var1580 ". Available Size: ")))
(assert true)
(define-const var1656 var1531 (getValidInvokers/-1541930559 (cast-from-var279-to-var1373 var16!2))) ; Statement: $r55 = virtualinvoke r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.rpc.cluster.router.state.BitList getValidInvokers()>() 
(assert true)
(define-const var189 Int (size/306862997 var1656)) ; Statement: $i6 = virtualinvoke $r55.<org.apache.dubbo.rpc.cluster.router.state.BitList: int size()>() 
(assert true)
(define-const var274 String (append/-1001720160 var938 var189)) ; Statement: $r56 = virtualinvoke $r54.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i6) 
(declare-const var938!1 String)
(assert (str.prefixof var938 var938!1))
(assert true)
(define-const var3412 String (append/672562846 var274 ". Available Invokers : ")) ; Statement: $r57 = virtualinvoke $r56.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(". Available Invokers : ") 
(declare-const var274!1 String)
(assert (= var274!1 (str.++ var274 ". Available Invokers : ")))
(assert true)
(define-const var3276 String (joinValidInvokerAddresses/1128379477 (cast-from-var279-to-var1373 var16!2))) ; Statement: $r58 = virtualinvoke r0.<org.apache.dubbo.registry.integration.RegistryDirectory: java.lang.String joinValidInvokerAddresses()>() 
(assert true)
(define-const var639 String (append/672562846 var3412 var3276)) ; Statement: $r59 = virtualinvoke $r57.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r58) 
(declare-const var3412!1 String)
(assert (= var3412!1 (str.++ var3412 var3276)))
(assert true)
(define-const var3764 String (toString/-2075883882 var639)) ; Statement: $r60 = virtualinvoke $r59.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var159_info/484404803 (cast-from-var209-to-var159 var361) var3764)) ; Statement: interfaceinvoke $r43.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r60) 

(declare-const var361!1 var209)
(declare-const var3764!1 String)
 ; Statement: return 
(check-sat)
; {var1703_notNull/751190363=([java.lang.Object, java.lang.String], void), cast-from-var943-to-var2396=([java.util.List], java.lang.Object), var943_size/-959786421=([java.util.List], int), var943_get/-1216255739=([java.util.List, int], java.lang.Object), cast-from-var2396-to-var3393=([java.lang.Object], org.apache.dubbo.common.URL), getProtocol/491749358=([org.apache.dubbo.common.URL], java.lang.String), var1531_emptyList/-142670980=([], org.apache.dubbo.rpc.cluster.router.state.BitList), var3668_bootstrap$/325012201=([org.apache.dubbo.registry.integration.RegistryDirectory], java.lang.Runnable), refreshRouter/-887806803=([org.apache.dubbo.rpc.cluster.directory.AbstractDirectory, org.apache.dubbo.rpc.cluster.router.state.BitList, java.lang.Runnable], void), cast-from-var279-to-var1373=([org.apache.dubbo.registry.integration.RegistryDirectory], org.apache.dubbo.rpc.cluster.directory.AbstractDirectory), destroyAllInvokers/-712141914=([org.apache.dubbo.registry.integration.RegistryDirectory], void), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getConsumerUrl/1674456727=([org.apache.dubbo.registry.integration.DynamicDirectory], org.apache.dubbo.common.URL), cast-from-var279-to-var3025=([org.apache.dubbo.registry.integration.RegistryDirectory], org.apache.dubbo.registry.integration.DynamicDirectory), getServiceKey/1456125852=([org.apache.dubbo.common.URL], java.lang.String), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), getInvokers/-1026765557=([org.apache.dubbo.rpc.cluster.directory.AbstractDirectory], org.apache.dubbo.rpc.cluster.router.state.BitList), size/306862997=([org.apache.dubbo.rpc.cluster.router.state.BitList], int), getValidInvokers/-1541930559=([org.apache.dubbo.rpc.cluster.directory.AbstractDirectory], org.apache.dubbo.rpc.cluster.router.state.BitList), joinValidInvokerAddresses/1128379477=([org.apache.dubbo.rpc.cluster.directory.AbstractDirectory], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var159_info/484404803=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), cast-from-var209-to-var159=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger)}
; {var279=org.apache.dubbo.registry.integration.RegistryDirectory, var16=r0, var943=java.util.List, var257=r39, var1703=org.apache.dubbo.common.utils.Assert, var2396=java.lang.Object, var3144="invokerUrls should not be null", var173=$i0, var3445=$r30, var1187=$r34, var896=$r31, var3393=org.apache.dubbo.common.URL, var3673=$r32, var659=$r33, var628=$z4, var1531=org.apache.dubbo.rpc.cluster.router.state.BitList, var2720=$r36, var1904=java.lang.Runnable, var3668=org.apache.dubbo.registry.integration.RegistryDirectory$lambda_refreshInvoker_3__1092, var3195=$r35, var1373=org.apache.dubbo.rpc.cluster.directory.AbstractDirectory, var209=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var361=$r43, var3385=$r44, var1200=$r45, var3025=org.apache.dubbo.registry.integration.DynamicDirectory, var3249=$r46, var3749=$r47, var2226=$r48, var1337=$r49, var2000=$i4, var1461=$r50, var3406=$r51, var3636=$r52, var2423=$i5, var1580=$r53, var938=$r54, var1656=$r55, var189=$i6, var274=$r56, var3412=$r57, var3276=$r58, var639=$r59, var3764=$r60, var159=org.apache.dubbo.common.logger.Logger}
; {org.apache.dubbo.registry.integration.RegistryDirectory=var279, r0=var16, java.util.List=var943, r39=var257, org.apache.dubbo.common.utils.Assert=var1703, java.lang.Object=var2396, "invokerUrls should not be null"=var3144, $i0=var173, $r30=var3445, $r34=var1187, $r31=var896, org.apache.dubbo.common.URL=var3393, $r32=var3673, $r33=var659, $z4=var628, org.apache.dubbo.rpc.cluster.router.state.BitList=var1531, $r36=var2720, java.lang.Runnable=var1904, org.apache.dubbo.registry.integration.RegistryDirectory$lambda_refreshInvoker_3__1092=var3668, $r35=var3195, org.apache.dubbo.rpc.cluster.directory.AbstractDirectory=var1373, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var209, $r43=var361, $r44=var3385, $r45=var1200, org.apache.dubbo.registry.integration.DynamicDirectory=var3025, $r46=var3249, $r47=var3749, $r48=var2226, $r49=var1337, $i4=var2000, $r50=var1461, $r51=var3406, $r52=var3636, $i5=var2423, $r53=var1580, $r54=var938, $r55=var1656, $i6=var189, $r56=var274, $r57=var3412, $r58=var3276, $r59=var639, $r60=var3764, org.apache.dubbo.common.logger.Logger=var159}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 7,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.integration.RegistryDirectory;	r39 := @parameter0: java.util.List;	staticinvoke <org.apache.dubbo.common.utils.Assert: void notNull(java.lang.Object,java.lang.String)>(r39, "invokerUrls should not be null");	$i0 = interfaceinvoke r39.<java.util.List: int size()>();	if $i0 != 1 goto r0.<org.apache.dubbo.registry.integration.RegistryDirectory: boolean forbidden> = 0;	$r30 = interfaceinvoke r39.<java.util.List: java.lang.Object get(int)>(0);	if $r30 == null goto r0.<org.apache.dubbo.registry.integration.RegistryDirectory: boolean forbidden> = 0;	$r34 = "empty";	$r31 = interfaceinvoke r39.<java.util.List: java.lang.Object get(int)>(0);	$r32 = (org.apache.dubbo.common.URL) $r31;	$r33 = virtualinvoke $r32.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	$z4 = virtualinvoke $r34.<java.lang.String: boolean equals(java.lang.Object)>($r33);	if $z4 == 0 goto r0.<org.apache.dubbo.registry.integration.RegistryDirectory: boolean forbidden> = 0;	$r36 = staticinvoke <org.apache.dubbo.rpc.cluster.router.state.BitList: org.apache.dubbo.rpc.cluster.router.state.BitList emptyList()>();	$r35 = staticinvoke <org.apache.dubbo.registry.integration.RegistryDirectory$lambda_refreshInvoker_3__1092: java.lang.Runnable bootstrap$(org.apache.dubbo.registry.integration.RegistryDirectory)>(r0);	virtualinvoke r0.<org.apache.dubbo.registry.integration.RegistryDirectory: void refreshRouter(org.apache.dubbo.rpc.cluster.router.state.BitList,java.lang.Runnable)>($r36, $r35);	virtualinvoke r0.<org.apache.dubbo.registry.integration.RegistryDirectory: void destroyAllInvokers()>();	goto [?= $r43 = <org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>];	$r43 = <org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r44 = new java.lang.StringBuilder;	specialinvoke $r44.<java.lang.StringBuilder: void <init>()>();	$r45 = virtualinvoke $r44.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Received invokers changed event from registry. Registry type: interface. Service Key: ");	$r46 = virtualinvoke r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.common.URL getConsumerUrl()>();	$r47 = virtualinvoke $r46.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>();	$r48 = virtualinvoke $r45.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r47);	$r49 = virtualinvoke $r48.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(". Urls Size : ");	$i4 = interfaceinvoke r39.<java.util.List: int size()>();	$r50 = virtualinvoke $r49.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i4);	$r51 = virtualinvoke $r50.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(". Invokers Size : ");	$r52 = virtualinvoke r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.rpc.cluster.router.state.BitList getInvokers()>();	$i5 = virtualinvoke $r52.<org.apache.dubbo.rpc.cluster.router.state.BitList: int size()>();	$r53 = virtualinvoke $r51.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i5);	$r54 = virtualinvoke $r53.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(". Available Size: ");	$r55 = virtualinvoke r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.rpc.cluster.router.state.BitList getValidInvokers()>();	$i6 = virtualinvoke $r55.<org.apache.dubbo.rpc.cluster.router.state.BitList: int size()>();	$r56 = virtualinvoke $r54.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i6);	$r57 = virtualinvoke $r56.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(". Available Invokers : ");	$r58 = virtualinvoke r0.<org.apache.dubbo.registry.integration.RegistryDirectory: java.lang.String joinValidInvokerAddresses()>();	$r59 = virtualinvoke $r57.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r58);	$r60 = virtualinvoke $r59.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r43.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r60);	return
;block_num 5