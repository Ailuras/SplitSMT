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

(declare-sort var3430 0)
(declare-sort var2590 0)
(declare-sort var3478 0)
(declare-sort var1557 0)
(declare-sort var3810 0)
(declare-sort var798 0)
(declare-sort var2048 0)
(declare-sort var3926 0)
(declare-sort var1470 0)
(declare-sort var3129 0)
(declare-sort var3807 0)
(declare-sort var1975 0)
(declare-sort var2823 0)
(declare-sort var1122 0)
(declare-sort var121 0)
(declare-sort var240 0)
(declare-sort var1947 0)
(declare-sort var2490 0)
(declare-sort var1306 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var3129!class ClassObject)
(declare-const var1975!class ClassObject)
(declare-const var121!class ClassObject)
(declare-const var1947!class ClassObject)
(declare-fun var3478_buildMetadataUrl/1386040074 (var3430) var2590)
(declare-fun var3430_getApplicationModel/1173884853 (var3430) var1557)
(declare-fun getInternalModule/890555230 (var1557) var3810)
(declare-fun getAttribute/-225665909 (var2590 String) var798)
(declare-fun var2048_support/1207467391 () Bool)
(declare-fun var3926_inNativeImage/-778320806 () Bool)
(declare-fun registerInternalConsumer/-577857373 (var3810 ClassObject var2590) var1470)
(declare-fun getExtensionLoader/-514331157 (var2823 ClassObject) var3807)
(declare-fun cast-from-var1557-to-var2823 (var1557) var2823)
(declare-fun getProtocol/491749358 (var2590) String)
(declare-fun getExtension/-203349416 (var3807 String Bool) var798)
(declare-fun cast-from-var798-to-var1975 (var798) var1975)
(declare-fun setServiceModel/1097940449 (var2590 var1122) var2590)
(declare-fun cast-from-var1470-to-var1122 (var1470) var1122)
(declare-fun getParameter/2144001655 (var2590 String Bool) Bool)
(declare-fun getAdaptiveExtension/-2068350643 (var3807) var798)
(declare-fun cast-from-var798-to-var121 (var798) var121)
(declare-fun var1975_refer/-581737709 (var1975 ClassObject var2590) var240)
(declare-fun var2490-init () var2490)
(declare-fun var121_getProxy/-84091048 (var121 var240) var798)
(declare-fun cast-from-var798-to-var1947 (var798) var1947)
(declare-fun <init>/24939971 (var2490 var1470 var1947 var3810) void)
(declare-fun getInternalProxy/-208446410 (var2490) var798)
(declare-fun getServiceMetadata/703324177 (var1122) var1306)
(declare-fun setTarget/-251600361 (var1306 var798) void)
(declare-fun addAttribute/-751097508 (var1306 String var798) void)
(declare-fun setProxyObject/-1035565173 (var1122 var798) void)
(declare-fun initMethodModels/299763735 (var1470) void)
(declare-const null-var3430 var3430)
(declare-const var2697 var3430) ; Statement: r0 := @parameter0: org.apache.dubbo.registry.client.ServiceInstance 
(assert (not (= var2697 null-var3430)))
(define-const var822 var2590 (var3478_buildMetadataUrl/1386040074 var2697)) ; Statement: r32 = staticinvoke <org.apache.dubbo.registry.client.metadata.MetadataUtils: org.apache.dubbo.common.URL buildMetadataUrl(org.apache.dubbo.registry.client.ServiceInstance)>(r0) 
(define-const var199 var1557 (var3430_getApplicationModel/1173884853 var2697)) ; Statement: r1 = interfaceinvoke r0.<org.apache.dubbo.registry.client.ServiceInstance: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel()>() 
(assert true)
(define-const var2871 var3810 (getInternalModule/890555230 var199)) ; Statement: r2 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.rpc.model.ModuleModel getInternalModule()>() 
(define-const var1512 String "2.0.0") ; Statement: $r4 = "2.0.0" 
(assert true)
(define-const var3153 var798 (getAttribute/-225665909 var822 "meta-v")) ; Statement: $r3 = virtualinvoke r32.<org.apache.dubbo.common.URL: java.lang.Object getAttribute(java.lang.String)>("meta-v") 
(assert true)
(define-const var465 Bool false) ; Statement: z5 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>($r3) 
(define-const var2416 Bool var2048_support/1207467391) ; Statement: $z0 = staticinvoke <org.apache.dubbo.metadata.MetadataServiceV2Detector: boolean support()>() 
 ; Statement: if $z0 != 0 goto $z4 = staticinvoke <org.apache.dubbo.common.aot.NativeDetector: boolean inNativeImage()>() 
