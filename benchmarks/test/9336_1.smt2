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

(declare-sort var2688 0)
(declare-sort var3738 0)
(declare-sort var1048 0)
(declare-sort var3394 0)
(declare-sort var3448 0)
(declare-sort var2701 0)
(declare-sort var653 0)
(declare-sort var2812 0)
(declare-sort var1223 0)
(declare-sort var710 0)
(declare-sort var1031 0)
(declare-sort var975 0)
(declare-sort var3005 0)
(declare-sort var3034 0)
(declare-sort var3218 0)
(declare-sort var2418 0)
(declare-sort var2993 0)
(declare-sort var1441 0)
(declare-sort var871 0)
(declare-sort var3467 0)
(declare-sort var3036 0)
(declare-sort var772 0)
(declare-sort var127 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var1223!class ClassObject)
(declare-const var1441!class ClassObject)
(declare-fun getName/383349173 (var3738) String)
(declare-fun var3394_isEmpty/-813097145 (String) Bool)
(declare-fun provider/2052580610 (var2701) var3448)
(declare-fun cast-from-var2688-to-var2701 (var2688) var2701)
(declare-fun var2688_findConfiguredHosts/-303812874 (var3738 var3448 var1048) String)
(declare-fun var653_isIPV6URLStdFormat/1867278366 (String) Bool)
(define-fun contains/1009244746 ((s String) (subs String)) Bool (str.contains s subs))
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun getExtensionLoader/1668578899 (var710 ClassObject) var2812)
(declare-fun cast-from-var2688-to-var710 (var2688) var710)
(declare-fun var2688_findConfiguredPort/-2050701514 (var3738 var3448 var2812 String var1048) Int)
(declare-fun var1031-init () var1031)
(declare-fun intValue/-1815674922 (Int) Int)
(declare-fun getContextPath/683600075 (var2701 var3738) var975)
(declare-fun var3034_bootstrap$/1230857546 (var2688) var3005)
(declare-fun map/1305667865 (var975 var3005) var975)
(declare-fun path/2052580610 (var2701) String)
(declare-fun orElse/-757175127 (var975 var3218) var3218)
(declare-fun cast-from-String-to-var3218 (String) var3218)
(declare-fun cast-from-var3218-to-String (var3218) String)
(declare-fun <init>/1472585720 (var1031 String String String String Int String var1048) void)
(declare-fun cast-from-var1031-to-var2993 (var1031) var2993)
(declare-fun getProtocol/491749358 (var2993) String)
(declare-fun hasExtension/-1450549355 (var2812 String) Bool)
(declare-fun getScopeModel/439405660 (var3467) var871)
(declare-fun cast-from-var2688-to-var3467 (var2688) var3467)
(declare-fun setScopeModel/-1563758557 (var2993 var3036) var2993)
(declare-fun cast-from-var871-to-var3036 (var871) var3036)
(declare-fun providerModel/14293649 (var2688) var772)
(declare-fun setServiceModel/1097940449 (var2993 var127) var2993)
(declare-fun cast-from-var772-to-var127 (var772) var127)
(declare-const null-var2688 var2688)
(declare-const null-var3738 var3738)
(declare-const null-var1048 var1048)
(declare-const null-NullType var2418)
(declare-const null-String String)
(declare-const var1599 var2688) ; Statement: r1 := @this: org.apache.dubbo.config.ServiceConfig 
(assert (not (= var1599 null-var2688)))
(declare-const var1983 var3738) ; Statement: r0 := @parameter0: org.apache.dubbo.config.ProtocolConfig 
(assert (not (= var1983 null-var3738)))
(declare-const var1752 var1048) ; Statement: r2 := @parameter1: java.util.Map 
(assert (not (= var1752 null-var1048)))
(assert true)
(define-const var8 String (getName/383349173 var1983)) ; Statement: r19 = virtualinvoke r0.<org.apache.dubbo.config.ProtocolConfig: java.lang.String getName()>() 
(define-const var2270 Bool (var3394_isEmpty/-813097145 var8)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r19) 
 ; Statement: if $z0 == 0 goto $r3 = r1.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.config.ProviderConfig provider> 
