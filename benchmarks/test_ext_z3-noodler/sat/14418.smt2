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

(declare-sort var831 0)
(declare-sort var465 0)
(declare-sort var3629 0)
(declare-sort var3541 0)
(declare-sort var3106 0)
(declare-sort var3989 0)
(declare-sort var3196 0)
(declare-sort var508 0)
(declare-sort var2892 0)
(declare-sort var2788 0)
(declare-sort var1641 0)
(declare-sort var1168 0)
(declare-sort var3051 0)
(declare-sort var2056 0)
(declare-sort var62 0)
(declare-sort var3600 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var3600!class ClassObject)
(declare-fun getAddress/-1835497617 (var465) String)
(declare-fun metadataMap/-1558756437 (var831) var3629)
(declare-fun containsKey/-787811830 (var3629 var3541) Bool)
(declare-fun cast-from-String-to-var3541 (String) var3541)
(declare-fun getMetadataServiceProxy/-1062332047 (var831 var3989) var3106)
(declare-fun cast-from-var465-to-var3989 (var465) var3989)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun registryURL/642990325 (var508) var3196)
(declare-fun cast-from-var831-to-var508 (var831) var508)
(declare-fun getScopeModel/-1957927771 (var3196) var2892)
(declare-fun var1641_getApplicationModel/75536413 (var2892) var2788)
(declare-fun getApplicationName/1861025684 (var2788) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var1168_getLocalHost/-1653363627 () String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2056_bootstrap$/1571390317 (var831 var465 String) var3051)
(declare-fun var3106_getAndListenInstanceMetadata/980858577 (var3106 String var3051) String)
(declare-fun put/-1753019971 (var3629 var3541 var3541) var3541)
(declare-fun var62_toJavaObject/-1745526013 (String ClassObject) var3541)
(define-fun cast-from-ClassObject-to-ClassObject ((arg ClassObject)) ClassObject arg)
(declare-fun cast-from-var3541-to-var3600 (var3541) var3600)
(declare-fun setMetadata/1197589529 (var465 var3600) void)
(declare-const null-var831 var831)
(declare-const null-var465 var465)
(declare-const var3176 var831) ; Statement: r2 := @this: org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery 
(assert (not (= var3176 null-var831)))
(declare-const var572 var465) ; Statement: r0 := @parameter0: org.apache.dubbo.registry.client.DefaultServiceInstance 
(assert (not (= var572 null-var465)))
(assert true)
(define-const var2210 String (getAddress/-1835497617 var572)) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.registry.client.DefaultServiceInstance: java.lang.String getAddress()>() 
(define-const var1195 var3629 (metadataMap/-1558756437 var3176)) ; Statement: $r3 = r2.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: java.util.concurrent.ConcurrentHashMap metadataMap> 
(assert true)
(define-const var727 Bool (containsKey/-787811830 var1195 (cast-from-String-to-var3541 var2210))) ; Statement: $z0 = virtualinvoke $r3.<java.util.concurrent.ConcurrentHashMap: boolean containsKey(java.lang.Object)>(r1) 
 ; Statement: if $z0 == 0 goto r23 = specialinvoke r2.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: org.apache.dubbo.metadata.MetadataService getMetadataServiceProxy(org.apache.dubbo.registry.client.ServiceInstance)>(r0) 
