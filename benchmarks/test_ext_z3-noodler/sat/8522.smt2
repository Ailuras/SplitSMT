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

(declare-sort var1556 0)
(declare-sort var2707 0)
(declare-sort var1515 0)
(declare-sort var2907 0)
(declare-sort var262 0)
(declare-sort var742 0)
(declare-sort var2635 0)
(declare-sort var856 0)
(declare-sort var970 0)
(declare-sort var2099 0)
(declare-sort var2138 0)
(declare-sort var3523 0)
(declare-sort var3442 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var1515!class ClassObject)
(declare-const var856!class ClassObject)
(declare-fun configManager/-235729372 (var1556) var2707)
(declare-fun loadConfigsOfTypeFromProps/-1808308145 (var2907 ClassObject) var3442)
(declare-fun cast-from-var2707-to-var2907 (var2707) var2907)
(declare-fun applicationModel/-235729372 (var1556) var262)
(declare-fun getModelName/-2051809897 (var742) String)
(declare-fun cast-from-var262-to-var742 (var262) var742)
(declare-fun var2635_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun useRegistryAsConfigCenterIfNecessary/-594122918 (var1556) void)
(declare-fun getConfigCenters/-1919726171 (var2707) var970)
(declare-fun var2099_isEmpty/73262611 (var970) Bool)
(declare-fun var856-init () var856)
(declare-fun <init>/-467524512 (var856) void)
(declare-fun setScopeModel/-330737779 (var2138 var742) void)
(declare-fun cast-from-var856-to-var2138 (var856) var2138)
(declare-fun refresh/-1420329662 (var2138) void)
(declare-fun var3523_validateConfigCenterConfig/-1799182018 (var856) void)
(declare-fun isValid/1209436132 (var856) Bool)
(declare-fun var2099_isNotEmpty/-572947236 (var970) Bool)
(declare-const null-var1556 var1556)
(declare-const var917 var1556) ; Statement: r0 := @this: org.apache.dubbo.config.deploy.DefaultApplicationDeployer 
(assert (not (= var917 null-var1556)))
(define-const var2280 var2707 (configManager/-235729372 var917)) ; Statement: $r1 = r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.config.context.ConfigManager configManager> 
(assert true)
;(assert (loadConfigsOfTypeFromProps/-1808308145 (cast-from-var2707-to-var2907 var2280) var1515!class)) ; Statement: virtualinvoke $r1.<org.apache.dubbo.config.context.ConfigManager: java.util.List loadConfigsOfTypeFromProps(java.lang.Class)>(class "Lorg/apache/dubbo/config/ApplicationConfig;") 

