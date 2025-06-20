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

(declare-sort var2256 0)
(declare-sort var234 0)
(declare-sort var2156 0)
(declare-sort var2028 0)
(declare-sort var919 0)
(declare-sort var160 0)
(declare-sort var2745 0)
(declare-sort var3963 0)
(declare-sort var1880 0)
(declare-sort var2078 0)
(declare-sort var1656 0)
(declare-sort var1246 0)
(declare-sort var3889 0)
(declare-sort var3250 0)
(declare-sort var2075 0)
(declare-sort var1637 0)
(declare-sort var1206 0)
(declare-sort var3924 0)
(declare-sort var2257 0)
(declare-sort var3548 0)
(declare-sort var409 0)
(declare-sort var3778 0)
(declare-sort var2615 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var2078!class ClassObject)
(declare-const var3924!class ClassObject)
(declare-fun getName/383349173 (var234) String)
(declare-fun var2028_isEmpty/-813097145 (String) Bool)
(declare-fun provider/2052580610 (var160) var919)
(declare-fun cast-from-var2256-to-var160 (var2256) var160)
(declare-fun var2256_findConfiguredHosts/-303812874 (var234 var919 var2156) String)
(declare-fun var2745_isIPV6URLStdFormat/1867278366 (String) Bool)
(declare-fun var2745_getLocalHostV6/298303413 () String)
(declare-fun getExtensionLoader/1668578899 (var1656 ClassObject) var1880)
(declare-fun cast-from-var2256-to-var1656 (var2256) var1656)
(declare-fun var2256_findConfiguredPort/-2050701514 (var234 var919 var1880 String var2156) Int)
(declare-fun var1246-init () var1246)
(declare-fun intValue/-1815674922 (Int) Int)
(declare-fun getContextPath/683600075 (var160 var234) var3889)
(declare-fun var2075_bootstrap$/1230857546 (var2256) var3250)
(declare-fun map/1305667865 (var3889 var3250) var3889)
(declare-fun path/2052580610 (var160) String)
(declare-fun orElse/-757175127 (var3889 var1637) var1637)
(declare-fun cast-from-String-to-var1637 (String) var1637)
(declare-fun cast-from-var1637-to-String (var1637) String)
(declare-fun <init>/1472585720 (var1246 String String String String Int String var2156) void)
(declare-fun cast-from-var1246-to-var1206 (var1246) var1206)
(declare-fun getProtocol/491749358 (var1206) String)
(declare-fun hasExtension/-1450549355 (var1880 String) Bool)
(declare-fun getScopeModel/439405660 (var3548) var2257)
(declare-fun cast-from-var2256-to-var3548 (var2256) var3548)
(declare-fun setScopeModel/-1563758557 (var1206 var409) var1206)
(declare-fun cast-from-var2257-to-var409 (var2257) var409)
(declare-fun providerModel/14293649 (var2256) var3778)
(declare-fun setServiceModel/1097940449 (var1206 var2615) var1206)
(declare-fun cast-from-var3778-to-var2615 (var3778) var2615)
(declare-const null-var2256 var2256)
(declare-const null-var234 var234)
(declare-const null-var2156 var2156)
(declare-const null-String String)
(declare-const null-NullType var3963)
(declare-const var1227 var2256) ; Statement: r1 := @this: org.apache.dubbo.config.ServiceConfig 
(assert (not (= var1227 null-var2256)))
(declare-const var3324 var234) ; Statement: r0 := @parameter0: org.apache.dubbo.config.ProtocolConfig 
(assert (not (= var3324 null-var234)))
(declare-const var361 var2156) ; Statement: r2 := @parameter1: java.util.Map 
(assert (not (= var361 null-var2156)))
(assert true)
(define-const var3358 String (getName/383349173 var3324)) ; Statement: r19 = virtualinvoke r0.<org.apache.dubbo.config.ProtocolConfig: java.lang.String getName()>() 
(define-const var2036 Bool (var2028_isEmpty/-813097145 var3358)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r19) 
 ; Statement: if $z0 == 0 goto $r3 = r1.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.config.ProviderConfig provider> 