(assert (= (ite var727 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var3856 var3106 (getMetadataServiceProxy/-1062332047 var3176 (cast-from-var465-to-var3989 var572))) ; Statement: r23 = specialinvoke r2.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: org.apache.dubbo.metadata.MetadataService getMetadataServiceProxy(org.apache.dubbo.registry.client.ServiceInstance)>(r0) 
(define-const var1395 String String-init) ; Statement: $r4 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1395)) ; Statement: specialinvoke $r4.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1395!1 String)
(assert (= var1395!1 ""))
(define-const var1215 var3196 (registryURL/642990325 (cast-from-var831-to-var508 var3176))) ; Statement: $r5 = r2.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: org.apache.dubbo.common.URL registryURL> 
(assert true)
(define-const var2714 var2892 (getScopeModel/-1957927771 var1215)) ; Statement: $r6 = virtualinvoke $r5.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ScopeModel getScopeModel()>() 
(define-const var3663 var2788 (var1641_getApplicationModel/75536413 var2714)) ; Statement: $r7 = staticinvoke <org.apache.dubbo.rpc.model.ScopeModelUtil: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel(org.apache.dubbo.rpc.model.ScopeModel)>($r6) 
(assert true)
(define-const var3859 String (getApplicationName/1861025684 var3663)) ; Statement: $r8 = virtualinvoke $r7.<org.apache.dubbo.rpc.model.ApplicationModel: java.lang.String getApplicationName()>() 
(assert true)
(define-const var1475 String (append/672562846 var1395!1 var3859)) ; Statement: $r10 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8) 
(declare-const var1395!2 String)
(assert (= var1395!2 (str.++ var1395!1 var3859)))
(define-const var1735 String var1168_getLocalHost/-1653363627) ; Statement: $r9 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHost()>() 
(assert true)
(define-const var3033 String (append/672562846 var1475 var1735)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9) 
(declare-const var1475!1 String)
(assert (= var1475!1 (str.++ var1475 var1735)))
(assert true)
(define-const var177 String (toString/-2075883882 var3033)) ; Statement: r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var2125 var3051 (var2056_bootstrap$/1571390317 var3176 var572 var2210)) ; Statement: $r13 = staticinvoke <org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery$lambda_fillServiceInstance_2__1000: org.apache.dubbo.metadata.InstanceMetadataChangedListener bootstrap$(org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery,org.apache.dubbo.registry.client.DefaultServiceInstance,java.lang.String)>(r2, r0, r1) 
(define-const var3899 String (var3106_getAndListenInstanceMetadata/980858577 var3856 var177 var2125)) ; Statement: r14 = interfaceinvoke r23.<org.apache.dubbo.metadata.MetadataService: java.lang.String getAndListenInstanceMetadata(java.lang.String,org.apache.dubbo.metadata.InstanceMetadataChangedListener)>(r12, $r13) 
(define-const var1180 var3629 (metadataMap/-1558756437 var3176)) ; Statement: $r15 = r2.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: java.util.concurrent.ConcurrentHashMap metadataMap> 
(assert true)
;(assert (put/-1753019971 var1180 (cast-from-String-to-var3541 var2210) (cast-from-String-to-var3541 var3899))) ; Statement: virtualinvoke $r15.<java.util.concurrent.ConcurrentHashMap: java.lang.Object put(java.lang.Object,java.lang.Object)>(r1, r14) 

(declare-const var1180!1 var3629)
(declare-const var2210!1 String)
(declare-const var3899!1 String)
(define-const var44 var3541 (var62_toJavaObject/-1745526013 var3899!1 (cast-from-ClassObject-to-ClassObject var3600!class))) ; Statement: $r16 = staticinvoke <org.apache.dubbo.common.utils.JsonUtils: java.lang.Object toJavaObject(java.lang.String,java.lang.reflect.Type)>(r14, class "Ljava/util/Map;") 
(define-const var2034 var3600 (cast-from-var3541-to-var3600 var44)) ; Statement: $r17 = (java.util.Map) $r16 
(assert true)
;(assert (setMetadata/1197589529 var572 var2034)) ; Statement: virtualinvoke r0.<org.apache.dubbo.registry.client.DefaultServiceInstance: void setMetadata(java.util.Map)>($r17) 

