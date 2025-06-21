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

(declare-sort var3617 0)
(declare-sort var2902 0)
(declare-sort var719 0)
(declare-sort var866 0)
(declare-sort var661 0)
(declare-sort var3892 0)
(declare-sort var3069 0)
(declare-sort var3277 0)
(declare-sort var1111 0)
(declare-sort var994 0)
(declare-sort var183 0)
(declare-sort var2003 0)
(declare-sort var843 0)
(declare-sort var2972 0)
(declare-sort var3522 0)
(declare-sort var2102 0)
(declare-sort var507 0)
(declare-sort var2725 0)
(declare-sort var587 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var2003!class ClassObject)
(declare-fun <init>/-726220000 (var719 ClassObject var2902) void)
(declare-fun cast-from-var3617-to-var719 (var3617) var719)
(declare-fun enableConfigurationListen/1962874429 (var3617) Bool)
(declare-fun originalUrls/1962874429 (var3617) var866)
(declare-fun var661-init () var661)
(declare-fun <init>/-2175807 (var661) void)
(declare-fun cast-from-var661-to-var3892 (var661) var3892)
(declare-fun customizedConsumerUrlMap/1962874429 (var3617) var3892)
(declare-fun getScopeModel/-1957927771 (var2902) var3069)
(declare-fun var1111_getModuleModel/430886367 (var3069) var3277)
(declare-fun moduleModel/1962874429 (var3617) var3277)
(declare-fun getOrDefaultApplicationModel/-1374397043 (var2902) var994)
(declare-fun getExtensionLoader/-514331157 (var843 ClassObject) var183)
(declare-fun cast-from-var994-to-var843 (var994) var843)
(declare-fun getSupportedExtensionInstances/322061016 (var183) var2972)
(declare-fun var3522_isEmpty/73262611 (var2102) Bool)
(declare-fun cast-from-var2972-to-var2102 (var2972) var2102)
(declare-fun providerFirstParams/1962874429 (var3617) var2972)
(declare-fun consumerUrl/-1577131577 (var507) var2902)
(declare-fun cast-from-var3617-to-var507 (var3617) var507)
(declare-fun getProtocol/491749358 (var2902) String)
(declare-fun getParameter/506106603 (var2902 String String) String)
(declare-fun var2725-init () var2725)
(declare-fun getServiceInterface/-1311863806 (var2902) String)
(declare-fun getVersion/189836348 (var2902) String)
(declare-fun getGroup/1342955253 (var2902) String)
(declare-fun <init>/-1421662058 (var2725 String String String String) void)
(declare-fun consumerProtocolServiceKey/1962874429 (var3617) var2725)
(declare-const null-var3617 var3617)
(declare-const null-ClassObject ClassObject)
(declare-const null-var2902 var2902)
(declare-const null-var866 var866)
(declare-const null-var2972 var2972)
(declare-const null-String String)
(declare-const var641 var3617) ; Statement: r0 := @this: org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory 
(assert (not (= var641 null-var3617)))
(declare-const var2908 ClassObject) ; Statement: r1 := @parameter0: java.lang.Class 
(assert (not (= var2908 null-ClassObject)))
(declare-const var3884 var2902) ; Statement: r2 := @parameter1: org.apache.dubbo.common.URL 
(assert (not (= var3884 null-var2902)))
(assert true)
;(assert (<init>/-726220000 (cast-from-var3617-to-var719 var641) var2908 var3884)) ; Statement: specialinvoke r0.<org.apache.dubbo.registry.integration.DynamicDirectory: void <init>(java.lang.Class,org.apache.dubbo.common.URL)>(r1, r2) 

(declare-const var641!1 var3617)
(declare-const var2908!1 ClassObject)
(declare-const var3884!1 var2902)
(declare-const var641!2 var3617)
(assert (not (= var641!2 null-var3617)))
(assert (= (enableConfigurationListen/1962874429 var641!2) (ite (= 1 1) true false))) ; Statement: r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: boolean enableConfigurationListen> = 1 
(declare-const var641!3 var3617)
(assert (not (= var641!3 null-var3617)))
(assert (= (originalUrls/1962874429 var641!3) null-var866)) ; Statement: r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: java.util.List originalUrls> = null 
(define-const var2867 var661 var661-init) ; Statement: $r3 = new java.util.concurrent.ConcurrentHashMap 
(assert true)
;(assert (<init>/-2175807 var2867)) ; Statement: specialinvoke $r3.<java.util.concurrent.ConcurrentHashMap: void <init>()>() 

