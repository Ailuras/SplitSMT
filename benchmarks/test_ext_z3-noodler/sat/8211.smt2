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

(declare-sort var1115 0)
(declare-sort var3619 0)
(declare-sort var1153 0)
(declare-sort var360 0)
(declare-sort var3924 0)
(declare-sort var1838 0)
(declare-sort var2394 0)
(declare-sort var2330 0)
(declare-sort var2570 0)
(declare-sort var2877 0)
(declare-sort var3113 0)
(declare-sort var3920 0)
(declare-sort var1730 0)
(declare-sort var2521 0)
(declare-sort var2307 0)
(declare-sort var1591 0)
(declare-sort var3773 0)
(declare-sort var3636 0)
(declare-sort var3952 0)
(declare-sort var1089 0)
(declare-sort var2612 0)
(declare-sort var3330 0)
(declare-sort var3498 0)
(declare-sort var3484 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun urls/2049477907 (var360) var1153)
(declare-fun cast-from-var1115-to-var360 (var1115) var360)
(declare-fun var1153_clear/2124191932 (var1153) void)
(declare-fun meshModeHandleUrl/-1115739643 (var1115 var3619) void)
(declare-fun url/1800549272 (var3924) String)
(declare-fun cast-from-var1115-to-var3924 (var1115) var3924)
(declare-fun var1838_isNotEmpty/-1251449450 (String) Bool)
(declare-fun aggregateUrlFromRegistry/1486959579 (var1115 var3619) void)
(declare-fun createInvoker/249732378 (var1115) void)
(declare-fun var2330_isInfoEnabled/-651841081 (var2330) Bool)
(declare-fun cast-from-var2394-to-var2330 (var2394) var2330)
(declare-fun var2570-init () var2570)
(declare-fun var3619_get/1088891777 (var3619 var2877) var2877)
(declare-fun cast-from-String-to-var2877 (String) var2877)
(declare-fun cast-from-var2877-to-String (var2877) String)
(declare-fun <init>/-1145568936 (var2570 String String Int String var3619) void)
(declare-fun getScopeModel/439405660 (var3920) var3113)
(declare-fun cast-from-var1115-to-var3920 (var1115) var3920)
(declare-fun setScopeModel/-1563758557 (var1730 var2521) var1730)
(declare-fun cast-from-var2570-to-var1730 (var2570) var1730)
(declare-fun cast-from-var3113-to-var2521 (var3113) var2521)
(declare-fun consumerModel/624895015 (var1115) var2307)
(declare-fun setServiceModel/1097940449 (var1730 var1591) var1730)
(declare-fun cast-from-var2307-to-var1591 (var2307) var1591)
(declare-fun getServiceModel/-1583884111 (var1591) var3773)
(declare-fun getApplicationModel/-625877363 (var3952) var3636)
(declare-fun cast-from-var1115-to-var3952 (var1115) var3952)
(declare-fun var1089_publishServiceDefinition/-1436415640 (var1730 var3773 var3636) void)
(declare-fun proxyFactory/624895015 (var1115) var2612)
(declare-fun invoker/624895015 (var1115) var3330)
(declare-fun generic/974719397 (var3498) String)
(declare-fun cast-from-var1115-to-var3498 (var1115) var3498)
(declare-fun var3484_isGeneric/-443667814 (String) Bool)
(declare-fun var2612_getProxy/1110343636 (var2612 var3330 Bool) var2877)
(declare-const null-var1115 var1115)
(declare-const null-var3619 var3619)
(declare-const var1115-logger var2394)
(declare-const var1291 var1115) ; Statement: r0 := @this: org.apache.dubbo.config.ReferenceConfig 
(assert (not (= var1291 null-var1115)))
(declare-const var2825 var3619) ; Statement: r2 := @parameter0: java.util.Map 
(assert (not (= var2825 null-var3619)))
(define-const var3387 var1153 (urls/2049477907 (cast-from-var1115-to-var360 var1291))) ; Statement: $r1 = r0.<org.apache.dubbo.config.ReferenceConfig: java.util.List urls> 
;(assert (var1153_clear/2124191932 var3387)) ; Statement: interfaceinvoke $r1.<java.util.List: void clear()>() 

(declare-const var3387!1 var1153)
(assert true)
;(assert (meshModeHandleUrl/-1115739643 var1291 var2825)) ; Statement: specialinvoke r0.<org.apache.dubbo.config.ReferenceConfig: void meshModeHandleUrl(java.util.Map)>(r2) 