(declare-const var572!1 var465)
(declare-const var2034!1 var3600)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {getAddress/-1835497617=([org.apache.dubbo.registry.client.DefaultServiceInstance], java.lang.String), metadataMap/-1558756437=([org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery], java.util.concurrent.ConcurrentHashMap), containsKey/-787811830=([java.util.concurrent.ConcurrentHashMap, java.lang.Object], boolean), cast-from-String-to-var3541=([java.lang.String], java.lang.Object), getMetadataServiceProxy/-1062332047=([org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery, org.apache.dubbo.registry.client.ServiceInstance], org.apache.dubbo.metadata.MetadataService), cast-from-var465-to-var3989=([org.apache.dubbo.registry.client.DefaultServiceInstance], org.apache.dubbo.registry.client.ServiceInstance), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), registryURL/642990325=([org.apache.dubbo.registry.client.AbstractServiceDiscovery], org.apache.dubbo.common.URL), cast-from-var831-to-var508=([org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery], org.apache.dubbo.registry.client.AbstractServiceDiscovery), getScopeModel/-1957927771=([org.apache.dubbo.common.URL], org.apache.dubbo.rpc.model.ScopeModel), var1641_getApplicationModel/75536413=([org.apache.dubbo.rpc.model.ScopeModel], org.apache.dubbo.rpc.model.ApplicationModel), getApplicationName/1861025684=([org.apache.dubbo.rpc.model.ApplicationModel], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var1168_getLocalHost/-1653363627=([], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2056_bootstrap$/1571390317=([org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery, org.apache.dubbo.registry.client.DefaultServiceInstance, java.lang.String], org.apache.dubbo.metadata.InstanceMetadataChangedListener), var3106_getAndListenInstanceMetadata/980858577=([org.apache.dubbo.metadata.MetadataService, java.lang.String, org.apache.dubbo.metadata.InstanceMetadataChangedListener], java.lang.String), put/-1753019971=([java.util.concurrent.ConcurrentHashMap, java.lang.Object, java.lang.Object], java.lang.Object), var62_toJavaObject/-1745526013=([java.lang.String, java.lang.reflect.Type], java.lang.Object), cast-from-ClassObject-to-ClassObject=([java.lang.Class], java.lang.reflect.Type), cast-from-var3541-to-var3600=([java.lang.Object], java.util.Map), setMetadata/1197589529=([org.apache.dubbo.registry.client.DefaultServiceInstance, java.util.Map], void)}
; {var831=org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery, var3176=r2, var465=org.apache.dubbo.registry.client.DefaultServiceInstance, var572=r0, var2210=r1, var3629=java.util.concurrent.ConcurrentHashMap, var1195=$r3, var3541=java.lang.Object, var727=$z0, var3106=org.apache.dubbo.metadata.MetadataService, var3989=org.apache.dubbo.registry.client.ServiceInstance, var3856=r23, var1395=$r4, var3196=org.apache.dubbo.common.URL, var508=org.apache.dubbo.registry.client.AbstractServiceDiscovery, var1215=$r5, var2892=org.apache.dubbo.rpc.model.ScopeModel, var2714=$r6, var2788=org.apache.dubbo.rpc.model.ApplicationModel, var1641=org.apache.dubbo.rpc.model.ScopeModelUtil, var3663=$r7, var3859=$r8, var1475=$r10, var1168=org.apache.dubbo.common.utils.NetUtils, var1735=$r9, var3033=$r11, var177=r12, var3051=org.apache.dubbo.metadata.InstanceMetadataChangedListener, var2056=org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery$lambda_fillServiceInstance_2__1000, var2125=$r13, var3899=r14, var1180=$r15, var62=org.apache.dubbo.common.utils.JsonUtils, var3600=java.util.Map, var44=$r16, var2034=$r17}
; {org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery=var831, r2=var3176, org.apache.dubbo.registry.client.DefaultServiceInstance=var465, r0=var572, r1=var2210, java.util.concurrent.ConcurrentHashMap=var3629, $r3=var1195, java.lang.Object=var3541, $z0=var727, org.apache.dubbo.metadata.MetadataService=var3106, org.apache.dubbo.registry.client.ServiceInstance=var3989, r23=var3856, $r4=var1395, org.apache.dubbo.common.URL=var3196, org.apache.dubbo.registry.client.AbstractServiceDiscovery=var508, $r5=var1215, org.apache.dubbo.rpc.model.ScopeModel=var2892, $r6=var2714, org.apache.dubbo.rpc.model.ApplicationModel=var2788, org.apache.dubbo.rpc.model.ScopeModelUtil=var1641, $r7=var3663, $r8=var3859, $r10=var1475, org.apache.dubbo.common.utils.NetUtils=var1168, $r9=var1735, $r11=var3033, r12=var177, org.apache.dubbo.metadata.InstanceMetadataChangedListener=var3051, org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery$lambda_fillServiceInstance_2__1000=var2056, $r13=var2125, r14=var3899, $r15=var1180, org.apache.dubbo.common.utils.JsonUtils=var62, java.util.Map=var3600, $r16=var44, $r17=var2034}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r2 := @this: org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery;	r0 := @parameter0: org.apache.dubbo.registry.client.DefaultServiceInstance;	r1 = virtualinvoke r0.<org.apache.dubbo.registry.client.DefaultServiceInstance: java.lang.String getAddress()>();	$r3 = r2.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: java.util.concurrent.ConcurrentHashMap metadataMap>;	$z0 = virtualinvoke $r3.<java.util.concurrent.ConcurrentHashMap: boolean containsKey(java.lang.Object)>(r1);	if $z0 == 0 goto r23 = specialinvoke r2.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: org.apache.dubbo.metadata.MetadataService getMetadataServiceProxy(org.apache.dubbo.registry.client.ServiceInstance)>(r0);	r23 = specialinvoke r2.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: org.apache.dubbo.metadata.MetadataService getMetadataServiceProxy(org.apache.dubbo.registry.client.ServiceInstance)>(r0);	$r4 = new java.lang.StringBuilder;	specialinvoke $r4.<java.lang.StringBuilder: void <init>()>();	$r5 = r2.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: org.apache.dubbo.common.URL registryURL>;	$r6 = virtualinvoke $r5.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ScopeModel getScopeModel()>();	$r7 = staticinvoke <org.apache.dubbo.rpc.model.ScopeModelUtil: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel(org.apache.dubbo.rpc.model.ScopeModel)>($r6);	$r8 = virtualinvoke $r7.<org.apache.dubbo.rpc.model.ApplicationModel: java.lang.String getApplicationName()>();	$r10 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8);	$r9 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHost()>();	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9);	r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	$r13 = staticinvoke <org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery$lambda_fillServiceInstance_2__1000: org.apache.dubbo.metadata.InstanceMetadataChangedListener bootstrap$(org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery,org.apache.dubbo.registry.client.DefaultServiceInstance,java.lang.String)>(r2, r0, r1);	r14 = interfaceinvoke r23.<org.apache.dubbo.metadata.MetadataService: java.lang.String getAndListenInstanceMetadata(java.lang.String,org.apache.dubbo.metadata.InstanceMetadataChangedListener)>(r12, $r13);	$r15 = r2.<org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery: java.util.concurrent.ConcurrentHashMap metadataMap>;	virtualinvoke $r15.<java.util.concurrent.ConcurrentHashMap: java.lang.Object put(java.lang.Object,java.lang.Object)>(r1, r14);	$r16 = staticinvoke <org.apache.dubbo.common.utils.JsonUtils: java.lang.Object toJavaObject(java.lang.String,java.lang.reflect.Type)>(r14, class "Ljava/util/Map;");	$r17 = (java.util.Map) $r16;	virtualinvoke r0.<org.apache.dubbo.registry.client.DefaultServiceInstance: void setMetadata(java.util.Map)>($r17);	return
;block_num 3