(assert (not (= (ite var2416 1 0) 0))) ; Cond: $z0 != 0 
(define-const var2856 Bool var3926_inNativeImage/-778320806) ; Statement: $z4 = staticinvoke <org.apache.dubbo.common.aot.NativeDetector: boolean inNativeImage()>() 
 ; Statement: if z5 == 0 goto $r5 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.rpc.model.ModuleModel getInternalModule()>() 
(assert (= (ite var465 1 0) 0)) ; Cond: z5 == 0 
(assert true)
(define-const var593 var3810 (getInternalModule/890555230 var199)) ; Statement: $r5 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.rpc.model.ModuleModel getInternalModule()>() 
(assert true)
(define-const var2663 var1470 (registerInternalConsumer/-577857373 var593 var3129!class var822)) ; Statement: r35 = virtualinvoke $r5.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.rpc.model.ConsumerModel registerInternalConsumer(java.lang.Class,org.apache.dubbo.common.URL)>(class "Lorg/apache/dubbo/metadata/MetadataService;", r32) 
(assert true) ; Non Conditional
 ; Statement: if $z4 == 0 goto $r7 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/Protocol;") 
(assert (= (ite var2856 1 0) 0)) ; Cond: $z4 == 0 
(assert true)
(define-const var2245 var3807 (getExtensionLoader/-514331157 (cast-from-var1557-to-var2823 var199) var1975!class)) ; Statement: $r7 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/Protocol;") 
(assert true)
(define-const var3147 String (getProtocol/491749358 var822)) ; Statement: $r6 = virtualinvoke r32.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(assert true)
(define-const var665 var798 (getExtension/-203349416 var2245 var3147 (ite (= 1 0) true false))) ; Statement: $r8 = virtualinvoke $r7.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getExtension(java.lang.String,boolean)>($r6, 0) 
(define-const var334 var1975 (cast-from-var798-to-var1975 var665)) ; Statement: $r24 = (org.apache.dubbo.rpc.Protocol) $r8 
(assert true)
(define-const var2090 var2590 (setServiceModel/1097940449 var822 (cast-from-var1470-to-var1122 var2663))) ; Statement: $r25 = virtualinvoke r32.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL setServiceModel(org.apache.dubbo.rpc.model.ServiceModel)>(r35) 
(define-const var3712 var2590 var2090) ; Statement: r36 = $r25 
(assert true)
(define-const var2034 Bool (getParameter/2144001655 var2090 "auth" (ite (= 1 0) true false))) ; Statement: $z1 = virtualinvoke $r25.<org.apache.dubbo.common.URL: boolean getParameter(java.lang.String,boolean)>("auth", 0) 
 ; Statement: if $z1 == 0 goto $r9 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/ProxyFactory;") 
(assert (= (ite var2034 1 0) 0)) ; Cond: $z1 == 0 
(assert true)
(define-const var2615 var3807 (getExtensionLoader/-514331157 (cast-from-var1557-to-var2823 var199) var121!class)) ; Statement: $r9 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/ProxyFactory;") 
(assert true)
(define-const var3341 var798 (getAdaptiveExtension/-2068350643 var2615)) ; Statement: $r10 = virtualinvoke $r9.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getAdaptiveExtension()>() 
(define-const var3853 var121 (cast-from-var798-to-var121 var3341)) ; Statement: $r23 = (org.apache.dubbo.rpc.ProxyFactory) $r10 
 ; Statement: if z5 == 0 goto r40 = interfaceinvoke $r24.<org.apache.dubbo.rpc.Protocol: org.apache.dubbo.rpc.Invoker refer(java.lang.Class,org.apache.dubbo.common.URL)>(class "Lorg/apache/dubbo/metadata/MetadataService;", r36) 