(declare-const var2867!1 var661)
(declare-const var641!4 var3617)
(assert (not (= var641!4 null-var3617)))
(assert (= (customizedConsumerUrlMap/1962874429 var641!4) (cast-from-var661-to-var3892 var2867!1))) ; Statement: r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: java.util.concurrent.ConcurrentMap customizedConsumerUrlMap> = $r3 
(assert true)
(define-const var1401 var3069 (getScopeModel/-1957927771 var3884!1)) ; Statement: $r4 = virtualinvoke r2.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ScopeModel getScopeModel()>() 
(define-const var3701 var3277 (var1111_getModuleModel/430886367 var1401)) ; Statement: $r5 = staticinvoke <org.apache.dubbo.rpc.model.ScopeModelUtil: org.apache.dubbo.rpc.model.ModuleModel getModuleModel(org.apache.dubbo.rpc.model.ScopeModel)>($r4) 
(declare-const var641!5 var3617)
(assert (not (= var641!5 null-var3617)))
(assert (= (moduleModel/1962874429 var641!5) var3701)) ; Statement: r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.rpc.model.ModuleModel moduleModel> = $r5 
(assert true)
(define-const var2748 var994 (getOrDefaultApplicationModel/-1374397043 var3884!1)) ; Statement: $r6 = virtualinvoke r2.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ApplicationModel getOrDefaultApplicationModel()>() 
(assert true)
(define-const var3652 var183 (getExtensionLoader/-514331157 (cast-from-var994-to-var843 var2748) var2003!class)) ; Statement: $r7 = virtualinvoke $r6.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/registry/ProviderFirstParams;") 
(assert true)
(define-const var1508 var2972 (getSupportedExtensionInstances/322061016 var3652)) ; Statement: r8 = virtualinvoke $r7.<org.apache.dubbo.common.extension.ExtensionLoader: java.util.Set getSupportedExtensionInstances()>() 
(define-const var2502 Bool (var3522_isEmpty/73262611 (cast-from-var2972-to-var2102 var1508))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>(r8) 
 ; Statement: if $z0 == 0 goto $i0 = interfaceinvoke r8.<java.util.Set: int size()>() 
(assert (not (= (ite var2502 1 0) 0))) ; Negate: Cond: $z0 == 0  
(declare-const var641!6 var3617)
(assert (not (= var641!6 null-var3617)))
(assert (= (providerFirstParams/1962874429 var641!6) null-var2972)) ; Statement: r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: java.util.Set providerFirstParams> = null 
 ; Statement: goto [?= $r25 = r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.common.URL consumerUrl>] 
(assert true) ; Non Conditional
(define-const var2691 var2902 (consumerUrl/-1577131577 (cast-from-var3617-to-var507 var641!6))) ; Statement: $r25 = r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.common.URL consumerUrl> 
(define-const var733 var2902 (consumerUrl/-1577131577 (cast-from-var3617-to-var507 var641!6))) ; Statement: $r26 = r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.common.URL consumerUrl> 
(assert true)
(define-const var177 String (getProtocol/491749358 var733)) ; Statement: $r27 = virtualinvoke $r26.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(assert true)
(define-const var2331 String (getParameter/506106603 var2691 "protocol" var177)) ; Statement: $r28 = virtualinvoke $r25.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("protocol", $r27) 
(define-const var1920 var2725 var2725-init) ; Statement: $r12 = new org.apache.dubbo.common.ProtocolServiceKey 
(define-const var2962 var2902 (consumerUrl/-1577131577 (cast-from-var3617-to-var507 var641!6))) ; Statement: $r29 = r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.common.URL consumerUrl> 
(assert true)
(define-const var2566 String (getServiceInterface/-1311863806 var2962)) ; Statement: $r15 = virtualinvoke $r29.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>() 
(define-const var218 var2902 (consumerUrl/-1577131577 (cast-from-var3617-to-var507 var641!6))) ; Statement: $r30 = r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.common.URL consumerUrl> 
(assert true)
(define-const var3164 String (getVersion/189836348 var218)) ; Statement: $r14 = virtualinvoke $r30.<org.apache.dubbo.common.URL: java.lang.String getVersion()>() 
(define-const var1475 var2902 (consumerUrl/-1577131577 (cast-from-var3617-to-var507 var641!6))) ; Statement: $r31 = r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.common.URL consumerUrl> 
(assert true)
(define-const var1136 String (getGroup/1342955253 var1475)) ; Statement: $r13 = virtualinvoke $r31.<org.apache.dubbo.common.URL: java.lang.String getGroup()>() 
(define-const var744 String "consumer") ; Statement: $r32 = "consumer" 
(assert true)
(define-const var379 Bool (= var744 var2331)) ; Statement: $z2 = virtualinvoke $r32.<java.lang.String: boolean equals(java.lang.Object)>($r28) 
 ; Statement: if $z2 != 0 goto $r33 = null 
(assert (not (= (ite var379 1 0) 0))) ; Cond: $z2 != 0 
(define-const var3583 String null-String) ; Statement: $r33 = null 
(assert true) ; Non Conditional
(assert true)
;(assert (<init>/-1421662058 var1920 var2566 var3164 var1136 var3583)) ; Statement: specialinvoke $r12.<org.apache.dubbo.common.ProtocolServiceKey: void <init>(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>($r15, $r14, $r13, $r33) 

(declare-const var1920!1 var2725)
(declare-const var2566!1 String)
(declare-const var3164!1 String)
(declare-const var1136!1 String)
(declare-const var3583!1 String)
(declare-const var641!7 var3617)
(assert (not (= var641!7 null-var3617)))
(assert (= (consumerProtocolServiceKey/1962874429 var641!7) var1920!1)) ; Statement: r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.common.ProtocolServiceKey consumerProtocolServiceKey> = $r12 
 ; Statement: return 
(check-sat)
; {<init>/-726220000=([org.apache.dubbo.registry.integration.DynamicDirectory, java.lang.Class, org.apache.dubbo.common.URL], void), cast-from-var3617-to-var719=([org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory], org.apache.dubbo.registry.integration.DynamicDirectory), enableConfigurationListen/1962874429=([org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory], boolean), originalUrls/1962874429=([org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory], java.util.List), var661-init=([], java.util.concurrent.ConcurrentHashMap), <init>/-2175807=([java.util.concurrent.ConcurrentHashMap], void), cast-from-var661-to-var3892=([java.util.concurrent.ConcurrentHashMap], java.util.concurrent.ConcurrentMap), customizedConsumerUrlMap/1962874429=([org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory], java.util.concurrent.ConcurrentMap), getScopeModel/-1957927771=([org.apache.dubbo.common.URL], org.apache.dubbo.rpc.model.ScopeModel), var1111_getModuleModel/430886367=([org.apache.dubbo.rpc.model.ScopeModel], org.apache.dubbo.rpc.model.ModuleModel), moduleModel/1962874429=([org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory], org.apache.dubbo.rpc.model.ModuleModel), getOrDefaultApplicationModel/-1374397043=([org.apache.dubbo.common.URL], org.apache.dubbo.rpc.model.ApplicationModel), getExtensionLoader/-514331157=([org.apache.dubbo.common.extension.ExtensionAccessor, java.lang.Class], org.apache.dubbo.common.extension.ExtensionLoader), cast-from-var994-to-var843=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.common.extension.ExtensionAccessor), getSupportedExtensionInstances/322061016=([org.apache.dubbo.common.extension.ExtensionLoader], java.util.Set), var3522_isEmpty/73262611=([java.util.Collection], boolean), cast-from-var2972-to-var2102=([java.util.Set], java.util.Collection), providerFirstParams/1962874429=([org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory], java.util.Set), consumerUrl/-1577131577=([org.apache.dubbo.rpc.cluster.directory.AbstractDirectory], org.apache.dubbo.common.URL), cast-from-var3617-to-var507=([org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory], org.apache.dubbo.rpc.cluster.directory.AbstractDirectory), getProtocol/491749358=([org.apache.dubbo.common.URL], java.lang.String), getParameter/506106603=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var2725-init=([], org.apache.dubbo.common.ProtocolServiceKey), getServiceInterface/-1311863806=([org.apache.dubbo.common.URL], java.lang.String), getVersion/189836348=([org.apache.dubbo.common.URL], java.lang.String), getGroup/1342955253=([org.apache.dubbo.common.URL], java.lang.String), <init>/-1421662058=([org.apache.dubbo.common.ProtocolServiceKey, java.lang.String, java.lang.String, java.lang.String, java.lang.String], void), consumerProtocolServiceKey/1962874429=([org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory], org.apache.dubbo.common.ProtocolServiceKey)}
; {var3617=org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory, var641=r0, var2908=r1, var2902=org.apache.dubbo.common.URL, var3884=r2, var719=org.apache.dubbo.registry.integration.DynamicDirectory, var866=java.util.List, var661=java.util.concurrent.ConcurrentHashMap, var2867=$r3, var3892=java.util.concurrent.ConcurrentMap, var3069=org.apache.dubbo.rpc.model.ScopeModel, var1401=$r4, var3277=org.apache.dubbo.rpc.model.ModuleModel, var1111=org.apache.dubbo.rpc.model.ScopeModelUtil, var3701=$r5, var994=org.apache.dubbo.rpc.model.ApplicationModel, var2748=$r6, var183=org.apache.dubbo.common.extension.ExtensionLoader, var2003=org.apache.dubbo.registry.ProviderFirstParams, var843=org.apache.dubbo.common.extension.ExtensionAccessor, var3652=$r7, var2972=java.util.Set, var1508=r8, var3522=org.apache.dubbo.common.utils.CollectionUtils, var2102=java.util.Collection, var2502=$z0, var507=org.apache.dubbo.rpc.cluster.directory.AbstractDirectory, var2691=$r25, var733=$r26, var177=$r27, var2331=$r28, var2725=org.apache.dubbo.common.ProtocolServiceKey, var1920=$r12, var2962=$r29, var2566=$r15, var218=$r30, var3164=$r14, var1475=$r31, var1136=$r13, var744=$r32, var379=$z2, var587=null_type, var3583=$r33}
; {org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory=var3617, r0=var641, r1=var2908, org.apache.dubbo.common.URL=var2902, r2=var3884, org.apache.dubbo.registry.integration.DynamicDirectory=var719, java.util.List=var866, java.util.concurrent.ConcurrentHashMap=var661, $r3=var2867, java.util.concurrent.ConcurrentMap=var3892, org.apache.dubbo.rpc.model.ScopeModel=var3069, $r4=var1401, org.apache.dubbo.rpc.model.ModuleModel=var3277, org.apache.dubbo.rpc.model.ScopeModelUtil=var1111, $r5=var3701, org.apache.dubbo.rpc.model.ApplicationModel=var994, $r6=var2748, org.apache.dubbo.common.extension.ExtensionLoader=var183, org.apache.dubbo.registry.ProviderFirstParams=var2003, org.apache.dubbo.common.extension.ExtensionAccessor=var843, $r7=var3652, java.util.Set=var2972, r8=var1508, org.apache.dubbo.common.utils.CollectionUtils=var3522, java.util.Collection=var2102, $z0=var2502, org.apache.dubbo.rpc.cluster.directory.AbstractDirectory=var507, $r25=var2691, $r26=var733, $r27=var177, $r28=var2331, org.apache.dubbo.common.ProtocolServiceKey=var2725, $r12=var1920, $r29=var2962, $r15=var2566, $r30=var218, $r14=var3164, $r31=var1475, $r13=var1136, $r32=var744, $z2=var379, null_type=var587, $r33=var3583}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory;	r1 := @parameter0: java.lang.Class;	r2 := @parameter1: org.apache.dubbo.common.URL;	specialinvoke r0.<org.apache.dubbo.registry.integration.DynamicDirectory: void <init>(java.lang.Class,org.apache.dubbo.common.URL)>(r1, r2);	r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: boolean enableConfigurationListen> = 1;	r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: java.util.List originalUrls> = null;	$r3 = new java.util.concurrent.ConcurrentHashMap;	specialinvoke $r3.<java.util.concurrent.ConcurrentHashMap: void <init>()>();	r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: java.util.concurrent.ConcurrentMap customizedConsumerUrlMap> = $r3;	$r4 = virtualinvoke r2.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ScopeModel getScopeModel()>();	$r5 = staticinvoke <org.apache.dubbo.rpc.model.ScopeModelUtil: org.apache.dubbo.rpc.model.ModuleModel getModuleModel(org.apache.dubbo.rpc.model.ScopeModel)>($r4);	r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.rpc.model.ModuleModel moduleModel> = $r5;	$r6 = virtualinvoke r2.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ApplicationModel getOrDefaultApplicationModel()>();	$r7 = virtualinvoke $r6.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/registry/ProviderFirstParams;");	r8 = virtualinvoke $r7.<org.apache.dubbo.common.extension.ExtensionLoader: java.util.Set getSupportedExtensionInstances()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>(r8);	if $z0 == 0 goto $i0 = interfaceinvoke r8.<java.util.Set: int size()>();	r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: java.util.Set providerFirstParams> = null;	goto [?= $r25 = r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.common.URL consumerUrl>];	$r25 = r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.common.URL consumerUrl>;	$r26 = r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.common.URL consumerUrl>;	$r27 = virtualinvoke $r26.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	$r28 = virtualinvoke $r25.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("protocol", $r27);	$r12 = new org.apache.dubbo.common.ProtocolServiceKey;	$r29 = r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.common.URL consumerUrl>;	$r15 = virtualinvoke $r29.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>();	$r30 = r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.common.URL consumerUrl>;	$r14 = virtualinvoke $r30.<org.apache.dubbo.common.URL: java.lang.String getVersion()>();	$r31 = r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.common.URL consumerUrl>;	$r13 = virtualinvoke $r31.<org.apache.dubbo.common.URL: java.lang.String getGroup()>();	$r32 = "consumer";	$z2 = virtualinvoke $r32.<java.lang.String: boolean equals(java.lang.Object)>($r28);	if $z2 != 0 goto $r33 = null;	$r33 = null;	specialinvoke $r12.<org.apache.dubbo.common.ProtocolServiceKey: void <init>(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>($r15, $r14, $r13, $r33);	r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.common.ProtocolServiceKey consumerProtocolServiceKey> = $r12;	return
;block_num 5