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

(declare-sort var1513 0)
(declare-sort var1343 0)
(declare-sort var829 0)
(declare-sort var511 0)
(declare-sort var677 0)
(declare-sort var3614 0)
(declare-sort var1199 0)
(declare-sort var2475 0)
(declare-sort var256 0)
(declare-sort var568 0)
(declare-sort var893 0)
(declare-sort var1729 0)
(declare-sort var126 0)
(declare-sort var2393 0)
(declare-sort var3971 0)
(declare-sort var1105 0)
(declare-sort var1204 0)
(declare-sort var3964 0)
(declare-sort var1285 0)
(declare-sort var1591 0)
(declare-sort var40 0)
(declare-sort var515 0)
(declare-sort var620 0)
(declare-sort var1544 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun urls/2049477907 (var511) var829)
(declare-fun cast-from-var1513-to-var511 (var1513) var511)
(declare-fun var829_clear/2124191932 (var829) void)
(declare-fun meshModeHandleUrl/-1115739643 (var1513 var1343) void)
(declare-fun url/1800549272 (var677) String)
(declare-fun cast-from-var1513-to-var677 (var1513) var677)
(declare-fun var3614_isNotEmpty/-1251449450 (String) Bool)
(declare-fun parseUrl/-1515732928 (var1513 var1343) void)
(declare-fun createInvoker/249732378 (var1513) void)
(declare-fun var2475_isInfoEnabled/-651841081 (var2475) Bool)
(declare-fun cast-from-var1199-to-var2475 (var1199) var2475)
(declare-fun var256-init () var256)
(declare-fun var1343_get/1088891777 (var1343 var568) var568)
(declare-fun cast-from-String-to-var568 (String) var568)
(declare-fun cast-from-var568-to-String (var568) String)
(declare-fun <init>/-1145568936 (var256 String String Int String var1343) void)
(declare-fun getScopeModel/439405660 (var1729) var893)
(declare-fun cast-from-var1513-to-var1729 (var1513) var1729)
(declare-fun setScopeModel/-1563758557 (var126 var2393) var126)
(declare-fun cast-from-var256-to-var126 (var256) var126)
(declare-fun cast-from-var893-to-var2393 (var893) var2393)
(declare-fun consumerModel/624895015 (var1513) var3971)
(declare-fun setServiceModel/1097940449 (var126 var1105) var126)
(declare-fun cast-from-var3971-to-var1105 (var3971) var1105)
(declare-fun getServiceModel/-1583884111 (var1105) var1204)
(declare-fun getApplicationModel/-625877363 (var1285) var3964)
(declare-fun cast-from-var1513-to-var1285 (var1513) var1285)
(declare-fun var1591_publishServiceDefinition/-1436415640 (var126 var1204 var3964) void)
(declare-fun proxyFactory/624895015 (var1513) var40)
(declare-fun invoker/624895015 (var1513) var515)
(declare-fun generic/974719397 (var620) String)
(declare-fun cast-from-var1513-to-var620 (var1513) var620)
(declare-fun var1544_isGeneric/-443667814 (String) Bool)
(declare-fun var40_getProxy/1110343636 (var40 var515 Bool) var568)
(declare-const null-var1513 var1513)
(declare-const null-var1343 var1343)
(declare-const var1513-logger var1199)
(declare-const var3885 var1513) ; Statement: r0 := @this: org.apache.dubbo.config.ReferenceConfig 
(assert (not (= var3885 null-var1513)))
(declare-const var2358 var1343) ; Statement: r2 := @parameter0: java.util.Map 
(assert (not (= var2358 null-var1343)))
(define-const var3917 var829 (urls/2049477907 (cast-from-var1513-to-var511 var3885))) ; Statement: $r1 = r0.<org.apache.dubbo.config.ReferenceConfig: java.util.List urls> 
;(assert (var829_clear/2124191932 var3917)) ; Statement: interfaceinvoke $r1.<java.util.List: void clear()>() 

(declare-const var3917!1 var829)
(assert true)
;(assert (meshModeHandleUrl/-1115739643 var3885 var2358)) ; Statement: specialinvoke r0.<org.apache.dubbo.config.ReferenceConfig: void meshModeHandleUrl(java.util.Map)>(r2) 

