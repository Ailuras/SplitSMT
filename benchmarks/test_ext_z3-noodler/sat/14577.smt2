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

(declare-sort var963 0)
(declare-sort var3013 0)
(declare-sort var1968 0)
(declare-sort var3119 0)
(declare-sort var1211 0)
(declare-sort var2689 0)
(declare-sort var2602 0)
(declare-sort var2906 0)
(declare-sort var3770 0)
(declare-sort var110 0)
(declare-sort var3186 0)
(declare-sort var465 0)
(declare-sort var3531 0)
(declare-sort var2089 0)
(declare-sort var318 0)
(declare-sort var1545 0)
(declare-sort var1620 0)
(declare-sort var2791 0)
(declare-sort var1307 0)
(declare-sort var863 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var1307!class ClassObject)
(declare-fun queryMap/-1577131577 (var3119) var1968)
(declare-fun cast-from-var963-to-var3119 (var963) var3119)
(declare-fun var1968_get/1088891777 (var1968 var1211) var1211)
(declare-fun cast-from-String-to-var1211 (String) var1211)
(declare-fun cast-from-var1211-to-String (var1211) String)
(declare-fun var2689_isNotBlank/-358081771 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun getApplicationModel/969163997 (var3013) var2602)
(declare-fun registry/2129308851 (var3770) var2906)
(declare-fun cast-from-var963-to-var3770 (var963) var3770)
(declare-fun var110_getUrl/-275947851 (var110) var3013)
(declare-fun cast-from-var2906-to-var110 (var2906) var110)
(declare-fun getParameter/-1307325648 (var3013 String) String)
(declare-fun getParameter/506106603 (var3013 String String) String)
(declare-fun var3186_toSubscribeEvent/-1893012148 (var2602 String) var3186)
(declare-fun var3531_bootstrap$/2073401745 (var963 var3013) var465)
(declare-fun var2089_post/215772806 (var318 var465) var1211)
(declare-fun cast-from-var3186-to-var318 (var3186) var318)
(declare-fun moduleModel/-1746140277 (var963) var1545)
(declare-fun modelEnvironment/424243254 (var1545) var1620)
(declare-fun getConfiguration/1187702785 (var1620) var2791)
(declare-fun var1307_valueOf/1602327315 (Bool) var1307)
(declare-fun convert/580494670 (var863 ClassObject String var1211) var1211)
(declare-fun cast-from-var2791-to-var863 (var2791) var863)
(declare-fun cast-from-var1307-to-var1211 (var1307) var1211)
(declare-fun cast-from-var1211-to-var1307 (var1211) var1307)
(declare-fun booleanValue/-1820462562 (var1307) Bool)
(declare-const null-var963 var963)
(declare-const null-var3013 var3013)
(declare-const var3237 var963) ; Statement: r0 := @this: org.apache.dubbo.registry.integration.RegistryDirectory 
(assert (not (= var3237 null-var963)))
(declare-const var2841 var3013) ; Statement: r4 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var2841 null-var3013)))
(define-const var1537 var1968 (queryMap/-1577131577 (cast-from-var963-to-var3119 var3237))) ; Statement: $r1 = r0.<org.apache.dubbo.registry.integration.RegistryDirectory: java.util.Map queryMap> 
(define-const var1490 var1211 (var1968_get/1088891777 var1537 (cast-from-String-to-var1211 "protocol"))) ; Statement: $r2 = interfaceinvoke $r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("protocol") 
(define-const var3403 String (cast-from-var1211-to-String var1490)) ; Statement: r3 = (java.lang.String) $r2 
(define-const var3488 Bool (var2689_isNotBlank/-358081771 (cast-from-String-to-String var3403))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotBlank(java.lang.CharSequence)>(r3) 
 ; Statement: if $z0 == 0 goto $r21 = virtualinvoke r4.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel()>() 
(assert (= (ite var3488 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var3330 var2602 (getApplicationModel/969163997 var2841)) ; Statement: $r21 = virtualinvoke r4.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel()>() 
(define-const var552 var2906 (registry/2129308851 (cast-from-var963-to-var3770 var3237))) ; Statement: $r5 = r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.registry.Registry registry> 
(define-const var1086 var3013 (var110_getUrl/-275947851 (cast-from-var2906-to-var110 var552))) ; Statement: $r9 = interfaceinvoke $r5.<org.apache.dubbo.registry.Registry: org.apache.dubbo.common.URL getUrl()>() 
(define-const var3107 var2906 (registry/2129308851 (cast-from-var963-to-var3770 var3237))) ; Statement: $r6 = r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.registry.Registry registry> 
(define-const var3522 var3013 (var110_getUrl/-275947851 (cast-from-var2906-to-var110 var3107))) ; Statement: $r7 = interfaceinvoke $r6.<org.apache.dubbo.registry.Registry: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var3855 String (getParameter/-1307325648 var3522 "protocol")) ; Statement: $r8 = virtualinvoke $r7.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("protocol") 
(assert true)
(define-const var2684 String (getParameter/506106603 var1086 "REGISTRY_CLUSTER" var3855)) ; Statement: $r22 = virtualinvoke $r9.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("REGISTRY_CLUSTER", $r8) 
(define-const var3114 var3186 (var3186_toSubscribeEvent/-1893012148 var3330 var2684)) ; Statement: $r11 = staticinvoke <org.apache.dubbo.metrics.registry.event.RegistryEvent: org.apache.dubbo.metrics.registry.event.RegistryEvent toSubscribeEvent(org.apache.dubbo.rpc.model.ApplicationModel,java.lang.String)>($r21, $r22) 
(define-const var243 var465 (var3531_bootstrap$/2073401745 var3237 var2841)) ; Statement: $r10 = staticinvoke <org.apache.dubbo.registry.integration.RegistryDirectory$lambda_subscribe_0__1068: java.util.function.Supplier bootstrap$(org.apache.dubbo.registry.integration.RegistryDirectory,org.apache.dubbo.common.URL)>(r0, r4) 
;(assert (var2089_post/215772806 (cast-from-var3186-to-var318 var3114) var243)) ; Statement: staticinvoke <org.apache.dubbo.metrics.event.MetricsEventBus: java.lang.Object post(org.apache.dubbo.metrics.event.MetricsEvent,java.util.function.Supplier)>($r11, $r10) 

(declare-const var3114!1 var3186)
(declare-const var243!1 var465)
(define-const var3899 var1545 (moduleModel/-1746140277 var3237)) ; Statement: $r12 = r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.rpc.model.ModuleModel moduleModel> 
(assert true)
(define-const var1059 var1620 (modelEnvironment/424243254 var3899)) ; Statement: $r13 = virtualinvoke $r12.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.common.config.ModuleEnvironment modelEnvironment()>() 
(assert true)
(define-const var2095 var2791 (getConfiguration/1187702785 var1059)) ; Statement: $r15 = virtualinvoke $r13.<org.apache.dubbo.common.config.ModuleEnvironment: org.apache.dubbo.common.config.CompositeConfiguration getConfiguration()>() 
(define-const var338 var1307 (var1307_valueOf/1602327315 (ite (= 1 1) true false))) ; Statement: $r14 = staticinvoke <java.lang.Boolean: java.lang.Boolean valueOf(boolean)>(1) 
(assert true)
(define-const var946 var1211 (convert/580494670 (cast-from-var2791-to-var863 var2095) var1307!class "enable-configuration-listen" (cast-from-var1307-to-var1211 var338))) ; Statement: $r16 = virtualinvoke $r15.<org.apache.dubbo.common.config.CompositeConfiguration: java.lang.Object convert(java.lang.Class,java.lang.String,java.lang.Object)>(class "Ljava/lang/Boolean;", "enable-configuration-listen", $r14) 
(define-const var163 var1307 (cast-from-var1211-to-var1307 var946)) ; Statement: $r17 = (java.lang.Boolean) $r16 
(assert true)
(define-const var3063 Bool (booleanValue/-1820462562 var163)) ; Statement: $z1 = virtualinvoke $r17.<java.lang.Boolean: boolean booleanValue()>() 
 ; Statement: if $z1 == 0 goto return 
(assert (= (ite var3063 1 0) 0)) ; Cond: $z1 == 0 
 ; Statement: return 
(check-sat)
; {queryMap/-1577131577=([org.apache.dubbo.rpc.cluster.directory.AbstractDirectory], java.util.Map), cast-from-var963-to-var3119=([org.apache.dubbo.registry.integration.RegistryDirectory], org.apache.dubbo.rpc.cluster.directory.AbstractDirectory), var1968_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var1211=([java.lang.String], java.lang.Object), cast-from-var1211-to-String=([java.lang.Object], java.lang.String), var2689_isNotBlank/-358081771=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), getApplicationModel/969163997=([org.apache.dubbo.common.URL], org.apache.dubbo.rpc.model.ApplicationModel), registry/2129308851=([org.apache.dubbo.registry.integration.DynamicDirectory], org.apache.dubbo.registry.Registry), cast-from-var963-to-var3770=([org.apache.dubbo.registry.integration.RegistryDirectory], org.apache.dubbo.registry.integration.DynamicDirectory), var110_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var2906-to-var110=([org.apache.dubbo.registry.Registry], org.apache.dubbo.common.Node), getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), getParameter/506106603=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var3186_toSubscribeEvent/-1893012148=([org.apache.dubbo.rpc.model.ApplicationModel, java.lang.String], org.apache.dubbo.metrics.registry.event.RegistryEvent), var3531_bootstrap$/2073401745=([org.apache.dubbo.registry.integration.RegistryDirectory, org.apache.dubbo.common.URL], java.util.function.Supplier), var2089_post/215772806=([org.apache.dubbo.metrics.event.MetricsEvent, java.util.function.Supplier], java.lang.Object), cast-from-var3186-to-var318=([org.apache.dubbo.metrics.registry.event.RegistryEvent], org.apache.dubbo.metrics.event.MetricsEvent), moduleModel/-1746140277=([org.apache.dubbo.registry.integration.RegistryDirectory], org.apache.dubbo.rpc.model.ModuleModel), modelEnvironment/424243254=([org.apache.dubbo.rpc.model.ModuleModel], org.apache.dubbo.common.config.ModuleEnvironment), getConfiguration/1187702785=([org.apache.dubbo.common.config.ModuleEnvironment], org.apache.dubbo.common.config.CompositeConfiguration), var1307_valueOf/1602327315=([boolean], java.lang.Boolean), convert/580494670=([org.apache.dubbo.common.config.Configuration, java.lang.Class, java.lang.String, java.lang.Object], java.lang.Object), cast-from-var2791-to-var863=([org.apache.dubbo.common.config.CompositeConfiguration], org.apache.dubbo.common.config.Configuration), cast-from-var1307-to-var1211=([java.lang.Boolean], java.lang.Object), cast-from-var1211-to-var1307=([java.lang.Object], java.lang.Boolean), booleanValue/-1820462562=([java.lang.Boolean], boolean)}
; {var963=org.apache.dubbo.registry.integration.RegistryDirectory, var3237=r0, var3013=org.apache.dubbo.common.URL, var2841=r4, var1968=java.util.Map, var3119=org.apache.dubbo.rpc.cluster.directory.AbstractDirectory, var1537=$r1, var1211=java.lang.Object, var1490=$r2, var3403=r3, var2689=org.apache.dubbo.common.utils.StringUtils, var3488=$z0, var2602=org.apache.dubbo.rpc.model.ApplicationModel, var3330=$r21, var2906=org.apache.dubbo.registry.Registry, var3770=org.apache.dubbo.registry.integration.DynamicDirectory, var552=$r5, var110=org.apache.dubbo.common.Node, var1086=$r9, var3107=$r6, var3522=$r7, var3855=$r8, var2684=$r22, var3186=org.apache.dubbo.metrics.registry.event.RegistryEvent, var3114=$r11, var465=java.util.function.Supplier, var3531=org.apache.dubbo.registry.integration.RegistryDirectory$lambda_subscribe_0__1068, var243=$r10, var2089=org.apache.dubbo.metrics.event.MetricsEventBus, var318=org.apache.dubbo.metrics.event.MetricsEvent, var1545=org.apache.dubbo.rpc.model.ModuleModel, var3899=$r12, var1620=org.apache.dubbo.common.config.ModuleEnvironment, var1059=$r13, var2791=org.apache.dubbo.common.config.CompositeConfiguration, var2095=$r15, var1307=java.lang.Boolean, var338=$r14, var863=org.apache.dubbo.common.config.Configuration, var946=$r16, var163=$r17, var3063=$z1}
; {org.apache.dubbo.registry.integration.RegistryDirectory=var963, r0=var3237, org.apache.dubbo.common.URL=var3013, r4=var2841, java.util.Map=var1968, org.apache.dubbo.rpc.cluster.directory.AbstractDirectory=var3119, $r1=var1537, java.lang.Object=var1211, $r2=var1490, r3=var3403, org.apache.dubbo.common.utils.StringUtils=var2689, $z0=var3488, org.apache.dubbo.rpc.model.ApplicationModel=var2602, $r21=var3330, org.apache.dubbo.registry.Registry=var2906, org.apache.dubbo.registry.integration.DynamicDirectory=var3770, $r5=var552, org.apache.dubbo.common.Node=var110, $r9=var1086, $r6=var3107, $r7=var3522, $r8=var3855, $r22=var2684, org.apache.dubbo.metrics.registry.event.RegistryEvent=var3186, $r11=var3114, java.util.function.Supplier=var465, org.apache.dubbo.registry.integration.RegistryDirectory$lambda_subscribe_0__1068=var3531, $r10=var243, org.apache.dubbo.metrics.event.MetricsEventBus=var2089, org.apache.dubbo.metrics.event.MetricsEvent=var318, org.apache.dubbo.rpc.model.ModuleModel=var1545, $r12=var3899, org.apache.dubbo.common.config.ModuleEnvironment=var1620, $r13=var1059, org.apache.dubbo.common.config.CompositeConfiguration=var2791, $r15=var2095, java.lang.Boolean=var1307, $r14=var338, org.apache.dubbo.common.config.Configuration=var863, $r16=var946, $r17=var163, $z1=var3063}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotBlank(java.lang.CharSequence)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.integration.RegistryDirectory;	r4 := @parameter0: org.apache.dubbo.common.URL;	$r1 = r0.<org.apache.dubbo.registry.integration.RegistryDirectory: java.util.Map queryMap>;	$r2 = interfaceinvoke $r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("protocol");	r3 = (java.lang.String) $r2;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotBlank(java.lang.CharSequence)>(r3);	if $z0 == 0 goto $r21 = virtualinvoke r4.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel()>();	$r21 = virtualinvoke r4.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel()>();	$r5 = r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.registry.Registry registry>;	$r9 = interfaceinvoke $r5.<org.apache.dubbo.registry.Registry: org.apache.dubbo.common.URL getUrl()>();	$r6 = r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.registry.Registry registry>;	$r7 = interfaceinvoke $r6.<org.apache.dubbo.registry.Registry: org.apache.dubbo.common.URL getUrl()>();	$r8 = virtualinvoke $r7.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("protocol");	$r22 = virtualinvoke $r9.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("REGISTRY_CLUSTER", $r8);	$r11 = staticinvoke <org.apache.dubbo.metrics.registry.event.RegistryEvent: org.apache.dubbo.metrics.registry.event.RegistryEvent toSubscribeEvent(org.apache.dubbo.rpc.model.ApplicationModel,java.lang.String)>($r21, $r22);	$r10 = staticinvoke <org.apache.dubbo.registry.integration.RegistryDirectory$lambda_subscribe_0__1068: java.util.function.Supplier bootstrap$(org.apache.dubbo.registry.integration.RegistryDirectory,org.apache.dubbo.common.URL)>(r0, r4);	staticinvoke <org.apache.dubbo.metrics.event.MetricsEventBus: java.lang.Object post(org.apache.dubbo.metrics.event.MetricsEvent,java.util.function.Supplier)>($r11, $r10);	$r12 = r0.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.rpc.model.ModuleModel moduleModel>;	$r13 = virtualinvoke $r12.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.common.config.ModuleEnvironment modelEnvironment()>();	$r15 = virtualinvoke $r13.<org.apache.dubbo.common.config.ModuleEnvironment: org.apache.dubbo.common.config.CompositeConfiguration getConfiguration()>();	$r14 = staticinvoke <java.lang.Boolean: java.lang.Boolean valueOf(boolean)>(1);	$r16 = virtualinvoke $r15.<org.apache.dubbo.common.config.CompositeConfiguration: java.lang.Object convert(java.lang.Class,java.lang.String,java.lang.Object)>(class "Ljava/lang/Boolean;", "enable-configuration-listen", $r14);	$r17 = (java.lang.Boolean) $r16;	$z1 = virtualinvoke $r17.<java.lang.Boolean: boolean booleanValue()>();	if $z1 == 0 goto return;	return
;block_num 3