(assert (not (= (ite var465 1 0) 0))) ; Negate: Cond: z5 == 0  
(define-const var3460 var240 (var1975_refer/-581737709 var334 var1947!class var3712)) ; Statement: r37 = interfaceinvoke $r24.<org.apache.dubbo.rpc.Protocol: org.apache.dubbo.rpc.Invoker refer(java.lang.Class,org.apache.dubbo.common.URL)>(class "Lorg/apache/dubbo/metadata/MetadataServiceV2;", r36) 
(assert true)
(define-const var2129 Bool (getParameter/2144001655 var3712 "auth" (ite (= 1 0) true false))) ; Statement: $z3 = virtualinvoke r36.<org.apache.dubbo.common.URL: boolean getParameter(java.lang.String,boolean)>("auth", 0) 
 ; Statement: if $z3 == 0 goto $r17 = new org.apache.dubbo.registry.client.metadata.MetadataUtils$RemoteMetadataService 
(assert (= (ite var2129 1 0) 0)) ; Cond: $z3 == 0 
(define-const var1044 var2490 var2490-init) ; Statement: $r17 = new org.apache.dubbo.registry.client.metadata.MetadataUtils$RemoteMetadataService 
(define-const var330 var798 (var121_getProxy/-84091048 var3853 var3460)) ; Statement: $r18 = interfaceinvoke $r23.<org.apache.dubbo.rpc.ProxyFactory: java.lang.Object getProxy(org.apache.dubbo.rpc.Invoker)>(r37) 
(define-const var3978 var1947 (cast-from-var798-to-var1947 var330)) ; Statement: $r19 = (org.apache.dubbo.metadata.MetadataServiceV2) $r18 
(assert true)
;(assert (<init>/24939971 var1044 var2663 var3978 var2871)) ; Statement: specialinvoke $r17.<org.apache.dubbo.registry.client.metadata.MetadataUtils$RemoteMetadataService: void <init>(org.apache.dubbo.rpc.model.ConsumerModel,org.apache.dubbo.metadata.MetadataServiceV2,org.apache.dubbo.rpc.model.ModuleModel)>(r35, $r19, r2) 

(declare-const var1044!1 var2490)
(declare-const var2663!1 var1470)
(declare-const var3978!1 var1947)
(declare-const var2871!1 var3810)
(define-const var1514 var2490 var1044!1) ; Statement: r39 = $r17 
 ; Statement: goto [?= $r42 = virtualinvoke r39.<org.apache.dubbo.registry.client.metadata.MetadataUtils$RemoteMetadataService: java.lang.Object getInternalProxy()>()] 
(assert true) ; Non Conditional
(assert true)
(define-const var3971 var798 (getInternalProxy/-208446410 var1514)) ; Statement: $r42 = virtualinvoke r39.<org.apache.dubbo.registry.client.metadata.MetadataUtils$RemoteMetadataService: java.lang.Object getInternalProxy()>() 
(assert true)
(define-const var1032 var1306 (getServiceMetadata/703324177 (cast-from-var1470-to-var1122 var2663!1))) ; Statement: $r43 = virtualinvoke r35.<org.apache.dubbo.rpc.model.ConsumerModel: org.apache.dubbo.rpc.model.ServiceMetadata getServiceMetadata()>() 
(assert true)
;(assert (setTarget/-251600361 var1032 var3971)) ; Statement: virtualinvoke $r43.<org.apache.dubbo.rpc.model.ServiceMetadata: void setTarget(java.lang.Object)>($r42) 

(declare-const var1032!1 var1306)
(declare-const var3971!1 var798)
(assert true)
(define-const var2333 var1306 (getServiceMetadata/703324177 (cast-from-var1470-to-var1122 var2663!1))) ; Statement: $r44 = virtualinvoke r35.<org.apache.dubbo.rpc.model.ConsumerModel: org.apache.dubbo.rpc.model.ServiceMetadata getServiceMetadata()>() 
(assert true)
;(assert (addAttribute/-751097508 var2333 "refClass" var3971!1)) ; Statement: virtualinvoke $r44.<org.apache.dubbo.rpc.model.ServiceMetadata: void addAttribute(java.lang.String,java.lang.Object)>("refClass", $r42) 

(declare-const var2333!1 var1306)
(declare-const var37 String)
(declare-const var3971!2 var798)
(assert true)
;(assert (setProxyObject/-1035565173 (cast-from-var1470-to-var1122 var2663!1) var3971!2)) ; Statement: virtualinvoke r35.<org.apache.dubbo.rpc.model.ConsumerModel: void setProxyObject(java.lang.Object)>($r42) 

