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

(declare-sort var1890 0)
(declare-sort var312 0)
(declare-sort var438 0)
(declare-sort var2269 0)
(declare-sort var196 0)
(declare-sort var1786 0)
(declare-sort var3765 0)
(declare-sort var1933 0)
(declare-sort var1679 0)
(declare-sort var2133 0)
(declare-sort var2835 0)
(declare-sort var3062 0)
(declare-sort var1536 0)
(declare-sort var3840 0)
(declare-sort var159 0)
(declare-sort var2979 0)
(declare-sort var3890 0)
(declare-sort var2083 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var2133!class ClassObject)
(declare-const var3062!class ClassObject)
(declare-const var159!class ClassObject)
(declare-fun var438_buildMetadataUrl/1386040074 (var1890) var312)
(declare-fun var1890_getApplicationModel/1173884853 (var1890) var2269)
(declare-fun getInternalModule/890555230 (var2269) var196)
(declare-fun getAttribute/-225665909 (var312 String) var1786)
(declare-fun var3765_support/1207467391 () Bool)
(declare-fun var1933_inNativeImage/-778320806 () Bool)
(declare-fun registerInternalConsumer/-577857373 (var196 ClassObject var312) var1679)
(declare-fun getExtensionLoader/-514331157 (var1536 ClassObject) var2835)
(declare-fun cast-from-var2269-to-var1536 (var2269) var1536)
(declare-fun getProtocol/491749358 (var312) String)
(declare-fun getExtension/-203349416 (var2835 String Bool) var1786)
(declare-fun cast-from-var1786-to-var3062 (var1786) var3062)
(declare-fun setServiceModel/1097940449 (var312 var3840) var312)
(declare-fun cast-from-var1679-to-var3840 (var1679) var3840)
(declare-fun getParameter/2144001655 (var312 String Bool) Bool)
(declare-fun getAdaptiveExtension/-2068350643 (var2835) var1786)
(declare-fun cast-from-var1786-to-var159 (var1786) var159)
(declare-fun var3062_refer/-581737709 (var3062 ClassObject var312) var2979)
(declare-fun var3890-init () var3890)
(declare-fun var159_getProxy/-84091048 (var159 var2979) var1786)
(declare-fun cast-from-var1786-to-var2133 (var1786) var2133)
(declare-fun <init>/-627934689 (var3890 var1679 var2133 var196) void)
(declare-fun getInternalProxy/-208446410 (var3890) var1786)
(declare-fun getServiceMetadata/703324177 (var3840) var2083)
(declare-fun setTarget/-251600361 (var2083 var1786) void)
(declare-fun addAttribute/-751097508 (var2083 String var1786) void)
(declare-fun setProxyObject/-1035565173 (var3840 var1786) void)
(declare-fun initMethodModels/299763735 (var1679) void)
(declare-const null-var1890 var1890)
(declare-const var2226 var1890) ; Statement: r0 := @parameter0: org.apache.dubbo.registry.client.ServiceInstance 
(assert (not (= var2226 null-var1890)))
(define-const var2569 var312 (var438_buildMetadataUrl/1386040074 var2226)) ; Statement: r32 = staticinvoke <org.apache.dubbo.registry.client.metadata.MetadataUtils: org.apache.dubbo.common.URL buildMetadataUrl(org.apache.dubbo.registry.client.ServiceInstance)>(r0) 
(define-const var1293 var2269 (var1890_getApplicationModel/1173884853 var2226)) ; Statement: r1 = interfaceinvoke r0.<org.apache.dubbo.registry.client.ServiceInstance: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel()>() 
(assert true)
(define-const var364 var196 (getInternalModule/890555230 var1293)) ; Statement: r2 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.rpc.model.ModuleModel getInternalModule()>() 
(define-const var462 String "2.0.0") ; Statement: $r4 = "2.0.0" 
(assert true)
(define-const var2261 var1786 (getAttribute/-225665909 var2569 "meta-v")) ; Statement: $r3 = virtualinvoke r32.<org.apache.dubbo.common.URL: java.lang.Object getAttribute(java.lang.String)>("meta-v") 
(assert true)
(define-const var3520 Bool false) ; Statement: z5 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>($r3) 
(define-const var2251 Bool var3765_support/1207467391) ; Statement: $z0 = staticinvoke <org.apache.dubbo.metadata.MetadataServiceV2Detector: boolean support()>() 
 ; Statement: if $z0 != 0 goto $z4 = staticinvoke <org.apache.dubbo.common.aot.NativeDetector: boolean inNativeImage()>() 