(declare-const var3885!1 var1513)
(declare-const var2358!1 var1343)
(define-const var664 String (url/1800549272 (cast-from-var1513-to-var677 var3885!1))) ; Statement: $r3 = r0.<org.apache.dubbo.config.ReferenceConfig: java.lang.String url> 
(define-const var1798 Bool (var3614_isNotEmpty/-1251449450 var664)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r3) 
 ; Statement: if $z0 == 0 goto specialinvoke r0.<org.apache.dubbo.config.ReferenceConfig: void aggregateUrlFromRegistry(java.util.Map)>(r2) 
(assert (not (= (ite var1798 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
;(assert (parseUrl/-1515732928 var3885!1 var2358!1)) ; Statement: specialinvoke r0.<org.apache.dubbo.config.ReferenceConfig: void parseUrl(java.util.Map)>(r2) 

(declare-const var3885!2 var1513)
(declare-const var2358!2 var1343)
 ; Statement: goto [?= specialinvoke r0.<org.apache.dubbo.config.ReferenceConfig: void createInvoker()>()] 
(assert true) ; Non Conditional
(assert true)
;(assert (createInvoker/249732378 var3885!2)) ; Statement: specialinvoke r0.<org.apache.dubbo.config.ReferenceConfig: void createInvoker()>() 

(declare-const var3885!3 var1513)
(define-const var1689 var1199 var1513-logger) ; Statement: $r4 = <org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var164 Bool (var2475_isInfoEnabled/-651841081 (cast-from-var1199-to-var2475 var1689))) ; Statement: $z1 = interfaceinvoke $r4.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isInfoEnabled()>() 
 ; Statement: if $z1 == 0 goto $r17 = new org.apache.dubbo.common.url.component.ServiceConfigURL 
(assert (= (ite var164 1 0) 0)) ; Cond: $z1 == 0 
(define-const var2396 var256 var256-init) ; Statement: $r17 = new org.apache.dubbo.common.url.component.ServiceConfigURL 
(define-const var1583 var568 (var1343_get/1088891777 var2358!2 (cast-from-String-to-var568 "register.ip"))) ; Statement: $r18 = interfaceinvoke r2.<java.util.Map: java.lang.Object get(java.lang.Object)>("register.ip") 
(define-const var556 String (cast-from-var568-to-String var1583)) ; Statement: $r19 = (java.lang.String) $r18 
(define-const var115 var568 (var1343_get/1088891777 var2358!2 (cast-from-String-to-var568 "interface"))) ; Statement: $r20 = interfaceinvoke r2.<java.util.Map: java.lang.Object get(java.lang.Object)>("interface") 
(define-const var1087 String (cast-from-var568-to-String var115)) ; Statement: $r21 = (java.lang.String) $r20 
(assert true)
;(assert (<init>/-1145568936 var2396 "consumer" var556 0 var1087 var2358!2)) ; Statement: specialinvoke $r17.<org.apache.dubbo.common.url.component.ServiceConfigURL: void <init>(java.lang.String,java.lang.String,int,java.lang.String,java.util.Map)>("consumer", $r19, 0, $r21, r2) 

(declare-const var2396!1 var256)
(declare-const var1261 String)
(declare-const var556!1 String)
(declare-const var967 Int)
(declare-const var1087!1 String)
(declare-const var2358!3 var1343)
(assert true)
(define-const var355 var893 (getScopeModel/439405660 (cast-from-var1513-to-var1729 var3885!3))) ; Statement: $r22 = virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.rpc.model.ModuleModel getScopeModel()>() 
(assert true)
(define-const var1303 var126 (setScopeModel/-1563758557 (cast-from-var256-to-var126 var2396!1) (cast-from-var893-to-var2393 var355))) ; Statement: $r23 = virtualinvoke $r17.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL setScopeModel(org.apache.dubbo.rpc.model.ScopeModel)>($r22) 
(define-const var3951 var3971 (consumerModel/624895015 var3885!3)) ; Statement: $r24 = r0.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.rpc.model.ConsumerModel consumerModel> 
(assert true)
(define-const var3271 var126 (setServiceModel/1097940449 var1303 (cast-from-var3971-to-var1105 var3951))) ; Statement: $r25 = virtualinvoke $r23.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL setServiceModel(org.apache.dubbo.rpc.model.ServiceModel)>($r24) 
(define-const var2631 var3971 (consumerModel/624895015 var3885!3)) ; Statement: $r26 = r0.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.rpc.model.ConsumerModel consumerModel> 
(assert true)
(define-const var1435 var1204 (getServiceModel/-1583884111 (cast-from-var3971-to-var1105 var2631))) ; Statement: $r27 = virtualinvoke $r26.<org.apache.dubbo.rpc.model.ConsumerModel: org.apache.dubbo.rpc.model.ServiceDescriptor getServiceModel()>() 
(assert true)
(define-const var3502 var3964 (getApplicationModel/-625877363 (cast-from-var1513-to-var1285 var3885!3))) ; Statement: $r28 = virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel()>() 
;(assert (var1591_publishServiceDefinition/-1436415640 var3271 var1435 var3502)) ; Statement: staticinvoke <org.apache.dubbo.registry.client.metadata.MetadataUtils: void publishServiceDefinition(org.apache.dubbo.common.URL,org.apache.dubbo.rpc.model.ServiceDescriptor,org.apache.dubbo.rpc.model.ApplicationModel)>($r25, $r27, $r28) 

(declare-const var3271!1 var126)
(declare-const var1435!1 var1204)
(declare-const var3502!1 var3964)
(define-const var2441 var40 (proxyFactory/624895015 var3885!3)) ; Statement: $r29 = r0.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.rpc.ProxyFactory proxyFactory> 
(define-const var3707 var515 (invoker/624895015 var3885!3)) ; Statement: $r30 = r0.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.rpc.Invoker invoker> 
(define-const var1502 String (generic/974719397 (cast-from-var1513-to-var620 var3885!3))) ; Statement: $r31 = r0.<org.apache.dubbo.config.ReferenceConfig: java.lang.String generic> 
(define-const var3260 Bool (var1544_isGeneric/-443667814 var1502)) ; Statement: $z3 = staticinvoke <org.apache.dubbo.rpc.support.ProtocolUtils: boolean isGeneric(java.lang.String)>($r31) 
(define-const var608 var568 (var40_getProxy/1110343636 var2441 var3707 var3260)) ; Statement: $r32 = interfaceinvoke $r29.<org.apache.dubbo.rpc.ProxyFactory: java.lang.Object getProxy(org.apache.dubbo.rpc.Invoker,boolean)>($r30, $z3) 
 ; Statement: return $r32 
(check-sat)
; {urls/2049477907=([org.apache.dubbo.config.AbstractInterfaceConfig], java.util.List), cast-from-var1513-to-var511=([org.apache.dubbo.config.ReferenceConfig], org.apache.dubbo.config.AbstractInterfaceConfig), var829_clear/2124191932=([java.util.List], void), meshModeHandleUrl/-1115739643=([org.apache.dubbo.config.ReferenceConfig, java.util.Map], void), url/1800549272=([org.apache.dubbo.config.ReferenceConfigBase], java.lang.String), cast-from-var1513-to-var677=([org.apache.dubbo.config.ReferenceConfig], org.apache.dubbo.config.ReferenceConfigBase), var3614_isNotEmpty/-1251449450=([java.lang.String], boolean), parseUrl/-1515732928=([org.apache.dubbo.config.ReferenceConfig, java.util.Map], void), createInvoker/249732378=([org.apache.dubbo.config.ReferenceConfig], void), var2475_isInfoEnabled/-651841081=([org.apache.dubbo.common.logger.Logger], boolean), cast-from-var1199-to-var2475=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), var256-init=([], org.apache.dubbo.common.url.component.ServiceConfigURL), var1343_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var568=([java.lang.String], java.lang.Object), cast-from-var568-to-String=([java.lang.Object], java.lang.String), <init>/-1145568936=([org.apache.dubbo.common.url.component.ServiceConfigURL, java.lang.String, java.lang.String, int, java.lang.String, java.util.Map], void), getScopeModel/439405660=([org.apache.dubbo.config.AbstractMethodConfig], org.apache.dubbo.rpc.model.ModuleModel), cast-from-var1513-to-var1729=([org.apache.dubbo.config.ReferenceConfig], org.apache.dubbo.config.AbstractMethodConfig), setScopeModel/-1563758557=([org.apache.dubbo.common.URL, org.apache.dubbo.rpc.model.ScopeModel], org.apache.dubbo.common.URL), cast-from-var256-to-var126=([org.apache.dubbo.common.url.component.ServiceConfigURL], org.apache.dubbo.common.URL), cast-from-var893-to-var2393=([org.apache.dubbo.rpc.model.ModuleModel], org.apache.dubbo.rpc.model.ScopeModel), consumerModel/624895015=([org.apache.dubbo.config.ReferenceConfig], org.apache.dubbo.rpc.model.ConsumerModel), setServiceModel/1097940449=([org.apache.dubbo.common.URL, org.apache.dubbo.rpc.model.ServiceModel], org.apache.dubbo.common.URL), cast-from-var3971-to-var1105=([org.apache.dubbo.rpc.model.ConsumerModel], org.apache.dubbo.rpc.model.ServiceModel), getServiceModel/-1583884111=([org.apache.dubbo.rpc.model.ServiceModel], org.apache.dubbo.rpc.model.ServiceDescriptor), getApplicationModel/-625877363=([org.apache.dubbo.config.AbstractConfig], org.apache.dubbo.rpc.model.ApplicationModel), cast-from-var1513-to-var1285=([org.apache.dubbo.config.ReferenceConfig], org.apache.dubbo.config.AbstractConfig), var1591_publishServiceDefinition/-1436415640=([org.apache.dubbo.common.URL, org.apache.dubbo.rpc.model.ServiceDescriptor, org.apache.dubbo.rpc.model.ApplicationModel], void), proxyFactory/624895015=([org.apache.dubbo.config.ReferenceConfig], org.apache.dubbo.rpc.ProxyFactory), invoker/624895015=([org.apache.dubbo.config.ReferenceConfig], org.apache.dubbo.rpc.Invoker), generic/974719397=([org.apache.dubbo.config.AbstractReferenceConfig], java.lang.String), cast-from-var1513-to-var620=([org.apache.dubbo.config.ReferenceConfig], org.apache.dubbo.config.AbstractReferenceConfig), var1544_isGeneric/-443667814=([java.lang.String], boolean), var40_getProxy/1110343636=([org.apache.dubbo.rpc.ProxyFactory, org.apache.dubbo.rpc.Invoker, boolean], java.lang.Object)}
; {var1513=org.apache.dubbo.config.ReferenceConfig, var3885=r0, var1343=java.util.Map, var2358=r2, var829=java.util.List, var511=org.apache.dubbo.config.AbstractInterfaceConfig, var3917=$r1, var677=org.apache.dubbo.config.ReferenceConfigBase, var664=$r3, var3614=org.apache.dubbo.common.utils.StringUtils, var1798=$z0, var1199=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1689=$r4, var2475=org.apache.dubbo.common.logger.Logger, var164=$z1, var256=org.apache.dubbo.common.url.component.ServiceConfigURL, var2396=$r17, var568=java.lang.Object, var1583=$r18, var556=$r19, var115=$r20, var1087=$r21, var1261="consumer", var967=0, var893=org.apache.dubbo.rpc.model.ModuleModel, var1729=org.apache.dubbo.config.AbstractMethodConfig, var355=$r22, var126=org.apache.dubbo.common.URL, var2393=org.apache.dubbo.rpc.model.ScopeModel, var1303=$r23, var3971=org.apache.dubbo.rpc.model.ConsumerModel, var3951=$r24, var1105=org.apache.dubbo.rpc.model.ServiceModel, var3271=$r25, var2631=$r26, var1204=org.apache.dubbo.rpc.model.ServiceDescriptor, var1435=$r27, var3964=org.apache.dubbo.rpc.model.ApplicationModel, var1285=org.apache.dubbo.config.AbstractConfig, var3502=$r28, var1591=org.apache.dubbo.registry.client.metadata.MetadataUtils, var40=org.apache.dubbo.rpc.ProxyFactory, var2441=$r29, var515=org.apache.dubbo.rpc.Invoker, var3707=$r30, var620=org.apache.dubbo.config.AbstractReferenceConfig, var1502=$r31, var1544=org.apache.dubbo.rpc.support.ProtocolUtils, var3260=$z3, var608=$r32}
; {org.apache.dubbo.config.ReferenceConfig=var1513, r0=var3885, java.util.Map=var1343, r2=var2358, java.util.List=var829, org.apache.dubbo.config.AbstractInterfaceConfig=var511, $r1=var3917, org.apache.dubbo.config.ReferenceConfigBase=var677, $r3=var664, org.apache.dubbo.common.utils.StringUtils=var3614, $z0=var1798, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1199, $r4=var1689, org.apache.dubbo.common.logger.Logger=var2475, $z1=var164, org.apache.dubbo.common.url.component.ServiceConfigURL=var256, $r17=var2396, java.lang.Object=var568, $r18=var1583, $r19=var556, $r20=var115, $r21=var1087, "consumer"=var1261, 0=var967, org.apache.dubbo.rpc.model.ModuleModel=var893, org.apache.dubbo.config.AbstractMethodConfig=var1729, $r22=var355, org.apache.dubbo.common.URL=var126, org.apache.dubbo.rpc.model.ScopeModel=var2393, $r23=var1303, org.apache.dubbo.rpc.model.ConsumerModel=var3971, $r24=var3951, org.apache.dubbo.rpc.model.ServiceModel=var1105, $r25=var3271, $r26=var2631, org.apache.dubbo.rpc.model.ServiceDescriptor=var1204, $r27=var1435, org.apache.dubbo.rpc.model.ApplicationModel=var3964, org.apache.dubbo.config.AbstractConfig=var1285, $r28=var3502, org.apache.dubbo.registry.client.metadata.MetadataUtils=var1591, org.apache.dubbo.rpc.ProxyFactory=var40, $r29=var2441, org.apache.dubbo.rpc.Invoker=var515, $r30=var3707, org.apache.dubbo.config.AbstractReferenceConfig=var620, $r31=var1502, org.apache.dubbo.rpc.support.ProtocolUtils=var1544, $z3=var3260, $r32=var608}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.ReferenceConfig;	r2 := @parameter0: java.util.Map;	$r1 = r0.<org.apache.dubbo.config.ReferenceConfig: java.util.List urls>;	interfaceinvoke $r1.<java.util.List: void clear()>();	specialinvoke r0.<org.apache.dubbo.config.ReferenceConfig: void meshModeHandleUrl(java.util.Map)>(r2);	$r3 = r0.<org.apache.dubbo.config.ReferenceConfig: java.lang.String url>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r3);	if $z0 == 0 goto specialinvoke r0.<org.apache.dubbo.config.ReferenceConfig: void aggregateUrlFromRegistry(java.util.Map)>(r2);	specialinvoke r0.<org.apache.dubbo.config.ReferenceConfig: void parseUrl(java.util.Map)>(r2);	goto [?= specialinvoke r0.<org.apache.dubbo.config.ReferenceConfig: void createInvoker()>()];	specialinvoke r0.<org.apache.dubbo.config.ReferenceConfig: void createInvoker()>();	$r4 = <org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$z1 = interfaceinvoke $r4.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isInfoEnabled()>();	if $z1 == 0 goto $r17 = new org.apache.dubbo.common.url.component.ServiceConfigURL;	$r17 = new org.apache.dubbo.common.url.component.ServiceConfigURL;	$r18 = interfaceinvoke r2.<java.util.Map: java.lang.Object get(java.lang.Object)>("register.ip");	$r19 = (java.lang.String) $r18;	$r20 = interfaceinvoke r2.<java.util.Map: java.lang.Object get(java.lang.Object)>("interface");	$r21 = (java.lang.String) $r20;	specialinvoke $r17.<org.apache.dubbo.common.url.component.ServiceConfigURL: void <init>(java.lang.String,java.lang.String,int,java.lang.String,java.util.Map)>("consumer", $r19, 0, $r21, r2);	$r22 = virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.rpc.model.ModuleModel getScopeModel()>();	$r23 = virtualinvoke $r17.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL setScopeModel(org.apache.dubbo.rpc.model.ScopeModel)>($r22);	$r24 = r0.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.rpc.model.ConsumerModel consumerModel>;	$r25 = virtualinvoke $r23.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL setServiceModel(org.apache.dubbo.rpc.model.ServiceModel)>($r24);	$r26 = r0.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.rpc.model.ConsumerModel consumerModel>;	$r27 = virtualinvoke $r26.<org.apache.dubbo.rpc.model.ConsumerModel: org.apache.dubbo.rpc.model.ServiceDescriptor getServiceModel()>();	$r28 = virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel()>();	staticinvoke <org.apache.dubbo.registry.client.metadata.MetadataUtils: void publishServiceDefinition(org.apache.dubbo.common.URL,org.apache.dubbo.rpc.model.ServiceDescriptor,org.apache.dubbo.rpc.model.ApplicationModel)>($r25, $r27, $r28);	$r29 = r0.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.rpc.ProxyFactory proxyFactory>;	$r30 = r0.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.rpc.Invoker invoker>;	$r31 = r0.<org.apache.dubbo.config.ReferenceConfig: java.lang.String generic>;	$z3 = staticinvoke <org.apache.dubbo.rpc.support.ProtocolUtils: boolean isGeneric(java.lang.String)>($r31);	$r32 = interfaceinvoke $r29.<org.apache.dubbo.rpc.ProxyFactory: java.lang.Object getProxy(org.apache.dubbo.rpc.Invoker,boolean)>($r30, $z3);	return $r32
;block_num 4