(assert (= (ite var2270 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2021 var3448 (provider/2052580610 (cast-from-var2688-to-var2701 var1599))) ; Statement: $r3 = r1.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.config.ProviderConfig provider> 
(define-const var819 String (var2688_findConfiguredHosts/-303812874 var1983 var2021 var1752)) ; Statement: $r18 = staticinvoke <org.apache.dubbo.config.ServiceConfig: java.lang.String findConfiguredHosts(org.apache.dubbo.config.ProtocolConfig,org.apache.dubbo.config.ProviderConfig,java.util.Map)>(r0, $r3, r2) 
(define-const var672 String var819) ; Statement: r20 = $r18 
(define-const var275 Bool (var653_isIPV6URLStdFormat/1867278366 var819)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: boolean isIPV6URLStdFormat(java.lang.String)>($r18) 
 ; Statement: if $z1 == 0 goto $r4 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHostV6()>() 
(assert (not (= (ite var275 1 0) 0))) ; Negate: Cond: $z1 == 0  
(assert true)
(define-const var2950 Bool (contains/1009244746 var819 (cast-from-String-to-String "["))) ; Statement: $z2 = virtualinvoke $r18.<java.lang.String: boolean contains(java.lang.CharSequence)>("[") 
 ; Statement: if $z2 != 0 goto $r22 = r1.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.config.ProviderConfig provider> 
(assert (not (= (ite var2950 1 0) 0))) ; Cond: $z2 != 0 
(define-const var279 var3448 (provider/2052580610 (cast-from-var2688-to-var2701 var1599))) ; Statement: $r22 = r1.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.config.ProviderConfig provider> 
(assert true)
(define-const var3589 var2812 (getExtensionLoader/1668578899 (cast-from-var2688-to-var710 var1599) var1223!class)) ; Statement: $r23 = virtualinvoke r1.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/Protocol;") 
(define-const var2259 Int (var2688_findConfiguredPort/-2050701514 var1983 var279 var3589 var8 var1752)) ; Statement: $r24 = staticinvoke <org.apache.dubbo.config.ServiceConfig: java.lang.Integer findConfiguredPort(org.apache.dubbo.config.ProtocolConfig,org.apache.dubbo.config.ProviderConfig,org.apache.dubbo.common.extension.ExtensionLoader,java.lang.String,java.util.Map)>(r0, $r22, $r23, r19, r2) 
(define-const var2818 var1031 var1031-init) ; Statement: $r25 = new org.apache.dubbo.common.url.component.ServiceConfigURL 
(assert true)
(define-const var608 Int (intValue/-1815674922 var2259)) ; Statement: $i0 = virtualinvoke $r24.<java.lang.Integer: int intValue()>() 
(assert true)
(define-const var2368 var975 (getContextPath/683600075 (cast-from-var2688-to-var2701 var1599) var1983)) ; Statement: $r26 = virtualinvoke r1.<org.apache.dubbo.config.ServiceConfig: java.util.Optional getContextPath(org.apache.dubbo.config.ProtocolConfig)>(r0) 
(define-const var338 var3005 (var3034_bootstrap$/1230857546 var1599)) ; Statement: $r27 = staticinvoke <org.apache.dubbo.config.ServiceConfig$lambda_buildUrl_10__486: java.util.function.Function bootstrap$(org.apache.dubbo.config.ServiceConfig)>(r1) 
(assert true)
(define-const var3529 var975 (map/1305667865 var2368 var338)) ; Statement: $r28 = virtualinvoke $r26.<java.util.Optional: java.util.Optional map(java.util.function.Function)>($r27) 
(define-const var3343 String (path/2052580610 (cast-from-var2688-to-var2701 var1599))) ; Statement: $r29 = r1.<org.apache.dubbo.config.ServiceConfig: java.lang.String path> 
(assert true)
(define-const var2538 var3218 (orElse/-757175127 var3529 (cast-from-String-to-var3218 var3343))) ; Statement: $r30 = virtualinvoke $r28.<java.util.Optional: java.lang.Object orElse(java.lang.Object)>($r29) 
(define-const var572 String (cast-from-var3218-to-String var2538)) ; Statement: $r31 = (java.lang.String) $r30 
(assert true)
;(assert (<init>/1472585720 var2818 var8 null-String null-String var672 var608 var572 var1752)) ; Statement: specialinvoke $r25.<org.apache.dubbo.common.url.component.ServiceConfigURL: void <init>(java.lang.String,java.lang.String,java.lang.String,java.lang.String,int,java.lang.String,java.util.Map)>(r19, null, null, r20, $i0, $r31, r2) 

(declare-const var2818!1 var1031)
(declare-const var8!1 String)
(declare-const var357 var2418)
(declare-const var357!1 var2418)
(declare-const var672!1 String)
(declare-const var608!1 Int)
(declare-const var572!1 String)
(declare-const var1752!1 var1048)
(define-const var67 var2993 (cast-from-var1031-to-var2993 var2818!1)) ; Statement: r32 = $r25 
(assert true)
(define-const var1850 var2812 (getExtensionLoader/1668578899 (cast-from-var2688-to-var710 var1599) var1441!class)) ; Statement: $r33 = virtualinvoke r1.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/cluster/ConfiguratorFactory;") 
(assert true)
(define-const var2671 String (getProtocol/491749358 (cast-from-var1031-to-var2993 var2818!1))) ; Statement: $r34 = virtualinvoke $r25.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(assert true)
(define-const var3775 Bool (hasExtension/-1450549355 var1850 var2671)) ; Statement: $z3 = virtualinvoke $r33.<org.apache.dubbo.common.extension.ExtensionLoader: boolean hasExtension(java.lang.String)>($r34) 
 ; Statement: if $z3 == 0 goto $r5 = virtualinvoke r1.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.rpc.model.ModuleModel getScopeModel()>() 
(assert (= (ite var3775 1 0) 0)) ; Cond: $z3 == 0 
(assert true)
(define-const var3349 var871 (getScopeModel/439405660 (cast-from-var2688-to-var3467 var1599))) ; Statement: $r5 = virtualinvoke r1.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.rpc.model.ModuleModel getScopeModel()>() 
(assert true)
(define-const var2511 var2993 (setScopeModel/-1563758557 var67 (cast-from-var871-to-var3036 var3349))) ; Statement: $r12 = virtualinvoke r32.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL setScopeModel(org.apache.dubbo.rpc.model.ScopeModel)>($r5) 
(define-const var2261 var772 (providerModel/14293649 var1599)) ; Statement: $r6 = r1.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.rpc.model.ProviderModel providerModel> 
(assert true)
(define-const var910 var2993 (setServiceModel/1097940449 var2511 (cast-from-var772-to-var127 var2261))) ; Statement: $r13 = virtualinvoke $r12.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL setServiceModel(org.apache.dubbo.rpc.model.ServiceModel)>($r6) 
 ; Statement: return $r13 
(check-sat)
; {getName/383349173=([org.apache.dubbo.config.ProtocolConfig], java.lang.String), var3394_isEmpty/-813097145=([java.lang.String], boolean), provider/2052580610=([org.apache.dubbo.config.ServiceConfigBase], org.apache.dubbo.config.ProviderConfig), cast-from-var2688-to-var2701=([org.apache.dubbo.config.ServiceConfig], org.apache.dubbo.config.ServiceConfigBase), var2688_findConfiguredHosts/-303812874=([org.apache.dubbo.config.ProtocolConfig, org.apache.dubbo.config.ProviderConfig, java.util.Map], java.lang.String), var653_isIPV6URLStdFormat/1867278366=([java.lang.String], boolean), contains/1009244746=([java.lang.String, java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), getExtensionLoader/1668578899=([org.apache.dubbo.config.AbstractConfig, java.lang.Class], org.apache.dubbo.common.extension.ExtensionLoader), cast-from-var2688-to-var710=([org.apache.dubbo.config.ServiceConfig], org.apache.dubbo.config.AbstractConfig), var2688_findConfiguredPort/-2050701514=([org.apache.dubbo.config.ProtocolConfig, org.apache.dubbo.config.ProviderConfig, org.apache.dubbo.common.extension.ExtensionLoader, java.lang.String, java.util.Map], java.lang.Integer), var1031-init=([], org.apache.dubbo.common.url.component.ServiceConfigURL), intValue/-1815674922=([java.lang.Integer], int), getContextPath/683600075=([org.apache.dubbo.config.ServiceConfigBase, org.apache.dubbo.config.ProtocolConfig], java.util.Optional), var3034_bootstrap$/1230857546=([org.apache.dubbo.config.ServiceConfig], java.util.function.Function), map/1305667865=([java.util.Optional, java.util.function.Function], java.util.Optional), path/2052580610=([org.apache.dubbo.config.ServiceConfigBase], java.lang.String), orElse/-757175127=([java.util.Optional, java.lang.Object], java.lang.Object), cast-from-String-to-var3218=([java.lang.String], java.lang.Object), cast-from-var3218-to-String=([java.lang.Object], java.lang.String), <init>/1472585720=([org.apache.dubbo.common.url.component.ServiceConfigURL, java.lang.String, java.lang.String, java.lang.String, java.lang.String, int, java.lang.String, java.util.Map], void), cast-from-var1031-to-var2993=([org.apache.dubbo.common.url.component.ServiceConfigURL], org.apache.dubbo.common.URL), getProtocol/491749358=([org.apache.dubbo.common.URL], java.lang.String), hasExtension/-1450549355=([org.apache.dubbo.common.extension.ExtensionLoader, java.lang.String], boolean), getScopeModel/439405660=([org.apache.dubbo.config.AbstractMethodConfig], org.apache.dubbo.rpc.model.ModuleModel), cast-from-var2688-to-var3467=([org.apache.dubbo.config.ServiceConfig], org.apache.dubbo.config.AbstractMethodConfig), setScopeModel/-1563758557=([org.apache.dubbo.common.URL, org.apache.dubbo.rpc.model.ScopeModel], org.apache.dubbo.common.URL), cast-from-var871-to-var3036=([org.apache.dubbo.rpc.model.ModuleModel], org.apache.dubbo.rpc.model.ScopeModel), providerModel/14293649=([org.apache.dubbo.config.ServiceConfig], org.apache.dubbo.rpc.model.ProviderModel), setServiceModel/1097940449=([org.apache.dubbo.common.URL, org.apache.dubbo.rpc.model.ServiceModel], org.apache.dubbo.common.URL), cast-from-var772-to-var127=([org.apache.dubbo.rpc.model.ProviderModel], org.apache.dubbo.rpc.model.ServiceModel)}
; {var2688=org.apache.dubbo.config.ServiceConfig, var1599=r1, var3738=org.apache.dubbo.config.ProtocolConfig, var1983=r0, var1048=java.util.Map, var1752=r2, var8=r19, var3394=org.apache.dubbo.common.utils.StringUtils, var2270=$z0, var3448=org.apache.dubbo.config.ProviderConfig, var2701=org.apache.dubbo.config.ServiceConfigBase, var2021=$r3, var819=$r18, var672=r20, var653=org.apache.dubbo.common.utils.NetUtils, var275=$z1, var2950=$z2, var279=$r22, var2812=org.apache.dubbo.common.extension.ExtensionLoader, var1223=org.apache.dubbo.rpc.Protocol, var710=org.apache.dubbo.config.AbstractConfig, var3589=$r23, var2259=$r24, var1031=org.apache.dubbo.common.url.component.ServiceConfigURL, var2818=$r25, var608=$i0, var975=java.util.Optional, var2368=$r26, var3005=java.util.function.Function, var3034=org.apache.dubbo.config.ServiceConfig$lambda_buildUrl_10__486, var338=$r27, var3529=$r28, var3343=$r29, var3218=java.lang.Object, var2538=$r30, var572=$r31, var2418=null_type, var357=null, var2993=org.apache.dubbo.common.URL, var67=r32, var1441=org.apache.dubbo.rpc.cluster.ConfiguratorFactory, var1850=$r33, var2671=$r34, var3775=$z3, var871=org.apache.dubbo.rpc.model.ModuleModel, var3467=org.apache.dubbo.config.AbstractMethodConfig, var3349=$r5, var3036=org.apache.dubbo.rpc.model.ScopeModel, var2511=$r12, var772=org.apache.dubbo.rpc.model.ProviderModel, var2261=$r6, var127=org.apache.dubbo.rpc.model.ServiceModel, var910=$r13}
; {org.apache.dubbo.config.ServiceConfig=var2688, r1=var1599, org.apache.dubbo.config.ProtocolConfig=var3738, r0=var1983, java.util.Map=var1048, r2=var1752, r19=var8, org.apache.dubbo.common.utils.StringUtils=var3394, $z0=var2270, org.apache.dubbo.config.ProviderConfig=var3448, org.apache.dubbo.config.ServiceConfigBase=var2701, $r3=var2021, $r18=var819, r20=var672, org.apache.dubbo.common.utils.NetUtils=var653, $z1=var275, $z2=var2950, $r22=var279, org.apache.dubbo.common.extension.ExtensionLoader=var2812, org.apache.dubbo.rpc.Protocol=var1223, org.apache.dubbo.config.AbstractConfig=var710, $r23=var3589, $r24=var2259, org.apache.dubbo.common.url.component.ServiceConfigURL=var1031, $r25=var2818, $i0=var608, java.util.Optional=var975, $r26=var2368, java.util.function.Function=var3005, org.apache.dubbo.config.ServiceConfig$lambda_buildUrl_10__486=var3034, $r27=var338, $r28=var3529, $r29=var3343, java.lang.Object=var3218, $r30=var2538, $r31=var572, null_type=var2418, null=var357, org.apache.dubbo.common.URL=var2993, r32=var67, org.apache.dubbo.rpc.cluster.ConfiguratorFactory=var1441, $r33=var1850, $r34=var2671, $z3=var3775, org.apache.dubbo.rpc.model.ModuleModel=var871, org.apache.dubbo.config.AbstractMethodConfig=var3467, $r5=var3349, org.apache.dubbo.rpc.model.ScopeModel=var3036, $r12=var2511, org.apache.dubbo.rpc.model.ProviderModel=var772, $r6=var2261, org.apache.dubbo.rpc.model.ServiceModel=var127, $r13=var910}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<java.lang.String: boolean contains(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1,"<java.lang.String: boolean contains(java.lang.CharSequence)>": 1}
;stmts r1 := @this: org.apache.dubbo.config.ServiceConfig;	r0 := @parameter0: org.apache.dubbo.config.ProtocolConfig;	r2 := @parameter1: java.util.Map;	r19 = virtualinvoke r0.<org.apache.dubbo.config.ProtocolConfig: java.lang.String getName()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r19);	if $z0 == 0 goto $r3 = r1.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.config.ProviderConfig provider>;	$r3 = r1.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.config.ProviderConfig provider>;	$r18 = staticinvoke <org.apache.dubbo.config.ServiceConfig: java.lang.String findConfiguredHosts(org.apache.dubbo.config.ProtocolConfig,org.apache.dubbo.config.ProviderConfig,java.util.Map)>(r0, $r3, r2);	r20 = $r18;	$z1 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: boolean isIPV6URLStdFormat(java.lang.String)>($r18);	if $z1 == 0 goto $r4 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHostV6()>();	$z2 = virtualinvoke $r18.<java.lang.String: boolean contains(java.lang.CharSequence)>("[");	if $z2 != 0 goto $r22 = r1.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.config.ProviderConfig provider>;	$r22 = r1.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.config.ProviderConfig provider>;	$r23 = virtualinvoke r1.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/Protocol;");	$r24 = staticinvoke <org.apache.dubbo.config.ServiceConfig: java.lang.Integer findConfiguredPort(org.apache.dubbo.config.ProtocolConfig,org.apache.dubbo.config.ProviderConfig,org.apache.dubbo.common.extension.ExtensionLoader,java.lang.String,java.util.Map)>(r0, $r22, $r23, r19, r2);	$r25 = new org.apache.dubbo.common.url.component.ServiceConfigURL;	$i0 = virtualinvoke $r24.<java.lang.Integer: int intValue()>();	$r26 = virtualinvoke r1.<org.apache.dubbo.config.ServiceConfig: java.util.Optional getContextPath(org.apache.dubbo.config.ProtocolConfig)>(r0);	$r27 = staticinvoke <org.apache.dubbo.config.ServiceConfig$lambda_buildUrl_10__486: java.util.function.Function bootstrap$(org.apache.dubbo.config.ServiceConfig)>(r1);	$r28 = virtualinvoke $r26.<java.util.Optional: java.util.Optional map(java.util.function.Function)>($r27);	$r29 = r1.<org.apache.dubbo.config.ServiceConfig: java.lang.String path>;	$r30 = virtualinvoke $r28.<java.util.Optional: java.lang.Object orElse(java.lang.Object)>($r29);	$r31 = (java.lang.String) $r30;	specialinvoke $r25.<org.apache.dubbo.common.url.component.ServiceConfigURL: void <init>(java.lang.String,java.lang.String,java.lang.String,java.lang.String,int,java.lang.String,java.util.Map)>(r19, null, null, r20, $i0, $r31, r2);	r32 = $r25;	$r33 = virtualinvoke r1.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/cluster/ConfiguratorFactory;");	$r34 = virtualinvoke $r25.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	$z3 = virtualinvoke $r33.<org.apache.dubbo.common.extension.ExtensionLoader: boolean hasExtension(java.lang.String)>($r34);	if $z3 == 0 goto $r5 = virtualinvoke r1.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.rpc.model.ModuleModel getScopeModel()>();	$r5 = virtualinvoke r1.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.rpc.model.ModuleModel getScopeModel()>();	$r12 = virtualinvoke r32.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL setScopeModel(org.apache.dubbo.rpc.model.ScopeModel)>($r5);	$r6 = r1.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.rpc.model.ProviderModel providerModel>;	$r13 = virtualinvoke $r12.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL setServiceModel(org.apache.dubbo.rpc.model.ServiceModel)>($r6);	return $r13
;block_num 5