(assert (not (= (ite var2251 1 0) 0))) ; Cond: $z0 != 0 
(define-const var3451 Bool var1933_inNativeImage/-778320806) ; Statement: $z4 = staticinvoke <org.apache.dubbo.common.aot.NativeDetector: boolean inNativeImage()>() 
 ; Statement: if z5 == 0 goto $r5 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.rpc.model.ModuleModel getInternalModule()>() 
(assert (= (ite var3520 1 0) 0)) ; Cond: z5 == 0 
(assert true)
(define-const var283 var196 (getInternalModule/890555230 var1293)) ; Statement: $r5 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.rpc.model.ModuleModel getInternalModule()>() 
(assert true)
(define-const var3829 var1679 (registerInternalConsumer/-577857373 var283 var2133!class var2569)) ; Statement: r35 = virtualinvoke $r5.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.rpc.model.ConsumerModel registerInternalConsumer(java.lang.Class,org.apache.dubbo.common.URL)>(class "Lorg/apache/dubbo/metadata/MetadataService;", r32) 
(assert true) ; Non Conditional
 ; Statement: if $z4 == 0 goto $r7 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/Protocol;") 
(assert (= (ite var3451 1 0) 0)) ; Cond: $z4 == 0 
(assert true)
(define-const var604 var2835 (getExtensionLoader/-514331157 (cast-from-var2269-to-var1536 var1293) var3062!class)) ; Statement: $r7 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/Protocol;") 
(assert true)
(define-const var779 String (getProtocol/491749358 var2569)) ; Statement: $r6 = virtualinvoke r32.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(assert true)
(define-const var801 var1786 (getExtension/-203349416 var604 var779 (ite (= 1 0) true false))) ; Statement: $r8 = virtualinvoke $r7.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getExtension(java.lang.String,boolean)>($r6, 0) 
(define-const var1398 var3062 (cast-from-var1786-to-var3062 var801)) ; Statement: $r24 = (org.apache.dubbo.rpc.Protocol) $r8 
(assert true)
(define-const var2945 var312 (setServiceModel/1097940449 var2569 (cast-from-var1679-to-var3840 var3829))) ; Statement: $r25 = virtualinvoke r32.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL setServiceModel(org.apache.dubbo.rpc.model.ServiceModel)>(r35) 
(define-const var1370 var312 var2945) ; Statement: r36 = $r25 
(assert true)
(define-const var1362 Bool (getParameter/2144001655 var2945 "auth" (ite (= 1 0) true false))) ; Statement: $z1 = virtualinvoke $r25.<org.apache.dubbo.common.URL: boolean getParameter(java.lang.String,boolean)>("auth", 0) 
 ; Statement: if $z1 == 0 goto $r9 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/ProxyFactory;") 
(assert (= (ite var1362 1 0) 0)) ; Cond: $z1 == 0 
(assert true)
(define-const var2280 var2835 (getExtensionLoader/-514331157 (cast-from-var2269-to-var1536 var1293) var159!class)) ; Statement: $r9 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/ProxyFactory;") 
(assert true)
(define-const var3169 var1786 (getAdaptiveExtension/-2068350643 var2280)) ; Statement: $r10 = virtualinvoke $r9.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getAdaptiveExtension()>() 
(define-const var1122 var159 (cast-from-var1786-to-var159 var3169)) ; Statement: $r23 = (org.apache.dubbo.rpc.ProxyFactory) $r10 
 ; Statement: if z5 == 0 goto r40 = interfaceinvoke $r24.<org.apache.dubbo.rpc.Protocol: org.apache.dubbo.rpc.Invoker refer(java.lang.Class,org.apache.dubbo.common.URL)>(class "Lorg/apache/dubbo/metadata/MetadataService;", r36) 