(declare-const var2663!2 var1470)
(declare-const var3971!3 var798)
(assert true)
;(assert (initMethodModels/299763735 var2663!2)) ; Statement: virtualinvoke r35.<org.apache.dubbo.rpc.model.ConsumerModel: void initMethodModels()>() 

(declare-const var2663!3 var1470)
 ; Statement: return r39 
(check-sat)
; {var3478_buildMetadataUrl/1386040074=([org.apache.dubbo.registry.client.ServiceInstance], org.apache.dubbo.common.URL), var3430_getApplicationModel/1173884853=([org.apache.dubbo.registry.client.ServiceInstance], org.apache.dubbo.rpc.model.ApplicationModel), getInternalModule/890555230=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.rpc.model.ModuleModel), getAttribute/-225665909=([org.apache.dubbo.common.URL, java.lang.String], java.lang.Object), var2048_support/1207467391=([], boolean), var3926_inNativeImage/-778320806=([], boolean), registerInternalConsumer/-577857373=([org.apache.dubbo.rpc.model.ModuleModel, java.lang.Class, org.apache.dubbo.common.URL], org.apache.dubbo.rpc.model.ConsumerModel), getExtensionLoader/-514331157=([org.apache.dubbo.common.extension.ExtensionAccessor, java.lang.Class], org.apache.dubbo.common.extension.ExtensionLoader), cast-from-var1557-to-var2823=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.common.extension.ExtensionAccessor), getProtocol/491749358=([org.apache.dubbo.common.URL], java.lang.String), getExtension/-203349416=([org.apache.dubbo.common.extension.ExtensionLoader, java.lang.String, boolean], java.lang.Object), cast-from-var798-to-var1975=([java.lang.Object], org.apache.dubbo.rpc.Protocol), setServiceModel/1097940449=([org.apache.dubbo.common.URL, org.apache.dubbo.rpc.model.ServiceModel], org.apache.dubbo.common.URL), cast-from-var1470-to-var1122=([org.apache.dubbo.rpc.model.ConsumerModel], org.apache.dubbo.rpc.model.ServiceModel), getParameter/2144001655=([org.apache.dubbo.common.URL, java.lang.String, boolean], boolean), getAdaptiveExtension/-2068350643=([org.apache.dubbo.common.extension.ExtensionLoader], java.lang.Object), cast-from-var798-to-var121=([java.lang.Object], org.apache.dubbo.rpc.ProxyFactory), var1975_refer/-581737709=([org.apache.dubbo.rpc.Protocol, java.lang.Class, org.apache.dubbo.common.URL], org.apache.dubbo.rpc.Invoker), var2490-init=([], org.apache.dubbo.registry.client.metadata.MetadataUtils$RemoteMetadataService), var121_getProxy/-84091048=([org.apache.dubbo.rpc.ProxyFactory, org.apache.dubbo.rpc.Invoker], java.lang.Object), cast-from-var798-to-var1947=([java.lang.Object], org.apache.dubbo.metadata.MetadataServiceV2), <init>/24939971=([org.apache.dubbo.registry.client.metadata.MetadataUtils$RemoteMetadataService, org.apache.dubbo.rpc.model.ConsumerModel, org.apache.dubbo.metadata.MetadataServiceV2, org.apache.dubbo.rpc.model.ModuleModel], void), getInternalProxy/-208446410=([org.apache.dubbo.registry.client.metadata.MetadataUtils$RemoteMetadataService], java.lang.Object), getServiceMetadata/703324177=([org.apache.dubbo.rpc.model.ServiceModel], org.apache.dubbo.rpc.model.ServiceMetadata), setTarget/-251600361=([org.apache.dubbo.rpc.model.ServiceMetadata, java.lang.Object], void), addAttribute/-751097508=([org.apache.dubbo.rpc.model.ServiceMetadata, java.lang.String, java.lang.Object], void), setProxyObject/-1035565173=([org.apache.dubbo.rpc.model.ServiceModel, java.lang.Object], void), initMethodModels/299763735=([org.apache.dubbo.rpc.model.ConsumerModel], void)}
; {var3430=org.apache.dubbo.registry.client.ServiceInstance, var2697=r0, var2590=org.apache.dubbo.common.URL, var3478=org.apache.dubbo.registry.client.metadata.MetadataUtils, var822=r32, var1557=org.apache.dubbo.rpc.model.ApplicationModel, var199=r1, var3810=org.apache.dubbo.rpc.model.ModuleModel, var2871=r2, var1512=$r4, var798=java.lang.Object, var3153=$r3, var465=z5, var2048=org.apache.dubbo.metadata.MetadataServiceV2Detector, var2416=$z0, var3926=org.apache.dubbo.common.aot.NativeDetector, var2856=$z4, var593=$r5, var1470=org.apache.dubbo.rpc.model.ConsumerModel, var3129=org.apache.dubbo.metadata.MetadataService, var2663=r35, var3807=org.apache.dubbo.common.extension.ExtensionLoader, var1975=org.apache.dubbo.rpc.Protocol, var2823=org.apache.dubbo.common.extension.ExtensionAccessor, var2245=$r7, var3147=$r6, var665=$r8, var334=$r24, var1122=org.apache.dubbo.rpc.model.ServiceModel, var2090=$r25, var3712=r36, var2034=$z1, var121=org.apache.dubbo.rpc.ProxyFactory, var2615=$r9, var3341=$r10, var3853=$r23, var240=org.apache.dubbo.rpc.Invoker, var1947=org.apache.dubbo.metadata.MetadataServiceV2, var3460=r37, var2129=$z3, var2490=org.apache.dubbo.registry.client.metadata.MetadataUtils$RemoteMetadataService, var1044=$r17, var330=$r18, var3978=$r19, var1514=r39, var3971=$r42, var1306=org.apache.dubbo.rpc.model.ServiceMetadata, var1032=$r43, var2333=$r44, var37="refClass"}
; {org.apache.dubbo.registry.client.ServiceInstance=var3430, r0=var2697, org.apache.dubbo.common.URL=var2590, org.apache.dubbo.registry.client.metadata.MetadataUtils=var3478, r32=var822, org.apache.dubbo.rpc.model.ApplicationModel=var1557, r1=var199, org.apache.dubbo.rpc.model.ModuleModel=var3810, r2=var2871, $r4=var1512, java.lang.Object=var798, $r3=var3153, z5=var465, org.apache.dubbo.metadata.MetadataServiceV2Detector=var2048, $z0=var2416, org.apache.dubbo.common.aot.NativeDetector=var3926, $z4=var2856, $r5=var593, org.apache.dubbo.rpc.model.ConsumerModel=var1470, org.apache.dubbo.metadata.MetadataService=var3129, r35=var2663, org.apache.dubbo.common.extension.ExtensionLoader=var3807, org.apache.dubbo.rpc.Protocol=var1975, org.apache.dubbo.common.extension.ExtensionAccessor=var2823, $r7=var2245, $r6=var3147, $r8=var665, $r24=var334, org.apache.dubbo.rpc.model.ServiceModel=var1122, $r25=var2090, r36=var3712, $z1=var2034, org.apache.dubbo.rpc.ProxyFactory=var121, $r9=var2615, $r10=var3341, $r23=var3853, org.apache.dubbo.rpc.Invoker=var240, org.apache.dubbo.metadata.MetadataServiceV2=var1947, r37=var3460, $z3=var2129, org.apache.dubbo.registry.client.metadata.MetadataUtils$RemoteMetadataService=var2490, $r17=var1044, $r18=var330, $r19=var3978, r39=var1514, $r42=var3971, org.apache.dubbo.rpc.model.ServiceMetadata=var1306, $r43=var1032, $r44=var2333, "refClass"=var37}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.registry.client.ServiceInstance;	r32 = staticinvoke <org.apache.dubbo.registry.client.metadata.MetadataUtils: org.apache.dubbo.common.URL buildMetadataUrl(org.apache.dubbo.registry.client.ServiceInstance)>(r0);	r1 = interfaceinvoke r0.<org.apache.dubbo.registry.client.ServiceInstance: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel()>();	r2 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.rpc.model.ModuleModel getInternalModule()>();	$r4 = "2.0.0";	$r3 = virtualinvoke r32.<org.apache.dubbo.common.URL: java.lang.Object getAttribute(java.lang.String)>("meta-v");	z5 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>($r3);	$z0 = staticinvoke <org.apache.dubbo.metadata.MetadataServiceV2Detector: boolean support()>();	if $z0 != 0 goto $z4 = staticinvoke <org.apache.dubbo.common.aot.NativeDetector: boolean inNativeImage()>();	$z4 = staticinvoke <org.apache.dubbo.common.aot.NativeDetector: boolean inNativeImage()>();	if z5 == 0 goto $r5 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.rpc.model.ModuleModel getInternalModule()>();	$r5 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.rpc.model.ModuleModel getInternalModule()>();	r35 = virtualinvoke $r5.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.rpc.model.ConsumerModel registerInternalConsumer(java.lang.Class,org.apache.dubbo.common.URL)>(class "Lorg/apache/dubbo/metadata/MetadataService;", r32);	if $z4 == 0 goto $r7 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/Protocol;");	$r7 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/Protocol;");	$r6 = virtualinvoke r32.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	$r8 = virtualinvoke $r7.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getExtension(java.lang.String,boolean)>($r6, 0);	$r24 = (org.apache.dubbo.rpc.Protocol) $r8;	$r25 = virtualinvoke r32.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL setServiceModel(org.apache.dubbo.rpc.model.ServiceModel)>(r35);	r36 = $r25;	$z1 = virtualinvoke $r25.<org.apache.dubbo.common.URL: boolean getParameter(java.lang.String,boolean)>("auth", 0);	if $z1 == 0 goto $r9 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/ProxyFactory;");	$r9 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/ProxyFactory;");	$r10 = virtualinvoke $r9.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getAdaptiveExtension()>();	$r23 = (org.apache.dubbo.rpc.ProxyFactory) $r10;	if z5 == 0 goto r40 = interfaceinvoke $r24.<org.apache.dubbo.rpc.Protocol: org.apache.dubbo.rpc.Invoker refer(java.lang.Class,org.apache.dubbo.common.URL)>(class "Lorg/apache/dubbo/metadata/MetadataService;", r36);	r37 = interfaceinvoke $r24.<org.apache.dubbo.rpc.Protocol: org.apache.dubbo.rpc.Invoker refer(java.lang.Class,org.apache.dubbo.common.URL)>(class "Lorg/apache/dubbo/metadata/MetadataServiceV2;", r36);	$z3 = virtualinvoke r36.<org.apache.dubbo.common.URL: boolean getParameter(java.lang.String,boolean)>("auth", 0);	if $z3 == 0 goto $r17 = new org.apache.dubbo.registry.client.metadata.MetadataUtils$RemoteMetadataService;	$r17 = new org.apache.dubbo.registry.client.metadata.MetadataUtils$RemoteMetadataService;	$r18 = interfaceinvoke $r23.<org.apache.dubbo.rpc.ProxyFactory: java.lang.Object getProxy(org.apache.dubbo.rpc.Invoker)>(r37);	$r19 = (org.apache.dubbo.metadata.MetadataServiceV2) $r18;	specialinvoke $r17.<org.apache.dubbo.registry.client.metadata.MetadataUtils$RemoteMetadataService: void <init>(org.apache.dubbo.rpc.model.ConsumerModel,org.apache.dubbo.metadata.MetadataServiceV2,org.apache.dubbo.rpc.model.ModuleModel)>(r35, $r19, r2);	r39 = $r17;	goto [?= $r42 = virtualinvoke r39.<org.apache.dubbo.registry.client.metadata.MetadataUtils$RemoteMetadataService: java.lang.Object getInternalProxy()>()];	$r42 = virtualinvoke r39.<org.apache.dubbo.registry.client.metadata.MetadataUtils$RemoteMetadataService: java.lang.Object getInternalProxy()>();	$r43 = virtualinvoke r35.<org.apache.dubbo.rpc.model.ConsumerModel: org.apache.dubbo.rpc.model.ServiceMetadata getServiceMetadata()>();	virtualinvoke $r43.<org.apache.dubbo.rpc.model.ServiceMetadata: void setTarget(java.lang.Object)>($r42);	$r44 = virtualinvoke r35.<org.apache.dubbo.rpc.model.ConsumerModel: org.apache.dubbo.rpc.model.ServiceMetadata getServiceMetadata()>();	virtualinvoke $r44.<org.apache.dubbo.rpc.model.ServiceMetadata: void addAttribute(java.lang.String,java.lang.Object)>("refClass", $r42);	virtualinvoke r35.<org.apache.dubbo.rpc.model.ConsumerModel: void setProxyObject(java.lang.Object)>($r42);	virtualinvoke r35.<org.apache.dubbo.rpc.model.ConsumerModel: void initMethodModels()>();	return r39
;block_num 9