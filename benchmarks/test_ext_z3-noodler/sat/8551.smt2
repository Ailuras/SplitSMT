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

(declare-sort var1503 0)
(declare-sort var1930 0)
(declare-sort var640 0)
(declare-sort var2476 0)
(declare-sort var2738 0)
(declare-sort var664 0)
(declare-sort var2135 0)
(declare-sort var2205 0)
(declare-sort var813 0)
(declare-sort var824 0)
(declare-sort var652 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var640!class ClassObject)
(declare-const var2205!class ClassObject)
(declare-fun configManager/-235729372 (var1503) var1930)
(declare-fun loadConfigsOfTypeFromProps/-1808308145 (var2476 ClassObject) var652)
(declare-fun cast-from-var1930-to-var2476 (var1930) var2476)
(declare-fun applicationModel/-235729372 (var1503) var2738)
(declare-fun getModelName/-2051809897 (var664) String)
(declare-fun cast-from-var2738-to-var664 (var2738) var664)
(declare-fun var2135_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun useRegistryAsConfigCenterIfNecessary/-594122918 (var1503) void)
(declare-fun getConfigCenters/-1919726171 (var1930) var813)
(declare-fun var824_isEmpty/73262611 (var813) Bool)
(declare-fun var813_iterator/-1617794947 (var813) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-fun var824_isNotEmpty/-572947236 (var813) Bool)
(declare-const null-var1503 var1503)
(declare-const var2774 var1503) ; Statement: r0 := @this: org.apache.dubbo.config.deploy.DefaultApplicationDeployer 
(assert (not (= var2774 null-var1503)))
(define-const var2497 var1930 (configManager/-235729372 var2774)) ; Statement: $r1 = r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.config.context.ConfigManager configManager> 
(assert true)
;(assert (loadConfigsOfTypeFromProps/-1808308145 (cast-from-var1930-to-var2476 var2497) var640!class)) ; Statement: virtualinvoke $r1.<org.apache.dubbo.config.context.ConfigManager: java.util.List loadConfigsOfTypeFromProps(java.lang.Class)>(class "Lorg/apache/dubbo/config/ApplicationConfig;") 