(assert (= (ite var3520 1 0) 0)) ; Cond: z5 == 0 
(define-const var2033 var2979 (var3062_refer/-581737709 var1398 var2133!class var1370)) ; Statement: r40 = interfaceinvoke $r24.<org.apache.dubbo.rpc.Protocol: org.apache.dubbo.rpc.Invoker refer(java.lang.Class,org.apache.dubbo.common.URL)>(class "Lorg/apache/dubbo/metadata/MetadataService;", r36) 
(assert true)
(define-const var901 Bool (getParameter/2144001655 var1370 "auth" (ite (= 1 0) true false))) ; Statement: $z2 = virtualinvoke r36.<org.apache.dubbo.common.URL: boolean getParameter(java.lang.String,boolean)>("auth", 0) 
 ; Statement: if $z2 == 0 goto $r11 = new org.apache.dubbo.registry.client.metadata.MetadataUtils$RemoteMetadataService 
(assert (= (ite var901 1 0) 0)) ; Cond: $z2 == 0 
(define-const var3164 var3890 var3890-init) ; Statement: $r11 = new org.apache.dubbo.registry.client.metadata.MetadataUtils$RemoteMetadataService 
(define-const var2516 var1786 (var159_getProxy/-84091048 var1122 var2033)) ; Statement: $r12 = interfaceinvoke $r23.<org.apache.dubbo.rpc.ProxyFactory: java.lang.Object getProxy(org.apache.dubbo.rpc.Invoker)>(r40) 
(define-const var3042 var2133 (cast-from-var1786-to-var2133 var2516)) ; Statement: $r13 = (org.apache.dubbo.metadata.MetadataService) $r12 
(assert true)
;(assert (<init>/-627934689 var3164 var3829 var3042 var364)) ; Statement: specialinvoke $r11.<org.apache.dubbo.registry.client.metadata.MetadataUtils$RemoteMetadataService: void <init>(org.apache.dubbo.rpc.model.ConsumerModel,org.apache.dubbo.metadata.MetadataService,org.apache.dubbo.rpc.model.ModuleModel)>(r35, $r13, r2) 

(declare-const var3164!1 var3890)
(declare-const var3829!1 var1679)
(declare-const var3042!1 var2133)
(declare-const var364!1 var196)
(define-const var1835 var3890 var3164!1) ; Statement: r39 = $r11 
(assert true) ; Non Conditional
(assert true)
(define-const var928 var1786 (getInternalProxy/-208446410 var1835)) ; Statement: $r42 = virtualinvoke r39.<org.apache.dubbo.registry.client.metadata.MetadataUtils$RemoteMetadataService: java.lang.Object getInternalProxy()>() 
(assert true)
(define-const var2799 var2083 (getServiceMetadata/703324177 (cast-from-var1679-to-var3840 var3829!1))) ; Statement: $r43 = virtualinvoke r35.<org.apache.dubbo.rpc.model.ConsumerModel: org.apache.dubbo.rpc.model.ServiceMetadata getServiceMetadata()>() 
(assert true)
;(assert (setTarget/-251600361 var2799 var928)) ; Statement: virtualinvoke $r43.<org.apache.dubbo.rpc.model.ServiceMetadata: void setTarget(java.lang.Object)>($r42) 

(declare-const var2799!1 var2083)
(declare-const var928!1 var1786)
(assert true)
(define-const var1736 var2083 (getServiceMetadata/703324177 (cast-from-var1679-to-var3840 var3829!1))) ; Statement: $r44 = virtualinvoke r35.<org.apache.dubbo.rpc.model.ConsumerModel: org.apache.dubbo.rpc.model.ServiceMetadata getServiceMetadata()>() 
(assert true)
;(assert (addAttribute/-751097508 var1736 "refClass" var928!1)) ; Statement: virtualinvoke $r44.<org.apache.dubbo.rpc.model.ServiceMetadata: void addAttribute(java.lang.String,java.lang.Object)>("refClass", $r42) 

(declare-const var1736!1 var2083)
(declare-const var874 String)
(declare-const var928!2 var1786)
(assert true)
;(assert (setProxyObject/-1035565173 (cast-from-var1679-to-var3840 var3829!1) var928!2)) ; Statement: virtualinvoke r35.<org.apache.dubbo.rpc.model.ConsumerModel: void setProxyObject(java.lang.Object)>($r42) 

