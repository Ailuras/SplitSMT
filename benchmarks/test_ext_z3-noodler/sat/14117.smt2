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

(declare-sort var1847 0)
(declare-sort var1956 0)
(declare-sort var1813 0)
(declare-sort var3048 0)
(declare-sort var2769 0)
(declare-sort var2447 0)
(declare-sort var385 0)
(declare-sort var3082 0)
(declare-sort var2938 0)
(declare-sort var965 0)
(declare-sort var2108 0)
(declare-sort var3465 0)
(declare-sort var1109 0)
(declare-sort var2129 0)
(declare-sort var3146 0)
(declare-sort var1396 0)
(declare-sort var870 0)
(declare-sort var1206 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var3465!class ClassObject)
(declare-fun <init>/-726220000 (var1813 ClassObject var1956) void)
(declare-fun cast-from-var1847-to-var1813 (var1847) var1813)
(declare-fun enableConfigurationListen/1962874429 (var1847) Bool)
(declare-fun originalUrls/1962874429 (var1847) var3048)
(declare-fun var2769-init () var2769)
(declare-fun <init>/-2175807 (var2769) void)
(declare-fun cast-from-var2769-to-var2447 (var2769) var2447)
(declare-fun customizedConsumerUrlMap/1962874429 (var1847) var2447)
(declare-fun getScopeModel/-1957927771 (var1956) var385)
(declare-fun var2938_getModuleModel/430886367 (var385) var3082)
(declare-fun moduleModel/1962874429 (var1847) var3082)
(declare-fun getOrDefaultApplicationModel/-1374397043 (var1956) var965)
(declare-fun getExtensionLoader/-514331157 (var1109 ClassObject) var2108)
(declare-fun cast-from-var965-to-var1109 (var965) var1109)
(declare-fun getSupportedExtensionInstances/322061016 (var2108) var2129)
(declare-fun var3146_isEmpty/73262611 (var1396) Bool)
(declare-fun cast-from-var2129-to-var1396 (var2129) var1396)
(declare-fun providerFirstParams/1962874429 (var1847) var2129)
(declare-fun consumerUrl/-1577131577 (var870) var1956)
(declare-fun cast-from-var1847-to-var870 (var1847) var870)
(declare-fun getProtocol/491749358 (var1956) String)
(declare-fun getParameter/506106603 (var1956 String String) String)
(declare-fun var1206-init () var1206)
(declare-fun getServiceInterface/-1311863806 (var1956) String)
(declare-fun getVersion/189836348 (var1956) String)
(declare-fun getGroup/1342955253 (var1956) String)
(declare-fun <init>/-1421662058 (var1206 String String String String) void)
(declare-fun consumerProtocolServiceKey/1962874429 (var1847) var1206)
(declare-const null-var1847 var1847)
(declare-const null-ClassObject ClassObject)
(declare-const null-var1956 var1956)
(declare-const null-var3048 var3048)
(declare-const null-var2129 var2129)
(declare-const var145 var1847) ; Statement: r0 := @this: org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory 
(assert (not (= var145 null-var1847)))
(declare-const var108 ClassObject) ; Statement: r1 := @parameter0: java.lang.Class 
(assert (not (= var108 null-ClassObject)))
(declare-const var3178 var1956) ; Statement: r2 := @parameter1: org.apache.dubbo.common.URL 
(assert (not (= var3178 null-var1956)))
(assert true)
;(assert (<init>/-726220000 (cast-from-var1847-to-var1813 var145) var108 var3178)) ; Statement: specialinvoke r0.<org.apache.dubbo.registry.integration.DynamicDirectory: void <init>(java.lang.Class,org.apache.dubbo.common.URL)>(r1, r2) 