(declare-const var1291!1 var1115)
(declare-const var2825!1 var3619)
(define-const var3874 String (url/1800549272 (cast-from-var1115-to-var3924 var1291!1))) ; Statement: $r3 = r0.<org.apache.dubbo.config.ReferenceConfig: java.lang.String url> 
(define-const var1276 Bool (var1838_isNotEmpty/-1251449450 var3874)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r3) 
 ; Statement: if $z0 == 0 goto specialinvoke r0.<org.apache.dubbo.config.ReferenceConfig: void aggregateUrlFromRegistry(java.util.Map)>(r2) 
(assert (= (ite var1276 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
;(assert (aggregateUrlFromRegistry/1486959579 var1291!1 var2825!1)) ; Statement: specialinvoke r0.<org.apache.dubbo.config.ReferenceConfig: void aggregateUrlFromRegistry(java.util.Map)>(r2) 

(declare-const var1291!2 var1115)
(declare-const var2825!2 var3619)
(assert true) ; Non Conditional
(assert true)
;(assert (createInvoker/249732378 var1291!2)) ; Statement: specialinvoke r0.<org.apache.dubbo.config.ReferenceConfig: void createInvoker()>() 

(declare-const var1291!3 var1115)
(define-const var1905 var2394 var1115-logger) ; Statement: $r4 = <org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var3313 Bool (var2330_isInfoEnabled/-651841081 (cast-from-var2394-to-var2330 var1905))) ; Statement: $z1 = interfaceinvoke $r4.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isInfoEnabled()>() 
 ; Statement: if $z1 == 0 goto $r17 = new org.apache.dubbo.common.url.component.ServiceConfigURL 
(assert (= (ite var3313 1 0) 0)) ; Cond: $z1 == 0 
(define-const var1837 var2570 var2570-init) ; Statement: $r17 = new org.apache.dubbo.common.url.component.ServiceConfigURL 
(define-const var474 var2877 (var3619_get/1088891777 var2825!2 (cast-from-String-to-var2877 "register.ip"))) ; Statement: $r18 = interfaceinvoke r2.<java.util.Map: java.lang.Object get(java.lang.Object)>("register.ip") 
(define-const var160 String (cast-from-var2877-to-String var474)) ; Statement: $r19 = (java.lang.String) $r18 
(define-const var2593 var2877 (var3619_get/1088891777 var2825!2 (cast-from-String-to-var2877 "interface"))) ; Statement: $r20 = interfaceinvoke r2.<java.util.Map: java.lang.Object get(java.lang.Object)>("interface") 
(define-const var2435 String (cast-from-var2877-to-String var2593)) ; Statement: $r21 = (java.lang.String) $r20 
(assert true)
;(assert (<init>/-1145568936 var1837 "consumer" var160 0 var2435 var2825!2)) ; Statement: specialinvoke $r17.<org.apache.dubbo.common.url.component.ServiceConfigURL: void <init>(java.lang.String,java.lang.String,int,java.lang.String,java.util.Map)>("consumer", $r19, 0, $r21, r2) 

(declare-const var1837!1 var2570)
(declare-const var3211 String)
(declare-const var160!1 String)
(declare-const var2639 Int)
(declare-const var2435!1 String)
(declare-const var2825!3 var3619)
(assert true)
(define-const var828 var3113 (getScopeModel/439405660 (cast-from-var1115-to-var3920 var1291!3))) ; Statement: $r22 = virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.rpc.model.ModuleModel getScopeModel()>() 
(assert true)
(define-const var318 var1730 (setScopeModel/-1563758557 (cast-from-var2570-to-var1730 var1837!1) (cast-from-var3113-to-var2521 var828))) ; Statement: $r23 = virtualinvoke $r17.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL setScopeModel(org.apache.dubbo.rpc.model.ScopeModel)>($r22) 
(define-const var3255 var2307 (consumerModel/624895015 var1291!3)) ; Statement: $r24 = r0.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.rpc.model.ConsumerModel consumerModel> 
(assert true)
(define-const var3940 var1730 (setServiceModel/1097940449 var318 (cast-from-var2307-to-var1591 var3255))) ; Statement: $r25 = virtualinvoke $r23.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL setServiceModel(org.apache.dubbo.rpc.model.ServiceModel)>($r24) 
(define-const var2936 var2307 (consumerModel/624895015 var1291!3)) ; Statement: $r26 = r0.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.rpc.model.ConsumerModel consumerModel> 
(assert true)
(define-const var1160 var3773 (getServiceModel/-1583884111 (cast-from-var2307-to-var1591 var2936))) ; Statement: $r27 = virtualinvoke $r26.<org.apache.dubbo.rpc.model.ConsumerModel: org.apache.dubbo.rpc.model.ServiceDescriptor getServiceModel()>() 
(assert true)
(define-const var3745 var3636 (getApplicationModel/-625877363 (cast-from-var1115-to-var3952 var1291!3))) ; Statement: $r28 = virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel()>() 
;(assert (var1089_publishServiceDefinition/-1436415640 var3940 var1160 var3745)) ; Statement: staticinvoke <org.apache.dubbo.registry.client.metadata.MetadataUtils: void publishServiceDefinition(org.apache.dubbo.common.URL,org.apache.dubbo.rpc.model.ServiceDescriptor,org.apache.dubbo.rpc.model.ApplicationModel)>($r25, $r27, $r28) 

(declare-const var3940!1 var1730)
(declare-const var1160!1 var3773)
(declare-const var3745!1 var3636)
(define-const var2454 var2612 (proxyFactory/624895015 var1291!3)) ; Statement: $r29 = r0.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.rpc.ProxyFactory proxyFactory> 
(define-const var404 var3330 (invoker/624895015 var1291!3)) ; Statement: $r30 = r0.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.rpc.Invoker invoker> 
(define-const var1925 String (generic/974719397 (cast-from-var1115-to-var3498 var1291!3))) ; Statement: $r31 = r0.<org.apache.dubbo.config.ReferenceConfig: java.lang.String generic> 
(define-const var1495 Bool (var3484_isGeneric/-443667814 var1925)) ; Statement: $z3 = staticinvoke <org.apache.dubbo.rpc.support.ProtocolUtils: boolean isGeneric(java.lang.String)>($r31) 
(define-const var3377 var2877 (var2612_getProxy/1110343636 var2454 var404 var1495)) ; Statement: $r32 = interfaceinvoke $r29.<org.apache.dubbo.rpc.ProxyFactory: java.lang.Object getProxy(org.apache.dubbo.rpc.Invoker,boolean)>($r30, $z3) 
 ; Statement: return $r32 
(check-sat)
; {urls/2049477907=([org.apache.dubbo.config.AbstractInterfaceConfig], java.util.List), cast-from-var1115-to-var360=([org.apache.dubbo.config.ReferenceConfig], org.apache.dubbo.config.AbstractInterfaceConfig), var1153_clear/2124191932=([java.util.List], void), meshModeHandleUrl/-1115739643=([org.apache.dubbo.config.ReferenceConfig, java.util.Map], void), url/1800549272=([org.apache.dubbo.config.ReferenceConfigBase], java.lang.String), cast-from-var1115-to-var3924=([org.apache.dubbo.config.ReferenceConfig], org.apache.dubbo.config.ReferenceConfigBase), var1838_isNotEmpty/-1251449450=([java.lang.String], boolean), aggregateUrlFromRegistry/1486959579=([org.apache.dubbo.config.ReferenceConfig, java.util.Map], void), createInvoker/249732378=([org.apache.dubbo.config.ReferenceConfig], void), var2330_isInfoEnabled/-651841081=([org.apache.dubbo.common.logger.Logger], boolean), cast-from-var2394-to-var2330=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), var2570-init=([], org.apache.dubbo.common.url.component.ServiceConfigURL), var3619_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var2877=([java.lang.String], java.lang.Object), cast-from-var2877-to-String=([java.lang.Object], java.lang.String), <init>/-1145568936=([org.apache.dubbo.common.url.component.ServiceConfigURL, java.lang.String, java.lang.String, int, java.lang.String, java.util.Map], void), getScopeModel/439405660=([org.apache.dubbo.config.AbstractMethodConfig], org.apache.dubbo.rpc.model.ModuleModel), cast-from-var1115-to-var3920=([org.apache.dubbo.config.ReferenceConfig], org.apache.dubbo.config.AbstractMethodConfig), setScopeModel/-1563758557=([org.apache.dubbo.common.URL, org.apache.dubbo.rpc.model.ScopeModel], org.apache.dubbo.common.URL), cast-from-var2570-to-var1730=([org.apache.dubbo.common.url.component.ServiceConfigURL], org.apache.dubbo.common.URL), cast-from-var3113-to-var2521=([org.apache.dubbo.rpc.model.ModuleModel], org.apache.dubbo.rpc.model.ScopeModel), consumerModel/624895015=([org.apache.dubbo.config.ReferenceConfig], org.apache.dubbo.rpc.model.ConsumerModel), setServiceModel/1097940449=([org.apache.dubbo.common.URL, org.apache.dubbo.rpc.model.ServiceModel], org.apache.dubbo.common.URL), cast-from-var2307-to-var1591=([org.apache.dubbo.rpc.model.ConsumerModel], org.apache.dubbo.rpc.model.ServiceModel), getServiceModel/-1583884111=([org.apache.dubbo.rpc.model.ServiceModel], org.apache.dubbo.rpc.model.ServiceDescriptor), getApplicationModel/-625877363=([org.apache.dubbo.config.AbstractConfig], org.apache.dubbo.rpc.model.ApplicationModel), cast-from-var1115-to-var3952=([org.apache.dubbo.config.ReferenceConfig], org.apache.dubbo.config.AbstractConfig), var1089_publishServiceDefinition/-1436415640=([org.apache.dubbo.common.URL, org.apache.dubbo.rpc.model.ServiceDescriptor, org.apache.dubbo.rpc.model.ApplicationModel], void), proxyFactory/624895015=([org.apache.dubbo.config.ReferenceConfig], org.apache.dubbo.rpc.ProxyFactory), invoker/624895015=([org.apache.dubbo.config.ReferenceConfig], org.apache.dubbo.rpc.Invoker), generic/974719397=([org.apache.dubbo.config.AbstractReferenceConfig], java.lang.String), cast-from-var1115-to-var3498=([org.apache.dubbo.config.ReferenceConfig], org.apache.dubbo.config.AbstractReferenceConfig), var3484_isGeneric/-443667814=([java.lang.String], boolean), var2612_getProxy/1110343636=([org.apache.dubbo.rpc.ProxyFactory, org.apache.dubbo.rpc.Invoker, boolean], java.lang.Object)}
; {var1115=org.apache.dubbo.config.ReferenceConfig, var1291=r0, var3619=java.util.Map, var2825=r2, var1153=java.util.List, var360=org.apache.dubbo.config.AbstractInterfaceConfig, var3387=$r1, var3924=org.apache.dubbo.config.ReferenceConfigBase, var3874=$r3, var1838=org.apache.dubbo.common.utils.StringUtils, var1276=$z0, var2394=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1905=$r4, var2330=org.apache.dubbo.common.logger.Logger, var3313=$z1, var2570=org.apache.dubbo.common.url.component.ServiceConfigURL, var1837=$r17, var2877=java.lang.Object, var474=$r18, var160=$r19, var2593=$r20, var2435=$r21, var3211="consumer", var2639=0, var3113=org.apache.dubbo.rpc.model.ModuleModel, var3920=org.apache.dubbo.config.AbstractMethodConfig, var828=$r22, var1730=org.apache.dubbo.common.URL, var2521=org.apache.dubbo.rpc.model.ScopeModel, var318=$r23, var2307=org.apache.dubbo.rpc.model.ConsumerModel, var3255=$r24, var1591=org.apache.dubbo.rpc.model.ServiceModel, var3940=$r25, var2936=$r26, var3773=org.apache.dubbo.rpc.model.ServiceDescriptor, var1160=$r27, var3636=org.apache.dubbo.rpc.model.ApplicationModel, var3952=org.apache.dubbo.config.AbstractConfig, var3745=$r28, var1089=org.apache.dubbo.registry.client.metadata.MetadataUtils, var2612=org.apache.dubbo.rpc.ProxyFactory, var2454=$r29, var3330=org.apache.dubbo.rpc.Invoker, var404=$r30, var3498=org.apache.dubbo.config.AbstractReferenceConfig, var1925=$r31, var3484=org.apache.dubbo.rpc.support.ProtocolUtils, var1495=$z3, var3377=$r32}
; {org.apache.dubbo.config.ReferenceConfig=var1115, r0=var1291, java.util.Map=var3619, r2=var2825, java.util.List=var1153, org.apache.dubbo.config.AbstractInterfaceConfig=var360, $r1=var3387, org.apache.dubbo.config.ReferenceConfigBase=var3924, $r3=var3874, org.apache.dubbo.common.utils.StringUtils=var1838, $z0=var1276, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var2394, $r4=var1905, org.apache.dubbo.common.logger.Logger=var2330, $z1=var3313, org.apache.dubbo.common.url.component.ServiceConfigURL=var2570, $r17=var1837, java.lang.Object=var2877, $r18=var474, $r19=var160, $r20=var2593, $r21=var2435, "consumer"=var3211, 0=var2639, org.apache.dubbo.rpc.model.ModuleModel=var3113, org.apache.dubbo.config.AbstractMethodConfig=var3920, $r22=var828, org.apache.dubbo.common.URL=var1730, org.apache.dubbo.rpc.model.ScopeModel=var2521, $r23=var318, org.apache.dubbo.rpc.model.ConsumerModel=var2307, $r24=var3255, org.apache.dubbo.rpc.model.ServiceModel=var1591, $r25=var3940, $r26=var2936, org.apache.dubbo.rpc.model.ServiceDescriptor=var3773, $r27=var1160, org.apache.dubbo.rpc.model.ApplicationModel=var3636, org.apache.dubbo.config.AbstractConfig=var3952, $r28=var3745, org.apache.dubbo.registry.client.metadata.MetadataUtils=var1089, org.apache.dubbo.rpc.ProxyFactory=var2612, $r29=var2454, org.apache.dubbo.rpc.Invoker=var3330, $r30=var404, org.apache.dubbo.config.AbstractReferenceConfig=var3498, $r31=var1925, org.apache.dubbo.rpc.support.ProtocolUtils=var3484, $z3=var1495, $r32=var3377}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.ReferenceConfig;	r2 := @parameter0: java.util.Map;	$r1 = r0.<org.apache.dubbo.config.ReferenceConfig: java.util.List urls>;	interfaceinvoke $r1.<java.util.List: void clear()>();	specialinvoke r0.<org.apache.dubbo.config.ReferenceConfig: void meshModeHandleUrl(java.util.Map)>(r2);	$r3 = r0.<org.apache.dubbo.config.ReferenceConfig: java.lang.String url>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r3);	if $z0 == 0 goto specialinvoke r0.<org.apache.dubbo.config.ReferenceConfig: void aggregateUrlFromRegistry(java.util.Map)>(r2);	specialinvoke r0.<org.apache.dubbo.config.ReferenceConfig: void aggregateUrlFromRegistry(java.util.Map)>(r2);	specialinvoke r0.<org.apache.dubbo.config.ReferenceConfig: void createInvoker()>();	$r4 = <org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$z1 = interfaceinvoke $r4.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isInfoEnabled()>();	if $z1 == 0 goto $r17 = new org.apache.dubbo.common.url.component.ServiceConfigURL;	$r17 = new org.apache.dubbo.common.url.component.ServiceConfigURL;	$r18 = interfaceinvoke r2.<java.util.Map: java.lang.Object get(java.lang.Object)>("register.ip");	$r19 = (java.lang.String) $r18;	$r20 = interfaceinvoke r2.<java.util.Map: java.lang.Object get(java.lang.Object)>("interface");	$r21 = (java.lang.String) $r20;	specialinvoke $r17.<org.apache.dubbo.common.url.component.ServiceConfigURL: void <init>(java.lang.String,java.lang.String,int,java.lang.String,java.util.Map)>("consumer", $r19, 0, $r21, r2);	$r22 = virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.rpc.model.ModuleModel getScopeModel()>();	$r23 = virtualinvoke $r17.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL setScopeModel(org.apache.dubbo.rpc.model.ScopeModel)>($r22);	$r24 = r0.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.rpc.model.ConsumerModel consumerModel>;	$r25 = virtualinvoke $r23.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL setServiceModel(org.apache.dubbo.rpc.model.ServiceModel)>($r24);	$r26 = r0.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.rpc.model.ConsumerModel consumerModel>;	$r27 = virtualinvoke $r26.<org.apache.dubbo.rpc.model.ConsumerModel: org.apache.dubbo.rpc.model.ServiceDescriptor getServiceModel()>();	$r28 = virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel()>();	staticinvoke <org.apache.dubbo.registry.client.metadata.MetadataUtils: void publishServiceDefinition(org.apache.dubbo.common.URL,org.apache.dubbo.rpc.model.ServiceDescriptor,org.apache.dubbo.rpc.model.ApplicationModel)>($r25, $r27, $r28);	$r29 = r0.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.rpc.ProxyFactory proxyFactory>;	$r30 = r0.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.rpc.Invoker invoker>;	$r31 = r0.<org.apache.dubbo.config.ReferenceConfig: java.lang.String generic>;	$z3 = staticinvoke <org.apache.dubbo.rpc.support.ProtocolUtils: boolean isGeneric(java.lang.String)>($r31);	$r32 = interfaceinvoke $r29.<org.apache.dubbo.rpc.ProxyFactory: java.lang.Object getProxy(org.apache.dubbo.rpc.Invoker,boolean)>($r30, $z3);	return $r32
;block_num 4