(declare-const var3829!2 var1679)
(declare-const var928!3 var1786)
(assert true)
;(assert (initMethodModels/299763735 var3829!2)) ; Statement: virtualinvoke r35.<org.apache.dubbo.rpc.model.ConsumerModel: void initMethodModels()>() 

(declare-const var3829!3 var1679)
 ; Statement: return r39 
(check-sat)
; {var438_buildMetadataUrl/1386040074=([org.apache.dubbo.registry.client.ServiceInstance], org.apache.dubbo.common.URL), var1890_getApplicationModel/1173884853=([org.apache.dubbo.registry.client.ServiceInstance], org.apache.dubbo.rpc.model.ApplicationModel), getInternalModule/890555230=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.rpc.model.ModuleModel), getAttribute/-225665909=([org.apache.dubbo.common.URL, java.lang.String], java.lang.Object), var3765_support/1207467391=([], boolean), var1933_inNativeImage/-778320806=([], boolean), registerInternalConsumer/-577857373=([org.apache.dubbo.rpc.model.ModuleModel, java.lang.Class, org.apache.dubbo.common.URL], org.apache.dubbo.rpc.model.ConsumerModel), getExtensionLoader/-514331157=([org.apache.dubbo.common.extension.ExtensionAccessor, java.lang.Class], org.apache.dubbo.common.extension.ExtensionLoader), cast-from-var2269-to-var1536=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.common.extension.ExtensionAccessor), getProtocol/491749358=([org.apache.dubbo.common.URL], java.lang.String), getExtension/-203349416=([org.apache.dubbo.common.extension.ExtensionLoader, java.lang.String, boolean], java.lang.Object), cast-from-var1786-to-var3062=([java.lang.Object], org.apache.dubbo.rpc.Protocol), setServiceModel/1097940449=([org.apache.dubbo.common.URL, org.apache.dubbo.rpc.model.ServiceModel], org.apache.dubbo.common.URL), cast-from-var1679-to-var3840=([org.apache.dubbo.rpc.model.ConsumerModel], org.apache.dubbo.rpc.model.ServiceModel), getParameter/2144001655=([org.apache.dubbo.common.URL, java.lang.String, boolean], boolean), getAdaptiveExtension/-2068350643=([org.apache.dubbo.common.extension.ExtensionLoader], java.lang.Object), cast-from-var1786-to-var159=([java.lang.Object], org.apache.dubbo.rpc.ProxyFactory), var3062_refer/-581737709=([org.apache.dubbo.rpc.Protocol, java.lang.Class, org.apache.dubbo.common.URL], org.apache.dubbo.rpc.Invoker), var3890-init=([], org.apache.dubbo.registry.client.metadata.MetadataUtils$RemoteMetadataService), var159_getProxy/-84091048=([org.apache.dubbo.rpc.ProxyFactory, org.apache.dubbo.rpc.Invoker], java.lang.Object), cast-from-var1786-to-var2133=([java.lang.Object], org.apache.dubbo.metadata.MetadataService), <init>/-627934689=([org.apache.dubbo.registry.client.metadata.MetadataUtils$RemoteMetadataService, org.apache.dubbo.rpc.model.ConsumerModel, org.apache.dubbo.metadata.MetadataService, org.apache.dubbo.rpc.model.ModuleModel], void), getInternalProxy/-208446410=([org.apache.dubbo.registry.client.metadata.MetadataUtils$RemoteMetadataService], java.lang.Object), getServiceMetadata/703324177=([org.apache.dubbo.rpc.model.ServiceModel], org.apache.dubbo.rpc.model.ServiceMetadata), setTarget/-251600361=([org.apache.dubbo.rpc.model.ServiceMetadata, java.lang.Object], void), addAttribute/-751097508=([org.apache.dubbo.rpc.model.ServiceMetadata, java.lang.String, java.lang.Object], void), setProxyObject/-1035565173=([org.apache.dubbo.rpc.model.ServiceModel, java.lang.Object], void), initMethodModels/299763735=([org.apache.dubbo.rpc.model.ConsumerModel], void)}
; {var1890=org.apache.dubbo.registry.client.ServiceInstance, var2226=r0, var312=org.apache.dubbo.common.URL, var438=org.apache.dubbo.registry.client.metadata.MetadataUtils, var2569=r32, var2269=org.apache.dubbo.rpc.model.ApplicationModel, var1293=r1, var196=org.apache.dubbo.rpc.model.ModuleModel, var364=r2, var462=$r4, var1786=java.lang.Object, var2261=$r3, var3520=z5, var3765=org.apache.dubbo.metadata.MetadataServiceV2Detector, var2251=$z0, var1933=org.apache.dubbo.common.aot.NativeDetector, var3451=$z4, var283=$r5, var1679=org.apache.dubbo.rpc.model.ConsumerModel, var2133=org.apache.dubbo.metadata.MetadataService, var3829=r35, var2835=org.apache.dubbo.common.extension.ExtensionLoader, var3062=org.apache.dubbo.rpc.Protocol, var1536=org.apache.dubbo.common.extension.ExtensionAccessor, var604=$r7, var779=$r6, var801=$r8, var1398=$r24, var3840=org.apache.dubbo.rpc.model.ServiceModel, var2945=$r25, var1370=r36, var1362=$z1, var159=org.apache.dubbo.rpc.ProxyFactory, var2280=$r9, var3169=$r10, var1122=$r23, var2979=org.apache.dubbo.rpc.Invoker, var2033=r40, var901=$z2, var3890=org.apache.dubbo.registry.client.metadata.MetadataUtils$RemoteMetadataService, var3164=$r11, var2516=$r12, var3042=$r13, var1835=r39, var928=$r42, var2083=org.apache.dubbo.rpc.model.ServiceMetadata, var2799=$r43, var1736=$r44, var874="refClass"}
; {org.apache.dubbo.registry.client.ServiceInstance=var1890, r0=var2226, org.apache.dubbo.common.URL=var312, org.apache.dubbo.registry.client.metadata.MetadataUtils=var438, r32=var2569, org.apache.dubbo.rpc.model.ApplicationModel=var2269, r1=var1293, org.apache.dubbo.rpc.model.ModuleModel=var196, r2=var364, $r4=var462, java.lang.Object=var1786, $r3=var2261, z5=var3520, org.apache.dubbo.metadata.MetadataServiceV2Detector=var3765, $z0=var2251, org.apache.dubbo.common.aot.NativeDetector=var1933, $z4=var3451, $r5=var283, org.apache.dubbo.rpc.model.ConsumerModel=var1679, org.apache.dubbo.metadata.MetadataService=var2133, r35=var3829, org.apache.dubbo.common.extension.ExtensionLoader=var2835, org.apache.dubbo.rpc.Protocol=var3062, org.apache.dubbo.common.extension.ExtensionAccessor=var1536, $r7=var604, $r6=var779, $r8=var801, $r24=var1398, org.apache.dubbo.rpc.model.ServiceModel=var3840, $r25=var2945, r36=var1370, $z1=var1362, org.apache.dubbo.rpc.ProxyFactory=var159, $r9=var2280, $r10=var3169, $r23=var1122, org.apache.dubbo.rpc.Invoker=var2979, r40=var2033, $z2=var901, org.apache.dubbo.registry.client.metadata.MetadataUtils$RemoteMetadataService=var3890, $r11=var3164, $r12=var2516, $r13=var3042, r39=var1835, $r42=var928, org.apache.dubbo.rpc.model.ServiceMetadata=var2083, $r43=var2799, $r44=var1736, "refClass"=var874}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.registry.client.ServiceInstance;	r32 = staticinvoke <org.apache.dubbo.registry.client.metadata.MetadataUtils: org.apache.dubbo.common.URL buildMetadataUrl(org.apache.dubbo.registry.client.ServiceInstance)>(r0);	r1 = interfaceinvoke r0.<org.apache.dubbo.registry.client.ServiceInstance: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel()>();	r2 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.rpc.model.ModuleModel getInternalModule()>();	$r4 = "2.0.0";	$r3 = virtualinvoke r32.<org.apache.dubbo.common.URL: java.lang.Object getAttribute(java.lang.String)>("meta-v");	z5 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>($r3);	$z0 = staticinvoke <org.apache.dubbo.metadata.MetadataServiceV2Detector: boolean support()>();	if $z0 != 0 goto $z4 = staticinvoke <org.apache.dubbo.common.aot.NativeDetector: boolean inNativeImage()>();	$z4 = staticinvoke <org.apache.dubbo.common.aot.NativeDetector: boolean inNativeImage()>();	if z5 == 0 goto $r5 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.rpc.model.ModuleModel getInternalModule()>();	$r5 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.rpc.model.ModuleModel getInternalModule()>();	r35 = virtualinvoke $r5.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.rpc.model.ConsumerModel registerInternalConsumer(java.lang.Class,org.apache.dubbo.common.URL)>(class "Lorg/apache/dubbo/metadata/MetadataService;", r32);	if $z4 == 0 goto $r7 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/Protocol;");	$r7 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/Protocol;");	$r6 = virtualinvoke r32.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	$r8 = virtualinvoke $r7.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getExtension(java.lang.String,boolean)>($r6, 0);	$r24 = (org.apache.dubbo.rpc.Protocol) $r8;	$r25 = virtualinvoke r32.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL setServiceModel(org.apache.dubbo.rpc.model.ServiceModel)>(r35);	r36 = $r25;	$z1 = virtualinvoke $r25.<org.apache.dubbo.common.URL: boolean getParameter(java.lang.String,boolean)>("auth", 0);	if $z1 == 0 goto $r9 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/ProxyFactory;");	$r9 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/ProxyFactory;");	$r10 = virtualinvoke $r9.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getAdaptiveExtension()>();	$r23 = (org.apache.dubbo.rpc.ProxyFactory) $r10;	if z5 == 0 goto r40 = interfaceinvoke $r24.<org.apache.dubbo.rpc.Protocol: org.apache.dubbo.rpc.Invoker refer(java.lang.Class,org.apache.dubbo.common.URL)>(class "Lorg/apache/dubbo/metadata/MetadataService;", r36);	r40 = interfaceinvoke $r24.<org.apache.dubbo.rpc.Protocol: org.apache.dubbo.rpc.Invoker refer(java.lang.Class,org.apache.dubbo.common.URL)>(class "Lorg/apache/dubbo/metadata/MetadataService;", r36);	$z2 = virtualinvoke r36.<org.apache.dubbo.common.URL: boolean getParameter(java.lang.String,boolean)>("auth", 0);	if $z2 == 0 goto $r11 = new org.apache.dubbo.registry.client.metadata.MetadataUtils$RemoteMetadataService;	$r11 = new org.apache.dubbo.registry.client.metadata.MetadataUtils$RemoteMetadataService;	$r12 = interfaceinvoke $r23.<org.apache.dubbo.rpc.ProxyFactory: java.lang.Object getProxy(org.apache.dubbo.rpc.Invoker)>(r40);	$r13 = (org.apache.dubbo.metadata.MetadataService) $r12;	specialinvoke $r11.<org.apache.dubbo.registry.client.metadata.MetadataUtils$RemoteMetadataService: void <init>(org.apache.dubbo.rpc.model.ConsumerModel,org.apache.dubbo.metadata.MetadataService,org.apache.dubbo.rpc.model.ModuleModel)>(r35, $r13, r2);	r39 = $r11;	$r42 = virtualinvoke r39.<org.apache.dubbo.registry.client.metadata.MetadataUtils$RemoteMetadataService: java.lang.Object getInternalProxy()>();	$r43 = virtualinvoke r35.<org.apache.dubbo.rpc.model.ConsumerModel: org.apache.dubbo.rpc.model.ServiceMetadata getServiceMetadata()>();	virtualinvoke $r43.<org.apache.dubbo.rpc.model.ServiceMetadata: void setTarget(java.lang.Object)>($r42);	$r44 = virtualinvoke r35.<org.apache.dubbo.rpc.model.ConsumerModel: org.apache.dubbo.rpc.model.ServiceMetadata getServiceMetadata()>();	virtualinvoke $r44.<org.apache.dubbo.rpc.model.ServiceMetadata: void addAttribute(java.lang.String,java.lang.Object)>("refClass", $r42);	virtualinvoke r35.<org.apache.dubbo.rpc.model.ConsumerModel: void setProxyObject(java.lang.Object)>($r42);	virtualinvoke r35.<org.apache.dubbo.rpc.model.ConsumerModel: void initMethodModels()>();	return r39
;block_num 9