(declare-const var145!1 var1847)
(declare-const var108!1 ClassObject)
(declare-const var3178!1 var1956)
(declare-const var145!2 var1847)
(assert (not (= var145!2 null-var1847)))
(assert (= (enableConfigurationListen/1962874429 var145!2) (ite (= 1 1) true false))) ; Statement: r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: boolean enableConfigurationListen> = 1 
(declare-const var145!3 var1847)
(assert (not (= var145!3 null-var1847)))
(assert (= (originalUrls/1962874429 var145!3) null-var3048)) ; Statement: r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: java.util.List originalUrls> = null 
(define-const var1962 var2769 var2769-init) ; Statement: $r3 = new java.util.concurrent.ConcurrentHashMap 
(assert true)
;(assert (<init>/-2175807 var1962)) ; Statement: specialinvoke $r3.<java.util.concurrent.ConcurrentHashMap: void <init>()>() 

(declare-const var1962!1 var2769)
(declare-const var145!4 var1847)
(assert (not (= var145!4 null-var1847)))
(assert (= (customizedConsumerUrlMap/1962874429 var145!4) (cast-from-var2769-to-var2447 var1962!1))) ; Statement: r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: java.util.concurrent.ConcurrentMap customizedConsumerUrlMap> = $r3 
(assert true)
(define-const var2822 var385 (getScopeModel/-1957927771 var3178!1)) ; Statement: $r4 = virtualinvoke r2.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ScopeModel getScopeModel()>() 
(define-const var3873 var3082 (var2938_getModuleModel/430886367 var2822)) ; Statement: $r5 = staticinvoke <org.apache.dubbo.rpc.model.ScopeModelUtil: org.apache.dubbo.rpc.model.ModuleModel getModuleModel(org.apache.dubbo.rpc.model.ScopeModel)>($r4) 
(declare-const var145!5 var1847)
(assert (not (= var145!5 null-var1847)))
(assert (= (moduleModel/1962874429 var145!5) var3873)) ; Statement: r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.rpc.model.ModuleModel moduleModel> = $r5 
(assert true)
(define-const var2187 var965 (getOrDefaultApplicationModel/-1374397043 var3178!1)) ; Statement: $r6 = virtualinvoke r2.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ApplicationModel getOrDefaultApplicationModel()>() 
(assert true)
(define-const var747 var2108 (getExtensionLoader/-514331157 (cast-from-var965-to-var1109 var2187) var3465!class)) ; Statement: $r7 = virtualinvoke $r6.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/registry/ProviderFirstParams;") 
(assert true)
(define-const var334 var2129 (getSupportedExtensionInstances/322061016 var747)) ; Statement: r8 = virtualinvoke $r7.<org.apache.dubbo.common.extension.ExtensionLoader: java.util.Set getSupportedExtensionInstances()>() 
(define-const var613 Bool (var3146_isEmpty/73262611 (cast-from-var2129-to-var1396 var334))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>(r8) 
 ; Statement: if $z0 == 0 goto $i0 = interfaceinvoke r8.<java.util.Set: int size()>() 
(assert (not (= (ite var613 1 0) 0))) ; Negate: Cond: $z0 == 0  
(declare-const var145!6 var1847)
(assert (not (= var145!6 null-var1847)))
(assert (= (providerFirstParams/1962874429 var145!6) null-var2129)) ; Statement: r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: java.util.Set providerFirstParams> = null 
 ; Statement: goto [?= $r25 = r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.common.URL consumerUrl>] 
(assert true) ; Non Conditional
(define-const var3505 var1956 (consumerUrl/-1577131577 (cast-from-var1847-to-var870 var145!6))) ; Statement: $r25 = r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.common.URL consumerUrl> 
(define-const var1192 var1956 (consumerUrl/-1577131577 (cast-from-var1847-to-var870 var145!6))) ; Statement: $r26 = r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.common.URL consumerUrl> 
(assert true)
(define-const var163 String (getProtocol/491749358 var1192)) ; Statement: $r27 = virtualinvoke $r26.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(assert true)
(define-const var1545 String (getParameter/506106603 var3505 "protocol" var163)) ; Statement: $r28 = virtualinvoke $r25.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("protocol", $r27) 
(define-const var738 var1206 var1206-init) ; Statement: $r12 = new org.apache.dubbo.common.ProtocolServiceKey 
(define-const var1333 var1956 (consumerUrl/-1577131577 (cast-from-var1847-to-var870 var145!6))) ; Statement: $r29 = r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.common.URL consumerUrl> 
(assert true)
(define-const var2930 String (getServiceInterface/-1311863806 var1333)) ; Statement: $r15 = virtualinvoke $r29.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>() 
(define-const var3044 var1956 (consumerUrl/-1577131577 (cast-from-var1847-to-var870 var145!6))) ; Statement: $r30 = r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.common.URL consumerUrl> 
(assert true)
(define-const var554 String (getVersion/189836348 var3044)) ; Statement: $r14 = virtualinvoke $r30.<org.apache.dubbo.common.URL: java.lang.String getVersion()>() 
(define-const var2356 var1956 (consumerUrl/-1577131577 (cast-from-var1847-to-var870 var145!6))) ; Statement: $r31 = r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.common.URL consumerUrl> 
(assert true)
(define-const var2642 String (getGroup/1342955253 var2356)) ; Statement: $r13 = virtualinvoke $r31.<org.apache.dubbo.common.URL: java.lang.String getGroup()>() 
(define-const var3454 String "consumer") ; Statement: $r32 = "consumer" 
(assert true)
(define-const var2643 Bool (= var3454 var1545)) ; Statement: $z2 = virtualinvoke $r32.<java.lang.String: boolean equals(java.lang.Object)>($r28) 
 ; Statement: if $z2 != 0 goto $r33 = null 
(assert (not (not (= (ite var2643 1 0) 0)))) ; Negate: Cond: $z2 != 0  
(define-const var422 String var1545) ; Statement: $r33 = $r28 
 ; Statement: goto [?= specialinvoke $r12.<org.apache.dubbo.common.ProtocolServiceKey: void <init>(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>($r15, $r14, $r13, $r33)] 
(assert true) ; Non Conditional
(assert true)
;(assert (<init>/-1421662058 var738 var2930 var554 var2642 var422)) ; Statement: specialinvoke $r12.<org.apache.dubbo.common.ProtocolServiceKey: void <init>(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>($r15, $r14, $r13, $r33) 

(declare-const var738!1 var1206)
(declare-const var2930!1 String)
(declare-const var554!1 String)
(declare-const var2642!1 String)
(declare-const var422!1 String)
(declare-const var145!7 var1847)
(assert (not (= var145!7 null-var1847)))
(assert (= (consumerProtocolServiceKey/1962874429 var145!7) var738!1)) ; Statement: r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.common.ProtocolServiceKey consumerProtocolServiceKey> = $r12 
 ; Statement: return 
(check-sat)
; {<init>/-726220000=([org.apache.dubbo.registry.integration.DynamicDirectory, java.lang.Class, org.apache.dubbo.common.URL], void), cast-from-var1847-to-var1813=([org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory], org.apache.dubbo.registry.integration.DynamicDirectory), enableConfigurationListen/1962874429=([org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory], boolean), originalUrls/1962874429=([org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory], java.util.List), var2769-init=([], java.util.concurrent.ConcurrentHashMap), <init>/-2175807=([java.util.concurrent.ConcurrentHashMap], void), cast-from-var2769-to-var2447=([java.util.concurrent.ConcurrentHashMap], java.util.concurrent.ConcurrentMap), customizedConsumerUrlMap/1962874429=([org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory], java.util.concurrent.ConcurrentMap), getScopeModel/-1957927771=([org.apache.dubbo.common.URL], org.apache.dubbo.rpc.model.ScopeModel), var2938_getModuleModel/430886367=([org.apache.dubbo.rpc.model.ScopeModel], org.apache.dubbo.rpc.model.ModuleModel), moduleModel/1962874429=([org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory], org.apache.dubbo.rpc.model.ModuleModel), getOrDefaultApplicationModel/-1374397043=([org.apache.dubbo.common.URL], org.apache.dubbo.rpc.model.ApplicationModel), getExtensionLoader/-514331157=([org.apache.dubbo.common.extension.ExtensionAccessor, java.lang.Class], org.apache.dubbo.common.extension.ExtensionLoader), cast-from-var965-to-var1109=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.common.extension.ExtensionAccessor), getSupportedExtensionInstances/322061016=([org.apache.dubbo.common.extension.ExtensionLoader], java.util.Set), var3146_isEmpty/73262611=([java.util.Collection], boolean), cast-from-var2129-to-var1396=([java.util.Set], java.util.Collection), providerFirstParams/1962874429=([org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory], java.util.Set), consumerUrl/-1577131577=([org.apache.dubbo.rpc.cluster.directory.AbstractDirectory], org.apache.dubbo.common.URL), cast-from-var1847-to-var870=([org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory], org.apache.dubbo.rpc.cluster.directory.AbstractDirectory), getProtocol/491749358=([org.apache.dubbo.common.URL], java.lang.String), getParameter/506106603=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var1206-init=([], org.apache.dubbo.common.ProtocolServiceKey), getServiceInterface/-1311863806=([org.apache.dubbo.common.URL], java.lang.String), getVersion/189836348=([org.apache.dubbo.common.URL], java.lang.String), getGroup/1342955253=([org.apache.dubbo.common.URL], java.lang.String), <init>/-1421662058=([org.apache.dubbo.common.ProtocolServiceKey, java.lang.String, java.lang.String, java.lang.String, java.lang.String], void), consumerProtocolServiceKey/1962874429=([org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory], org.apache.dubbo.common.ProtocolServiceKey)}
; {var1847=org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory, var145=r0, var108=r1, var1956=org.apache.dubbo.common.URL, var3178=r2, var1813=org.apache.dubbo.registry.integration.DynamicDirectory, var3048=java.util.List, var2769=java.util.concurrent.ConcurrentHashMap, var1962=$r3, var2447=java.util.concurrent.ConcurrentMap, var385=org.apache.dubbo.rpc.model.ScopeModel, var2822=$r4, var3082=org.apache.dubbo.rpc.model.ModuleModel, var2938=org.apache.dubbo.rpc.model.ScopeModelUtil, var3873=$r5, var965=org.apache.dubbo.rpc.model.ApplicationModel, var2187=$r6, var2108=org.apache.dubbo.common.extension.ExtensionLoader, var3465=org.apache.dubbo.registry.ProviderFirstParams, var1109=org.apache.dubbo.common.extension.ExtensionAccessor, var747=$r7, var2129=java.util.Set, var334=r8, var3146=org.apache.dubbo.common.utils.CollectionUtils, var1396=java.util.Collection, var613=$z0, var870=org.apache.dubbo.rpc.cluster.directory.AbstractDirectory, var3505=$r25, var1192=$r26, var163=$r27, var1545=$r28, var1206=org.apache.dubbo.common.ProtocolServiceKey, var738=$r12, var1333=$r29, var2930=$r15, var3044=$r30, var554=$r14, var2356=$r31, var2642=$r13, var3454=$r32, var2643=$z2, var422=$r33}
; {org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory=var1847, r0=var145, r1=var108, org.apache.dubbo.common.URL=var1956, r2=var3178, org.apache.dubbo.registry.integration.DynamicDirectory=var1813, java.util.List=var3048, java.util.concurrent.ConcurrentHashMap=var2769, $r3=var1962, java.util.concurrent.ConcurrentMap=var2447, org.apache.dubbo.rpc.model.ScopeModel=var385, $r4=var2822, org.apache.dubbo.rpc.model.ModuleModel=var3082, org.apache.dubbo.rpc.model.ScopeModelUtil=var2938, $r5=var3873, org.apache.dubbo.rpc.model.ApplicationModel=var965, $r6=var2187, org.apache.dubbo.common.extension.ExtensionLoader=var2108, org.apache.dubbo.registry.ProviderFirstParams=var3465, org.apache.dubbo.common.extension.ExtensionAccessor=var1109, $r7=var747, java.util.Set=var2129, r8=var334, org.apache.dubbo.common.utils.CollectionUtils=var3146, java.util.Collection=var1396, $z0=var613, org.apache.dubbo.rpc.cluster.directory.AbstractDirectory=var870, $r25=var3505, $r26=var1192, $r27=var163, $r28=var1545, org.apache.dubbo.common.ProtocolServiceKey=var1206, $r12=var738, $r29=var1333, $r15=var2930, $r30=var3044, $r14=var554, $r31=var2356, $r13=var2642, $r32=var3454, $z2=var2643, $r33=var422}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory;	r1 := @parameter0: java.lang.Class;	r2 := @parameter1: org.apache.dubbo.common.URL;	specialinvoke r0.<org.apache.dubbo.registry.integration.DynamicDirectory: void <init>(java.lang.Class,org.apache.dubbo.common.URL)>(r1, r2);	r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: boolean enableConfigurationListen> = 1;	r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: java.util.List originalUrls> = null;	$r3 = new java.util.concurrent.ConcurrentHashMap;	specialinvoke $r3.<java.util.concurrent.ConcurrentHashMap: void <init>()>();	r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: java.util.concurrent.ConcurrentMap customizedConsumerUrlMap> = $r3;	$r4 = virtualinvoke r2.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ScopeModel getScopeModel()>();	$r5 = staticinvoke <org.apache.dubbo.rpc.model.ScopeModelUtil: org.apache.dubbo.rpc.model.ModuleModel getModuleModel(org.apache.dubbo.rpc.model.ScopeModel)>($r4);	r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.rpc.model.ModuleModel moduleModel> = $r5;	$r6 = virtualinvoke r2.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ApplicationModel getOrDefaultApplicationModel()>();	$r7 = virtualinvoke $r6.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/registry/ProviderFirstParams;");	r8 = virtualinvoke $r7.<org.apache.dubbo.common.extension.ExtensionLoader: java.util.Set getSupportedExtensionInstances()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>(r8);	if $z0 == 0 goto $i0 = interfaceinvoke r8.<java.util.Set: int size()>();	r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: java.util.Set providerFirstParams> = null;	goto [?= $r25 = r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.common.URL consumerUrl>];	$r25 = r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.common.URL consumerUrl>;	$r26 = r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.common.URL consumerUrl>;	$r27 = virtualinvoke $r26.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	$r28 = virtualinvoke $r25.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("protocol", $r27);	$r12 = new org.apache.dubbo.common.ProtocolServiceKey;	$r29 = r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.common.URL consumerUrl>;	$r15 = virtualinvoke $r29.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>();	$r30 = r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.common.URL consumerUrl>;	$r14 = virtualinvoke $r30.<org.apache.dubbo.common.URL: java.lang.String getVersion()>();	$r31 = r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.common.URL consumerUrl>;	$r13 = virtualinvoke $r31.<org.apache.dubbo.common.URL: java.lang.String getGroup()>();	$r32 = "consumer";	$z2 = virtualinvoke $r32.<java.lang.String: boolean equals(java.lang.Object)>($r28);	if $z2 != 0 goto $r33 = null;	$r33 = $r28;	goto [?= specialinvoke $r12.<org.apache.dubbo.common.ProtocolServiceKey: void <init>(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>($r15, $r14, $r13, $r33)];	specialinvoke $r12.<org.apache.dubbo.common.ProtocolServiceKey: void <init>(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>($r15, $r14, $r13, $r33);	r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.common.ProtocolServiceKey consumerProtocolServiceKey> = $r12;	return
;block_num 5