(declare-const var2280!1 var2707)
(declare-const var3370 ClassObject)
(define-const var1530 var262 (applicationModel/-235729372 var917)) ; Statement: $r2 = r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.rpc.model.ApplicationModel applicationModel> 
(assert true)
(define-const var2364 String (getModelName/-2051809897 (cast-from-var262-to-var742 var1530))) ; Statement: $r3 = virtualinvoke $r2.<org.apache.dubbo.rpc.model.ApplicationModel: java.lang.String getModelName()>() 
(define-const var1854 Bool (var2635_isBlank/-523695098 (cast-from-String-to-String var2364))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>($r3) 
 ; Statement: if $z0 == 0 goto $r4 = r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.config.context.ConfigManager configManager> 
(assert (= (ite var1854 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2354 var2707 (configManager/-235729372 var917)) ; Statement: $r4 = r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.config.context.ConfigManager configManager> 
(assert true)
;(assert (loadConfigsOfTypeFromProps/-1808308145 (cast-from-var2707-to-var2907 var2354) var856!class)) ; Statement: virtualinvoke $r4.<org.apache.dubbo.config.context.ConfigManager: java.util.List loadConfigsOfTypeFromProps(java.lang.Class)>(class "Lorg/apache/dubbo/config/ConfigCenterConfig;") 

(declare-const var2354!1 var2707)
(declare-const var1271 ClassObject)
(assert true)
;(assert (useRegistryAsConfigCenterIfNecessary/-594122918 var917)) ; Statement: specialinvoke r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: void useRegistryAsConfigCenterIfNecessary()>() 

(declare-const var917!1 var1556)
(define-const var2482 var2707 (configManager/-235729372 var917!1)) ; Statement: $r5 = r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.config.context.ConfigManager configManager> 
(assert true)
(define-const var3327 var970 (getConfigCenters/-1919726171 var2482)) ; Statement: $r23 = virtualinvoke $r5.<org.apache.dubbo.config.context.ConfigManager: java.util.Collection getConfigCenters()>() 
(define-const var701 var970 var3327) ; Statement: r24 = $r23 
(define-const var44 Bool (var2099_isEmpty/73262611 var3327)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>($r23) 
 ; Statement: if $z1 == 0 goto r25 = interfaceinvoke $r23.<java.util.Collection: java.util.Iterator iterator()>() 
(assert (not (= (ite var44 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var3700 var856 var856-init) ; Statement: $r16 = new org.apache.dubbo.config.ConfigCenterConfig 
(assert true)
;(assert (<init>/-467524512 var3700)) ; Statement: specialinvoke $r16.<org.apache.dubbo.config.ConfigCenterConfig: void <init>()>() 

(declare-const var3700!1 var856)
(define-const var1076 var262 (applicationModel/-235729372 var917!1)) ; Statement: $r17 = r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.rpc.model.ApplicationModel applicationModel> 
(assert true)
;(assert (setScopeModel/-330737779 (cast-from-var856-to-var2138 var3700!1) (cast-from-var262-to-var742 var1076))) ; Statement: virtualinvoke $r16.<org.apache.dubbo.config.ConfigCenterConfig: void setScopeModel(org.apache.dubbo.rpc.model.ScopeModel)>($r17) 

(declare-const var3700!2 var856)
(declare-const var1076!1 var262)
(assert true)
;(assert (refresh/-1420329662 (cast-from-var856-to-var2138 var3700!2))) ; Statement: virtualinvoke $r16.<org.apache.dubbo.config.ConfigCenterConfig: void refresh()>() 

(declare-const var3700!3 var856)
;(assert (var3523_validateConfigCenterConfig/-1799182018 var3700!3)) ; Statement: staticinvoke <org.apache.dubbo.config.utils.ConfigValidationUtils: void validateConfigCenterConfig(org.apache.dubbo.config.ConfigCenterConfig)>($r16) 

(declare-const var3700!4 var856)
(assert true)
(define-const var53 Bool (isValid/1209436132 var3700!4)) ; Statement: $z5 = virtualinvoke $r16.<org.apache.dubbo.config.ConfigCenterConfig: boolean isValid()>() 
 ; Statement: if $z5 == 0 goto (branch) 
(assert (= (ite var53 1 0) 0)) ; Cond: $z5 == 0 
 ; Statement: goto [?= $z3 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmpty(java.util.Collection)>(r24)] 
(assert true) ; Non Conditional
(define-const var281 Bool (var2099_isNotEmpty/-572947236 var701)) ; Statement: $z3 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmpty(java.util.Collection)>(r24) 
 ; Statement: if $z3 == 0 goto return 
(assert (= (ite var281 1 0) 0)) ; Cond: $z3 == 0 
 ; Statement: return 
(check-sat)
; {configManager/-235729372=([org.apache.dubbo.config.deploy.DefaultApplicationDeployer], org.apache.dubbo.config.context.ConfigManager), loadConfigsOfTypeFromProps/-1808308145=([org.apache.dubbo.config.context.AbstractConfigManager, java.lang.Class], java.util.List), cast-from-var2707-to-var2907=([org.apache.dubbo.config.context.ConfigManager], org.apache.dubbo.config.context.AbstractConfigManager), applicationModel/-235729372=([org.apache.dubbo.config.deploy.DefaultApplicationDeployer], org.apache.dubbo.rpc.model.ApplicationModel), getModelName/-2051809897=([org.apache.dubbo.rpc.model.ScopeModel], java.lang.String), cast-from-var262-to-var742=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.rpc.model.ScopeModel), var2635_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), useRegistryAsConfigCenterIfNecessary/-594122918=([org.apache.dubbo.config.deploy.DefaultApplicationDeployer], void), getConfigCenters/-1919726171=([org.apache.dubbo.config.context.ConfigManager], java.util.Collection), var2099_isEmpty/73262611=([java.util.Collection], boolean), var856-init=([], org.apache.dubbo.config.ConfigCenterConfig), <init>/-467524512=([org.apache.dubbo.config.ConfigCenterConfig], void), setScopeModel/-330737779=([org.apache.dubbo.config.AbstractConfig, org.apache.dubbo.rpc.model.ScopeModel], void), cast-from-var856-to-var2138=([org.apache.dubbo.config.ConfigCenterConfig], org.apache.dubbo.config.AbstractConfig), refresh/-1420329662=([org.apache.dubbo.config.AbstractConfig], void), var3523_validateConfigCenterConfig/-1799182018=([org.apache.dubbo.config.ConfigCenterConfig], void), isValid/1209436132=([org.apache.dubbo.config.ConfigCenterConfig], boolean), var2099_isNotEmpty/-572947236=([java.util.Collection], boolean)}
; {var1556=org.apache.dubbo.config.deploy.DefaultApplicationDeployer, var917=r0, var2707=org.apache.dubbo.config.context.ConfigManager, var2280=$r1, var1515=org.apache.dubbo.config.ApplicationConfig, var2907=org.apache.dubbo.config.context.AbstractConfigManager, var3370=class "Lorg/apache/dubbo/config/ApplicationConfig;", var262=org.apache.dubbo.rpc.model.ApplicationModel, var1530=$r2, var742=org.apache.dubbo.rpc.model.ScopeModel, var2364=$r3, var2635=org.apache.dubbo.common.utils.StringUtils, var1854=$z0, var2354=$r4, var856=org.apache.dubbo.config.ConfigCenterConfig, var1271=class "Lorg/apache/dubbo/config/ConfigCenterConfig;", var2482=$r5, var970=java.util.Collection, var3327=$r23, var701=r24, var2099=org.apache.dubbo.common.utils.CollectionUtils, var44=$z1, var3700=$r16, var1076=$r17, var2138=org.apache.dubbo.config.AbstractConfig, var3523=org.apache.dubbo.config.utils.ConfigValidationUtils, var53=$z5, var281=$z3, var3442=java.util.List}
; {org.apache.dubbo.config.deploy.DefaultApplicationDeployer=var1556, r0=var917, org.apache.dubbo.config.context.ConfigManager=var2707, $r1=var2280, org.apache.dubbo.config.ApplicationConfig=var1515, org.apache.dubbo.config.context.AbstractConfigManager=var2907, class "Lorg/apache/dubbo/config/ApplicationConfig;"=var3370, org.apache.dubbo.rpc.model.ApplicationModel=var262, $r2=var1530, org.apache.dubbo.rpc.model.ScopeModel=var742, $r3=var2364, org.apache.dubbo.common.utils.StringUtils=var2635, $z0=var1854, $r4=var2354, org.apache.dubbo.config.ConfigCenterConfig=var856, class "Lorg/apache/dubbo/config/ConfigCenterConfig;"=var1271, $r5=var2482, java.util.Collection=var970, $r23=var3327, r24=var701, org.apache.dubbo.common.utils.CollectionUtils=var2099, $z1=var44, $r16=var3700, $r17=var1076, org.apache.dubbo.config.AbstractConfig=var2138, org.apache.dubbo.config.utils.ConfigValidationUtils=var3523, $z5=var53, $z3=var281, java.util.List=var3442}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.deploy.DefaultApplicationDeployer;	$r1 = r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.config.context.ConfigManager configManager>;	virtualinvoke $r1.<org.apache.dubbo.config.context.ConfigManager: java.util.List loadConfigsOfTypeFromProps(java.lang.Class)>(class "Lorg/apache/dubbo/config/ApplicationConfig;");	$r2 = r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.rpc.model.ApplicationModel applicationModel>;	$r3 = virtualinvoke $r2.<org.apache.dubbo.rpc.model.ApplicationModel: java.lang.String getModelName()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>($r3);	if $z0 == 0 goto $r4 = r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.config.context.ConfigManager configManager>;	$r4 = r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.config.context.ConfigManager configManager>;	virtualinvoke $r4.<org.apache.dubbo.config.context.ConfigManager: java.util.List loadConfigsOfTypeFromProps(java.lang.Class)>(class "Lorg/apache/dubbo/config/ConfigCenterConfig;");	specialinvoke r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: void useRegistryAsConfigCenterIfNecessary()>();	$r5 = r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.config.context.ConfigManager configManager>;	$r23 = virtualinvoke $r5.<org.apache.dubbo.config.context.ConfigManager: java.util.Collection getConfigCenters()>();	r24 = $r23;	$z1 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>($r23);	if $z1 == 0 goto r25 = interfaceinvoke $r23.<java.util.Collection: java.util.Iterator iterator()>();	$r16 = new org.apache.dubbo.config.ConfigCenterConfig;	specialinvoke $r16.<org.apache.dubbo.config.ConfigCenterConfig: void <init>()>();	$r17 = r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.rpc.model.ApplicationModel applicationModel>;	virtualinvoke $r16.<org.apache.dubbo.config.ConfigCenterConfig: void setScopeModel(org.apache.dubbo.rpc.model.ScopeModel)>($r17);	virtualinvoke $r16.<org.apache.dubbo.config.ConfigCenterConfig: void refresh()>();	staticinvoke <org.apache.dubbo.config.utils.ConfigValidationUtils: void validateConfigCenterConfig(org.apache.dubbo.config.ConfigCenterConfig)>($r16);	$z5 = virtualinvoke $r16.<org.apache.dubbo.config.ConfigCenterConfig: boolean isValid()>();	if $z5 == 0 goto (branch);	goto [?= $z3 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmpty(java.util.Collection)>(r24)];	$z3 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmpty(java.util.Collection)>(r24);	if $z3 == 0 goto return;	return
;block_num 6