(assert (= (ite var2036 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1780 var919 (provider/2052580610 (cast-from-var2256-to-var160 var1227))) ; Statement: $r3 = r1.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.config.ProviderConfig provider> 
(define-const var739 String (var2256_findConfiguredHosts/-303812874 var3324 var1780 var361)) ; Statement: $r18 = staticinvoke <org.apache.dubbo.config.ServiceConfig: java.lang.String findConfiguredHosts(org.apache.dubbo.config.ProtocolConfig,org.apache.dubbo.config.ProviderConfig,java.util.Map)>(r0, $r3, r2) 
(define-const var3131 String var739) ; Statement: r20 = $r18 
(define-const var1398 Bool (var2745_isIPV6URLStdFormat/1867278366 var739)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: boolean isIPV6URLStdFormat(java.lang.String)>($r18) 
 ; Statement: if $z1 == 0 goto $r4 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHostV6()>() 
(assert (= (ite var1398 1 0) 0)) ; Cond: $z1 == 0 
(define-const var169 String var2745_getLocalHostV6/298303413) ; Statement: $r4 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHostV6()>() 
 ; Statement: if $r4 == null goto $r22 = r1.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.config.ProviderConfig provider> 
(assert (= var169 null-String)) ; Cond: $r4 == null 
(define-const var3298 var919 (provider/2052580610 (cast-from-var2256-to-var160 var1227))) ; Statement: $r22 = r1.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.config.ProviderConfig provider> 
(assert true)
(define-const var949 var1880 (getExtensionLoader/1668578899 (cast-from-var2256-to-var1656 var1227) var2078!class)) ; Statement: $r23 = virtualinvoke r1.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/Protocol;") 
(define-const var2517 Int (var2256_findConfiguredPort/-2050701514 var3324 var3298 var949 var3358 var361)) ; Statement: $r24 = staticinvoke <org.apache.dubbo.config.ServiceConfig: java.lang.Integer findConfiguredPort(org.apache.dubbo.config.ProtocolConfig,org.apache.dubbo.config.ProviderConfig,org.apache.dubbo.common.extension.ExtensionLoader,java.lang.String,java.util.Map)>(r0, $r22, $r23, r19, r2) 
(define-const var38 var1246 var1246-init) ; Statement: $r25 = new org.apache.dubbo.common.url.component.ServiceConfigURL 
(assert true)
(define-const var2271 Int (intValue/-1815674922 var2517)) ; Statement: $i0 = virtualinvoke $r24.<java.lang.Integer: int intValue()>() 
(assert true)
(define-const var1451 var3889 (getContextPath/683600075 (cast-from-var2256-to-var160 var1227) var3324)) ; Statement: $r26 = virtualinvoke r1.<org.apache.dubbo.config.ServiceConfig: java.util.Optional getContextPath(org.apache.dubbo.config.ProtocolConfig)>(r0) 
(define-const var1525 var3250 (var2075_bootstrap$/1230857546 var1227)) ; Statement: $r27 = staticinvoke <org.apache.dubbo.config.ServiceConfig$lambda_buildUrl_10__486: java.util.function.Function bootstrap$(org.apache.dubbo.config.ServiceConfig)>(r1) 
(assert true)
(define-const var3538 var3889 (map/1305667865 var1451 var1525)) ; Statement: $r28 = virtualinvoke $r26.<java.util.Optional: java.util.Optional map(java.util.function.Function)>($r27) 
(define-const var3217 String (path/2052580610 (cast-from-var2256-to-var160 var1227))) ; Statement: $r29 = r1.<org.apache.dubbo.config.ServiceConfig: java.lang.String path> 
(assert true)
(define-const var1078 var1637 (orElse/-757175127 var3538 (cast-from-String-to-var1637 var3217))) ; Statement: $r30 = virtualinvoke $r28.<java.util.Optional: java.lang.Object orElse(java.lang.Object)>($r29) 
(define-const var2144 String (cast-from-var1637-to-String var1078)) ; Statement: $r31 = (java.lang.String) $r30 
(assert true)
;(assert (<init>/1472585720 var38 var3358 null-String null-String var3131 var2271 var2144 var361)) ; Statement: specialinvoke $r25.<org.apache.dubbo.common.url.component.ServiceConfigURL: void <init>(java.lang.String,java.lang.String,java.lang.String,java.lang.String,int,java.lang.String,java.util.Map)>(r19, null, null, r20, $i0, $r31, r2) 

(declare-const var38!1 var1246)
(declare-const var3358!1 String)
(declare-const var335 var3963)
(declare-const var335!1 var3963)
(declare-const var3131!1 String)
(declare-const var2271!1 Int)
(declare-const var2144!1 String)
(declare-const var361!1 var2156)
(define-const var1844 var1206 (cast-from-var1246-to-var1206 var38!1)) ; Statement: r32 = $r25 
(assert true)
(define-const var1080 var1880 (getExtensionLoader/1668578899 (cast-from-var2256-to-var1656 var1227) var3924!class)) ; Statement: $r33 = virtualinvoke r1.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/cluster/ConfiguratorFactory;") 
(assert true)
(define-const var1444 String (getProtocol/491749358 (cast-from-var1246-to-var1206 var38!1))) ; Statement: $r34 = virtualinvoke $r25.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(assert true)
(define-const var3796 Bool (hasExtension/-1450549355 var1080 var1444)) ; Statement: $z3 = virtualinvoke $r33.<org.apache.dubbo.common.extension.ExtensionLoader: boolean hasExtension(java.lang.String)>($r34) 
 ; Statement: if $z3 == 0 goto $r5 = virtualinvoke r1.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.rpc.model.ModuleModel getScopeModel()>() 
(assert (= (ite var3796 1 0) 0)) ; Cond: $z3 == 0 
(assert true)
(define-const var1475 var2257 (getScopeModel/439405660 (cast-from-var2256-to-var3548 var1227))) ; Statement: $r5 = virtualinvoke r1.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.rpc.model.ModuleModel getScopeModel()>() 
(assert true)
(define-const var3036 var1206 (setScopeModel/-1563758557 var1844 (cast-from-var2257-to-var409 var1475))) ; Statement: $r12 = virtualinvoke r32.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL setScopeModel(org.apache.dubbo.rpc.model.ScopeModel)>($r5) 
(define-const var3495 var3778 (providerModel/14293649 var1227)) ; Statement: $r6 = r1.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.rpc.model.ProviderModel providerModel> 
(assert true)
(define-const var3805 var1206 (setServiceModel/1097940449 var3036 (cast-from-var3778-to-var2615 var3495))) ; Statement: $r13 = virtualinvoke $r12.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL setServiceModel(org.apache.dubbo.rpc.model.ServiceModel)>($r6) 
 ; Statement: return $r13 
(check-sat)
; {getName/383349173=([org.apache.dubbo.config.ProtocolConfig], java.lang.String), var2028_isEmpty/-813097145=([java.lang.String], boolean), provider/2052580610=([org.apache.dubbo.config.ServiceConfigBase], org.apache.dubbo.config.ProviderConfig), cast-from-var2256-to-var160=([org.apache.dubbo.config.ServiceConfig], org.apache.dubbo.config.ServiceConfigBase), var2256_findConfiguredHosts/-303812874=([org.apache.dubbo.config.ProtocolConfig, org.apache.dubbo.config.ProviderConfig, java.util.Map], java.lang.String), var2745_isIPV6URLStdFormat/1867278366=([java.lang.String], boolean), var2745_getLocalHostV6/298303413=([], java.lang.String), getExtensionLoader/1668578899=([org.apache.dubbo.config.AbstractConfig, java.lang.Class], org.apache.dubbo.common.extension.ExtensionLoader), cast-from-var2256-to-var1656=([org.apache.dubbo.config.ServiceConfig], org.apache.dubbo.config.AbstractConfig), var2256_findConfiguredPort/-2050701514=([org.apache.dubbo.config.ProtocolConfig, org.apache.dubbo.config.ProviderConfig, org.apache.dubbo.common.extension.ExtensionLoader, java.lang.String, java.util.Map], java.lang.Integer), var1246-init=([], org.apache.dubbo.common.url.component.ServiceConfigURL), intValue/-1815674922=([java.lang.Integer], int), getContextPath/683600075=([org.apache.dubbo.config.ServiceConfigBase, org.apache.dubbo.config.ProtocolConfig], java.util.Optional), var2075_bootstrap$/1230857546=([org.apache.dubbo.config.ServiceConfig], java.util.function.Function), map/1305667865=([java.util.Optional, java.util.function.Function], java.util.Optional), path/2052580610=([org.apache.dubbo.config.ServiceConfigBase], java.lang.String), orElse/-757175127=([java.util.Optional, java.lang.Object], java.lang.Object), cast-from-String-to-var1637=([java.lang.String], java.lang.Object), cast-from-var1637-to-String=([java.lang.Object], java.lang.String), <init>/1472585720=([org.apache.dubbo.common.url.component.ServiceConfigURL, java.lang.String, java.lang.String, java.lang.String, java.lang.String, int, java.lang.String, java.util.Map], void), cast-from-var1246-to-var1206=([org.apache.dubbo.common.url.component.ServiceConfigURL], org.apache.dubbo.common.URL), getProtocol/491749358=([org.apache.dubbo.common.URL], java.lang.String), hasExtension/-1450549355=([org.apache.dubbo.common.extension.ExtensionLoader, java.lang.String], boolean), getScopeModel/439405660=([org.apache.dubbo.config.AbstractMethodConfig], org.apache.dubbo.rpc.model.ModuleModel), cast-from-var2256-to-var3548=([org.apache.dubbo.config.ServiceConfig], org.apache.dubbo.config.AbstractMethodConfig), setScopeModel/-1563758557=([org.apache.dubbo.common.URL, org.apache.dubbo.rpc.model.ScopeModel], org.apache.dubbo.common.URL), cast-from-var2257-to-var409=([org.apache.dubbo.rpc.model.ModuleModel], org.apache.dubbo.rpc.model.ScopeModel), providerModel/14293649=([org.apache.dubbo.config.ServiceConfig], org.apache.dubbo.rpc.model.ProviderModel), setServiceModel/1097940449=([org.apache.dubbo.common.URL, org.apache.dubbo.rpc.model.ServiceModel], org.apache.dubbo.common.URL), cast-from-var3778-to-var2615=([org.apache.dubbo.rpc.model.ProviderModel], org.apache.dubbo.rpc.model.ServiceModel)}
; {var2256=org.apache.dubbo.config.ServiceConfig, var1227=r1, var234=org.apache.dubbo.config.ProtocolConfig, var3324=r0, var2156=java.util.Map, var361=r2, var3358=r19, var2028=org.apache.dubbo.common.utils.StringUtils, var2036=$z0, var919=org.apache.dubbo.config.ProviderConfig, var160=org.apache.dubbo.config.ServiceConfigBase, var1780=$r3, var739=$r18, var3131=r20, var2745=org.apache.dubbo.common.utils.NetUtils, var1398=$z1, var169=$r4, var3963=null_type, var3298=$r22, var1880=org.apache.dubbo.common.extension.ExtensionLoader, var2078=org.apache.dubbo.rpc.Protocol, var1656=org.apache.dubbo.config.AbstractConfig, var949=$r23, var2517=$r24, var1246=org.apache.dubbo.common.url.component.ServiceConfigURL, var38=$r25, var2271=$i0, var3889=java.util.Optional, var1451=$r26, var3250=java.util.function.Function, var2075=org.apache.dubbo.config.ServiceConfig$lambda_buildUrl_10__486, var1525=$r27, var3538=$r28, var3217=$r29, var1637=java.lang.Object, var1078=$r30, var2144=$r31, var335=null, var1206=org.apache.dubbo.common.URL, var1844=r32, var3924=org.apache.dubbo.rpc.cluster.ConfiguratorFactory, var1080=$r33, var1444=$r34, var3796=$z3, var2257=org.apache.dubbo.rpc.model.ModuleModel, var3548=org.apache.dubbo.config.AbstractMethodConfig, var1475=$r5, var409=org.apache.dubbo.rpc.model.ScopeModel, var3036=$r12, var3778=org.apache.dubbo.rpc.model.ProviderModel, var3495=$r6, var2615=org.apache.dubbo.rpc.model.ServiceModel, var3805=$r13}
; {org.apache.dubbo.config.ServiceConfig=var2256, r1=var1227, org.apache.dubbo.config.ProtocolConfig=var234, r0=var3324, java.util.Map=var2156, r2=var361, r19=var3358, org.apache.dubbo.common.utils.StringUtils=var2028, $z0=var2036, org.apache.dubbo.config.ProviderConfig=var919, org.apache.dubbo.config.ServiceConfigBase=var160, $r3=var1780, $r18=var739, r20=var3131, org.apache.dubbo.common.utils.NetUtils=var2745, $z1=var1398, $r4=var169, null_type=var3963, $r22=var3298, org.apache.dubbo.common.extension.ExtensionLoader=var1880, org.apache.dubbo.rpc.Protocol=var2078, org.apache.dubbo.config.AbstractConfig=var1656, $r23=var949, $r24=var2517, org.apache.dubbo.common.url.component.ServiceConfigURL=var1246, $r25=var38, $i0=var2271, java.util.Optional=var3889, $r26=var1451, java.util.function.Function=var3250, org.apache.dubbo.config.ServiceConfig$lambda_buildUrl_10__486=var2075, $r27=var1525, $r28=var3538, $r29=var3217, java.lang.Object=var1637, $r30=var1078, $r31=var2144, null=var335, org.apache.dubbo.common.URL=var1206, r32=var1844, org.apache.dubbo.rpc.cluster.ConfiguratorFactory=var3924, $r33=var1080, $r34=var1444, $z3=var3796, org.apache.dubbo.rpc.model.ModuleModel=var2257, org.apache.dubbo.config.AbstractMethodConfig=var3548, $r5=var1475, org.apache.dubbo.rpc.model.ScopeModel=var409, $r12=var3036, org.apache.dubbo.rpc.model.ProviderModel=var3778, $r6=var3495, org.apache.dubbo.rpc.model.ServiceModel=var2615, $r13=var3805}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.config.ServiceConfig;	r0 := @parameter0: org.apache.dubbo.config.ProtocolConfig;	r2 := @parameter1: java.util.Map;	r19 = virtualinvoke r0.<org.apache.dubbo.config.ProtocolConfig: java.lang.String getName()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r19);	if $z0 == 0 goto $r3 = r1.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.config.ProviderConfig provider>;	$r3 = r1.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.config.ProviderConfig provider>;	$r18 = staticinvoke <org.apache.dubbo.config.ServiceConfig: java.lang.String findConfiguredHosts(org.apache.dubbo.config.ProtocolConfig,org.apache.dubbo.config.ProviderConfig,java.util.Map)>(r0, $r3, r2);	r20 = $r18;	$z1 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: boolean isIPV6URLStdFormat(java.lang.String)>($r18);	if $z1 == 0 goto $r4 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHostV6()>();	$r4 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHostV6()>();	if $r4 == null goto $r22 = r1.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.config.ProviderConfig provider>;	$r22 = r1.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.config.ProviderConfig provider>;	$r23 = virtualinvoke r1.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/Protocol;");	$r24 = staticinvoke <org.apache.dubbo.config.ServiceConfig: java.lang.Integer findConfiguredPort(org.apache.dubbo.config.ProtocolConfig,org.apache.dubbo.config.ProviderConfig,org.apache.dubbo.common.extension.ExtensionLoader,java.lang.String,java.util.Map)>(r0, $r22, $r23, r19, r2);	$r25 = new org.apache.dubbo.common.url.component.ServiceConfigURL;	$i0 = virtualinvoke $r24.<java.lang.Integer: int intValue()>();	$r26 = virtualinvoke r1.<org.apache.dubbo.config.ServiceConfig: java.util.Optional getContextPath(org.apache.dubbo.config.ProtocolConfig)>(r0);	$r27 = staticinvoke <org.apache.dubbo.config.ServiceConfig$lambda_buildUrl_10__486: java.util.function.Function bootstrap$(org.apache.dubbo.config.ServiceConfig)>(r1);	$r28 = virtualinvoke $r26.<java.util.Optional: java.util.Optional map(java.util.function.Function)>($r27);	$r29 = r1.<org.apache.dubbo.config.ServiceConfig: java.lang.String path>;	$r30 = virtualinvoke $r28.<java.util.Optional: java.lang.Object orElse(java.lang.Object)>($r29);	$r31 = (java.lang.String) $r30;	specialinvoke $r25.<org.apache.dubbo.common.url.component.ServiceConfigURL: void <init>(java.lang.String,java.lang.String,java.lang.String,java.lang.String,int,java.lang.String,java.util.Map)>(r19, null, null, r20, $i0, $r31, r2);	r32 = $r25;	$r33 = virtualinvoke r1.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/cluster/ConfiguratorFactory;");	$r34 = virtualinvoke $r25.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	$z3 = virtualinvoke $r33.<org.apache.dubbo.common.extension.ExtensionLoader: boolean hasExtension(java.lang.String)>($r34);	if $z3 == 0 goto $r5 = virtualinvoke r1.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.rpc.model.ModuleModel getScopeModel()>();	$r5 = virtualinvoke r1.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.rpc.model.ModuleModel getScopeModel()>();	$r12 = virtualinvoke r32.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL setScopeModel(org.apache.dubbo.rpc.model.ScopeModel)>($r5);	$r6 = r1.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.rpc.model.ProviderModel providerModel>;	$r13 = virtualinvoke $r12.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL setServiceModel(org.apache.dubbo.rpc.model.ServiceModel)>($r6);	return $r13
;block_num 5