(declare-const var2497!1 var1930)
(declare-const var3839 ClassObject)
(define-const var2213 var2738 (applicationModel/-235729372 var2774)) ; Statement: $r2 = r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.rpc.model.ApplicationModel applicationModel> 
(assert true)
(define-const var1618 String (getModelName/-2051809897 (cast-from-var2738-to-var664 var2213))) ; Statement: $r3 = virtualinvoke $r2.<org.apache.dubbo.rpc.model.ApplicationModel: java.lang.String getModelName()>() 
(define-const var2275 Bool (var2135_isBlank/-523695098 (cast-from-String-to-String var1618))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>($r3) 
 ; Statement: if $z0 == 0 goto $r4 = r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.config.context.ConfigManager configManager> 
(assert (= (ite var2275 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1863 var1930 (configManager/-235729372 var2774)) ; Statement: $r4 = r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.config.context.ConfigManager configManager> 
(assert true)
;(assert (loadConfigsOfTypeFromProps/-1808308145 (cast-from-var1930-to-var2476 var1863) var2205!class)) ; Statement: virtualinvoke $r4.<org.apache.dubbo.config.context.ConfigManager: java.util.List loadConfigsOfTypeFromProps(java.lang.Class)>(class "Lorg/apache/dubbo/config/ConfigCenterConfig;") 

(declare-const var1863!1 var1930)
(declare-const var1093 ClassObject)
(assert true)
;(assert (useRegistryAsConfigCenterIfNecessary/-594122918 var2774)) ; Statement: specialinvoke r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: void useRegistryAsConfigCenterIfNecessary()>() 

(declare-const var2774!1 var1503)
(define-const var2079 var1930 (configManager/-235729372 var2774!1)) ; Statement: $r5 = r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.config.context.ConfigManager configManager> 
(assert true)
(define-const var2423 var813 (getConfigCenters/-1919726171 var2079)) ; Statement: $r23 = virtualinvoke $r5.<org.apache.dubbo.config.context.ConfigManager: java.util.Collection getConfigCenters()>() 
(define-const var2613 var813 var2423) ; Statement: r24 = $r23 
(define-const var343 Bool (var824_isEmpty/73262611 var2423)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>($r23) 
 ; Statement: if $z1 == 0 goto r25 = interfaceinvoke $r23.<java.util.Collection: java.util.Iterator iterator()>() 
(assert (= (ite var343 1 0) 0)) ; Cond: $z1 == 0 
(define-const var59 Iterator (var813_iterator/-1617794947 var2423)) ; Statement: r25 = interfaceinvoke $r23.<java.util.Collection: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var1757 Bool (Iterator_hasNext/-1669924200 var59)) ; Statement: $z2 = interfaceinvoke r25.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z2 == 0 goto $z3 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmpty(java.util.Collection)>(r24) 
(assert (= (ite var1757 1 0) 0)) ; Cond: $z2 == 0 
(define-const var710 Bool (var824_isNotEmpty/-572947236 var2613)) ; Statement: $z3 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmpty(java.util.Collection)>(r24) 
 ; Statement: if $z3 == 0 goto return 
(assert (= (ite var710 1 0) 0)) ; Cond: $z3 == 0 
 ; Statement: return 
(check-sat)
; {configManager/-235729372=([org.apache.dubbo.config.deploy.DefaultApplicationDeployer], org.apache.dubbo.config.context.ConfigManager), loadConfigsOfTypeFromProps/-1808308145=([org.apache.dubbo.config.context.AbstractConfigManager, java.lang.Class], java.util.List), cast-from-var1930-to-var2476=([org.apache.dubbo.config.context.ConfigManager], org.apache.dubbo.config.context.AbstractConfigManager), applicationModel/-235729372=([org.apache.dubbo.config.deploy.DefaultApplicationDeployer], org.apache.dubbo.rpc.model.ApplicationModel), getModelName/-2051809897=([org.apache.dubbo.rpc.model.ScopeModel], java.lang.String), cast-from-var2738-to-var664=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.rpc.model.ScopeModel), var2135_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), useRegistryAsConfigCenterIfNecessary/-594122918=([org.apache.dubbo.config.deploy.DefaultApplicationDeployer], void), getConfigCenters/-1919726171=([org.apache.dubbo.config.context.ConfigManager], java.util.Collection), var824_isEmpty/73262611=([java.util.Collection], boolean), var813_iterator/-1617794947=([java.util.Collection], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), var824_isNotEmpty/-572947236=([java.util.Collection], boolean)}
; {var1503=org.apache.dubbo.config.deploy.DefaultApplicationDeployer, var2774=r0, var1930=org.apache.dubbo.config.context.ConfigManager, var2497=$r1, var640=org.apache.dubbo.config.ApplicationConfig, var2476=org.apache.dubbo.config.context.AbstractConfigManager, var3839=class "Lorg/apache/dubbo/config/ApplicationConfig;", var2738=org.apache.dubbo.rpc.model.ApplicationModel, var2213=$r2, var664=org.apache.dubbo.rpc.model.ScopeModel, var1618=$r3, var2135=org.apache.dubbo.common.utils.StringUtils, var2275=$z0, var1863=$r4, var2205=org.apache.dubbo.config.ConfigCenterConfig, var1093=class "Lorg/apache/dubbo/config/ConfigCenterConfig;", var2079=$r5, var813=java.util.Collection, var2423=$r23, var2613=r24, var824=org.apache.dubbo.common.utils.CollectionUtils, var343=$z1, var59=r25, var1757=$z2, var710=$z3, var652=java.util.List}
; {org.apache.dubbo.config.deploy.DefaultApplicationDeployer=var1503, r0=var2774, org.apache.dubbo.config.context.ConfigManager=var1930, $r1=var2497, org.apache.dubbo.config.ApplicationConfig=var640, org.apache.dubbo.config.context.AbstractConfigManager=var2476, class "Lorg/apache/dubbo/config/ApplicationConfig;"=var3839, org.apache.dubbo.rpc.model.ApplicationModel=var2738, $r2=var2213, org.apache.dubbo.rpc.model.ScopeModel=var664, $r3=var1618, org.apache.dubbo.common.utils.StringUtils=var2135, $z0=var2275, $r4=var1863, org.apache.dubbo.config.ConfigCenterConfig=var2205, class "Lorg/apache/dubbo/config/ConfigCenterConfig;"=var1093, $r5=var2079, java.util.Collection=var813, $r23=var2423, r24=var2613, org.apache.dubbo.common.utils.CollectionUtils=var824, $z1=var343, r25=var59, $z2=var1757, $z3=var710, java.util.List=var652}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.deploy.DefaultApplicationDeployer;	$r1 = r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.config.context.ConfigManager configManager>;	virtualinvoke $r1.<org.apache.dubbo.config.context.ConfigManager: java.util.List loadConfigsOfTypeFromProps(java.lang.Class)>(class "Lorg/apache/dubbo/config/ApplicationConfig;");	$r2 = r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.rpc.model.ApplicationModel applicationModel>;	$r3 = virtualinvoke $r2.<org.apache.dubbo.rpc.model.ApplicationModel: java.lang.String getModelName()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>($r3);	if $z0 == 0 goto $r4 = r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.config.context.ConfigManager configManager>;	$r4 = r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.config.context.ConfigManager configManager>;	virtualinvoke $r4.<org.apache.dubbo.config.context.ConfigManager: java.util.List loadConfigsOfTypeFromProps(java.lang.Class)>(class "Lorg/apache/dubbo/config/ConfigCenterConfig;");	specialinvoke r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: void useRegistryAsConfigCenterIfNecessary()>();	$r5 = r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.config.context.ConfigManager configManager>;	$r23 = virtualinvoke $r5.<org.apache.dubbo.config.context.ConfigManager: java.util.Collection getConfigCenters()>();	r24 = $r23;	$z1 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>($r23);	if $z1 == 0 goto r25 = interfaceinvoke $r23.<java.util.Collection: java.util.Iterator iterator()>();	r25 = interfaceinvoke $r23.<java.util.Collection: java.util.Iterator iterator()>();	$z2 = interfaceinvoke r25.<java.util.Iterator: boolean hasNext()>();	if $z2 == 0 goto $z3 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmpty(java.util.Collection)>(r24);	$z3 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmpty(java.util.Collection)>(r24);	if $z3 == 0 goto return;	return
;block_num 6